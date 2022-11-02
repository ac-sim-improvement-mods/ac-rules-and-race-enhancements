local ai = {}

--- Returns whether driver's average tyre life is below
--- the limit or not
---@param driver Driver
---@return bool
local function avgTyreWearBelowLimit(driver)
    local avgTyreLimit = 1 - (F1RegsConfig.data.RULES.AI_AVG_TYRE_LIFE + driver.aiTyreAvgRandom)/100
    local avgTyreWear = (driver.car.wheels[0].tyreWear +
                            driver.car.wheels[1].tyreWear +
                            driver.car.wheels[2].tyreWear +
                            driver.car.wheels[3].tyreWear) / 4
    return avgTyreWear > avgTyreLimit and true or false
end

--- Returns whether one of a driver's tyre life is below
--- the limit or not
---@param driver Driver
---@return bool
local function singleTyreWearBelowLimit(driver)
    local singleTyreLimit = 1 - (F1RegsConfig.data.RULES.AI_SINGLE_TYRE_LIFE + driver.aiTyreSingleRandom)/100

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
    physics.setCarFuel(driver.index, driver.aiPrePitFuel)
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

--- Variable aggression function for AI drivers
--- @param driver Driver
function ai.alternateAttack(driver)
    local delta = driver.carAheadDelta
    local speedMod = math.clamp(200/(driver.car.speedKmh or 200),1,2)
    local maxAggression = ac.load("app.F1Regs."..driver.index..".AI_Aggression")
    local upcomingTurn = ac.getTrackUpcomingTurn(driver.index)
    local upcomingTurnDistance = upcomingTurn.x
    local upcomingTurnAngle = upcomingTurn.y

    if upcomingTurnDistance >= 250 then
        maxAggression = maxAggression + (maxAggression*0.25)
    else
        if upcomingTurnAngle < 90 then
            maxAggression = maxAggression / speedMod
        end
    end

    local newAggression = delta > 0 and math.lerp(0, maxAggression, 1-delta+0.2) or 0

    if maxAggression ~= nil and maxAggression > 0 then
        physics.setAIAggression(driver.index, math.clamp(newAggression,0,maxAggression))
    end
end

return ai