local sim = ac.getSim()

Driver = class("Driver")
function Driver:initialize(carIndex)
	self.index = carIndex
	self.car = ac.getCar(carIndex)
	self.name = ac.getDriverName(carIndex)

	self.aiThrottleLimitBase = math.lerp(0.5, 1, 1 - ((1 - self.car.aiLevel) / 0.3))
	self.aiThrottleLimit = 1
	self.aiLevel = self.car.aiLevel
	self.aiLevelRelative = self:setAIRelativeLevel()
	self.aiAggression = self.car.aiAggression

	self.aiPrePitFuel = 0
	self.isAIPitCall = false
	self.isAIPitting = false
	self.aiSplineOffset = 0
	self.isAIMoveAside = false
	self.isAISpeedUp = false
	self.aiMgukDelivery = 0
	self.aiMgukRecovery = 0
	self.aiBrakeHint = 1
	self.aiGasBrakeLookAhead = 0
	self.aiCaution = 1

	self.isOnOutlap = false
	self.isOnFlyingLap = false
	self.isOnInLap = false
	self.inLap = 0

	self.pitstopCount = 0
	self.pitstopTime = 0
	self.pitlane = false
	self.pitlaneTime = 0
	self.isPitStopComplete = false
	self.hasPitted = false
	self.lapPitted = 0
	self.pittedLaps = {}
	self.tyreLaps = 0
	self.tyreCompoundStart = self.car.compoundIndex
	self.tyreCompoundNext = self.car.compoundIndex
	self.hasChangedTyreCompound = false
	self.tyreStints = {}
	self.tyreCompoundTextureTimer = 0

	self.trackPosition = -1
	self.carAhead = -1
	self.carAheadDelta = -1
	self.miniSectors = {}
	self.currentMiniSector = 0
	self.lapsCompleted = self.car.lapCount

	self.isInDrsActivationZone = self.car.drsAvailable
	self.drsZoneNextId = 0
	self.drsZoneId = 1
	self.drsZonePrevId = 0
	self.isDrsAvailable = false
	self.drsDetection = {}

	self.drsBeepFx = false
	self.drsFlapFx = false

	self.timePenalty = 0
	self.returnRacePosition = -1
	self.returnPostionTimer = -1

	self.aiTyreAvgRandom = math.randomizer(self.index, RARE_CONFIG.data.AI.AI_AVG_TYRE_LIFE_RANGE)
	self.aiTyreSingleRandom = math.randomizer(self.index, RARE_CONFIG.data.AI.AI_SINGLE_TYRE_LIFE_RANGE)

	self:updateTyreCompoundConfig()

	for i = 0, #DRS_ZONES.startLines do
		self.drsDetection[i] = false
	end

	for i = 0, math.floor(sim.trackLengthM / 50) do
		self.miniSectors[i] = 0
	end

	if self.car.isAIControlled then
		self:setAITyreCompound()
	end

	self.aiLevel = self.car.aiLevel
	self.aiGasBrakeLookAheadBase =
		ac.INIConfig.carData(self.index, "ai.ini"):get("LOOKAHEAD", "GAS_BRAKE_LOOKAHEAD", 10)
	self.aiBrakeHintBase = ac.INIConfig.carData(self.index, "ai.ini"):get("PEDALS", "BRAKE_HINT", 1)
	self.aiThrottleLimitBase = math.lerp(0.5, 1, 1 - ((1 - self.aiLevel) / 0.3))
	self.aiAggression = self.car.aiAggression

	if RARE_CONFIG.data.AI.AI_RELATIVE_SCALING == 1 then
		self.aiLevel = self.aiLevel * RARE_CONFIG.data.AI.AI_RELATIVE_LEVEL / 100
		self.aiThrottleLimitBase = math.lerp(0.5, 1, 1 - ((1 - self.aiLevel) / 0.3))
	end

	physics.setAILevel(self.index, 1)
	physics.setAIAggression(self.index, self.aiAggression)

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
	return (driver.car.isInPitlane and not driver.hasPitted) and driver.tyreLaps
		or (driver.car.lapCount - driver.lapPitted)
end

--- Updates driver's pitstop count
---@param driver Driver
---@return number
local function updatePistopCount(driver)
	if driver.car.isInPit and not driver.hasPitted then
		driver.hasPitted = true
		driver.aiTyreAvgRandom = math.randomizer(driver.index, RARE_CONFIG.data.AI.AI_AVG_TYRE_LIFE_RANGE)
		driver.aiTyreSingleRandom = math.randomizer(driver.index, RARE_CONFIG.data.AI.AI_SINGLE_TYRE_LIFE_RANGE)
		return driver.pitstopCount + 1
	elseif not driver.car.isInPitlane and driver.hasPitted then
		driver.hasPitted = false
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
		if not driver.isPitStopComplete then
			driver.isPitStopComplete = true
			return 0
		else
			return driver.pitstopTime + dt
		end
	else
		driver.isPitStopComplete = false
		return driver.pitstopTime
	end
end

local function getMiniSectorGap(driver, carAheadIndex)
	return driver.miniSectors[driver.currentMiniSector] - DRIVERS[carAheadIndex].miniSectors[driver.currentMiniSector]
end

