F1RegsConfig = nil
DRIVERS = {}
DRIVERS_ON_TRACK = 0
LEADER_LAPS = 1
NOTIFICATION_TIMER = 0
NOTIFICATION_TEXT = ""

--- Controls all of the regulated systems
function controlSystems(sim)
    --ac.perfBegin("2.controlSystems")
    local drivers = DRIVERS
    local best_lap_times = {}
    local vsc_deployed = VSC_DEPLOYED
    local vsc_called = VSC_CALLED
    local config = F1RegsConfig.data.RULES

    setTrackOrder()

    --ac.perfBegin("3.driversLoop")
    for index=0, #drivers do
        --ac.perfBegin("4.driver")
        local driver = drivers[index]
        setLeaderLaps(driver)
        getNextDetectionLine(driver)

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
        --ac.perfEnd("4.driver")
    end
    --ac.perfEnd("3.driversLoop")

    if LEADER_LAPS >= 2 then
        if config.VSC_RULES == 1 then enableVSC(sim,best_lap_times) end
    end

    --ac.perfEnd("2.controlSystems")
end