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

--- Converts session type number to the corresponding session type string
---@param sim ac.StateSim
---@return string
function sessionTypeString(sim)
    local sessionTypes = {
        "UNDEFINED",
        "PRACTICE",
        "QUALIFY",
        "RACE",
        "HOTLAP",
        "TIME ATTACK",
        "DRIFT",
        "DRAG"
    }

    return sessionTypes[sim.raceSessionType + 1]
end

--- Converts weather type number to the corresponding weather type string
---@param sim ac.StateSim
---@return string
function weatherTypeString(sim)
    local weatherTypes = {  
        "Light Thunderstorm", ---Value: 0.
        "Thunderstorm", ---Value: 1.
        "Heavy Thunderstorm", ---Value: 2.
        "Light Drizzle", ---Value: 3.
        "Drizzle", ---Value: 4.
        "Heavy Drizzle", ---Value: 5.
        "Light Rain", ---Value: 6.
        "Rain", ---Value: 7.
        "Heavy Rain", ---Value: 8.
        "Light Snow", ---Value: 9.
        "Snow", ---Value: 10.
        "Heavy Snow", ---Value: 11.
        "Light Sleet", ---Value: 12.
        "Sleet", ---Value: 13.
        "Heavy Sleet", ---Value: 14.
        "Clear", ---Value: 15.
        "Few Clouds", ---Value: 16.
        "Scattered Clouds", ---Value: 17.
        "Broken Clouds", ---Value: 18.
        "Overcast Clouds", ---Value: 19.
        "Fog", ---Value: 20.
        "Mist", ---Value: 21.
        "Smoke", ---Value: 22.
        "Haze", ---Value: 23.
        "Sand", ---Value: 24.
        "Dust", ---Value: 25.
        "Squalls", ---Value: 26.
        "Tornado", ---Value: 27.
        "Hurricane", ---Value: 28.
        "Cold", ---Value: 29.
        "Hot", ---Value: 30.
        "Windy", ---Value: 31.
        "Hail", ---Value: 32.
    }

    return weatherTypes[sim.weatherType + 1]
end

