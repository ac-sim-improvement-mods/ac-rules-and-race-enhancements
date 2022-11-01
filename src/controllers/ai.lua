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
            if avgTyreWearBelowLimit(driver) or singleTyreWearBelowLimit(driver) then
                triggerPitStop(driver)
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
    local maxAggression = ac.load("app.F1Regs."..driver.index..".AI_Aggression")

    local newAggression = math.lerp(0, maxAggression, 1-delta+0.2)

    physics.setAIAggression(driver.index, math.clamp(newAggression,0,maxAggression))
end

return ai