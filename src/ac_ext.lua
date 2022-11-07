ac_ext = ac

--- Returns time delta (s) between the driver and driver ahead on track
---@param driver Driver
---@return number
function getDelta(sim,carIndex,car2Index)
---@diagnostic disable-next-line: return-type-mismatch
    local car = ac.getCar(carIndex)
    local car2 = ac.getCar(car2Index)
    local carPos = car.splinePosition
    local car2Pos = car2.splinePosition

    if carPos > car2Pos then
        car2Pos = car2Pos + 1
    end
    
    return (car2Pos - carPos) / (car.speedKmh / 3.6) * sim.trackLengthM
end

--- Converts session type number to the corresponding session type string
---@param sim ac.StateSim
---@return string
function ac_ext.sessionTypeString(sim)
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
function ac_ext.weatherTypeString(sim)
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

return ac_ext