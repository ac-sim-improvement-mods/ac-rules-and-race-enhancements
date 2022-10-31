local drs = require 'src/systems/drs'
local vsc = require 'src/systems/vsc'
local ai = require 'src/systems/ai'

local racecontrol = {}

function readOnly( t )
    local proxy = {}
    local mt = {
        __index = t,
        __newindex = function ( t, k, v )
            error("attempt to update a read-only table", 2)
        end
    }
    setmetatable(proxy, mt)
    return proxy
end

local function getLeaderCompletedLaps()
    for i=0, ac.getSim().carsCount - 1 do
        local car = ac.getCar(i)

        if car.racePosition == 1 then
            return car.lapCount
        end
    end
end

local function isDrsEnabled(rules)
    if getLeaderCompletedLaps() >= rules.DRS_ACTIVATION_LAP then
        return true
    else
        return false
    end
end

local function isTrackWet(rules)
    local sim = ac.getSim()
    local wet_limit = rules.DRS_WET_LIMIT/100
    local track_wetness = sim.rainWetness
    local track_puddles = sim.rainWater

    local total_wetness = ((track_wetness/5) + (track_puddles*10))/2

    if total_wetness >= wet_limit then
        return true
    else
        return false
    end
end

--- Sets the on track order of drivers
--- and excludes drivers in the pitlane
local function getTrackOrder(drivers)
    local trackOrder = {}
    for index=0, #drivers do
        if not drivers[index].isInPitlane then
            table.insert(trackOrder,drivers[index])
        else
            drivers[index].trackPosition = -1
        end
    end

    -- Sort drivers by position on track, and ignore drivers in the pits
    table.sort(trackOrder, function (a,b) return a.car.splinePosition > b.car.splinePosition end)

    for trackPos=1, #trackOrder do
        local index = trackOrder[trackPos].index
        drivers[index].trackPosition = trackPos

        if trackPos == 1 then
            drivers[index].carAhead = trackOrder[#trackOrder].index
        else
            drivers[index].carAhead = trackOrder[trackPos - 1].index
        end
    end

    return #trackOrder
end


function racecontrol.getRaceControl()
    local rules = F1RegsConfig.data.RULES
    local drivers = DRIVERS
    local carsOnTrackCount = getTrackOrder(drivers)
    local leaderCompletedLaps = getLeaderCompletedLaps()
    local drsEnabled = isDrsEnabled(rules)
    local wetTrack = isTrackWet(rules)

    return readOnly{
        carsOnTrackCount = carsOnTrackCount,
        leaderCompletedLaps = leaderCompletedLaps,
        drsEnabled = drsEnabled,
        wetTrack = wetTrack
    }
end

function racecontrol.race()
    local rc = racecontrol.getRaceControl()
    local drivers = DRIVERS

    for i=0, #drivers do
        local driver = drivers[i]
        drs.controller(driver,rc.drsEnabled)
        DRIVERS[i] = driver
    end
end

return racecontrol