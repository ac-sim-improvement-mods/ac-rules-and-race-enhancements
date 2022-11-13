local connection = {}

local F1RegsData = ac.connect({
    ac.StructItem.key('F1RegsData'),
    connected = ac.StructItem.boolean(),
    scriptVersionId = ac.StructItem.int16(),
    drsEnabled = ac.StructItem.boolean(),
    drsAvailable = ac.StructItem.array(ac.StructItem.boolean(),32),
    carAhead = ac.StructItem.array(ac.StructItem.int16(),32),
    carAheadDelta = ac.StructItem.array(ac.StructItem.float(),32),
},false,ac.SharedNamespace.Shared)

local F1RegsDataPrivate = ac.connect({
    ac.StructItem.key('F1RegsDataPrivate'),
    aiLevelDefault = ac.StructItem.array(ac.StructItem.float(),32),
    aiAggressionDefault = ac.StructItem.array(ac.StructItem.float(),32),
},false,ac.SharedNamespace.Shared)

--- Stores race control data
--- @param rc race_control
function connection.storeRaceControlData(rc)
    F1RegsData.connected = true
    F1RegsData.scriptVersionId = SCRIPT_VERSION_CODE
    F1RegsData.drsEnabled = rc.drsEnabled
end

--- Stores driver data
--- @param driver Driver
function connection.storeDriverData(driver)
    F1RegsData.drsAvailable[driver.index] = driver.drsAvailable
    F1RegsData.carAhead[driver.index] = driver.carAhead
    F1RegsData.carAheadDelta[driver.index] = driver.carAheadDelta
end

--- Stores default AI level and aggression
--- @param driver Driver
function connection.storeDefaultData(driver)
    F1RegsDataPrivate.aiLevelDefault[driver.index] = driver.car.aiLevel
    F1RegsDataPrivate.aiAggressionDefault[driver.index] = driver.car.aiAggression
end

function connection.getDefaultLevel(index)
    return F1RegsDataPrivate.aiLevelDefault[index]
end

function connection.getDefaultAggression(index)
    return F1RegsDataPrivate.aiAggressionDefault[index]
end

return connection