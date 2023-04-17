local utils = require("src/utils")

---@class Driver
---@param carIndex number
---@return Driver
Driver = class("Driver", function(carIndex)
	local index = carIndex
	local car = ac.getCar(index)
	local name = ac.getDriverName(index)
	local lapsCompleted = car.lapCount

	local aiThrottleLimitBase = 1
	local aiThrottleLimit = 1
	local aiLevel = 1
	local aiAggression = 0
	local aiPrePitFuel = 0
	local aiPitCall = false
	local aiPitting = false
	local aiSplineOffset = 0
	local aiMoveAside = false
	local aiSpeedUp = false
	local aiMgukDelivery = 0
	local aiMgukRecovery = 0
	local aiBaseBrakeHint = 1
	local aiBrakeHint = 1

	local outLap = false
	local flyingLap = false
	local inLap = false
	local inLapCount = 0

	local pitstopCount = 0
	local pitstopTime = 0
	local pitlane = false
	local pitlaneTime = 0
	local pitstop = false
	local pitted = false
	local lapPitted = 0
	local pittedLaps = {}
	local tyreLaps = 0
	local tyreCompoundStart = car.compoundIndex
	local tyreCompoundNext = car.compoundIndex
	local tyreCompoundChange = false
	local tyreCompoundsAvailable = { 0 }
	local tyreStints = {}
	local tyreCompoundMaterialTarget = ""
	local tyreCompoundSoftTexture = ""
	local tyreComoundMediumTexture = ""
	local tyreCompoundHardTexture = ""
	local tyreCompoundTextureTimer = 0

	local trackPosition = -1
	local carAhead = -1
	local carAheadDelta = -1
	local miniSectors = {}
	local currentMiniSector = 0

	local drsActivationZone = car.drsAvailable
	local drsZoneNextId = 0
	local drsZoneId = 1
	local drsZonePrevId = 0
	local drsCheck = false
	local drsAvailable = false
	local drsDeployable = false
	local drsDetection = {}

	local drsBeepFx = false
	local drsFlapFx = false

	local timePenalty = 0
	local illegalOvertake = false
	local returnRacePosition = -1
	local returnPostionTimer = -1

	local aiTyreAvgRandom = utils.randomizer(index, RARECONFIG.data.AI.AI_AVG_TYRE_LIFE_RANGE)
	local aiTyreSingleRandom = utils.randomizer(index, RARECONFIG.data.AI.AI_SINGLE_TYRE_LIFE_RANGE)

	log("[" .. index .. "] " .. name .. " loaded")

	return {
		tyreCompoundTextureTimer = tyreCompoundTextureTimer,
		currentMiniSector = currentMiniSector,
		miniSectors = miniSectors,
		drsDetection = drsDetection,
		tyreCompoundSoftTexture = tyreCompoundSoftTexture,
		tyreComoundMediumTexture = tyreComoundMediumTexture,
		tyreCompoundHardTexture = tyreCompoundHardTexture,
		tyreCompoundMaterialTarget = tyreCompoundMaterialTarget,
		pittedLaps = pittedLaps,
		tyreStints = tyreStints,
		aiBrakeHint = aiBrakeHint,
		aiBaseBrakeHint = aiBaseBrakeHint,
		tyreCompoundsAvailable = tyreCompoundsAvailable,
		tyreCompoundStart = tyreCompoundStart,
		tyreCompoundNext = tyreCompoundNext,
		tyreCompoundChange = tyreCompoundChange,
		aiSplineOffset = aiSplineOffset,
		aiSpeedUp = aiSpeedUp,
		aiMoveAside = aiMoveAside,
		inLapCount = inLapCount,
		inLap = inLap,
		flyingLap = flyingLap,
		outLap = outLap,
		aiThrottleLimitBase = aiThrottleLimitBase,
		aiThrottleLimit = aiThrottleLimit,
		pitlaneTime = pitlaneTime,
		pitlane = pitlane,
		pitstop = pitstop,
		pitstopTime = pitstopTime,
		pitted = pitted,
		pitstopCount = pitstopCount,
		tyreLaps = tyreLaps,
		lapPitted = lapPitted,
		drsBeepFx = drsBeepFx,
		drsFlapFx = drsFlapFx,
		drsZoneNextId = drsZoneNextId,
		drsDeployable = drsDeployable,
		drsZonePrevId = drsZonePrevId,
		drsZoneId = drsZoneId,
		drsActivationZone = drsActivationZone,
		drsAvailable = drsAvailable,
		drsCheck = drsCheck,
		aiTyreSingleRandom = aiTyreSingleRandom,
		aiTyreAvgRandom = aiTyreAvgRandom,
		aiPitting = aiPitting,
		aiPitCall = aiPitCall,
		aiPrePitFuel = aiPrePitFuel,
		aiLevel = aiLevel,
		aiAggression = aiAggression,
		returnPostionTimer = returnPostionTimer,
		returnRacePosition = returnRacePosition,
		timePenalty = timePenalty,
		illegalOvertake = illegalOvertake,
		carAheadDelta = carAheadDelta,
		carAhead = carAhead,
		trackPosition = trackPosition,
		lapsCompleted = lapsCompleted,
		index = index,
		name = name,
		car = car,
		aiMgukDelivery = aiMgukDelivery,
		aiMgukRecovery = aiMgukRecovery,
	}
end, class.NoInitialize)

