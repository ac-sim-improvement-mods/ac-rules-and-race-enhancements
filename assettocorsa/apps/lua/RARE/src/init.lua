require("src/driver")
local utils = require("src/utils")

local function setAIFuelTankMax(sim, driver)
	local fuelcons = ac.INIConfig.carData(driver.index, "fuel_cons.ini"):get("FUEL_EVAL", "KM_PER_LITER", 0.0)
	local fuelload = 0
	local fuelPerLap = (sim.trackLengthM / 1000) / (fuelcons - (fuelcons * 0.1))

	if sim.raceSessionType == ac.SessionType.Race then
		fuelload = ((ac.getSession(sim.currentSessionIndex).laps + 2) * fuelPerLap)
	elseif sim.raceSessionType == ac.SessionType.Qualify then
		fuelload = 3.5 * fuelPerLap
	end

	physics.setCarFuel(driver.index, fuelload)
end

local function setAITyreCompound(driver, compounds)
	math.randomseed(os.clock() * driver.index)
	math.random()
	for i = 0, math.random(0, math.random(3)) do
		math.random()
	end
	local tyrevalue = compounds[math.random(1, #compounds)]
	driver.tyreCompoundStart = tyrevalue
	driver.tyreCompoundsAvailable = compounds

	if ac.getPatchVersionCode() >= 2278 then
		physics.setAITyres(driver.index, tyrevalue)
		log("[" .. driver.index .. "] " .. driver.name .. " tyre compound set to " .. tyrevalue)
	end
end

local function getTrackTyreCompounds(driver)
	local trackID = ac.getTrackID()
	local carID = ac.getCarID(driver.index)
	local compoundsIni = ac.INIConfig.load(
		ac.getFolder(ac.FolderID.ACApps) .. "/lua/RARE/data/tyre_compounds/" .. carID .. ".ini",
		ac.INIFormat.Default
	)

	driver.tyreCompoundMaterialTarget =
		compoundsIni:get("COMPOUNDS", "COMPOUND_TARGET_MATERIAL", "Unknown Compound Material Target")
	driver.tyreCompoundSoftTexture =
		compoundsIni:get("COMPOUNDS", "SOFT_COMPOUND_TEXTURE", ""):gsub('"', ""):gsub("'", "")
	driver.tyreCompoundMediumTexture =
		compoundsIni:get("COMPOUNDS", "MEDIUM_COMPOUND_TEXTURE", ""):gsub('"', ""):gsub("'", "")
	driver.tyreCompoundHardTexture =
		compoundsIni:get("COMPOUNDS", "HARD_COMPOUND_TEXTURE", ""):gsub('"', ""):gsub("'", "")

	local compounds = string.split(compoundsIni:get(trackID, "COMPOUNDS", "0"), ",")
	compoundsIni:setAndSave(trackID, "COMPOUNDS", compoundsIni:get(trackID, "COMPOUNDS", "0"))
	table.sort(compounds, function(a, b)
		return a < b
	end)

	log("[" .. driver.index .. "] " .. driver.name .. " has " .. #compounds .. " compounds available")
	return compounds
end

local function setAIAlternateLevel(driver, driverIni)
	driver.aiLevel = driver.car.aiLevel
	driver.aiBrakeHint = ac.INIConfig.carData(driver.index, "ai.ini"):get("PEDALS", "BRAKE_HINT", 1)
	driver.aiThrottleLimitBase = math.lerp(0.5, 1, 1 - ((1 - driver.aiLevel) / 0.3))
	driver.aiAggression = driver.car.aiAggression
	driverIni:setAndSave("AI_" .. driver.index, "AI_LEVEL", driver.car.aiLevel)
	driverIni:setAndSave("AI_" .. driver.index, "AI_THROTTLE_LIMIT", driver.aiThrottleLimitBase)
	driverIni:setAndSave("AI_" .. driver.index, "AI_AGGRESSION", driver.car.aiAggression)
end

local function getAIAlternateLevel(driver, driverIni)
	driver.aiLevel = driverIni:get("AI_" .. driver.index, "AI_LEVEL", driver.car.aiLevel)
	driver.aiThrottleLimitBase = driverIni:get(
		"AI_" .. driver.index,
		"AI_THROTTLE_LIMIT",
		math.lerp(0.5, 1, 1 - ((1 - driver.car.aiLevel) / 0.3))
	)
	driver.aiAggression = driverIni:get("AI_" .. driver.index, "AI_AGGRESSION", driver.car.aiAggression)
end

local function createDrivers(sim)
	local driverCount = ac.getSim().carsCount
	local driverIni =
		ac.INIConfig.load(ac.getFolder(ac.FolderID.ACApps) .. "/lua/RARE/data/drivers.ini", ac.INIFormat.Default)

	for i = 0, driverCount - 1 do
		DRIVERS[i] = Driver(i)
		local driver = DRIVERS[i]

		driver.tyreCompoundsAvailable = getTrackTyreCompounds(driver)

		for i = 0, #DRS_ZONES.startLines do
			driver.drsDetection[i] = false
		end

		for i = 0, math.floor(sim.trackLengthM / 50) do
			driver.miniSectors[i] = 0
		end

		if driver.car.isAIControlled then
			if RARECONFIG.data.AI.AI_TANK_FILL == 1 then
				setAIFuelTankMax(sim, driver)
			end
			setAITyreCompound(driver, driver.tyreCompoundsAvailable)

			if FIRST_LAUNCH then
				setAIAlternateLevel(driver, driverIni)
			else
				getAIAlternateLevel(driver, driverIni)
			end

			if RARECONFIG.data.AI.AI_RELATIVE_SCALING == 1 then
				driver.aiLevel = driver.aiLevel * RARECONFIG.data.AI.AI_RELATIVE_LEVEL / 100
				driver.aiThrottleLimitBase = math.lerp(0.5, 1, 1 - ((1 - driver.aiLevel) / 0.3))
			end

			physics.setAILevel(driver.index, 1)
			physics.setAIAggression(driver.index, driver.aiAggression)
		end
	end

	log("Created " .. driverCount .. " drivers")
end

local function initDataDir()
	local rareDataDir = ac.getFolder(ac.FolderID.ACApps) .. "/lua/RARE/data"
	if not io.dirExists(rareDataDir) then
		io.createDir(rareDataDir)
	end
end

local function cspVersionCheck()
	log(SCRIPT_NAME .. " version: " .. SCRIPT_VERSION)
	log(SCRIPT_NAME .. " version: " .. SCRIPT_VERSION_CODE)
	log("CSP version: " .. ac.getPatchVersionCode())

	if not utils.compatibleCspVersion() then
		ui.toast(
			ui.Icons.Warning,
			"[RARE] Incompatible CSP version. CSP " .. CSP_MIN_VERSION .. " (" .. CSP_MIN_VERSION_CODE .. ") required!"
		)
		log("[WARN] Incompatible CSP version. CSP " .. CSP_MIN_VERSION .. " (" .. CSP_MIN_VERSION_CODE .. ") required!")
		return false
	end
end

local function loadSettings(sim)
	local configFile = "settings.ini"
	try(function()
		RARECONFIG = MappedConfig(ac.getFolder(ac.FolderID.ACApps) .. "/lua/RARE/" .. configFile, {
			RULES = {
				DRS_RULES = (ac.INIConfig.OptionalNumber == nil) and ac.INIConfig.OptionalNumber or 1,
				DRS_ACTIVATION_LAP = (ac.INIConfig.OptionalNumber == nil) and ac.INIConfig.OptionalNumber or 3,
				DRS_GAP_DELTA = (ac.INIConfig.OptionalNumber == nil) and ac.INIConfig.OptionalNumber or 1000,
				DRS_WET_DISABLE = (ac.INIConfig.OptionalNumber == nil) and ac.INIConfig.OptionalNumber or 1,
				RESTRICT_COMPOUNDS = (ac.INIConfig.OptionalNumber == nil) and ac.INIConfig.OptionalNumber or 1,
				CORRECT_COMPOUNDS_COLORS = (ac.INIConfig.OptionalNumber == nil) and ac.INIConfig.OptionalNumber or 1,
				VSC_RULES = (ac.INIConfig.OptionalNumber == nil) and ac.INIConfig.OptionalNumber or 0,
				VSC_INIT_TIME = (ac.INIConfig.OptionalNumber == nil) and ac.INIConfig.OptionalNumber or 300,
				VSC_DEPLOY_TIME = (ac.INIConfig.OptionalNumber == nil) and ac.INIConfig.OptionalNumber or 300,
				RACE_REFUELING = (ac.INIConfig.OptionalNumber == nil) and ac.INIConfig.OptionalNumber or 0,
			},
			AI = {
				AI_FORCE_PIT_TYRES = (ac.INIConfig.OptionalNumber == nil) and ac.INIConfig.OptionalNumber or 1,
				AI_AVG_TYRE_LIFE = (ac.INIConfig.OptionalNumber == nil) and ac.INIConfig.OptionalNumber or 62,
				AI_AVG_TYRE_LIFE_RANGE = (ac.INIConfig.OptionalNumber == nil) and ac.INIConfig.OptionalNumber or 5,
				AI_SINGLE_TYRE_LIFE = (ac.INIConfig.OptionalNumber == nil) and ac.INIConfig.OptionalNumber or 45,
				AI_SINGLE_TYRE_LIFE_RANGE = (ac.INIConfig.OptionalNumber == nil) and ac.INIConfig.OptionalNumber or 5,
				AI_ALTERNATE_LEVEL = (ac.INIConfig.OptionalNumber == nil) and ac.INIConfig.OptionalNumber or 1,
				AI_RELATIVE_SCALING = (ac.INIConfig.OptionalNumber == nil) and ac.INIConfig.OptionalNumber or 0,
				AI_RELATIVE_LEVEL = (ac.INIConfig.OptionalNumber == nil) and ac.INIConfig.OptionalNumber or 100,
				AI_MGUK_CONTROL = (ac.INIConfig.OptionalNumber == nil) and ac.INIConfig.OptionalNumber or 1,
				AI_TANK_FILL = (ac.INIConfig.OptionalNumber == nil) and ac.INIConfig.OptionalNumber or 1,
			},
			AUDIO = {
				MASTER = (ac.INIConfig.OptionalNumber == nil) and ac.INIConfig.OptionalNumber or 100,
				DRS_BEEP = (ac.INIConfig.OptionalNumber == nil) and ac.INIConfig.OptionalNumber or 50,
				DRS_FLAP = (ac.INIConfig.OptionalNumber == nil) and ac.INIConfig.OptionalNumber or 50,
			},
			NOTIFICATIONS = {
				X_POS = (ac.INIConfig.OptionalNumber == nil) and ac.INIConfig.OptionalNumber
					or (sim.windowWidth / 2 - 360),
				Y_POS = (ac.INIConfig.OptionalNumber == nil) and ac.INIConfig.OptionalNumber or 50,
				SCALE = (ac.INIConfig.OptionalNumber == nil) and ac.INIConfig.OptionalNumber or 1,
				DURATION = (ac.INIConfig.OptionalNumber == nil) and ac.INIConfig.OptionalNumber or 5,
			},
			MISC = {
				PHYSICS_REBOOT = (ac.INIConfig.OptionalNumber == nil) and ac.INIConfig.OptionalNumber or 1,
			},
		})
		log("Config file: " .. ac.getFolder(ac.FolderID.ACApps) .. "/lua/RARE/" .. configFile)
		return true
	end, function(err)
		log("[ERROR] Failed to load config")
		return false
	end, function() end)
end

local function loadDRSZones()
	-- Get DRS Zones from track data folder
	try(function()
		DRS_ZONES = DrsZones("drs_zones.ini")
		return true
	end, function(err)
		log("[WARN]" .. err)
		log("[WARN] Failed to load DRS Zones!")
	end, function() end)
end

--- Initialize RARE and returns initialized state
--- @return boolean
function initialize(sim)
	log(FIRST_LAUNCH and "First initialization" or "Reinitializing")

	cspVersionCheck()
	loadSettings(sim)

	if not physics.allowed() then
		utils.createRareTrackConfig()
		utils.setPhysicsAllowed()
		setTimeout(function()
			local rareLayout = "[RACE]"
				.. "\nCONFIG_TRACK="
				.. (ac.getTrackLayout() ~= "" and ac.getTrackLayout() or ac.getTrackID())
				.. "_rare"
			ac.restartAssettoCorsa(rareLayout)
		end, 5, "reboot")
	end

	loadDRSZones()
	initDataDir()
	createDrivers(sim)

	log(SCRIPT_SHORT_NAME .. " Initialized")
	FIRST_LAUNCH = false
	return true
end
