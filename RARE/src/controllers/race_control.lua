---@diagnostic disable: return-type-mismatch
local connect = require("app/connection")
local drs = require("src/controllers/drs")
local vsc = require("src/controllers/vsc")
local ai = require("src/controllers/ai")
local notifications = require("src/ui/windows/notification_window")
require("src/helpers/helper")

local rc = {}

DRIVERS = {}

---@alias rc.WeekendSessions
---| `rc.WeekendSessions.FP1` @Value: 0.
---| `rc.WeekendSessions.FP2` @Value: 1.
---| `rc.WeekendSessions.FP3` @Value: 2.
---| `rc.WeekendSessions.Q1` @Value: 3.
---| `rc.WeekendSessions.Q2` @Value: 4.
---| `rc.WeekendSessions.Q3` @Value: 5.
---| `rc.WeekendSessions.Race` @Value: 6.
rc.WeekendSessions = {
	FP1 = 0,
	FP2 = 1,
	FP3 = 2,
	Q1 = 3,
	Q2 = 4,
	Q3 = 5,
	Race = 6,
}

---Returns leaders completed lap count.
---@return lapCount number
local function getLeaderCompletedLaps(sim)
	for i = 0, sim.carsCount - 1 do
		local car = ac.getCar(i)

		if car.racePosition == 1 then
			return car.lapCount
		end
	end
end

local drsActivationLap = 0
---Returns whether DRS is enabled or not
---@param config RARE_CONFIG.data
---@return drsEnabled boolean
local function isDrsEnabled(config, leaderCompletedLaps, wetTrack)
	if leaderCompletedLaps + 1 >= drsActivationLap and not wetTrack then
		return true
	else
		return false
	end
end

---Returns whether the track is too wet for DRS enabled or not
---@param config RARE_CONFIG.data
---@return wetTrack boolean
local function isTrackWet(config, sim)
	local isRaining = math.clamp(math.floor(sim.rainIntensity / 0.003), 0, 1) == 1
	local totalWetness = ((sim.rainWetness * 10000 * 3.75) + (sim.rainWater * 100 * 12.5)) * (isRaining and 1 or 0)

	if totalWetness > 40 then
		return true
	else
		return false
	end
end

--- Sets the on track order of drivers
--- and excludes drivers in the pitlane
--- @param drivers DRIVERS
local function getTrackOrder(drivers)
	local trackOrder = {}
	for index = 0, #drivers do
		if not drivers[index].car.isInPitlane then
			table.insert(trackOrder, drivers[index])
		else
			drivers[index].trackPosition = -1
		end
	end

	-- Sort drivers by position on track, and ignore drivers in the pits
	table.sort(trackOrder, function(a, b)
		return a.car.splinePosition > b.car.splinePosition
	end)

	for trackPos = 1, #trackOrder do
		local index = trackOrder[trackPos].index
		drivers[index].trackPosition = trackPos

		if trackPos == 1 then
			drivers[index].carAhead = trackOrder[#trackOrder].index
		else
			drivers[index].carAhead = trackOrder[trackPos - 1].index
		end
	end

	return #trackOrder
end

--- Race Control for qualify sessions
--- @param config RARE_CONFIG.data
--- @param driver Driver
local function qualifySession(racecontrol, config, driver)
	if racecontrol.sim.sessionTimeLeft <= 0 then
		physics.setAIPitStopRequest(driver.index, false)
		ac.log("sessionover")
	end
end

--- Race Control for practice sessions
--- @param config RARE_CONFIG.data
--- @param driver Driver
local function practiceSession(racecontrol, config, driver) end

--- Race Control for race sessions
--- @param config RARE_CONFIG.data
--- @param driver Driver
local function raceSession(lastUpdate, racecontrol, config, driver)
	local raceRules = config.RULES
	local aiRules = config.AI

	if driver.car.isAIControlled then
		if racecontrol.sim.isInMainMenu and not racecontrol.sim.isSessionStarted then
			driver:setFuelTankRace(racecontrol.sim, driver)

			if ac.getPatchVersionCode() >= 2278 then
				physics.setAIPitStopRequest(driver.index, false)
			end
		end
	else
		if racecontrol.sim.isInMainMenu and not racecontrol.sim.isSessionStarted then
			driver:setFuelTankRace(racecontrol.sim, driver)
		end
	end

	if raceRules.DRS_RULES == 1 then
		drs.controller(racecontrol, driver, racecontrol.drsEnabled)

		-- notifications handler
		if lastUpdate then
			if not lastUpdate.drsEnabled and racecontrol.drsEnabled then
				notifications.popup("DRS ENABLED")
			end

			if not lastUpdate.wetTrack and racecontrol.wetTrack then
				notifications.popup("DRS DISABLED - WET TRACK")
			end

			if lastUpdate.wetTrack and not racecontrol.wetTrack and not racecontrol.drsEnabled then
				notifications.popup("DRS ENABLED IN 2 LAPS")
				drsActivationLap = racecontrol.leaderCompletedLaps + 3
			end
		end
	else
		driver.isDrsAvailable = true
	end

	if driver.car.isAIControlled then
		ai.controller(raceRules, aiRules, driver)
	end

	return driver
end

--- Switch for runnimg the different kinds of sessioms
--- @param sessionType ac.SessionTypes
--- @param config RARE_CONFIG.data
--- @param driver Driver
local function runSession(lastUpdate, racecontrol, sessionType, driver)
	local config = RARE_CONFIG.data

	if sessionType == ac.SessionType.Race then
		raceSession(lastUpdate, racecontrol, config, driver)
	elseif sessionType == ac.SessionType.Qualify then
		qualifySession(racecontrol, config, driver)
	elseif sessionType == ac.SessionType.Practice then
		practiceSession(racecontrol, config, driver)
	end

	return driver
end

local function update(sim, drivers)
	local config = RARE_CONFIG.data
	local carsOnTrackCount = getTrackOrder(drivers)
	local leaderCompletedLaps = getLeaderCompletedLaps(sim)
	local wetTrack = isTrackWet(config, sim)
	local drsEnabled = isDrsEnabled(config, leaderCompletedLaps, wetTrack)
	local drsEnabledLap = drsActivationLap
	local session = nil

	if not sim.isOnlineRace then
		session = ac.getSession(sim.currentSessionIndex)
	end

	if not sim.isSessionStarted then
		drsActivationLap = config.RULES.DRS_ACTIVATION_LAP
		drsEnabledLap = drsEnabledLap
	end

	return readOnly({
		sim = sim,
		session = session,
		carsOnTrackCount = carsOnTrackCount,
		leaderCompletedLaps = leaderCompletedLaps,
		drsEnabled = drsEnabled,
		drsEnabledLap = drsEnabledLap,
		wetTrack = wetTrack,
	})
end

local racecontrol = nil

--- Updates and returns race control variables
--- @return racecontrol rc
function rc.getRaceControl(dt, sim)
	local drivers = DRIVERS
	local lastUpdate = racecontrol
	racecontrol = update(sim, drivers)

	for i = 0, #drivers do
		local driver = drivers[i]
		driver:update(dt, sim)
		DRIVERS[i] = runSession(lastUpdate, racecontrol, sim.raceSessionType, driver)
		connect.storeDriverData(driver)
	end

	connect.storeRaceControlData(racecontrol)

	return racecontrol
end

return rc
