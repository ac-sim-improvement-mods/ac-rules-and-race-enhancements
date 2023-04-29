require("src/helpers/ui_helper")
local drs = require("src/controllers/drs")

local space = 200

local function aiTreeNode(driver)
	ui.treeNode("[AI]", ui.TreeNodeFlags.DefaultOpen and ui.TreeNodeFlags.Framed, function()
		ui.inLineBulletText(
			"Throttle Limit",
			"["
				.. math.round(driver.aiThrottleLimitBase * 100, 2)
				.. "] "
				.. math.round(driver.aiThrottleLimit * 100, 2),
			space
		)
		ui.inLineBulletText(
			"Level",
			"[" .. math.round(driver.aiLevel * 100, 2) .. "] " .. math.round(driver.car.aiLevel * 100, 2),
			space
		)
		ui.inLineBulletText(
			"Aggression",
			"[" .. math.round(driver.aiAggression * 100, 2) .. "] " .. math.round(driver.car.aiAggression * 100, 2),
			space
		)
		ui.inLineBulletText(
			"Brake Hint",
			"[" .. math.round(driver.aiBaseBrakeHint * 100, 2) .. "] " .. math.round(driver.aiBrakeHint * 100, 2),
			space
		)
	end)
end

local function pitStopsTreeNode(driver)
	ui.treeNode("[PIT STOPS]", ui.TreeNodeFlags.DefaultOpen and ui.TreeNodeFlags.Framed, function()
		ui.inLineBulletText("In Pit Lane", ui.upperBool(driver.car.isInPitlane), space)
		ui.inLineBulletText("In Pits", ui.upperBool(driver.car.isInPit), space)
		ui.inLineBulletText("Pit Stop Count", driver.pitstopCount, space)
		ui.inLineBulletText("Last Pitted Lap", driver.lapPitted, space)
		ui.inLineBulletText("Last Pit Time", math.round(driver.pitlaneTime, 2), space)
		ui.inLineBulletText("Last Pit Stop Time", math.round(driver.pitstopTime, 2), space)
	end)
end

local function tyresTreeNode(driver)
	ui.treeNode("[TYRES]", ui.TreeNodeFlags.DefaultOpen and ui.TreeNodeFlags.Framed, function()
		local avg_tyre_wear = (
			(
				driver.car.wheels[0].tyreWear
				+ driver.car.wheels[1].tyreWear
				+ driver.car.wheels[2].tyreWear
				+ driver.car.wheels[3].tyreWear
			) / 4
		)
		ui.inLineBulletText("Stints", stringify(driver.tyreStints), space)

		ui.inLineBulletText("Compound Change", ui.upperBool(driver.hasChangedTyreCompound), space)

		ui.inLineBulletText(
			"Compounds",
			"Soft: "
				.. ac.getTyresName(driver.index, driver.tyreCompoundSoft)
				.. "\n"
				.. "Medium: "
				.. ac.getTyresName(driver.index, driver.tyreCompoundMedium)
				.. "\n"
				.. "Hard: "
				.. ac.getTyresName(driver.index, driver.tyreCompoundHard)
				.. "\n"
				.. "Inter: "
				.. ac.getTyresName(driver.index, driver.tyreCompoundInter)
				.. "\n"
				.. "Wet: "
				.. ac.getTyresName(driver.index, driver.tyreCompoundWet),
			space
		)

		ui.inLineBulletText("Compound Index", driver.car.compoundIndex, space)
		ui.inLineBulletText("Current Compound", ac.getTyresName(driver.car.index, driver.car.compoundIndex), space)
		ui.inLineBulletText("Next Compound", ac.getTyresName(driver.index, driver.tyreCompoundNext), space)
		ui.inLineBulletText("Start Compound", ac.getTyresName(driver.index, driver.tyreCompoundStart), space)
		ui.inLineBulletText("Tyre Laps", driver.tyreLaps, space)

		ui.inLineBulletText(
			"Tyre Life Avg Limit",
			RARE_CONFIG.data.AI.AI_AVG_TYRE_LIFE + driver.aiTyreAvgRandom .. " %",
			space,
			driver
		)
		ui.inLineBulletText(
			"Tyre Life Single Limit",
			RARE_CONFIG.data.AI.AI_SINGLE_TYRE_LIFE + driver.aiTyreSingleRandom .. " %",
			space,
			driver
		)

		ui.inLineBulletText("Tyre Life Average", math.round(100 - (avg_tyre_wear * 100), 1), space)
		if driver.car.isAIControlled then
			ui.inLineBulletText("Pitting New Tyres", ui.upperBool(driver.isAIPitting), space)
		end
		ui.inLineBulletText("Tyre Life [FL]", math.round(100 - (driver.car.wheels[0].tyreWear * 100), 1), space)
		ui.inLineBulletText("Tyre Life [RL]", math.round(100 - (driver.car.wheels[2].tyreWear * 100), 1), space)
		ui.inLineBulletText("Tyre Life [FR]", math.round(100 - (driver.car.wheels[1].tyreWear * 100), 1), space)
		ui.inLineBulletText("Tyre Life [RR]", math.round(100 - (driver.car.wheels[3].tyreWear * 100), 1), space)
	end)