--- Returns lap pitted or lap count if driver just pitted
---@param driver Driver
---@return number
local function getLapPitted(driver)
	return (driver.tyreLaps > 0 and driver.car.isInPitlane) and driver.car.lapCount or driver.lapPitted
end

--- Returns tyre lap count
---@param driver Driver
---@return number
local function getTyreLapCount(driver)
	return (driver.car.isInPitlane and not driver.pitted) and driver.tyreLaps
		or (driver.car.lapCount - driver.lapPitted)
end

local function getPitstopCount(driver)
	if driver.car.isInPit and not driver.pitted then
		driver.pitted = true
		driver.aiTyreAvgRandom = utils.randomizer(driver.index, RARECONFIG.data.AI.AI_AVG_TYRE_LIFE_RANGE)
		driver.aiTyreSingleRandom = utils.randomizer(driver.index, RARECONFIG.data.AI.AI_SINGLE_TYRE_LIFE_RANGE)
		return driver.pitstopCount + 1
	elseif not driver.car.isInPitlane and driver.pitted then
		driver.pitted = false
	end

	return driver.pitstopCount
end

local function getPitTime(dt, driver)
	if driver.car.isInPitlane then
		if driver.pitlaneTime > 0 and not driver.pitlane then
			driver.pitlane = true
			return 0
		else
			return driver.pitlaneTime + dt
		end
	else
		driver.pitlane = false
		return driver.pitlaneTime
	end
end

local function getPitstopTime(dt, driver)
	if driver.car.isInPit then
		if not driver.pitstop then
			driver.pitstop = true
			return 0
		else
			return driver.pitstopTime + dt
		end
	else
		driver.pitstop = false
		return driver.pitstopTime
	end
end

local function getMiniSectorGap(driver, carAheadIndex)
	return driver.miniSectors[driver.currentMiniSector] - DRIVERS[carAheadIndex].miniSectors[driver.currentMiniSector]
end

function Driver:update(dt, sim)
	self.lapPitted = getLapPitted(self)
	self.tyreLaps = getTyreLapCount(self)
	self.pitstopCount = getPitstopCount(self)
	self.pitlaneTime = getPitTime(dt, self)
	self.pitstopTime = getPitstopTime(dt, self)

	if not self.car.isInPit and self.car.fuel > 1 then
		self.aiPrePitFuel = self.car.fuel
	end

	if self.currentMiniSector ~= math.floor((self.car.splinePosition * sim.trackLengthM) / 50) then
		self.currentMiniSector = math.floor((self.car.splinePosition * sim.trackLengthM) / 50)
		self.miniSectors[self.currentMiniSector] = os.clock()
	end

	if self.carAhead >= 0 then
		-- self.carAheadDelta = ac.getDelta(sim, self.index, self.carAhead)
		self.carAheadDelta = getMiniSectorGap(self, self.carAhead) or ac.getDelta(sim, self.index, self.carAhead)
	end
end
