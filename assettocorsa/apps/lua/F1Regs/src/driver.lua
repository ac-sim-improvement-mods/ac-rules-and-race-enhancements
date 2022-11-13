local connect = require 'src/connection'

local function randomizer(index,range)
    math.random()
    for i=0, math.random(index) do
        math.randomseed(os.time()*(i+1))
        math.random()
    end

    return math.random(-range,range)
end

---@class Driver
---@param carIndex number
---@return Driver
Driver = class('Driver', function(carIndex)
    local sim = ac.getSim()
    local index = carIndex
    local car = ac.getCar(index)
    local name = ac.getDriverName(index)
    local lapsCompleted = car.lapCount

    local aiThrottleLimitBase = 0 
    local aiThrottleLimit = 1
    local aiLevel = 0
    local aiAggression = 0 -- 
    local aiPrePitFuel = 0
    local aiPitCall = false
    local aiPitting = false
    local aiSplineOffset = 0
    local aiMoveAside = false
    local aiSpeedUp = false

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
    local tyreLaps = 0

    local trackPosition = -1
    local carAhead = -1
    local carAheadDelta = -1

    local drsActivationZone = car.drsAvailable
    local drsZoneNextId = 0
    local drsZoneId = 0
    local drsZonePrevId = 0
    local drsCheck = false
    local drsAvailable = false
    local drsDeployable = false
    local drsBeepFx = false
    local drsFlapFx = false

    local timePenalty = 0
    local illegalOvertake = false
    local returnRacePosition = -1
    local returnPostionTimer = -1

    local fuelcons = ac.INIConfig.carData(index, 'fuel_cons.ini'):get('FUEL_EVAL', 'KM_PER_LITER', 0.0)
    local fuelload = 0
    local fuelPerLap =  (sim.trackLengthM / 1000) / (fuelcons - (fuelcons * 0.1))

    if sim.raceSessionType == ac.SessionType.Race then 
        fuelload = ((ac.getSession(sim.currentSessionIndex).laps + 2) * fuelPerLap)
    elseif sim.raceSessionType == ac.SessionType.Qualify then
        fuelload = 3.5 * fuelPerLap
    end

    if car.isAIControlled and not sim.isSessionStarted then
        physics.setCarFuel(index, fuelload)
    end

    local aiTyreAvgRandom = randomizer(index,F1RegsConfig.data.RULES.AI_AVG_TYRE_LIFE_RANGE)
    local aiTyreSingleRandom = randomizer(index, F1RegsConfig.data.RULES.AI_SINGLE_TYRE_LIFE_RANGE)

    log("[Loaded] Driver ["..index.."] "..name)

    return {
        aiSplineOffset = aiSplineOffset, aiSpeedUp = aiSpeedUp, aiMoveAside = aiMoveAside, inLapCount = inLapCount, inLap = inLap, flyingLap = flyingLap, outLap = outLap,
        fuelPerLap = fuelPerLap, aiThrottleLimitBase = aiThrottleLimitBase, aiThrottleLimit = aiThrottleLimit,
        pitlaneTime = pitlaneTime, pitlane = pitlane, pitstop = pitstop, pitstopTime = pitstopTime, pitted = pitted, pitstopCount = pitstopCount, tyreLaps = tyreLaps, lapPitted = lapPitted,
        drsBeepFx = drsBeepFx, drsFlapFx = drsFlapFx,
        drsZoneNextId = drsZoneNextId, drsDeployable = drsDeployable, drsZonePrevId = drsZonePrevId, drsZoneId = drsZoneId, 
        drsActivationZone = drsActivationZone, drsAvailable = drsAvailable, drsCheck = drsCheck,
        aiTyreSingleRandom = aiTyreSingleRandom, aiTyreAvgRandom = aiTyreAvgRandom, aiPitting = aiPitting, aiPitCall = aiPitCall, aiPrePitFuel = aiPrePitFuel, aiLevel = aiLevel, aiAggression = aiAggression, 
        returnPostionTimer = returnPostionTimer, returnRacePosition = returnRacePosition, timePenalty = timePenalty, illegalOvertake = illegalOvertake,
        carAheadDelta = carAheadDelta, carAhead = carAhead, trackPosition = trackPosition,
        lapsCompleted = lapsCompleted, index = index,  name = name, car = car
    }
end, class.NoInitialize)

--- Returns lap pitted or lap count if driver just pitted
---@param driver Driver
---@return number
local function getLapPitted(driver)
    if driver.tyreLaps > 0 and driver.car.isInPitlane then
       return driver.car.lapCount
    else
        return driver.lapPitted
    end
end

--- Returns tyre lap count
---@param driver Driver
---@return number
local function getTyreLapCount(driver)
    if driver.car.isInPitlane and not driver.pitted then
        return driver.tyreLaps
    else
        return driver.car.lapCount - driver.lapPitted
    end
    
end

local function getPitstopCount(driver)
    if driver.car.isInPit and not driver.pitted then
        driver.pitted = true
        driver.aiTyreAvgRandom = randomizer(driver.index,F1RegsConfig.data.RULES.AI_AVG_TYRE_LIFE_RANGE)
        driver.aiTyreSingleRandom = randomizer(driver.index,F1RegsConfig.data.RULES.AI_SINGLE_TYRE_LIFE_RANGE)
        return driver.pitstopCount + 1
    elseif not driver.car.isInPitlane and driver.pitted then
        driver.pitted = false
    end

    return driver.pitstopCount
end

local function getPitTime(dt,driver)
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

local function getPitstopTime(dt,driver)
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

function Driver:update(dt,sim)
    self.lapPitted = getLapPitted(self)
    self.tyreLaps = getTyreLapCount(self)
    self.pitstopCount = getPitstopCount(self)
    self.pitlaneTime = getPitTime(dt,self)
    self.pitstopTime = getPitstopTime(dt,self)

    if self.carAhead >= 0 then
        self.carAheadDelta = getDelta(sim,self.index,self.carAhead)
    end
end

