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

--- Sets the on track order of drivers
--- and excludes drivers in the pitlane
function setTrackOrder()
    --ac.perfBegin("3.setTrackOrder")
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

    --ac.perfEnd("3.setTrackOrder")
end

