function aiPitNewTires(sim,driver)
    --ac.perfBegin("5.aiPitNewTires")
    local avgTyreLimit = 1 - (F1RegsConfig.data.RULES.AI_AVG_TYRE_LIFE + driver.aiTyreAvgRandom)/100
    local singleTyreLimit = 1 - (F1RegsConfig.data.RULES.AI_SINGLE_TYRE_LIFE + driver.aiTyreSingleRandom)/100

    if driver.car.isAIControlled then
        if not driver.car.isInPitlane then
            if driver.aiPitCall then
                driver.aiPitCall = false
                driver.aiPitting = true
                physics.setCarFuel(driver.index, driver.aiPrePitFuel)
            elseif not driver.aiPitting then
                if LEADER_LAPS < ac.getSession(sim.currentSessionIndex).laps - 5 then
                    local avg_tyre_wear = ((driver.car.wheels[0].tyreWear + 
                                            driver.car.wheels[1].tyreWear +
                                            driver.car.wheels[2].tyreWear +
                                            driver.car.wheels[3].tyreWear) / 4)
                    if avg_tyre_wear > avgTyreLimit or 
                    driver.car.wheels[0].tyreWear > singleTyreLimit or
                    driver.car.wheels[1].tyreWear > singleTyreLimit or
                    driver.car.wheels[2].tyreWear > singleTyreLimit or
                    driver.car.wheels[3].tyreWear > singleTyreLimit then
                        --physics.setCarPenalty(ac.PenaltyType.MandatoryPits,1)
                        driver.aiPrePitFuel = driver.car.fuel
                        physics.setCarFuel(driver.index, 0.1)
                        driver.aiPitCall = true
                    end
                end
            end
        else            
            if driver.car.isInPit then
                physics.setCarFuel(driver.index, driver.aiPrePitFuel)
                driver.aiPitting = false
                driver.tyreLaps = 0
            else
                driver.aiPrePitFuel = driver.car.fuel
            end
        end
    end

    --ac.perfEnd("5.aiPitNewTires")
end

function alternateAIAttack(driver)
    --ac.perfBegin("attack")
    local delta = driver.carAheadDelta
    local defaultAgression = driver.aiAggression
    local defaultLevel = driver.aiLevel
    
    if delta < 0.6 and delta >= 0.3 then
        physics.setAIAggression(driver.index, math.clamp(defaultAgression + 0.15,0,0.60))
    elseif delta < 0.3 and delta >= 0 then
        physics.setAIAggression(driver.index, math.clamp(defaultAgression + 0.05,0,0.60))
    else
        physics.setAIAggression(driver.index, 0)
    end

    --ac.perfEnd("attack")
end