end

local function iceTreeNode(driver)
	ui.treeNode("[ICE]", ui.TreeNodeFlags.DefaultOpen and ui.TreeNodeFlags.Framed, function()
		ui.inLineBulletText("Max Fuel", driver.car.maxFuel, space)
		ui.inLineBulletText("Fuel", driver.car.fuel, space)
		ui.inLineBulletText("Pre Pit Fuel", driver.aiPrePitFuel, space)
		ui.inLineBulletText("Fuel Per Lap", driver.car.fuelPerLap, space)
		ui.inLineBulletText("Fuel Map", driver.car.fuelMap, space)
		ui.inLineBulletText("Engine Life Left", (driver.car.engineLifeLeft / 10) .. " %", space)
		ui.inLineBulletText("RPM Limiter", driver.car.rpmLimiter, space)
		ui.inLineBulletText("RPM", math.round(driver.car.rpm, 0), space)
	end)
end

local function hybridSystemsTreeNode(driver)
	ui.treeNode("[HYBRID SYSTEMS]", ui.TreeNodeFlags.DefaultOpen and ui.TreeNodeFlags.Framed, function()
		local mguhMode = ""
		if driver.car.mguhChargingBatteries then
			mguhMode = "BATTERY"
		else
			mguhMode = "ENGINE"
		end

		ui.inLineBulletText("ERS Charge", math.round(driver.car.kersCharge * 100, 2) .. " %", space)
		ui.inLineBulletText(
			"ERS Spent",
			string.format("%2.1f", driver.car.kersCurrentKJ) .. "/" .. math.round(driver.car.kersMaxKJ, 0) .. " KJ",
			space
		)
		ui.inLineBulletText("ERS Input", math.round(driver.car.kersInput * 100, 2) .. " %", space)
		ui.inLineBulletText("ERS Load", math.round(driver.car.kersLoad * 100, 2) .. " %", space)

		if driver.car.isAIControlled then
			ui.inLineBulletText("MGU-K Delivery", driver.aiMgukDelivery, space)
			ui.inLineBulletText("MGU-K Recovery", tostring(driver.aiMgukRecovery * 10) .. "%", space)
		else
			ui.inLineBulletText("MGU-K Delivery", string.upper(ac.getMGUKDeliveryName(driver.index)), space)
			ui.inLineBulletText("MGU-K Recovery", math.round(driver.car.mgukRecovery * 10) .. "%", space)
		end
		ui.inLineBulletText("MGU-H Mode", string.upper(mguhMode), space)
	end)
end

