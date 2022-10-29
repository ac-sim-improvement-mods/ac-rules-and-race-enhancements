WET_TRACK = false
DRS_ENABLED = false
DRS_ZONES = nil
DRS_ENABLED_LAP = 0

--- Checks if driver is before the detection line, not in the pits, 
--- not in a drs zone, and within 1 second of the car ahead on track
---@param driver Driver
function drsAvailable(driver)
    if not driver.car.isInPitlane then
        local inGap = checkGap(driver)
        local inDrsZone = driver.car.drsAvailable

        if crossedDetectionLine(driver) == false then
            driver.drsCheck = inGap
            if driver.drsAvailable and inDrsZone and driver.car.drsActive then 
                driver.drsDeployable = true
            elseif driver.drsAvailable and not inDrsZone and driver.drsDeployable then
                driver.drsAvailable = false
                driver.drsDeployable = false
            end
        else
            driver.drsAvailable = driver.drsCheck
            driver.drsDeployable = false
        end
    else
        driver.drsAvailable = false
    end
end

-- Determines if the track is too wet for DRS to be enabled
---@return boolean
function rainCheck(sim)
    local wet_limit = F1RegsConfig.data.RULES.DRS_WET_LIMIT/100
    local track_rain_intensity = sim.rainIntensity
    local track_wetness = sim.rainWetness
    local track_puddles = sim.rainWater

    local total_wetness = ((track_wetness/5) + (track_puddles*10))/2
    if total_wetness >= wet_limit then
        if not WET_TRACK then
            log("[Race Control] DRS Disabled | Conditions too wet")
            showNotification("DRS DISABLED | WET TRACK")
        end

        WET_TRACK = true
        DRS_ENABLED = false
    else
        if WET_TRACK then
            if total_wetness >= wet_limit - 0.05 and
            track_rain_intensity > 0.70 then
            else
                DRS_ENABLED_LAP = LEADER_LAPS + 2
                WET_TRACK = false

                log("[Race Control] Track is drying. DRS enabled in 2 laps on lap "..DRS_ENABLED_LAP)
                showNotification("DRS ENABLED IN 2 LAPS")
            end
        end
    end
end

--- Control the DRS functionality
---@param driver Driver
function controlDRS(sim,driver)
    --ac.perfBegin("drs")
    DRS_ENABLED = enableDRS(sim)
    if sim.isSessionStarted then
        drsAvailable(driver)

        if DRS_ENABLED then
            setDriverDRS(driver,driver.drsAvailable)
        else
            setDriverDRS(driver,false)
        end
    end

    --ac.perfEnd("drs")
end

--- Converts session type number to the corresponding session type string 
---@param driver Driver
---@return boolean
function getNextDetectionLine(driver)
    --ac.perfBegin("getNextDetection")
    local drs_zones = DRS_ZONES
    local closestStart = 0
    local drsZone = 0
    local drsZonePrev = 0

    --- Get next detection line
    for zone_index=0, drs_zones.zoneCount-1 do
        local startDistance = (DRS_ZONES.startZones[zone_index])-driver.car.splinePosition
        if startDistance <= 0 then startDistance = startDistance + 1 end

        if zone_index == 0 then
            closestStart = startDistance
            drsZone = 0
            drsZonePrev = drs_zones.zoneCount-1
        else
            if startDistance < closestStart then
                closestStart = startDistance
                drsZone = zone_index
                drsZonePrev = zone_index - 1
            end
        end
    end

    driver.drsZoneId = drsZone
    driver.drsZonePrevId = drsZonePrev

    --ac.perfEnd("getNextDetection")
    return false
end

--- Locks the specified driver's DRS
---@param driver Driver
function setDriverDRS(driver,allowed)
    physics.allowCarDRS(driver.index,not allowed)
    if driver.car.isAIControlled then
        if not allowed then
            physics.setCarDRS(driver.index, false)

        elseif allowed and 
            driver.car.brake < 0.5 and driver.car.speedKmh > 50 and getEndDistanceM(ac.getSim(),driver) > 100 then
            physics.setCarDRS(driver.index, true)
        end
    end
end

--- Enable DRS functionality if the lead driver has completed the specified numbers of laps
---@return boolean
function enableDRS(sim)
    rainCheck(sim)
    if not WET_TRACK then
        if LEADER_LAPS >= DRS_ENABLED_LAP then
            if not DRS_ENABLED then
                log("[Race Control] DRS Enabled")
                showNotification("DRS ENABLED")
            end
            return true
        else
            return false
        end
    else
        return false
    end
end

--- Checks if delta is within 1 second
---@param driver Driver
---@return boolean
function checkGap(driver)
    local delta = getDelta(driver)
    driver.carAheadDelta = delta
    return ((delta <= F1RegsConfig.data.RULES.DRS_GAP_DELTA/1000 and delta > 0.0) and true or false)
end

---@class DRS_Points
---@param fileName string
---@return DRS_Points
DRS_Points = class('DRS_Points', function(fileName)
    local ini = ac.INIConfig.trackData(fileName)
    local detectionZones = {}
    local startZones = {}
    local endZones = {}

    local index = 0
    while true do
        local dData = ''
        local sData = ''
        local eData = ''

        -- Extract DRS detection points from drs_zones.ini
        dData = try(function()
            return ini.sections['ZONE_'..index]['DETECTION'][1]
        end, function () end)
        sData = try(function()
            return ini.sections['ZONE_'..index]['START'][1]
        end, function () end)
        eData = try(function()
            return ini.sections['ZONE_'..index]['END'][1]
        end, function () end)

        -- If data is nil, break the while loop
        if dData == nil or sData == nil or eData == nil then break end

        -- Add data to appropriate arrays
        detectionZones[index] = tonumber(dData)
        startZones[index] = tonumber(sData)
        endZones[index] = tonumber(eData)

        log("[Loaded] DRS Zone "..index.." ["..dData..","..sData..","..eData.."]")

        index = index + 1
    end
    
    local zoneCount = index
    
    return {detectionZones = detectionZones, startZones = startZones, endZones = endZones, zoneCount = zoneCount}
end, class.NoInitialize)
