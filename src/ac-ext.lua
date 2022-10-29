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
    local track_order = {}
    local drivers = DRIVERS
    for index=0, #drivers do
        if not drivers[index].isInPitlane then
            table.insert(track_order,drivers[index])
        else
            drivers[index].trackPosition = -1
        end
    end

    DRIVERS_ON_TRACK = #track_order

    -- Sort drivers by position on track, and ignore drivers in the pits
    table.sort(track_order, function (a,b) return a.car.splinePosition > b.car.splinePosition end)

    for index=1, #track_order do
        drivers[track_order[index].index].trackPosition = index

        if index == 1 then
            drivers[track_order[index].index].carAhead = track_order[#track_order].index
        else
            drivers[track_order[index].index].carAhead = track_order[index - 1].index
        end
    end

    DRIVERS = drivers

    --ac.perfEnd("3.setTrackOrder")
end

function setLeaderLaps(driver)
    --ac.perfBegin("5.leaderlaps")
    if driver.car.racePosition == 1 then
        LEADER_LAPS = driver.car.lapCount+1
    end
    --ac.perfEnd("5.leaderlaps")
end