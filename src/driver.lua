
---@class Driver
---@param carIndex number
---@return Driver
Driver = class('Driver', function(carIndex)
    local index = carIndex
    
    local car = ac.getCar(index)
    local name = ac.getDriverName(index)

    local lapsCompleted = car.lapCount

    local aiTyreAvgRandom =0
    local aiTyreSingleRandom =0
    local aiLevel = car.aiLevel
    local aiAggression = car.aiAggression
    local aiPrePitFuel = 0
    local aiPitCall = false
    local aiPitting = false
    
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

    if car.isAIControlled and not ac.getSim().isSessionStarted then
        physics.setCarFuel(index, car.maxFuel)
    end

    for i=0, math.random(index + 1) do
        math.randomseed(os.time()*i + 1)
        math.random()
    end

    aiTyreAvgRandom = math.random(-F1RegsConfig.data.RULES.AI_AVG_TYRE_LIFE_RANGE,F1RegsConfig.data.RULES.AI_AVG_TYRE_LIFE_RANGE)
    aiTyreSingleRandom = math.random(-F1RegsConfig.data.RULES.AI_SINGLE_TYRE_LIFE_RANGE,F1RegsConfig.data.RULES.AI_SINGLE_TYRE_LIFE_RANGE)

    log("[Loaded] Driver ["..index.."] "..name)

    return {
        tyreLaps = tyreLaps, lapPitted = lapPitted,
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
    return driver.car.lapCount - driver.lapPitted
end

function Driver:update()
    self.lapPitted = getLapPitted(self)
    self.tyreLaps = getTyreLapCount(self)
end

