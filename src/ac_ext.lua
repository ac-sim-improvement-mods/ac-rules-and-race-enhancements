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

function audioHandler()
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

