--- Returns the main driver's distance to the detection line in meters
---@param driver Driver
---@return numberW
function getStartDistanceM(sim,driver)
    local distance = (DRS_ZONES.startZones[driver.drsZoneId]-driver.car.splinePosition)*sim.trackLengthM
    if distance <= 0 then distance = distance + sim.trackLengthM end
    return math.round(math.clamp(distance,0,10000), 5)
end

--- Returns the main driver's distance to the detection line in meters
---@param driver Driver
---@return number
function getEndDistanceM(sim,driver)
    local distance = (DRS_ZONES.endZones[driver.drsZonePrevId]-driver.car.splinePosition)*sim.trackLengthM
    if distance <= 0 then distance = distance + sim.trackLengthM end

    return math.round(math.clamp(distance,0,10000), 5)
end

--- Returns the main driver's distance to the detection line in meters
---@param driver Driver
---@return number
function getDetectionDistanceM(sim,driver)
    local distance = (DRS_ZONES.detectionZones[driver.drsZoneId]-driver.car.splinePosition)*sim.trackLengthM
    if distance <= 0 then distance = distance + sim.trackLengthM end

    return math.round(math.clamp(distance,0,10000), 5)
end

function crossedDetectionLine(driver)
    local drs_zones = DRS_ZONES
    local track_pos = driver.car.splinePosition
    local detection_line = drs_zones.detectionZones[driver.drsZoneId]
    local start_line = drs_zones.startZones[driver.drsZoneId]

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