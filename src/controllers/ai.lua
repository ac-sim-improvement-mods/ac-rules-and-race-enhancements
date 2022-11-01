local ai = {}

local function avgTyreWearBelowLimit(driver)
    local avgTyreLimit = 1 - (F1RegsConfig.data.RULES.AI_AVG_TYRE_LIFE + driver.aiTyreAvgRandom)/100
    local avgTyreWear = (driver.car.wheels[0].tyreWear +
                            driver.car.wheels[1].tyreWear +
                            driver.car.wheels[2].tyreWear +
                            driver.car.wheels[3].tyreWear) / 4
    return avgTyreWear > avgTyreLimit and true or false
end

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

local function triggerPitStop(driver)
    driver.aiPrePitFuel = driver.car.fuel
    physics.setCarFuel(driver.index, 0.1)
    driver.aiPitCall = true
end

local function strategyCall(driver,forced)
    local carAhead = DRIVERS[driver.carAhead]
    local trigger = true
    local lapsTotal = ac.getSession(ac.getSim().currentSessionIndex).laps
    local lapsRemaining = lapsTotal - driver.lapsCompleted
    
    if not forced then
        if not carAhead.aiPitCall and driver.carAheadDelta < 1 then
            trigger = false
        end

        if lapsRemaining <= 5 then
            trigger = false
        end
    end

    if trigger then triggerPitStop(driver) end
end

local function catchTriggeredPitStop(driver)
    driver.aiPitCall = false
    driver.aiPitting = true
    physics.setCarFuel(driver.index, driver.aiPrePitFuel)
end

local function pitstop(driver)
    physics.setCarFuel(driver.index, driver.aiPrePitFuel)
    driver.aiPitting = false
    driver.tyreLaps = 0
end

local function setPrePitFuel(driver)
    driver.aiPrePitFuel = driver.car.fuel
end

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

    local newAggression = math.lerp(0, maxAggression, 1-delta+0.2)

    if maxAggression ~= nil and maxAggression > 0 then
        physics.setAIAggression(driver.index, math.clamp(newAggression,0,maxAggression))
    end
end

return ai