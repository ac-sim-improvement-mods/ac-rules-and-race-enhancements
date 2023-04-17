local utils = require("src/helpers/utils")

Driver = class("Driver")

function Driver:initialize(carIndex)
	self.index = carIndex
	self.car = ac.getCar(carIndex)
	self.name = ac.getDriverName(carIndex)

	self.aiThrottleLimitBase = 1
	self.aiThrottleLimit = 1
	self.aiLevel = 1
	self.aiAggression = 0
	self.aiPrePitFuel = 0
	self.aiPitCall = false
	self.aiPitting = false
	self.aiSplineOffset = 0
	self.aiMoveAside = false
	self.aiSpeedUp = false
	self.aiMgukDelivery = 0
	self.aiMgukRecovery = 0
	self.aiBaseBrakeHint = 1
	self.aiBrakeHint = 1

	self.outLap = false
	self.flyingLap = false
	self.inLap = false
	self.inLapCount = 0

	self.pitstopCount = 0
	self.pitstopTime = 0
	self.pitlane = false
	self.pitlaneTime = 0
	self.pitstop = false
	self.pitted = false
	self.lapPitted = 0
	self.pittedLaps = {}
	self.tyreLaps = 0
	self.tyreCompoundStart = car.compoundIndex
	self.tyreCompoundNext = car.compoundIndex
	self.tyreCompoundChange = false
	self.tyreCompoundsAvailable = { 0 }
	self.tyreStints = {}
	self.tyreCompoundMaterialTarget = ""
	self.tyreCompoundSoftTexture = ""
	self.tyreComoundMediumTexture = ""
	self.tyreCompoundHardTexture = ""
	self.tyreCompoundTextureTimer = 0

	self.trackPosition = -1
	self.carAhead = -1
	self.carAheadDelta = -1
	self.miniSectors = {}
	self.currentMiniSector = 0

	self.drsActivationZone = car.drsAvailable
	self.drsZoneNextId = 0
	self.drsZoneId = 1
	self.drsZonePrevId = 0
	self.drsCheck = false
	self.drsAvailable = false
	self.drsDeployable = false
	self.drsDetection = {}

	self.drsBeepFx = false
	self.drsFlapFx = false

	self.timePenalty = 0
	self.illegalOvertake = false
	self.returnRacePosition = -1
	self.returnPostionTimer = -1

	self.aiTyreAvgRandom = utils.randomizer(index, RARECONFIG.data.AI.AI_AVG_TYRE_LIFE_RANGE)
	self.aiTyreSingleRandom = utils.randomizer(index, RARECONFIG.data.AI.AI_SINGLE_TYRE_LIFE_RANGE)

	log("[" .. self.index .. "] " .. self.name .. " initialized")

	return self
end

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