local function drsTreeNode(sim, rc, driver)
	ui.treeNode("[DRS]", ui.TreeNodeFlags.DefaultOpen and ui.TreeNodeFlags.Framed, function()
		if driver.car.drsPresent then
			if not driver.car.isInPitlane then
				local delta = driver.carAheadDelta
				ui.inLineBulletText(
					"Driver ahead [" .. driver.carAhead .. "]",
					tostring(ac.getDriverName(driver.carAhead)),
					space
				)
				ui.inLineBulletText("Enabled on Lap", rc.drsEnabledLap, space)
				ui.inLineBulletText("Enabled", ui.upperBool(rc.drsEnabled), space)
				if driver.car.speedKmh >= 1 then
					ui.inLineBulletText("Delta", math.round(delta, 3), space)
				else
					ui.inLineBulletText("Delta", "---", space)
				end
				ui.inLineBulletText(
					"In Gap",
					ui.upperBool(
						(delta <= RARE_CONFIG.data.RULES.DRS_GAP_DELTA / 1000 and delta > 0.0) and true or false
					),
					space
				)
				ui.inLineBulletText("Available", ui.upperBool(driver.isDrsAvailable), space)
				ui.inLineBulletText("Deploy Zone", ui.upperBool(driver.isInDrsActivationZone), space)
				ui.inLineBulletText("Active", ui.upperBool(driver.car.drsActive), space)
				ui.inLineBulletText("Zone Last ID", driver.drsZonePrevId, space)
				ui.inLineBulletText("Zone ID", driver.drsZoneId, space)
				ui.inLineBulletText("Zone Next ID", driver.drsZoneNextId, space)
				ui.inLineBulletText("Detection Line", tostring(getDetectionLineDistanceM(driver)) .. " m", space)
				ui.inLineBulletText("Start Line", tostring(getStartLineDistanceM(driver)) .. " m", space)
				ui.inLineBulletText("End Line", tostring(getEndLineDistanceM(driver)) .. " m", space)
				ui.inLineBulletText(
					"Track Progress M",
					tostring(math.round(driver.car.splinePosition * sim.trackLengthM, 5)) .. " m",
					space
				)
				ui.inLineBulletText(
					"Track Progress %",
					tostring(math.round(driver.car.splinePosition * 100, 2)) .. " %",
					space
				)
				ui.inLineBulletText("Upcoming Turn", ac.getTrackUpcomingTurn(driver.car.index), space)
			else
				ui.bulletText("IN PITS")
			end
		else
			ui.bulletText("DRS not present")
		end
	end)
end

local function damageTreeNode(driver)
	ui.treeNode("[DAMAGE]", ui.TreeNodeFlags.DefaultOpen and ui.TreeNodeFlags.Framed, function()
		ui.inLineBulletText("Damage 0", driver.car.damage[0], space)
		ui.inLineBulletText("Damage 1", driver.car.damage[1], space)
		ui.inLineBulletText("Damage 2", driver.car.damage[2], space)
		ui.inLineBulletText("Damage 3", driver.car.damage[3], space)
		ui.inLineBulletText("Damage 4", driver.car.damage[4], space)
		ui.inLineBulletText("Gear Box Damage", driver.car.gearboxDamage, space)
	end)
end

