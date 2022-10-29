---@class Driver
---@param carIndex number
---@return Driver
Driver = class('Driver', function(carIndex)
    local car = ac.getCar(carIndex)

    local index = carIndex
    local lapsCompleted = car.lapCount
    local name = ac.getDriverName(carIndex)

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

    local drsActivationZone = false
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

    return {
    tyreLaps = tyreLaps, lapPitted = lapPitted,
    drsBeepFx = drsBeepFx, drsFlapFx = drsFlapFx,
    drsDeployable = drsDeployable, drsZonePrevId = drsZonePrevId, drsZoneId = drsZoneId, 
    drsActivationZone = drsActivationZone, drsAvailable = drsAvailable, drsCheck = drsCheck,
    aiTyreSingleRandom = aiTyreSingleRandom, aiTyreAvgRandom = aiTyreAvgRandom, aiPitting = aiPitting, aiPitCall = aiPitCall, aiPrePitFuel = aiPrePitFuel, aiLevel = aiLevel, aiAggression = aiAggression, 
    returnPostionTimer = returnPostionTimer, returnRacePosition = returnRacePosition, timePenalty = timePenalty, illegalOvertake = illegalOvertake,
    carAheadDelta = carAheadDelta, carAhead = carAhead, trackPosition = trackPosition,
    lapsCompleted = lapsCompleted, index = index,  name = name, car = car
    }
end, class.NoInitialize)