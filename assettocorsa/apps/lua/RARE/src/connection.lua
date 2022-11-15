local connection = {}

local RareData = ac.connect({
    ac.StructItem.key('RareData'),
    connected = ac.StructItem.boolean(),
    scriptVersionId = ac.StructItem.int16(),
    drsEnabled = ac.StructItem.boolean(),
    drsAvailable = ac.StructItem.array(ac.StructItem.boolean(),32),
    carAhead = ac.StructItem.array(ac.StructItem.int16(),32),
    carAheadDelta = ac.StructItem.array(ac.StructItem.float(),32),
},false,ac.SharedNamespace.Shared)

local RareDataAIDefaults = ac.connect({
    ac.StructItem.key('RareDataAIDefaults'),
    aiLevelDefault = ac.StructItem.array(ac.StructItem.float(),32),
    aiAggressionDefault = ac.StructItem.array(ac.StructItem.float(),32),
},false,ac.SharedNamespace.Shared)

--- Stores race control data
--- @param rc race_control
function connection.storeRaceControlData(rc)
    RareData.connected = true
    RareData.scriptVersionId = SCRIPT_VERSION_CODE
    RareData.drsEnabled = rc.drsEnabled
end

--- Stores driver data
--- @param driver Driver
function connection.storeDriverData(driver)
    RareData.drsAvailable[driver.index] = driver.drsAvailable
    RareData.carAhead[driver.index] = driver.carAhead
    RareData.carAheadDelta[driver.index] = driver.carAheadDelta
end

--- Stores default AI level and aggression
--- @param driver Driver
function connection.storeDefaultAIData(driver)
    RareDataAIDefaults.aiLevelDefault[driver.index] = driver.car.aiLevel
    RareDataAIDefaults.aiAggressionDefault[driver.index] = driver.car.aiAggression
end

--- Returns boolean if connected to RARE
---@return connected boolean
function connection.connected()
    return RareData.connected
end

--- Returns script version ID
---@return scriptVersionId string
function connection.scriptVersionId()
    return RareData.scriptVersionId
end

--- Returns boolean DRS Enabled state
---@return drsEnabled boolean
function connection.drsEnabled()
    return RareData.drsEnabled
end

--- Returns DRS Available state for a specific car index
---@param carIndex number
---@return drsAvailable boolean
function connection.drsAvailable(carIndex)
    return RareData.drsAvailable[carIndex]
end

--- Returns car ahead on track car index for a specific car index
---@param carIndex number
---@return carAhead number
function connection.carAhead(carIndex)
    return RareData.carAhead[carIndex]
end

--- Returns car ahead on track car delta in seconds for a specific car index
---@param carIndex number
---@return carAheadDelta number
function connection.carAheadDelta(carIndex)
    return RareData.carAheadDelta[carIndex]
end

--- Returns default AI level for a specific car index
---@param carIndex number
---@return aiLevelDefault number
function connection.aiLevelDefault(carIndex)
    return RareDataAIDefaults.aiLevelDefault[carIndex]
end

--- Returns default AI aggression for a specific car index
---@param carIndex number
---@return aiAggressionDefault number
function connection.aiAggressionDefault(carIndex)
    return RareDataAIDefaults.aiAggressionDefault[carIndex]
end

return connection