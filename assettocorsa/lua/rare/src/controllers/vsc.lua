
local VSC_CALLED = false
local VSC_DEPLOYED = false
local VSC_LAP_TIME = 180000
local VSC_START_TIMER = 1000
local VSC_END_TIMER = 3000

local function enableVSC(sim,best_lap_times)
    if VSC_CALLED and not VSC_DEPLOYED then
        VSC_LAP_TIME = math.average(best_lap_times) / 0.31
        if VSC_LAP_TIME == 0 or VSC_LAP_TIME == nil then
            VSC_LAP_TIME = 180000
        end
        ac.log(VSC_LAP_TIME)
        VSC_DEPLOYED = true
        ac.log("Virtual Safety Car Deployed. No overtaking!")
        showNotification("VIRTUAL SAFETY CAR DEPLOYED")
        physics.overrideRacingFlag(ac.FlagType.Caution)
    end

    if not VSC_CALLED and not VSC_DEPLOYED then
        if sim.raceFlagType == ac.FlagType.Caution then
            if VSC_START_TIMER > 0 then
                VSC_START_TIMER = VSC_START_TIMER - 1
            else
                VSC_CALLED = true
            end
        else
            VSC_START_TIMER = 1000
        end
    elseif VSC_DEPLOYED then
        VSC_CALLED = false
        VSC_START_TIMER = 5

        if VSC_END_TIMER > 0 then

            if VSC_END_TIMER == 1000 and sim.raceFlagType == not ac.FlagType.Caution then
                ac.log("Virtual Safety Car is ending soon!")
                ui.toast(ui.Icons.Warning, "[RARE] Virtual Safety Car is ending soon!")
            end
            VSC_END_TIMER = VSC_END_TIMER - 1
        else
            physics.overrideRacingFlag(ac.FlagType.None)
            if sim.raceFlagType == not ac.FlagType.Caution then
                ac.log("Virtual Safety Car ended!")
                ui.toast(ui.Icons.Warning, "[RARE] Virtual Safety Car ended!")
                VSC_DEPLOYED = false
            else
                VSC_END_TIMER = 500
            end
        end
    end
end

local function controlVSC(sim,driver)
    local vsc_lap_time = VSC_LAP_TIME
    setDriverDRS(driver,false)

    if driver.car.estimatedLapTimeMs < vsc_lap_time then
        ac.log(driver.index.." estimated: "..driver.car.estimatedLapTimeMs)

        if driver.car.isAIControlled then
            physics.setAIThrottleLimit(driver.index, 0.3)
        else
            ui.toast(ui.Icons.Warning, "[RARE] Exceeding the pace of the Virtual Safety Car!")
        end
    end
end