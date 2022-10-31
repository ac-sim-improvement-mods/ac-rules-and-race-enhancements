F1RegsConfig = nil
DRIVERS = {}
DRIVERS_ON_TRACK = 0
LEADER_LAPS = 1
NOTIFICATION_TIMER = 0
NOTIFICATION_TEXT = ""

--- Controls all of the regulated systems
function controlSystems(sim)
    local drivers = DRIVERS
    local best_lap_times = {}
    local vsc_deployed = VSC_DEPLOYED
    local vsc_called = VSC_CALLED
    local config = F1RegsConfig.data.RULES

    setTrackOrder()

    for index=0, #drivers do
        local driver = drivers[index]
        setLeaderLaps(driver)


        if driver.tyreLaps > 0 and driver.car.isInPitlane then
            driver.lapPitted = driver.car.lapCount
        end

        driver.tyreLaps = driver.car.lapCount - driver.lapPitted
        if config.AI_FORCE_PIT_TYRES == 1 then aiPitNewTires(sim,driver) end
        if config.AI_AGGRESSION_RUBBERBAND == 1 then alternateAIAttack(driver) end
        if config.DRS_RULES == 1 then controlDRS(sim,driver) else driver.drsAvailable = true end

        -- if not vsc_deployed then
        --     -- controlDRS(sim,driver)
        --     -- if config.AI_AGGRESSION_RUBBERBAND == 1 then alternateAIAttack(driver) end
        -- elseif vsc_called and not vsc_deployed then
        --     if driver.car.bestLapTimeMs then
        --         best_lap_times[index] = driver.car.bestLapTimeMs
        --     end
        -- else
        --     controlVSC(sim,driver)
        -- end

        -- overtake_check(driver)
        storeData(driver)
    end

    if LEADER_LAPS >= 2 then
        if config.VSC_RULES == 1 then enableVSC(sim,best_lap_times) end
    end

end