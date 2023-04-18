require("src/classes/mapped_config")

Settings = class("Settings")

local function loadSettings(sim)
	local settingsDir = ac.dirname() .. "/settings"
	local settingsFile = settingsDir .. "/settings.ini"

	if not io.fileExists(settingsFile) then
		settingsFile = settingsDir .. "/default_settings.ini"
		ac.debug("yeeet", settingsFile)
	end

	local settings = nil
	settings = MappedConfig(settingsFile, {
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
			X_POS = (ac.INIConfig.OptionalNumber == nil) and ac.INIConfig.OptionalNumber or (sim.windowWidth / 2 - 360),
			Y_POS = (ac.INIConfig.OptionalNumber == nil) and ac.INIConfig.OptionalNumber or 50,
			SCALE = (ac.INIConfig.OptionalNumber == nil) and ac.INIConfig.OptionalNumber or 1,
			DURATION = (ac.INIConfig.OptionalNumber == nil) and ac.INIConfig.OptionalNumber or 5,
		},
		MISC = {
			PHYSICS_REBOOT = (ac.INIConfig.OptionalNumber == nil) and ac.INIConfig.OptionalNumber or 1,
		},
	})
	return settings
end

function Settings:initialize(sim) -- constructor
	return loadSettings(sim)
end

function Settings:reload(sim)
	loadSettings(sim)
end