local function sessionTreeNode(sim, rc, driver)
	ui.treeNode(
		"[" .. ac.sessionTypeString(sim) .. " SESSION]",
		ui.TreeNodeFlags.DefaultOpen and ui.TreeNodeFlags.Framed,
		function()
			ui.inLineBulletText(SCRIPT_SHORT_NAME .. " Enabled", ui.upperBool(ac.isWindowOpen("rare")), space)
			ui.inLineBulletText("Race Started", ui.upperBool(sim.isSessionStarted), space)
			ui.inLineBulletText("Physics Allowed", ui.upperBool(physics.allowed()), space)
			ui.inLineBulletText("Physics Late", sim.physicsLate, space)
			ui.inLineBulletText("Track Name", ac.getTrackName(), space)
			ui.inLineBulletText("Track ID", ac.getTrackID(), space)
			ui.inLineBulletText("Track Length", math.round(sim.trackLengthM), space)
			ui.inLineBulletText("Mini Sectors", #driver.miniSectors, space)
			ui.inLineBulletText(
				"Time",
				string.format("%02d:%02d:%02d", sim.timeHours, sim.timeMinutes, sim.timeSeconds),
				space
			)
			if not sim.isOnlineRace then
				ui.inLineBulletText(
					"Leader Lap",
					(rc.leaderCompletedLaps + 1) .. "/" .. ac.getSession(sim.currentSessionIndex).laps,
					space
				)
			end
		end
	)
end

local function sessionModifiersTreeNode(sim)
	ui.treeNode("[SESSION MODIFIERS]", ui.TreeNodeFlags.DefaultOpen and ui.TreeNodeFlags.Framed, function()
		ui.inLineBulletText("Tyre Blankets", ui.upperBool(sim.allowTyreBlankets), space)
		ui.inLineBulletText("Mechanical Damage Rate", tostring(sim.mechanicalDamageRate * 100) .. "%", space)
		ui.inLineBulletText("Tyre Consumption Rate", tostring(sim.tyreConsumptionRate * 100) .. "%", space)
		ui.inLineBulletText("Fuel Consumption Rate", tostring(sim.fuelConsumptionRate * 100) .. "%", space)
	end)
end

local function carInfoTreeNode(driver)
	ui.treeNode("[CAR INFO]", ui.TreeNodeFlags.DefaultOpen and ui.TreeNodeFlags.Framed, function()
		ui.inLineBulletText("Index", driver.car.index, space)
		ui.inLineBulletText("Brand", ac.getCarBrand(driver.car.index), space)
		ui.inLineBulletText("ID", ac.getCarID(driver.car.index), space)
		ui.inLineBulletText("Skin", ac.getCarSkinID(driver.car.index), space)
		ui.inLineBulletText("Extended Physics", ui.upperBool(driver.car.extendedPhysics), space)
		ui.inLineBulletText("Physics Available", ui.upperBool(driver.car.physicsAvailable), space)
		ui.inLineBulletText("DRS Present", ui.upperBool(driver.car.drsPresent), space)
	end)
end

local function vscTreeNode()
	ui.treeNode("[VSC]", ui.TreeNodeFlags.DefaultOpen and ui.TreeNodeFlags.Framed, function()
		ui.inLineBulletText("VSC Called", ui.upperBool(VSC_CALLED), space)
		ui.inLineBulletText("VSC Deployed", ui.upperBool(VSC_DEPLOYED), space)
		ui.inLineBulletText("VSC Lap TIme", ac.lapTimeToString(VSC_LAP_TIME), space)
	end)
end

local function driverTreeNode(sim, rc, driver)
	ui.treeNode("[DRIVER]", ui.TreeNodeFlags.DefaultOpen and ui.TreeNodeFlags.Framed, function()
		ui.inLineBulletText("Driver [" .. driver.index .. "]", driver.name, space)
		ui.inLineBulletText("Team", ac.getDriverTeam(driver.car.index), space)
		ui.inLineBulletText("Number", ac.getDriverNumber(driver.car.index), space)
		ui.inLineBulletText("Race Position", driver.car.racePosition .. "/" .. sim.carsCount, space)
		ui.inLineBulletText("Track Position", driver.trackPosition .. "/" .. rc.carsOnTrackCount, space)
		if not sim.isOnlineRace then
			ui.inLineBulletText(
				"Lap",
				(driver.car.lapCount + 1) .. "/" .. ac.getSession(sim.currentSessionIndex).laps,
				space
			)
		end
		if sim.raceSessionType == ac.SessionType.Qualify then
			ui.inLineBulletText("Out Lap", ui.upperBool(driver.isOnOutlap), space)
			ui.inLineBulletText("Flying Lap", ui.upperBool(driver.isOnFlyingLap), space)
			ui.inLineBulletText("In Lap", ui.upperBool(driver.isOnInLap), space)
		end
		ui.inLineBulletText("Last Lap Time", ac.lapTimeToString(driver.car.previousLapTimeMs), space)
		ui.inLineBulletText("Best Lap Time", ac.lapTimeToString(driver.car.bestLapTimeMs), space)
	end)
end

local function weatherTreeNode(sim, rc)
	ui.treeNode("[WEATHER]", ui.TreeNodeFlags.DefaultOpen and ui.TreeNodeFlags.Framed, function()
		local isRaining = math.clamp(math.floor(sim.rainIntensity / 0.003), 0, 1) == 1
		local totalWetness = ((sim.rainWetness * 10000 * 3.75) + (sim.rainWater * 100 * 12.5))
		ui.inLineBulletText("Weather Type", ac.weatherTypeString(sim), space)
		ui.inLineBulletText("Is Raining", ui.upperBool(isRaining), space)
		ui.inLineBulletText("Rain Intensity", math.round(sim.rainIntensity * 500, 2) .. "%", space)
		ui.inLineBulletText("Track Wetness", math.round(sim.rainWetness * 10000, 2) .. "%", space)
		ui.inLineBulletText("Track Puddles", math.round(sim.rainWater * 100, 2) .. "%", space)
		ui.inLineBulletText("Total Wetness", math.round(totalWetness, 2) .. "%", space)
		ui.inLineBulletText("Wet Track", ui.upperBool(rc.wetTrack), space)
	end)
end

local function inputsTreeNode(driver)
	ui.treeNode("[INPUTS]", ui.TreeNodeFlags.DefaultOpen and ui.TreeNodeFlags.Framed, function()
		ui.inLineBulletText("Gas", math.round(driver.car.gas, 5), space)
		ui.inLineBulletText("Brake", math.round(driver.car.brake, 5), space)
		ui.inLineBulletText("Clutch", math.round(driver.car.clutch, 5), space)
		ui.inLineBulletText("Steer", math.round(driver.car.steer, 5), space)
	end)
end

local function controllerScriptInputsTreeNode(driver)
	ui.treeNode("[SCRIPT CONTROLLER INPUTS]", ui.TreeNodeFlags.DefaultOpen and ui.TreeNodeFlags.Framed, function()
		ui.inLineBulletText(
			"[0] Total Brake Balance",
			math.round(ac.getCarPhysics(driver.index).scriptControllerInputs[0], 5),
			space
		)
		ui.inLineBulletText("[1] Brake Migration %", ac.getCarPhysics(driver.index).scriptControllerInputs[1], space)
		ui.inLineBulletText("[2] Exit Diff", ac.getCarPhysics(driver.index).scriptControllerInputs[2], space)
		ui.inLineBulletText("[3] Entry Diff", ac.getCarPhysics(driver.index).scriptControllerInputs[3], space)
		ui.inLineBulletText("[4] Mid Diff", ac.getCarPhysics(driver.index).scriptControllerInputs[4], space)
		ui.inLineBulletText("[5] Hispd Diff", ac.getCarPhysics(driver.index).scriptControllerInputs[5], space)
		ui.inLineBulletText("[6] Diff Mode", ac.getCarPhysics(driver.index).scriptControllerInputs[6], space)
		ui.inLineBulletText("[7]", ac.getCarPhysics(driver.index).scriptControllerInputs[7], space)
	end)
end

local function debugHeader()
	ui.inLineBulletText("CSP Version", ac.getPatchVersion(), space)
	ui.inLineBulletText("CSP Version Code", ac.getPatchVersionCode(), space)
	ui.inLineBulletText("Current Date", os.date("%Y-%m-%d"), space)
	ui.nextColumn()
	ui.inLineBulletText(SCRIPT_SHORT_NAME .. " Version", SCRIPT_VERSION, space)
	ui.inLineBulletText(SCRIPT_SHORT_NAME .. " Version Code", SCRIPT_VERSION_CODE, space)
	ui.inLineBulletText(SCRIPT_SHORT_NAME .. " Version Release Date", SCRIPT_BUILD_DATE, space)
	ui.newLine()
	ui.nextColumn()
end

function debug_window(sim, rc, error)
	ui.pushFont(ui.Font.Small)

	local driver = DRIVERS[sim.focusedCar]

	if error then
		ui.textColored(error, rgbm(1, 0, 0, 1))
	end

	if not ac.compatibleCspVersion(CSP_MIN_VERSION_CODE) then
		ui.text("INCOMPATIBLE VERSION OF CSP")
		return
	end

	ui.columns(2, true, "infocol")

	debugHeader()

	ui.columns(2, true, "debugcol2")

	if driver.car.isAIControlled then
		aiTreeNode(driver)
	end
	pitStopsTreeNode(driver)
	tyresTreeNode(driver)
	iceTreeNode(driver)
	if driver.car.kersPresent then
		hybridSystemsTreeNode(driver)
	end
	if RARE_CONFIG.data.RULES.DRS_RULES == 1 then
		drsTreeNode(sim, rc, driver)
	end
	damageTreeNode(driver)

	ui.nextColumn()

	sessionTreeNode(sim, rc, driver)
	if ac.getPatchVersionCode() >= 2278 then
		sessionModifiersTreeNode(sim)
	end
	if RARE_CONFIG.data.RULES.VSC_RULES == 1 then
		vscTreeNode()
	end
	carInfoTreeNode(driver)
	driverTreeNode(sim, rc, driver)
	weatherTreeNode(sim, rc)
	inputsTreeNode(driver)
	controllerScriptInputsTreeNode(driver)

	ui.popFont()
end
