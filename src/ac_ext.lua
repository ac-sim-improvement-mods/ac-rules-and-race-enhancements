--- Returns the main driver's track position in meters
---@param index number
---@return number
function getTrackPositionM(index)
    return ac.worldCoordinateToTrackProgress(ac.getCar(index).position)*ac.getSim().trackLengthM
end

--- Returns time delta (s) between the driver and driver ahead on track
---@param driver Driver
---@return number
function getDelta(driver)
---@diagnostic disable-next-line: return-type-mismatch
    return math.round((ac.getCar(driver.carAhead).splinePosition - driver.car.splinePosition) / (driver.car.speedKmh / 3.6) * ac.getSim().trackLengthM,5)
end


--- Is the installed CSP version compatible with F1 Regs
--- @return boolean
function compatibleCspVersion()
    if ac.getPatchVersionCode() < CSP_MIN_VERSION_ID then
        return false
    else
        return true
    end
end

DRS_FLAP = ui.MediaPlayer()
DRS_BEEP = ui.MediaPlayer()

function audioHandler(sim)
    local driver = DRIVERS[ac.getSim().focusedCar]

    if sim.cameraMode < 3 and sim.isWindowForeground then
        if driver.drsBeepFx and driver.car.drsAvailable and driver.drsAvailable then
            driver.drsBeepFx = false
            DRS_BEEP:play()
        elseif not driver.car.drsAvailable and driver.drsAvailable then
            driver.drsBeepFx = true
        end
    
        if driver.drsFlapFx ~= driver.car.drsActive then
            driver.drsFlapFx = driver.car.drsActive
            DRS_FLAP:play()
        end

        DRIVERS[ac.getSim().focusedCar] = driver
    end
end

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

--- Sets the on track order of drivers
--- and excludes drivers in the pitlane
function setTrackOrder()
    local trackOrder = {}
    local drivers = DRIVERS
    for index=0, #drivers do
        if not drivers[index].isInPitlane then
            table.insert(trackOrder,drivers[index])
        else
            drivers[index].trackPosition = -1
        end
    end

    -- Sort drivers by position on track, and ignore drivers in the pits
    table.sort(trackOrder, function (a,b) return a.car.splinePosition > b.car.splinePosition end)

    for index=1, #trackOrder do
        drivers[trackOrder[index].index].trackPosition = index

        if index == 1 then
            drivers[trackOrder[index].index].carAhead = trackOrder[#trackOrder].index
        else
            drivers[trackOrder[index].index].carAhead = trackOrder[index - 1].index
        end
    end

    DRIVERS_ON_TRACK = #trackOrder
    DRIVERS = drivers
end

function setLeaderLaps(driver)
    if driver.car.racePosition == 1 then
        LEADER_LAPS = driver.car.lapCount+1
    end
end
