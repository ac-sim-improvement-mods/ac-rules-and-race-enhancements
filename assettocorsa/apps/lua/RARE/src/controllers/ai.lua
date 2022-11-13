local ai = {}

local connect = require 'src/connection'

AI_COMP_OVERRIDE = false
AI_THROTTLE_LIMIT = 0.8
AI_LEVEL = 0.9
AI_AGGRESSION = 0.25

--- Returns whether driver's average tyre life is below
--- the limit or not
---@param driver Driver
---@return bool
local function avgTyreWearBelowLimit(driver)
    local avgTyreLimit = 1 - (RAREConfig.data.RULES.AI_AVG_TYRE_LIFE + driver.aiTyreAvgRandom)/100
    local avgTyreWear = (driver.car.wheels[0].tyreWear +
                            driver.car.wheels[1].tyreWear +
                            driver.car.wheels[2].tyreWear +
                            driver.car.wheels[3].tyreWear) / 4
    return avgTyreWear > avgTyreLimit and true or false
end

---@alias ai.QualifyLap
---| `ai.QualifyLap.OutLap` @Value: 0.
---| `ai.QualifyLap.FlyingLap` @Value: 1.
---| `ai.QualifyLap.InLap` @Value: 2.
ai.QualifyLap = {
    OutLap = 0,
    FlyingLap = 1,
    InLap = 3
} 

--- Returns whether one of a driver's tyre life is below
--- the limit or not
---@param driver Driver
---@return bool
local function singleTyreWearBelowLimit(driver)
    local singleTyreLimit = 1 - (RAREConfig.data.RULES.AI_SINGLE_TYRE_LIFE + driver.aiTyreSingleRandom)/100

    if driver.car.wheels[0].tyreWear > singleTyreLimit or
            driver.car.wheels[1].tyreWear > singleTyreLimit or
            driver.car.wheels[2].tyreWear > singleTyreLimit or
            driver.car.wheels[3].tyreWear > singleTyreLimit then
        return true
    else
        return false
    end
end

--- Force AI driver to drive to the pits
--- @param driver Driver
local function triggerPitStop(driver)
    driver.aiPrePitFuel = driver.car.fuel
    physics.setCarFuel(driver.index, 0.1)
    driver.aiPitCall = true
end

--- Determine if going to the pits is advantageous or not
--- @param driver Driver
--- @param forced boolean
local function strategyCall(driver,forced)
    local carAhead = DRIVERS[driver.carAhead]
    local trigger = true
    local lapsTotal = ac.getSession(ac.getSim().currentSessionIndex).laps
    local lapsRemaining = lapsTotal - driver.lapsCompleted
    
    if driver.car.splinePosition > 0.8 then
        trigger = false
    else
        if not forced then
            if not carAhead.aiPitCall and driver.carAheadDelta < 1 then
                trigger = false
            end
    
            if lapsRemaining <= 5 then
                trigger = false
            end
        end
    end

    if trigger then triggerPitStop(driver) end
end

--- Handles driver state when pitstop gets triggered.
--- Resets fuel to pre pit call state
---@param driver Driver
local function catchTriggeredPitStop(driver)
    driver.aiPitCall = false
    driver.aiPitting = true
    physics.setCarFuel(driver.index, driver.aiPrePitFuel)
end

--- Occurs when a driver is in the pit
---@param driver Driver
local function pitstop(driver)
    if RAREConfig.data.RULES.RACE_REFUELING == 0 then physics.setCarFuel(driver.index, driver.aiPrePitFuel) end
    driver.aiPitting = false
    driver.tyreLaps = 0
end

--- Sets drivers pre pit fuel value
local function setPrePitFuel(driver)
    driver.aiPrePitFuel = driver.car.fuel
end

--- Determines when an AI driver should pit for new tyres
--- @param driver Driver
function ai.pitNewTires(driver)
    if not driver.car.isInPitlane and not driver.aiPitting then
        if driver.aiPitCall then
            catchTriggeredPitStop(driver)
        else
            if singleTyreWearBelowLimit(driver) then
                strategyCall(driver,true)
            elseif avgTyreWearBelowLimit(driver) then
                strategyCall(driver, false)
            end
        end
    else            
        if driver.car.isInPit then
            pitstop(driver)
        else
            setPrePitFuel(driver)
        end
    end
end

