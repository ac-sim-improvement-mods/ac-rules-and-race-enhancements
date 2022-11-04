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
    local carAheadSplinePosition = ac.getCar(driver.carAhead).splinePosition
    local carSplinePosition = driver.car.splinePosition
    if carSplinePosition > carAheadSplinePosition then
        carAheadSplinePosition = carAheadSplinePosition + 1
    end
    return math.round((carAheadSplinePosition - carSplinePosition) / (driver.car.speedKmh / 3.6) * ac.getSim().trackLengthM,5)
end


--- Returns state of installed CSP version being compatible with F1 Regs
--- @return boolean
function compatibleCspVersion()
    if ac.getPatchVersionCode() < CSP_MIN_VERSION_ID then
        return false
    else
        return true
    end
end

