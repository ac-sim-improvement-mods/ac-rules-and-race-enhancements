local drs = {}

---@class DRS_Points
---@param fileName string
---@return DRS_Points
DrsZones = class('DRS_Points', function()
    local ini = ac.INIConfig.trackData('drs_zones.ini')
    local detectionZones = {}
    local startZones = {}
    local endZones = {}

    local index = 0
    while true do
        local detectionData = ''
        local startData = ''
        local endData = ''

        -- Extract DRS detection points from drs_zones.ini
        detectionData = try(function()
            return ini.sections['ZONE_'..index]['DETECTION'][1]
        end, function () end)
        startData = try(function()
            return ini.sections['ZONE_'..index]['START'][1]
        end, function () end)
        endData = try(function()
            return ini.sections['ZONE_'..index]['END'][1]
        end, function () end)

        -- If data is nil, break the while loop
        if detectionData == nil or startData == nil or endData == nil then break end

        -- Add data to appropriate arrays
        detectionZones[index] = tonumber(detectionData)
        startZones[index] = tonumber(startData)
        endZones[index] = tonumber(endData)

        log("[Loaded] DRS Zone "..index.." ["..detectionData..","..startData..","..endData.."]")

        index = index + 1
    end
    
    local count = index
    
    return {detectionZones = detectionZones, startZones = startZones, endZones = endZones, count = count}
end, class.NoInitialize)

--- Checks if driver is before the detection line, not in the pits, 
--- not in a drs zone, and within 1 second of the car ahead on track
---@param driver Driver
local function setDrsAvailable(driver)
    if not driver.car.isInPitlane then
        local inDrsZone = driver.car.drsAvailable

        if crossedDetectionLine(driver) == false then
            driver.drsCheck = inDrsRange(driver)
            if driver.drsAvailable and inDrsZone and driver.car.drsActive then 
                driver.drsDeployable = true
                driver.drsAvailable = true
            elseif driver.drsAvailable and not inDrsZone and driver.drsDeployable then
                driver.drsDeployable = false
                driver.drsAvailable = false
            end
        else
            driver.drsDeployable = false
            driver.drsAvailable = driver.drsCheck
        end
    else
        driver.drsAvailable = false
    end
end

--- Converts session type number to the corresponding session type string 
---@param driver Driver
local function setDriverDrsZones(driver)
    local detectionZones = DRS_ZONES.detectionZones
    local closestDetection = 0
    local drsZoneNext = 0
    local drsZone = 0
    local drsZonePrev = 0

    --- Get next detection line
    for i=0, #detectionZones do
        local detectionDistance = detectionZones[i] - driver.car.splinePosition
        if detectionDistance <= 0 then detectionDistance = detectionDistance + 1 end

        if i == 0 then
            closestDetection = detectionDistance
            drsZoneNext = 0
        else
            if detectionDistance < closestDetection then
                closestDetection = detectionDistance

                drsZoneNext = i
            end
        end
    end

    if drsZoneNext == 0 then
        drsZone = #detectionZones
    else
        drsZone = drsZoneNext - 1
    end

    if drsZone == 0 then
        drsZonePrev = #detectionZones
    else
        drsZonePrev = drsZone - 1
    end

    driver.drsZoneNextId = drsZoneNext
    driver.drsZoneId = drsZone
    driver.drsZonePrevId = drsZonePrev
end

--- Locks the specified driver's DRS
---@param driver Driver
local function setDriverDRS(driver,allowed)
    physics.allowCarDRS(driver.index,not allowed)
    if driver.car.isAIControlled then
        if not allowed then
            physics.setCarDRS(driver.index, false)
        elseif allowed and 
            driver.car.brake < 0.5 and driver.car.speedKmh > 50 and getEndLineDistanceM(driver) > 175 then
            physics.setCarDRS(driver.index, true)
        end
    end
end

--- Checks if delta is within 1 second
---@param driver Driver
---@return boolean
function inDrsRange(driver)
    local delta = getDelta(driver)
    driver.carAheadDelta = delta
    return ((delta <= F1RegsConfig.data.RULES.DRS_GAP_DELTA/1000 and delta > 0.0) and true or false)
end

function inDeployZone(driver)
    local zones = DRS_ZONES
    local track_pos = driver.car.splinePosition
    local detection_line = zones.detectionZones[driver.drsZoneId]
    local start_line = zones.startZones[driver.drsZonePrevId]

    -- This handles when a DRS start zone is past the finish line after the detection zone
    if detection_line > start_line then
        if track_pos >= 0 and track_pos < start_line then
            track_pos = track_pos + 1
        end

        start_line = start_line + 1
    end

    -- If driver is between the end zone of the previous DRS zone, and the detection line of the upcoming DRS zone
    if track_pos >= detection_line and track_pos < start_line then
        return true
    else
        return false
    end
end

--- Returns the main driver's distance to the detection line in meters
---@param driver Driver
---@return number
function getZoneLineDistanceM(zones,driver,drsZoneId)
    local sim = ac.getSim()
    local zoneLine = zones[drsZoneId]
    local distance = zoneLine - driver.car.splinePosition
    if distance <= 0 then distance = distance + 1 end
    return math.round(math.clamp(distance*sim.trackLengthM,0,10000), 5)
end

--- Returns the main driver's distance to the detection line in meters
---@param driver Driver
---@return number
function getDetectionLineDistanceM(driver)
    local drsZoneId = driver.drsZoneNextId
    return getZoneLineDistanceM(DRS_ZONES.detectionZones,driver,drsZoneId)
end

--- Returns the main driver's distance to the detection line in meters
---@param driver Driver
---@return number
function getStartLineDistanceM(driver)
    local drsZoneId = driver.drsZoneNextId
    return getZoneLineDistanceM(DRS_ZONES.startZones,driver,drsZoneId)
end

--- Returns the main driver's distance to the detection line in meters
---@param driver Driver
---@return number
function getEndLineDistanceM(driver)
    local endLineDistanceM = getZoneLineDistanceM(DRS_ZONES.endZones,driver,driver.drsZoneId)
    local startLineDistanceM = getZoneLineDistanceM(DRS_ZONES.startZones,driver,driver.drsZoneNextId)

    return startLineDistanceM < endLineDistanceM and 
        getZoneLineDistanceM(DRS_ZONES.endZones,driver,driver.drsZoneNextId) or 
        getZoneLineDistanceM(DRS_ZONES.endZones,driver,driver.drsZoneId)
end

function crossedDetectionLine(driver)
    local zones = DRS_ZONES
    local track_pos = driver.car.splinePosition
    local detection_line = zones.detectionZones[driver.drsZoneId]
    local start_line = zones.startZones[driver.drsZoneId]

    -- This handles when a DRS start zone is past the finish line after the detection zone
    if detection_line > start_line then
        if track_pos >= 0 and track_pos < start_line then
            track_pos = track_pos + 1
        end

        start_line = start_line + 1
    end

    -- If driver is between the end zone of the previous DRS zone, and the detection line of the upcoming DRS zone
    if track_pos >= detection_line and track_pos < start_line then
        return true
    else
        return false
    end
end

function drs.controller(driver,drsEnabled)
    setDriverDrsZones(driver)
    setDrsAvailable(driver)
    if drsEnabled then
        setDriverDRS(driver,driver.drsAvailable)
    else
        setDriverDRS(driver,false)
    end
end

return drs