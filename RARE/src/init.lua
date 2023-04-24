require("src/classes/driver")
require("src/classes/drs_zones")
require("src/classes/audio")
require("src/classes/mapped_config")
local settings = require("src/controllers/settings")

local function createDrivers(sim)
	local driverCount = sim.carsCount
	local driverIni =
		ac.INIConfig.load(ac.getFolder(ac.FolderID.ACApps) .. "/lua/RARE/data/drivers.ini", ac.INIFormat.Default)

	for i = 0, driverCount - 1 do
		DRIVERS[i] = Driver(i)
		local driver = DRIVERS[i]

		for i = 0, #DRS_ZONES.startLines do
			driver.drsDetection[i] = false
		end

		for i = 0, math.floor(sim.trackLengthM / 50) do
			driver.miniSectors[i] = 0
		end

		if driver.car.isAIControlled then
			if RARE_CONFIG.data.AI.AI_TANK_FILL == 1 then
				setAIFuelTankMax(sim, driver)
			end
			setAITyreCompound(driver, driver.tyreCompoundsAvailable)

			if FIRST_LAUNCH then
				setAIAlternateLevel(driver, driverIni)
			else
				getAIAlternateLevel(driver, driverIni)
			end

			if RARE_CONFIG.data.AI.AI_RELATIVE_SCALING == 1 then
				driver.aiLevel = driver.aiLevel * RARE_CONFIG.data.AI.AI_RELATIVE_LEVEL / 100
				driver.aiThrottleLimitBase = math.lerp(0.5, 1, 1 - ((1 - driver.aiLevel) / 0.3))
			end

			physics.setAILevel(driver.index, 1)
			physics.setAIAggression(driver.index, driver.aiAggression)
		end
	end

	log("Created " .. driverCount .. " drivers")
end

local function createDataDir()
	local rareDataDir = ac.getFolder(ac.FolderID.ACApps) .. "/lua/RARE/data"
	if not io.dirExists(rareDataDir) then
		io.createDir(rareDataDir)
	end
end

local function cspVersionCheck()
	log(SCRIPT_NAME .. " version: " .. SCRIPT_VERSION)
	log(SCRIPT_NAME .. " version: " .. SCRIPT_VERSION_CODE)
	log("CSP version: " .. ac.getPatchVersionCode())

	if not ac.compatibleCspVersion(CSP_MIN_VERSION_CODE) then
		ui.toast(
			ui.Icons.Warning,
			"[RARE] Incompatible CSP version. CSP " .. CSP_MIN_VERSION .. " (" .. CSP_MIN_VERSION_CODE .. ") required!"
		)
		log("[WARN] Incompatible CSP version. CSP " .. CSP_MIN_VERSION .. " (" .. CSP_MIN_VERSION_CODE .. ") required!")
		return false
	end
end

local function installExtensionContents()
	local extLuaDir = ac.getFolder(ac.FolderID.ExtLua)
	local connectionFile = io.loadFromZip(ac.dirname() .. "\\extension.zip", "connection.lua")

	ac.log(extLuaDir)
	ac.log(extLuaDir .. "\\RARE\\connection.lua")

	io.createDir(extLuaDir .. "\\RARE")
	io.deleteFile(extLuaDir .. "\\RARE\\connection.lua")
	io.copyFile(connectionFile, extLuaDir .. "\\RARE\\connection.lua")
end

--- Initialize RARE and returns initialized state
--- @return boolean
function initialize(sim)
	log(FIRST_LAUNCH and "First initialization" or "Reinitializing")

	installExtensionContents()
	cspVersionCheck()
	settings:load(sim)
	DRS_ZONES = DrsZones()
	SFX_DRIVER = Audio()
	createDataDir()
	createDrivers(sim)

	log(SCRIPT_SHORT_NAME .. " Initialized")
	FIRST_LAUNCH = false
	return true
end