local function moveOffRacingLine(driver)
    local delta = driver.carAheadDelta
    local driverAhead = DRIVERS[driver.carAhead]
    local splineSideLeft = ac.getTrackAISplineSides(driverAhead.splinePosition).x
    local splineSideRight = ac.getTrackAISplineSides(driverAhead.splinePosition).y
    local offset = splineSideLeft > splineSideLeft and -3 or 3

    if not driverAhead.flyingLap then

        if delta < 2 and delta > 0.1 then
            if driverAhead.car.isInPitlane then
                physics.setAITopSpeed(driverAhead.index, 0)
            else
                if ac.getTrackUpcomingTurn(driverAhead.index).x > 100 then
                    physics.setAISplineOffset(driverAhead.index,math.lerp(0,offset,driverAhead.aiSplineOffset))
                    physics.setAISplineOffset(driver.index,math.lerp(0,-offset,driver.aiSplineOffset))
                    physics.setAITopSpeed(driverAhead.index,200)
                    driverAhead.aiMoveAside = true
                    driverAhead.aiSpeedUp = false
                else
                    driverAhead.aiSplineOffset = math.lerp(offset,0,driverAhead.aiSplineOffset)
                    driver.aiSplineOffset = math.lerp(-offset,0,driver.aiSplineOffset)
                    physics.setAISplineOffset(driverAhead.index,driverAhead.aiSplineOffset)
                    physics.setAISplineOffset(driver.index,driver.aiSplineOffset)
                    physics.setAITopSpeed(driverAhead.index,1e9)
                    driverAhead.aiMoveAside = false
                    driverAhead.aiSpeedUp = true
                end
            end
        else
            driverAhead.aiSplineOffset = math.lerp(offset,0,driverAhead.aiSplineOffset)
            driver.aiSplineOffset = math.lerp(-offset,0,driver.aiSplineOffset)
            physics.setAISplineOffset(driverAhead.index,driverAhead.aiSplineOffset)
            physics.setAISplineOffset(driver.index,driver.aiSplineOffset)
            driverAhead.aiMoveAside = false
            driverAhead.aiSpeedUp = false
        end
    end
end

function ai.qualifying(driver)
    if driver.car.isInPitlane then
        physics.allowCarDRS(driver.index,true)
        if driver.car.isInPit then
            local qualiRunFuel = driver.fuelPerLap * 3.5
            physics.setCarFuel(driver.index,qualiRunFuel)
        end
        driver.inLap = false
        driver.flyingLap = false
        driver.outLap = true
    else
        if driver.flyingLap then
            moveOffRacingLine(driver)
            if ac.getTrackUpcomingTurn(driver.index).x > 200 then
                physics.setAIAggression(driver.index, 1)
            else
                physics.setAIAggression(driver.index, 0.25)
            end

            if driver.car.lapCount >= driver.inLapCount then
                driver.outLap = false
                driver.flyingLap = false
                driver.inLap = true
            end
        elseif driver.outLap then
            if driver.car.splinePosition <= 0.8 then 
                if not driver.aiMoveAside and not driver.aiSpeedUp then
                    physics.setAITopSpeed(driver.index, 250)
                    physics.setAILevel(driver.index,0.8)
                    physics.setAIAggression(driver.index, 1)
                    physics.allowCarDRS(driver.index,true)
    
                    if driver.carAheadDelta < 5 then
                        physics.setAITopSpeed(driver.index, 200)
                    end
                elseif driver.aiSpeedUp then
                    moveOffRacingLine(driver)
                end
            else 
                physics.setAITopSpeed(driver.index, 1e9)
                physics.setAILevel(driver.index,1)
                physics.setAIAggression(driver.index, 1)
                physics.allowCarDRS(driver.index,false)
                driver.outLap = false
                driver.flyingLap = true
                driver.inLapCount = driver.car.lapCount + 2
            end 
        elseif driver.inLap then
            if not driver.aiMoveAside and not driver.aiSpeedUp then 
                physics.setAITopSpeed(driver.index, 200)
                physics.setAILevel(driver.index,0.65)
                physics.setAIAggression(driver.index, 0)
            elseif driver.aiSpeedUp then
                moveOffRacingLine(driver)
            end
        end
    end
end

--- Variable aggression function for AI drivers
--- @param driver Driver
function ai.alternateAttack(driver)
    local override = AI_COMP_OVERRIDE
    local delta = driver.carAheadDelta
    local speedMod = math.clamp(200/(driver.car.speedKmh or 200),1,2)
    local maxAggression = driver.aiAggression
    local upcomingTurn = ac.getTrackUpcomingTurn(driver.index)
    local upcomingTurnDistance = upcomingTurn.x
    local upcomingTurnAngle = upcomingTurn.y
    
    -- if upcomingTurnDistance >= 250 then
    --     maxAggression = maxAggression + (maxAggression*0.25)
    -- else
    --     if upcomingTurnAngle < 90 then
    --         maxAggression = maxAggression / speedMod
    --     end
    -- end

    if delta > 0.2 then
        if math.abs(upcomingTurnAngle) < 30 and upcomingTurnDistance <= 50 then
            if driver.car.speedKmh < 100 then
                physics.setAIAggression(driver.index, 1)
            else
                physics.setAIAggression(driver.index, 0.6)
            end
        elseif upcomingTurnDistance > 200 and delta > 0.5 then
            physics.setAIAggression(driver.index, 1)
        end
    end

    if delta < 1 then
        physics.setAILevel(driver.index, 1)
    else
        if not override then
            physics.setAILevel(driver.index, 0.9)
        else
            physics.setAILevel(driver.index, AI_LEVEL)
        end
    end

    if upcomingTurnDistance > 200 or math.abs(upcomingTurnAngle) < 30 then
        physics.setAIThrottleLimit(driver.index, 1)
        driver.aiThrottleLimit= 1
    else
        if not override then
            physics.setAIThrottleLimit(driver.index, driver.aiThrottleLimitBase)
            driver.aiThrottleLimit = driver.aiThrottleLimitBase
        else
            physics.setAIThrottleLimit(driver.index, AI_THROTTLE_LIMIT)
            driver.aiThrottleLimit = AI_THROTTLE_LIMIT
        end
    end
end

return ai