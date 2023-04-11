local utils = require("src/utils")
local drs = require("src/controllers/drs")

function debugMenu(sim, rc, error)
	local driver = DRIVERS[sim.focusedCar]
	local math = math
	local space = 200
	ui.pushFont(ui.Font.Small)

	if error then
		ui.textColored(error, rgbm(1, 0, 0, 1))
	end

	if not utils.compatibleCspVersion() then
		ui.text("INCOMPATIBLE VERSION OF CSP")
		return
	end

	ui.columns(2, true, "infocol")

	utils.inLineBulletText("CSP Version", ac.getPatchVersion(), space)
	utils.inLineBulletText("CSP Version Code", ac.getPatchVersionCode(), space)
	utils.inLineBulletText("Current Date", os.date("%Y-%m-%d"), space)
	ui.nextColumn()
	utils.inLineBulletText(SCRIPT_SHORT_NAME .. " Version", SCRIPT_VERSION, space)
	utils.inLineBulletText(SCRIPT_SHORT_NAME .. " Version Code", SCRIPT_VERSION_CODE, space)
	utils.inLineBulletText(SCRIPT_SHORT_NAME .. " Version Release Date", SCRIPT_BUILD_DATE, space)
	ui.newLine()
	ui.nextColumn()

	ui.columns(2, true, "debugcol2")

	if driver.car.isAIControlled then
		ui.treeNode("[AI]", ui.TreeNodeFlags.DefaultOpen and ui.TreeNodeFlags.Framed, function()
			utils.inLineBulletText(
				"Throttle Limit",
				"["
					.. math.round(driver.aiThrottleLimitBase * 100, 2)
					.. "] "
					.. math.round(driver.aiThrottleLimit * 100, 2),
				space
			)
			utils.inLineBulletText(
				"Level",
				"[" .. math.round(driver.aiLevel * 100, 2) .. "] " .. math.round(driver.car.aiLevel * 100, 2),
				space
			)
			utils.inLineBulletText(
				"Aggression",
				"[" .. math.round(driver.aiAggression * 100, 2) .. "] " .. math.round(driver.car.aiAggression * 100, 2),
				space
			)
			utils.inLineBulletText(
				"Brake Hint",
				"[" .. math.round(driver.aiBaseBrakeHint * 100, 2) .. "] " .. math.round(driver.aiBrakeHint * 100, 2),
				space
			)
		end)
	end

	ui.treeNode("[PIT STOPS]", ui.TreeNodeFlags.DefaultOpen and ui.TreeNodeFlags.Framed, function()
		utils.inLineBulletText("In Pit Lane", utils.upperBool(driver.car.isInPitlane), space)
		utils.inLineBulletText("In Pits", utils.upperBool(driver.car.isInPit), space)
		utils.inLineBulletText("Pit Stop Count", driver.pitstopCount, space)
		utils.inLineBulletText("Last Pitted Lap", driver.lapPitted, space)
		utils.inLineBulletText("Last Pit Time", math.round(driver.pitlaneTime, 2), space)
		utils.inLineBulletText("Last Pit Stop Time", math.round(driver.pitstopTime, 2), space)
	end)

	ui.treeNode("[TYRES]", ui.TreeNodeFlags.DefaultOpen and ui.TreeNodeFlags.Framed, function()
		local avg_tyre_wear = (
			(
				driver.car.wheels[0].tyreWear
				+ driver.car.wheels[1].tyreWear
				+ driver.car.wheels[2].tyreWear
				+ driver.car.wheels[3].tyreWear
			) / 4
		)
		utils.inLineBulletText("Stints", stringify(driver.tyreStints), space)

		utils.inLineBulletText("Compound Change", utils.upperBool(driver.tyreCompoundChange), space)
		utils.inLineBulletText(
			"Compounds Available",
			"H:"
				.. ac.getTyresName(driver.index, driver.tyreCompoundsAvailable[3])
				.. "\nM:"
				.. ac.getTyresName(driver.index, driver.tyreCompoundsAvailable[2])
				.. "\nS:"
				.. ac.getTyresName(driver.index, driver.tyreCompoundsAvailable[1]),
			space
		)
		utils.inLineBulletText("Compound Index", driver.car.compoundIndex, space)
		utils.inLineBulletText("Current Compound", ac.getTyresName(driver.car.index, driver.car.compoundIndex), space)
		utils.inLineBulletText("Next Compound", ac.getTyresName(driver.index, driver.tyreCompoundNext), space)
		utils.inLineBulletText("Start Compound", ac.getTyresName(driver.index, driver.tyreCompoundStart), space)
		utils.inLineBulletText("Tyre Laps", driver.tyreLaps, space)

		utils.inLineBulletText(
			"Tyre Life Avg Limit",
			RARECONFIG.data.AI.AI_AVG_TYRE_LIFE + driver.aiTyreAvgRandom .. " %",
			space,
			driver
		)
		utils.inLineBulletText(
			"Tyre Life Single Limit",
			RARECONFIG.data.AI.AI_SINGLE_TYRE_LIFE + driver.aiTyreSingleRandom .. " %",
			space,
			driver
		)

		utils.inLineBulletText("Tyre Life Average", math.round(100 - (avg_tyre_wear * 100), 1), space)
		if driver.car.isAIControlled then
			utils.inLineBulletText("Pitting New Tyres", utils.upperBool(driver.aiPitting), space)
		end
		utils.inLineBulletText("Tyre Life [FL]", math.round(100 - (driver.car.wheels[0].tyreWear * 100), 1), space)
		utils.inLineBulletText("Tyre Life [RL]", math.round(100 - (driver.car.wheels[2].tyreWear * 100), 1), space)
		utils.inLineBulletText("Tyre Life [FR]", math.round(100 - (driver.car.wheels[1].tyreWear * 100), 1), space)
		utils.inLineBulletText("Tyre Life [RR]", math.round(100 - (driver.car.wheels[3].tyreWear * 100), 1), space)
	end)

	ui.treeNode("[ICE]", ui.TreeNodeFlags.DefaultOpen and ui.TreeNodeFlags.Framed, function()
		utils.inLineBulletText("Max Fuel", driver.car.maxFuel, space)
		utils.inLineBulletText("Fuel", driver.car.fuel, space)
		utils.inLineBulletText("Pre Pit Fuel", driver.aiPrePitFuel, space)
		utils.inLineBulletText("Fuel Per Lap", driver.car.fuelPerLap, space)
		utils.inLineBulletText("Fuel Map", driver.car.fuelMap, space)
		utils.inLineBulletText("Engine Life Left", (driver.car.engineLifeLeft / 10) .. " %", space)
		utils.inLineBulletText("RPM Limiter", driver.car.rpmLimiter, space)
		utils.inLineBulletText("RPM", math.round(driver.car.rpm, 0), space)
	end)

	if driver.car.kersPresent then
		ui.treeNode("[HYBRID SYSTEMS]", ui.TreeNodeFlags.DefaultOpen and ui.TreeNodeFlags.Framed, function()
			local mguhMode = ""
			if driver.car.mguhChargingBatteries then
				mguhMode = "BATTERY"
			else
				mguhMode = "ENGINE"
			end

			utils.inLineBulletText("ERS Charge", math.round(driver.car.kersCharge * 100, 2) .. " %", space)
			utils.inLineBulletText(
				"ERS Spent",
				string.format("%2.1f", driver.car.kersCurrentKJ) .. "/" .. math.round(driver.car.kersMaxKJ, 0) .. " KJ",
				space
			)
			utils.inLineBulletText("ERS Input", math.round(driver.car.kersInput * 100, 2) .. " %", space)
			utils.inLineBulletText("ERS Load", math.round(driver.car.kersLoad * 100, 2) .. " %", space)

			if driver.car.isAIControlled then
				utils.inLineBulletText("MGU-K Delivery", driver.aiMgukDelivery, space)
				utils.inLineBulletText("MGU-K Recovery", tostring(driver.aiMgukRecovery * 10) .. "%", space)
			else
				utils.inLineBulletText("MGU-K Delivery", string.upper(ac.getMGUKDeliveryName(driver.index)), space)
				utils.inLineBulletText("MGU-K Recovery", math.round(driver.car.mgukRecovery * 10) .. "%", space)
			end
			utils.inLineBulletText("MGU-H Mode", string.upper(mguhMode), space)
		end)
	end

	if RARECONFIG.data.RULES.DRS_RULES == 1 then
		ui.treeNode("[DRS]", ui.TreeNodeFlags.DefaultOpen and ui.TreeNodeFlags.Framed, function()
			if driver.car.drsPresent then
				if not driver.car.isInPitlane then
					local delta = driver.carAheadDelta
					utils.inLineBulletText(
						"Driver ahead [" .. driver.carAhead .. "]",
						tostring(ac.getDriverName(driver.carAhead)),
						space
					)
					utils.inLineBulletText("Enabled on Lap", rc.drsEnabledLap, space)
					utils.inLineBulletText("Enabled", utils.upperBool(rc.drsEnabled), space)
					if driver.car.speedKmh >= 1 then
						utils.inLineBulletText("Delta", math.round(delta, 3), space)
					else
						utils.inLineBulletText("Delta", "---", space)
					end
					utils.inLineBulletText(
						"In Gap",
						utils.upperBool(
							(delta <= RARECONFIG.data.RULES.DRS_GAP_DELTA / 1000 and delta > 0.0) and true or false
						),
						space
					)
					utils.inLineBulletText("Available", utils.upperBool(driver.drsAvailable), space)
					utils.inLineBulletText("Deploy Zone", utils.upperBool(driver.car.drsAvailable), space)
					utils.inLineBulletText("Active", utils.upperBool(driver.car.drsActive), space)
					utils.inLineBulletText("Zone Last ID", driver.drsZonePrevId, space)
					utils.inLineBulletText("Zone ID", driver.drsZoneId, space)
					utils.inLineBulletText("Zone Next ID", driver.drsZoneNextId, space)
					utils.inLineBulletText("Detection Line", tostring(getDetectionLineDistanceM(driver)) .. " m", space)
					utils.inLineBulletText("Start Line", tostring(getStartLineDistanceM(driver)) .. " m", space)
					utils.inLineBulletText("End Line", tostring(getEndLineDistanceM(driver)) .. " m", space)
					utils.inLineBulletText(
						"Track Progress M",
						tostring(math.round(driver.car.splinePosition * sim.trackLengthM, 5)) .. " m",
						space
					)
					utils.inLineBulletText(
						"Track Progress %",
						tostring(math.round(driver.car.splinePosition * 100, 2)) .. " %",
						space
					)
					utils.inLineBulletText("Upcoming Turn", ac.getTrackUpcomingTurn(driver.car.index), space)
				else
					ui.bulletText("IN PITS")
				end
			else
				ui.bulletText("DRS not present")
			end
		end)
	end

	ui.treeNode("[DAMAGE]", ui.TreeNodeFlags.DefaultOpen and ui.TreeNodeFlags.Framed, function()
		utils.inLineBulletText("Damage 0", driver.car.damage[0], space)
		utils.inLineBulletText("Damage 1", driver.car.damage[1], space)
		utils.inLineBulletText("Damage 2", driver.car.damage[2], space)
		utils.inLineBulletText("Damage 3", driver.car.damage[3], space)
		utils.inLineBulletText("Damage 4", driver.car.damage[4], space)
		utils.inLineBulletText("Gear Box Damage", driver.car.gearboxDamage, space)
	end)

	ui.nextColumn()

	ui.treeNode(
		"[" .. ac.sessionTypeString(sim) .. " SESSION]",
		ui.TreeNodeFlags.DefaultOpen and ui.TreeNodeFlags.Framed,
		function()
			utils.inLineBulletText(SCRIPT_SHORT_NAME .. " Enabled", utils.upperBool(ac.isWindowOpen("rare")), space)
			utils.inLineBulletText("Race Started", utils.upperBool(sim.isSessionStarted), space)
			utils.inLineBulletText("Physics Allowed", utils.upperBool(physics.allowed()), space)
			utils.inLineBulletText("Physics Late", sim.physicsLate, space)
			utils.inLineBulletText("Track Name", ac.getTrackName(), space)
			utils.inLineBulletText("Track ID", ac.getTrackID(), space)
			utils.inLineBulletText("Track Length", math.round(sim.trackLengthM), space)
			utils.inLineBulletText("Mini Sectors", #driver.miniSectors, space)
			utils.inLineBulletText(
				"Time",
				string.format("%02d:%02d:%02d", sim.timeHours, sim.timeMinutes, sim.timeSeconds),
				space
			)
			if not sim.isOnlineRace then
				utils.inLineBulletText(
					"Leader Lap",
					(rc.leaderCompletedLaps + 1) .. "/" .. ac.getSession(sim.currentSessionIndex).laps,
					space
				)
			end
		end
	)

	ui.treeNode("[SESSION MODIFIERS]", ui.TreeNodeFlags.DefaultOpen and ui.TreeNodeFlags.Framed, function()
		utils.inLineBulletText("Tyre Blankets", utils.upperBool(sim.allowTyreBlankets), space)
		utils.inLineBulletText("Mechanical Damage Rate", tostring(sim.mechanicalDamageRate * 100) .. "%", space)
		utils.inLineBulletText("Tyre Consumption Rate", tostring(sim.tyreConsumptionRate * 100) .. "%", space)
		utils.inLineBulletText("Fuel Consumption Rate", tostring(sim.fuelConsumptionRate * 100) .. "%", space)
	end)

	if RARECONFIG.data.RULES.VSC_RULES == 1 then
		ui.treeNode("[VSC]", ui.TreeNodeFlags.DefaultOpen and ui.TreeNodeFlags.Framed, function()
			utils.inLineBulletText("VSC Called", utils.upperBool(VSC_CALLED), space)
			utils.inLineBulletText("VSC Deployed", utils.upperBool(VSC_DEPLOYED), space)
			utils.inLineBulletText("VSC Lap TIme", ac.lapTimeToString(VSC_LAP_TIME), space)
		end)
	end

	ui.treeNode("[CAR INFO]", ui.TreeNodeFlags.DefaultOpen and ui.TreeNodeFlags.Framed, function()
		utils.inLineBulletText("Index", driver.car.index, space)
		utils.inLineBulletText("Brand", ac.getCarBrand(driver.car.index), space)
		utils.inLineBulletText("ID", ac.getCarID(driver.car.index), space)
		utils.inLineBulletText("Skin", ac.getCarSkinID(driver.car.index), space)
		utils.inLineBulletText("Extended Physics", utils.upperBool(driver.car.extendedPhysics), space)
		utils.inLineBulletText("Physics Available", utils.upperBool(driver.car.physicsAvailable), space)
		utils.inLineBulletText("DRS Present", utils.upperBool(driver.car.drsPresent), space)
	end)

	ui.treeNode("[DRIVER]", ui.TreeNodeFlags.DefaultOpen and ui.TreeNodeFlags.Framed, function()
		utils.inLineBulletText("Driver [" .. driver.index .. "]", driver.name, space)
		utils.inLineBulletText("Team", ac.getDriverTeam(driver.car.index), space)
		utils.inLineBulletText("Number", ac.getDriverNumber(driver.car.index), space)
		utils.inLineBulletText("Race Position", driver.car.racePosition .. "/" .. sim.carsCount, space)
		utils.inLineBulletText("Track Position", driver.trackPosition .. "/" .. rc.carsOnTrackCount, space)
		if not sim.isOnlineRace then
			utils.inLineBulletText(
				"Lap",
				(driver.car.lapCount + 1) .. "/" .. ac.getSession(sim.currentSessionIndex).laps,
				space
			)
		end
		if sim.raceSessionType == ac.SessionType.Qualify then
			utils.inLineBulletText("Out Lap", utils.upperBool(driver.outLap), space)
			utils.inLineBulletText("Flying Lap", utils.upperBool(driver.flyingLap), space)
			utils.inLineBulletText("In Lap", utils.upperBool(driver.inLap), space)
		end
		utils.inLineBulletText("Last Lap Time", ac.lapTimeToString(driver.car.previousLapTimeMs), space)
		utils.inLineBulletText("Best Lap Time", ac.lapTimeToString(driver.car.bestLapTimeMs), space)
	end)

	ui.treeNode("[WEATHER]", ui.TreeNodeFlags.DefaultOpen and ui.TreeNodeFlags.Framed, function()
		local totalWetness = (sim.rainWetness + (sim.rainWater * 10)) * 1000
		utils.inLineBulletText("Weather Type", ac.weatherTypeString(sim), space)
		utils.inLineBulletText("Rain Intensity", math.round(sim.rainIntensity * 100, 2) .. "%", space)
		utils.inLineBulletText("Track Wetness", math.round(sim.rainWetness * 1000, 2) .. "%", space)
		utils.inLineBulletText("Track Puddles", math.round(sim.rainWater * 1000, 2) .. "%", space)
		utils.inLineBulletText("Total Wetness", math.round(totalWetness, 2) .. "%", space)
		utils.inLineBulletText("Wet Track", utils.upperBool(rc.wetTrack), space)
	end)

	ui.treeNode("[INPUTS]", ui.TreeNodeFlags.DefaultOpen and ui.TreeNodeFlags.Framed, function()
		utils.inLineBulletText("Gas", math.round(driver.car.gas, 5), space)
		utils.inLineBulletText("Brake", math.round(driver.car.brake, 5), space)
		utils.inLineBulletText("Clutch", math.round(driver.car.clutch, 5), space)
		utils.inLineBulletText("Steer", math.round(driver.car.steer, 5), space)
	end)

	ui.treeNode("[SCRIPT CONTROLLER INPUTS]", ui.TreeNodeFlags.DefaultOpen and ui.TreeNodeFlags.Framed, function()
		utils.inLineBulletText(
			"[0] Total Brake Balance",
			math.round(ac.getCarPhysics(driver.index).scriptControllerInputs[0], 5),
			space
		)
		utils.inLineBulletText("[1] Brake Migration %", ac.getCarPhysics(driver.index).scriptControllerInputs[1], space)
		utils.inLineBulletText("[2] Exit Diff", ac.getCarPhysics(driver.index).scriptControllerInputs[2], space)
		utils.inLineBulletText("[3] Entry Diff", ac.getCarPhysics(driver.index).scriptControllerInputs[3], space)
		utils.inLineBulletText("[4] Mid Diff", ac.getCarPhysics(driver.index).scriptControllerInputs[4], space)
		utils.inLineBulletText("[5] Hispd Diff", ac.getCarPhysics(driver.index).scriptControllerInputs[5], space)
		utils.inLineBulletText("[6] Diff Mode", ac.getCarPhysics(driver.index).scriptControllerInputs[6], space)
		utils.inLineBulletText("[7]", ac.getCarPhysics(driver.index).scriptControllerInputs[7], space)
	end)
end
