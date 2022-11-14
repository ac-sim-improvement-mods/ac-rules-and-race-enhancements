local connection = {}

local RAREData = ac.connect({
    ac.StructItem.key('RAREData'),
    connected = ac.StructItem.boolean(),
    scriptVersionId = ac.StructItem.int16(),
    drsEnabled = ac.StructItem.boolean(),
    drsAvailable = ac.StructItem.array(ac.StructItem.boolean(),32),
    carAhead = ac.StructItem.array(ac.StructItem.int16(),32),
    carAheadDelta = ac.StructItem.array(ac.StructItem.float(),32),
},false,ac.SharedNamespace.Shared)

local RAREDataPrivate = ac.connect({
    ac.StructItem.key('RAREDataPrivate'),
    aiLevelDefault = ac.StructItem.array(ac.StructItem.float(),32),
    aiAggressionDefault = ac.StructItem.array(ac.StructItem.float(),32),
},false,ac.SharedNamespace.Shared)

--- Stores race control data
--- @param rc race_control
function connection.storeRaceControlData(rc)
    RAREData.connected = true
    RAREData.scriptVersionId = SCRIPT_VERSION_CODE
    RAREData.drsEnabled = rc.drsEnabled
end

--- Stores driver data
--- @param driver Driver
function connection.storeDriverData(driver)
    RAREData.drsAvailable[driver.index] = driver.drsAvailable
    RAREData.carAhead[driver.index] = driver.carAhead
    RAREData.carAheadDelta[driver.index] = driver.carAheadDelta
end

--- Stores default AI level and aggression
--- @param driver Driver
function connection.storeDefaultData(driver)
    RAREDataPrivate.aiLevelDefault[driver.index] = driver.car.aiLevel
    RAREDataPrivate.aiAggressionDefault[driver.index] = driver.car.aiAggression
end

function connection.getDefaultLevel(index)
    return RAREDataPrivate.aiLevelDefault[index]
end

function connection.getDefaultAggression(index)
    return RAREDataPrivate.aiAggressionDefault[index]
end

return connection