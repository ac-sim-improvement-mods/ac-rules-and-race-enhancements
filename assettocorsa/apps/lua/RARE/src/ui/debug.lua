function debugMenu(sim, rc, error)
    local driver = DRIVERS[sim.focusedCar]
    local math = math
    local space = 200
    ui.pushFont(ui.Font.Small)

    if error then ui.textColored(error, rgbm(1, 0, 0, 1)) end

    if not compatibleCspVersion() then
        ui.text("INCOMPATIBLE VERSION OF CSP")
        return
    end

    ui.columns(2, true, "infocol")

    inLineBulletText("CSP Version", ac.getPatchVersion(), space)
    inLineBulletText("CSP Version Code", ac.getPatchVersionCode(), space)
    inLineBulletText("Current Date", os.date("%Y-%m-%d"), space)
    ui.nextColumn()
    inLineBulletText(SCRIPT_SHORT_NAME .. " Version", SCRIPT_VERSION, space)
    inLineBulletText(SCRIPT_SHORT_NAME .. " Version Code", SCRIPT_VERSION_CODE,
                     space)
    inLineBulletText(SCRIPT_SHORT_NAME .. " Version Release Date",
                     SCRIPT_BUILD_DATE, space)
    ui.newLine()
    ui.nextColumn()

    ui.columns(2, true, "debugcol2")

    if driver.car.isAIControlled then
        ui.treeNode("[AI]",
                    ui.TreeNodeFlags.DefaultOpen and ui.TreeNodeFlags.Framed,
                    function()
            inLineBulletText("Throttle Limit",
                             "[" ..
                                 math.round(driver.aiThrottleLimitBase * 100, 2) ..
                                 "] " ..
                                 math.round(driver.aiThrottleLimit * 100, 2),
                             space)
            inLineBulletText("Level",
                             "[" .. math.round(driver.aiLevel * 100, 2) .. "] " ..
                                 math.round(driver.car.aiLevel * 100, 2), space)
            inLineBulletText("Aggression",
                             "[" .. math.round(driver.aiAggression * 100, 2) ..
                                 "] " ..
                                 math.round(driver.car.aiAggression * 100, 2),
                             space)
            inLineBulletText("Brake Hint",
                             "[" .. math.round(driver.aiBaseBrakeHint * 100, 2) ..
                                 "] " .. math.round(driver.aiBrakeHint * 100, 2),
                             space)
        end)
    end

    ui.treeNode("[PIT STOPS]",
                ui.TreeNodeFlags.DefaultOpen and ui.TreeNodeFlags.Framed,
                function()
        inLineBulletText("In Pit Lane", upperBool(driver.car.isInPitlane), space)
        inLineBulletText("In Pits", upperBool(driver.car.isInPit), space)
        inLineBulletText("Pit Stop Count", driver.pitstopCount, space)
        inLineBulletText("Last Pitted Lap", driver.lapPitted, space)
        inLineBulletText("Last Pit Time", math.round(driver.pitlaneTime, 2),
                         space)
        inLineBulletText("Last Pit Stop Time",
                         math.round(driver.pitstopTime, 2), space)
    end)

    ui.treeNode("[TYRES]",
                ui.TreeNodeFlags.DefaultOpen and ui.TreeNodeFlags.Framed,
                function()
        local avg_tyre_wear = ((driver.car.wheels[0].tyreWear +
                                  driver.car.wheels[1].tyreWear +
                                  driver.car.wheels[2].tyreWear +
                                  driver.car.wheels[3].tyreWear) / 4)
        inLineBulletText("Stints", stringify(driver.tyreStints), space)

        inLineBulletText("Compound Change",
                         upperBool(driver.tyreCompoundChange), space)
        inLineBulletText("Compounds Available",
                         "H:" ..
                             ac.getTyresName(driver.index,
                                             driver.tyreCompoundsAvailable[3]) ..
                             "\nM:" ..
                             ac.getTyresName(driver.index,
                                             driver.tyreCompoundsAvailable[2]) ..
                             "\nS:" ..
                             ac.getTyresName(driver.index,
                                             driver.tyreCompoundsAvailable[1]),
                         space)
        inLineBulletText("Compound Index", driver.car.compoundIndex, space)
        inLineBulletText("Current Compound", ac.getTyresName(driver.car.index,
                                                             driver.car
                                                                 .compoundIndex),
                         space)
        inLineBulletText("Next Compound", ac.getTyresName(driver.index,
                                                          driver.tyreCompoundNext),
                         space)
        inLineBulletText("Start Compound", ac.getTyresName(driver.index,
                                                           driver.tyreCompoundStart),
                         space)
        inLineBulletText("Tyre Laps", driver.tyreLaps, space)

        inLineBulletText("Tyre Life Avg Limit", RARECONFIG.data.AI
                             .AI_AVG_TYRE_LIFE + driver.aiTyreAvgRandom .. " %",
                         space, driver)
        inLineBulletText("Tyre Life Single Limit", RARECONFIG.data.AI
                             .AI_SINGLE_TYRE_LIFE + driver.aiTyreSingleRandom ..
                             " %", space, driver)

        inLineBulletText("Tyre Life Average",
                         math.round(100 - (avg_tyre_wear * 100), 1), space)
        if driver.car.isAIControlled then
            inLineBulletText("Pitting New Tyres", upperBool(driver.aiPitting),
                             space)
        end
        inLineBulletText("Tyre Life [FL]", math.round(
                             100 - (driver.car.wheels[0].tyreWear * 100), 1),
                         space)
        inLineBulletText("Tyre Life [RL]", math.round(
                             100 - (driver.car.wheels[2].tyreWear * 100), 1),
                         space)
        inLineBulletText("Tyre Life [FR]", math.round(
                             100 - (driver.car.wheels[1].tyreWear * 100), 1),
                         space)
        inLineBulletText("Tyre Life [RR]", math.round(
                             100 - (driver.car.wheels[3].tyreWear * 100), 1),
                         space)
    end)

    ui.treeNode("[ICE]",
                ui.TreeNodeFlags.DefaultOpen and ui.TreeNodeFlags.Framed,
                function()
        inLineBulletText("Max Fuel", driver.car.maxFuel, space)
        inLineBulletText("Fuel", driver.car.fuel, space)
        inLineBulletText("Pre Pit Fuel", driver.aiPrePitFuel, space)
        inLineBulletText("Fuel Per Lap", driver.car.fuelPerLap, space)
        inLineBulletText("Fuel Map", driver.car.fuelMap, space)
        inLineBulletText("Engine Life Left",
                         (driver.car.engineLifeLeft / 10) .. " %", space)
        inLineBulletText("RPM Limiter", driver.car.rpmLimiter, space)
        inLineBulletText("RPM", math.round(driver.car.rpm, 0), space)
    end)

    if driver.car.kersPresent then
        ui.treeNode("[HYBRID SYSTEMS]",
                    ui.TreeNodeFlags.DefaultOpen and ui.TreeNodeFlags.Framed,
                    function()
            local mguhMode = ""
            if driver.car.mguhChargingBatteries then
                mguhMode = "BATTERY"
            else
                mguhMode = "ENGINE"
            end

            inLineBulletText("ERS Charge", math.round(
                                 driver.car.kersCharge * 100, 2) .. " %", space)
            inLineBulletText("ERS Spent",
                             string.format("%2.1f", driver.car.kersCurrentKJ) ..
                                 "/" .. math.round(driver.car.kersMaxKJ, 0) ..
                                 " KJ", space)
            inLineBulletText("ERS Input",
                             math.round(driver.car.kersInput * 100, 2) .. " %",
                             space)
            inLineBulletText("ERS Load",
                             math.round(driver.car.kersLoad * 100, 2) .. " %",
                             space)

            if driver.car.isAIControlled then
                inLineBulletText("MGU-K Delivery", driver.aiMgukDelivery, space)
                inLineBulletText("MGU-K Recovery",
                                 tostring(driver.aiMgukRecovery * 10) .. "%",
                                 space)
            else
                inLineBulletText("MGU-K Delivery", string.upper(
                                     ac.getMGUKDeliveryName(driver.index)),
                                 space)
                inLineBulletText("MGU-K Recovery", math.round(
                                     driver.car.mgukRecovery * 10) .. "%", space)
            end
            inLineBulletText("MGU-H Mode", string.upper(mguhMode), space)
        end)
    end

    if RARECONFIG.data.RULES.DRS_RULES == 1 then
        ui.treeNode("[DRS]",
                    ui.TreeNodeFlags.DefaultOpen and ui.TreeNodeFlags.Framed,
                    function()
            if driver.car.drsPresent then
                if not driver.car.isInPitlane then
                    local delta = driver.carAheadDelta
                    inLineBulletText("Driver ahead [" .. driver.carAhead .. "]",
                                     tostring(ac.getDriverName(driver.carAhead)),
                                     space)
                    inLineBulletText("Enabled on Lap", rc.drsEnabledLap, space)
                    inLineBulletText("Enabled", upperBool(rc.drsEnabled), space)
                    if driver.car.speedKmh >= 1 then
                        inLineBulletText("Delta", math.round(delta, 3), space)
                    else
                        inLineBulletText("Delta", "---", space)
                    end
                    inLineBulletText("In Gap", upperBool(
                                         (delta <=
                                             RARECONFIG.data.RULES.DRS_GAP_DELTA /
                                             1000 and delta > 0.0) and true or
                                             false), space)
                    inLineBulletText("Check", upperBool(driver.drsCheck), space)
                    inLineBulletText("Crossed Detection",
                                     upperBool(crossedDetectionLine(driver)),
                                     space)
                    inLineBulletText("Available",
                                     upperBool(driver.drsAvailable), space)
                    inLineBulletText("Deploy Zone",
                                     upperBool(driver.car.drsAvailable), space)
                    inLineBulletText("Deployable",
                                     upperBool(driver.drsDeployable), space)
                    inLineBulletText("Active", upperBool(driver.car.drsActive),
                                     space)
                    inLineBulletText("Zone Last ID", driver.drsZonePrevId, space)
                    inLineBulletText("Zone ID", driver.drsZoneId, space)
                    inLineBulletText("Zone Next ID", driver.drsZoneNextId, space)
                    inLineBulletText("Detection Line", tostring(
                                         getDetectionLineDistanceM(driver)) ..
                                         " m", space)
                    inLineBulletText("Start Line", tostring(
                                         getStartLineDistanceM(driver)) .. " m",
                                     space)
                    inLineBulletText("End Line", tostring(
                                         getEndLineDistanceM(driver)) .. " m",
                                     space)
                    inLineBulletText("Track Progress M", tostring(
                                         math.round(
                                             driver.car.splinePosition *
                                                 sim.trackLengthM, 5)) .. " m",
                                     space)
                    inLineBulletText("Track Progress %", tostring(
                                         math.round(
                                             driver.car.splinePosition * 100, 2)) ..
                                         " %", space)
                    inLineBulletText("Upcoming Turn",
                                     ac.getTrackUpcomingTurn(driver.car.index),
                                     space)
                else
                    ui.bulletText("IN PITS")
                end
            else
                ui.bulletText("DRS not present")
            end
        end)
    end

    ui.treeNode("[DAMAGE]",
                ui.TreeNodeFlags.DefaultOpen and ui.TreeNodeFlags.Framed,
                function()
        inLineBulletText("Damage 0", driver.car.damage[0], space)
        inLineBulletText("Damage 1", driver.car.damage[1], space)
        inLineBulletText("Damage 2", driver.car.damage[2], space)
        inLineBulletText("Damage 3", driver.car.damage[3], space)
        inLineBulletText("Damage 4", driver.car.damage[4], space)
        inLineBulletText("Gear Box Damage", driver.car.gearboxDamage, space)
    end)

    ui.nextColumn()

    ui.treeNode("[" .. sessionTypeString(sim) .. " SESSION]",
                ui.TreeNodeFlags.DefaultOpen and ui.TreeNodeFlags.Framed,
                function()
        inLineBulletText(SCRIPT_SHORT_NAME .. " Enabled",
                         upperBool(ac.isWindowOpen('rare')), space)
        inLineBulletText("Race Started", upperBool(sim.isSessionStarted), space)
        inLineBulletText("Physics Allowed", upperBool(physics.allowed()), space)
        inLineBulletText("Physics Late", sim.physicsLate, space)
        inLineBulletText("Track", ac.getTrackName(), space)
        inLineBulletText("Time", string.format("%02d:%02d:%02d", sim.timeHours,
                                               sim.timeMinutes, sim.timeSeconds),
                         space)
        if not sim.isOnlineRace then
            inLineBulletText("Leader Lap",
                             (rc.leaderCompletedLaps + 1) .. "/" ..
                                 ac.getSession(sim.currentSessionIndex).laps,
                             space)
        end
    end)

    if RARECONFIG.data.RULES.VSC_RULES == 1 then
        ui.treeNode("[VSC]",
                    ui.TreeNodeFlags.DefaultOpen and ui.TreeNodeFlags.Framed,
                    function()
            inLineBulletText("VSC Called", upperBool(VSC_CALLED), space)
            inLineBulletText("VSC Deployed", upperBool(VSC_DEPLOYED), space)
            inLineBulletText("VSC Lap TIme", ac.lapTimeToString(VSC_LAP_TIME),
                             space)
        end)
    end

    ui.treeNode("[CAR INFO]",
                ui.TreeNodeFlags.DefaultOpen and ui.TreeNodeFlags.Framed,
                function()
        inLineBulletText("Index", driver.car.index, space)
        inLineBulletText("Brand", ac.getCarBrand(driver.car.index), space)
        inLineBulletText("ID", ac.getCarID(driver.car.index), space)
        inLineBulletText("Skin", ac.getCarSkinID(driver.car.index), space)
        inLineBulletText("Extended Physics",
                         upperBool(driver.car.extendedPhysics), space)
        inLineBulletText("Physics Available",
                         upperBool(driver.car.physicsAvailable), space)
        inLineBulletText("DRS Present", upperBool(driver.car.drsPresent), space)
        inLineBulletText("Kunos Car", upperBool(driver.car.isKunosCar), space)
    end)

    ui.treeNode("[DRIVER]",
                ui.TreeNodeFlags.DefaultOpen and ui.TreeNodeFlags.Framed,
                function()
        inLineBulletText("Driver [" .. driver.index .. "]", driver.name, space)
        inLineBulletText("Team", ac.getDriverTeam(driver.car.index), space)
        inLineBulletText("Number", ac.getDriverNumber(driver.car.index), space)
        inLineBulletText("Race Position",
                         driver.car.racePosition .. "/" .. sim.carsCount, space)
        inLineBulletText("Track Position",
                         driver.trackPosition .. "/" .. rc.carsOnTrackCount,
                         space)
        if not sim.isOnlineRace then
            inLineBulletText("Lap", (driver.car.lapCount + 1) .. "/" ..
                                 ac.getSession(sim.currentSessionIndex).laps,
                             space)
        end
        if sim.raceSessionType == ac.SessionType.Qualify then
            inLineBulletText("Out Lap", upperBool(driver.outLap), space)
            inLineBulletText("Flying Lap", upperBool(driver.flyingLap), space)
            inLineBulletText("In Lap", upperBool(driver.inLap), space)
        end
        inLineBulletText("Last Lap Time",
                         ac.lapTimeToString(driver.car.previousLapTimeMs), space)
        inLineBulletText("Best Lap Time",
                         ac.lapTimeToString(driver.car.bestLapTimeMs), space)
    end)

    ui.treeNode("[WEATHER]",
                ui.TreeNodeFlags.DefaultOpen and ui.TreeNodeFlags.Framed,
                function()
        local totalWetness = ((sim.rainWetness / 5) + (sim.rainWater * 10)) / 2
        inLineBulletText("Weather Type", weatherTypeString(sim), space)
        inLineBulletText("Rain Intensity",
                         math.round(sim.rainIntensity * 100, 2) .. "%", space)
        inLineBulletText("Track Wetness",
                         math.round(sim.rainWetness * 100, 2) .. "%", space)
        inLineBulletText("Track Puddles",
                         math.round(sim.rainWater * 100, 2) .. "%", space)
        inLineBulletText("Total Wetness",
                         math.round(totalWetness * 100, 2) .. "%", space)
        inLineBulletText("Total Wetness Limit", math.round(
                             RARECONFIG.data.RULES.DRS_WET_LIMIT, 2) .. "%",
                         space)
        inLineBulletText("Wet Track", upperBool(rc.wetTrack), space)
    end)

    ui.treeNode("[INPUTS]",
                ui.TreeNodeFlags.DefaultOpen and ui.TreeNodeFlags.Framed,
                function()
        inLineBulletText("Gas", math.round(driver.car.gas, 5), space)
        inLineBulletText("Brake", math.round(driver.car.brake, 5), space)
        inLineBulletText("Clutch", math.round(driver.car.clutch, 5), space)
        inLineBulletText("Steer", math.round(driver.car.steer, 5), space)
    end)

    ui.treeNode("[SCRIPT CONTROLLER INPUTS]",
                ui.TreeNodeFlags.DefaultOpen and ui.TreeNodeFlags.Framed,
                function()
        inLineBulletText("[0] Total Brake Balance", math.round(
                             ac.getCarPhysics(driver.index)
                                 .scriptControllerInputs[0], 5), space)
        inLineBulletText("[1] Brake Migration %",
                         ac.getCarPhysics(driver.index).scriptControllerInputs[1],
                         space)
        inLineBulletText("[2] Exit Diff", ac.getCarPhysics(driver.index)
                             .scriptControllerInputs[2], space)
        inLineBulletText("[3] Entry Diff", ac.getCarPhysics(driver.index)
                             .scriptControllerInputs[3], space)
        inLineBulletText("[4] Mid Diff", ac.getCarPhysics(driver.index)
                             .scriptControllerInputs[4], space)
        inLineBulletText("[5] Hispd Diff", ac.getCarPhysics(driver.index)
                             .scriptControllerInputs[5], space)
        inLineBulletText("[6] Diff Mode", ac.getCarPhysics(driver.index)
                             .scriptControllerInputs[6], space)
        inLineBulletText("[7]", ac.getCarPhysics(driver.index)
                             .scriptControllerInputs[7], space)
    end)
end