function Driver:updateTyreCompoundConfig()
	local trackID = ac.getTrackID()
	local carID = ac.getCarID(self.index)
	local compoundsIni = ac.INIConfig.load(
		ac.getFolder(ac.FolderID.ACApps) .. "/lua/RARE/configs/" .. carID .. ".ini",
		ac.INIFormat.Default
	)

	self.tyreCompoundMaterialTarget = compoundsIni:get("COMPOUND_TEXTURES", "COMPOUND_TARGET_MATERIAL", "")
	self.tyreCompoundSoftTexture =
		compoundsIni:get("COMPOUND_TEXTURES", "SOFT_COMPOUND_TEXTURE", ""):gsub('"', ""):gsub("'", "")
	self.tyreCompoundMediumTexture =
		compoundsIni:get("COMPOUND_TEXTURES", "MEDIUM_COMPOUND_TEXTURE", ""):gsub('"', ""):gsub("'", "")
	self.tyreCompoundHardTexture =
		compoundsIni:get("COMPOUND_TEXTURES", "HARD_COMPOUND_TEXTURE", ""):gsub('"', ""):gsub("'", "")
	self.tyreCompoundInterTexture =
		compoundsIni:get("COMPOUND_TEXTURES", "INTER_COMPOUND_TEXTURE", ""):gsub('"', ""):gsub("'", "")
	self.tyreCompoundWetTexture =
		compoundsIni:get("COMPOUND_TEXTURES", "WET_COMPOUND_TEXTURE", ""):gsub('"', ""):gsub("'", "")

	self.tyreCompoundSoft = compoundsIni:get(trackID, "SOFT_COMPOUND", ""):gsub('"', ""):gsub("'", "") ~= ""
			and compoundsIni:get(trackID, "SOFT_COMPOUND", ""):gsub('"', ""):gsub("'", "")
		or compoundsIni:get("COMPOUND_DEFAULTS", "SOFT_COMPOUND", "1"):gsub('"', ""):gsub("'", "")
	self.tyreCompoundMedium = compoundsIni:get(trackID, "MEDIUM_COMPOUND", ""):gsub('"', ""):gsub("'", "") ~= ""
			and compoundsIni:get(trackID, "MEDIUM_COMPOUND", ""):gsub('"', ""):gsub("'", "")
		or compoundsIni:get("COMPOUND_DEFAULTS", "MEDIUM_COMPOUND", "2"):gsub('"', ""):gsub("'", "")
	self.tyreCompoundHard = compoundsIni
				:get("COMPOUND_DEFAULTS", "HARD_COMPOUND", "")
				:gsub('"', "")
				:gsub("'", "") ~= ""
			and compoundsIni:get(trackID, "HARD_COMPOUND", ""):gsub('"', ""):gsub("'", "")
		or compoundsIni:get("COMPOUND_DEFAULTS", "HARD_COMPOUND", "3"):gsub('"', ""):gsub("'", "")
	self.tyreCompoundInter = compoundsIni:get("COMPOUND_DEFAULTS", "INTER_COMPOUND", "5"):gsub('"', ""):gsub("'", "")
	self.tyreCompoundWet = compoundsIni:get("COMPOUND_DEFAULTS", "WET_COMPOUND", "6"):gsub('"', ""):gsub("'", "")

	self.tyreCompoundsAvailable = {
		self.tyreCompoundSoft,
		self.tyreCompoundMedium,
		self.tyreCompoundHard,
		self.tyreCompoundInter,
		self.tyreCompoundWet,
	}

	self.tyreDryCompounds = {
		self.tyreCompoundSoft,
		self.tyreCompoundMedium,
		self.tyreCompoundHard,
	}

	self.tyreWetCompounds = {
		self.tyreCompoundInter,
		self.tyreCompoundWet,
	}

	table.sort(self.tyreCompoundsAvailable, function(a, b)
		return a < b
	end)

	log("[" .. self.index .. "] " .. self.name .. " has " .. #self.tyreCompoundsAvailable .. " compounds available")
end

function Driver:setFuelTankRace()
	local fuelcons = ac.INIConfig.carData(self.index, "fuel_cons.ini"):get("FUEL_EVAL", "KM_PER_LITER", 0.0)
	local fuelload = 0
	local fuelPerLap = (sim.trackLengthM / 1000) / (fuelcons - (fuelcons * 0.1))

	if sim.raceSessionType == ac.SessionType.Race then
		fuelload = ((ac.getSession(sim.currentSessionIndex).laps + 2) * fuelPerLap)
	elseif sim.raceSessionType == ac.SessionType.Qualify then
		fuelload = 3.5 * fuelPerLap
	end

	if self.car.isAIControlled then
		if RARE_CONFIG.data.AI.AI_TANK_FILL == 1 then
			physics.setCarFuel(self.index, fuelload)
		end
	else
		if RARE_CONFIG.data.DRIVER.TANK_FILL == 1 then
			ac.setSetupSpinnerValue("FUEL", fuelload)
		end
	end
end

function Driver:setAITyreCompound()
	math.randomseed(os.clock() * self.index)
	math.random()
	for i = 0, math.random(0, math.random(3)) do
		math.random()
	end
	local tyrevalue = self.tyreDryCompounds[math.random(1, #self.tyreDryCompounds)]
	self.tyreCompoundStart = tyrevalue

	if ac.getPatchVersionCode() >= 2278 then
		physics.setAITyres(self.index, tyrevalue)
		log("[" .. self.index .. "] " .. self.name .. " tyre compound set to " .. tyrevalue)
	end
end

function Driver:setAIRelativeLevel()
	self.aiLevelRelative = self.aiLevel * RARE_CONFIG.data.AI.AI_RELATIVE_LEVEL / 100
	self.aiThrottleLimitBase = math.lerp(0.5, 1, 1 - ((1 - self.aiLevelRelative) / 0.3))
end

function Driver:update(dt)
	self.lapPitted = getLapPitted(self)
	self.tyreLaps = getTyreLapCount(self)
	self.pitstopCount = updatePistopCount(self)
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
