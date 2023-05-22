local sim = ac.getSim()

local controls = require("src/ui/controls/slider")
local inject = require("src/controllers/injection")
local notifications = require("src/ui/windows/notification_window")
local injected = physics.allowed()

local presetNames = {
	"FORMULA",
	"GT",
}

local presets = {
	["FORMULA"] = {
		DRS_RULES = 1,
		DRS_ACTIVATION_LAP = 3,
		DRS_GAP_DELTA = 1000,
		DRS_WET_DISABLE = 1,
		RESTRICT_COMPOUNDS = 1,
		CORRECT_COMPOUNDS_COLORS = 1,
		VSC_RULES = 0,
		VSC_INIT_TIME = 300,
		VSC_DEPLOY_TIME = 300,
		RACE_REFUELING = 0,
	},
	["GT"] = {
		RESTRICT_COMPOUNDS = 0,
		CORRECT_COMPOUNDS_COLORS = 0,
		VSC_RULES = 0,
		VSC_INIT_TIME = 300,
		VSC_DEPLOY_TIME = 300,
		RACE_REFUELING = 1,
		DRS_RULES = 0,
		DRS_ACTIVATION_LAP = 0,
		DRS_GAP_DELTA = 0,
		DRS_WET_DISABLE = 0,
	},
}

function table.match(a, b)
	local match = true

	for k, v in pairs(a) do
		if v == b[k] then
		else
			match = false
		end
	end

	return match
end

local setPreset = {
	["FORMULA"] = function()
		RARE_CONFIG:set("RULES", "DRS_RULES", 1, false)
		RARE_CONFIG:set("RULES", "DRS_ACTIVATION_LAP", 3, false)
		RARE_CONFIG:set("RULES", "DRS_GAP_DELTA", 1000, false)
		RARE_CONFIG:set("RULES", "DRS_WET_DISABLE", 1, false)
		RARE_CONFIG:set("RULES", "RACE_REFUELING", 0, false)
		RARE_CONFIG:set("RULES", "RESTRICT_COMPOUNDS", 1, false)
		RARE_CONFIG:set("RULES", "CORRECT_COMPOUNDS_COLORS", 1, false)
	end,
	["GT"] = function()
		RARE_CONFIG:set("RULES", "DRS_RULES", 0, false)
		RARE_CONFIG:set("RULES", "DRS_ACTIVATION_LAP", 0, false)
		RARE_CONFIG:set("RULES", "DRS_GAP_DELTA", 0, false)
		RARE_CONFIG:set("RULES", "DRS_WET_DISABLE", 0, false)
		RARE_CONFIG:set("RULES", "RACE_REFUELING", 1, false)
		RARE_CONFIG:set("RULES", "RESTRICT_COMPOUNDS", 0, false)
		RARE_CONFIG:set("RULES", "CORRECT_COMPOUNDS_COLORS", 0, false)
	end,
}

local selectedPreset = "CUSTOM"

local function rulesTab()
	ui.tabItem("RULES", ui.TabItemFlags.None, function()
		ui.newLine(1)

		if sim.raceSessionType == 3 then
			if not sim.isInMainMenu or sim.isSessionStarted then
				ui.text("Can only edit RULES settings while\nin the setup menu before a race session has started.")
				return
			end
		end

		selectedPreset = "CUSTOM"
		for preset in pairs(presets) do
			if table.match(presets[preset], RARE_CONFIG.data.RULES) then
				selectedPreset = preset
			end
		end

		ui.header("RACE SERIES")
		ui.setNextItemWidth(ui.windowWidth() - 75)
		local changed = false
		ui.combo("##presetNames", selectedPreset, ui.ComboFlags.None, function()
			for i = 1, #presetNames do
				if ui.selectable(presetNames[i]) then
					selectedPreset, changed = presetNames[i], true
				end
			end
		end)

		if changed then
			setPreset[selectedPreset]()
		end

		ui.newLine(1)

		ui.header("DRS")
		controls.slider(
			RARE_CONFIG,
			"RULES",
			"DRS_RULES",
			0,
			1,
			1,
			true,
			RARE_CONFIG.data.RULES.DRS_RULES == 1 and "DRS Rules: ENABLED" or "DRS Rules: DISABLED",
			"Enable DRS being controlled by the app",
			function(v)
				return math.round(v, 0)
			end
		)

		if RARE_CONFIG.data.RULES.DRS_RULES == 1 then
			DRS_ENABLED_LAP = controls.slider(
				RARE_CONFIG,
				"RULES",
				"DRS_ACTIVATION_LAP",
				1,
				5,
				1,
				false,
				"Activation Lap: %.0f",
				"First lap to allow DRS activation",
				function(v)
					return v
				end
			)
			controls.slider(
				RARE_CONFIG,
				"RULES",
				"DRS_GAP_DELTA",
				100,
				2000,
				1,
				false,
				"Gap Delta: %.0f ms",
				"Max gap to car ahead when crossing detection line to allow DRS for the next zone",
				function(v)
					return math.floor(v / 50 + 0.5) * 50
				end
			)

			ui.newLine(1)

			controls.slider(
				RARE_CONFIG,
				"RULES",
				"DRS_WET_DISABLE",
				0,
				1,
				1,
				true,
				RARE_CONFIG.data.RULES.DRS_WET_DISABLE == 1 and "Disable DRS When Wet: ENABLED"
					or "Disable DRS When Wet: DISABLED",
				"Disable DRS activation if track wetness gets above the limit below",
				function(v)
					return math.round(v, 0)
				end
			)
		end
		ui.newLine(1)

		ui.header("FUEL")
		controls.slider(
			RARE_CONFIG,
			"RULES",
			"RACE_REFUELING",
			0,
			1,
			1,
			true,
			RARE_CONFIG.data.RULES.RACE_REFUELING == 1 and "Race Refueling: ENABLED" or "Race Refueling: DISABLED",
			"Enable or disable refueling during a race",
			function(v)
				return math.round(v, 0)
			end
		)

		ui.newLine(1)

		ui.header("TYRE COMPOUNDS")
		controls.slider(
			RARE_CONFIG,
			"RULES",
			"RESTRICT_COMPOUNDS",
			0,
			1,
			1,
			true,
			RARE_CONFIG.data.RULES.RESTRICT_COMPOUNDS == 1 and "Restrict Compound Choice: ENABLED"
				or "Restrict Compound Choice: DISABLED",
			"Enable or disable restricting compound choice to user defined set\nRequires configration in order to work",
			function(v)
				return math.round(v, 0)
			end
		)
		controls.slider(
			RARE_CONFIG,
			"RULES",
			"CORRECT_COMPOUNDS_COLORS",
			0,
			1,
			1,
			true,
			RARE_CONFIG.data.RULES.CORRECT_COMPOUNDS_COLORS == 1 and "Soft-Medium-Hard Compound Colors: ENABLED"
				or "Soft-Medium-Hard Compound Colors: DISABLED",
			"Enable or disable changing the compound colors to reflect the Hard (white) Medium (yellow) and Soft (red) compound\nRequires configration in order to work",
			function(v)
				return math.round(v, 0)
			end
		)
		ui.newLine(1)
	end)
end

local function aiTab()
	ui.tabItem("AI", ui.TabItemFlags.None, function()
		ui.newLine(1)

		-- if not sim.isInMainMenu then
		-- 	ui.text("Can only edit AI settings while\nin the setup menu before a session has started.")
		-- 	return
		-- elseif sim.isSessionStarted then
		-- 	ui.text("Can only edit AI settings while\nin the setup menu before a session has started.")
		-- 	return
		-- end

		ui.header("LEVEL")
		controls.slider(
			RARE_CONFIG,
			"AI",
			"AI_ALTERNATE_LEVEL",
			0,
			1,
			1,
			true,
			RARE_CONFIG.data.AI.AI_ALTERNATE_LEVEL == 1 and "Alternate AI Strength: ENABLED"
				or "Alternate AI Strength: DISABLED",
			"Changes the default AI level to be more competitive",
			function(v)
				return math.round(v, 0)
			end
		)

		ui.newLine(1)

		controls.slider(
			RARE_CONFIG,
			"AI",
			"AI_RELATIVE_SCALING",
			0,
			1,
			1,
			true,
			RARE_CONFIG.data.AI.AI_RELATIVE_SCALING == 1 and "Relative AI Scaling: ENABLED"
				or "Relative AI Scaling: DISABLED",
			"Enables relative AI scaling",
			function(v)
				return math.round(v, 0)
			end
		)

		controls.slider(
			RARE_CONFIG,
			"AI",
			"AI_RELATIVE_LEVEL",
			70,
			100,
			1,
			true,
			RARE_CONFIG.data.AI.AI_RELATIVE_LEVEL == 1 and "Relative AI Level %.0f%%" or "Relative AI Level %.0f%%",
			"Relative AI level, for easier scaling with BoP'd grids",
			function(v)
				for i = 0, #DRIVERS do
					DRIVERS[i]:setAIRelativeLevel()
				end

				return math.round(v, 0)
			end
		)

		ui.newLine(1)

		ui.header("TYRES")
		controls.slider(
			RARE_CONFIG,
			"AI",
			"AI_FORCE_PIT_TYRES",
			0,
			1,
			1,
			true,
			RARE_CONFIG.data.AI.AI_FORCE_PIT_TYRES == 1 and "Pit When Tyres Worn: ENABLED"
				or "Pit When Tyres Worn: DISABLED",
			"Force AI to pit for new tyres when their average tyre life is below AI TYRE LIFE",
			function(v)
				return math.round(v, 0)
			end
		)

		ui.newLine(1)

		local driver = DRIVERS[sim.focusedCar]
		if RARE_CONFIG.data.AI.AI_FORCE_PIT_TYRES == 1 then
			controls.slider(
				RARE_CONFIG,
				"AI",
				"AI_AVG_TYRE_LIFE",
				0,
				100,
				1,
				false,
				"Pit Below Avg Tyre Life: %.2f%%",
				"AI will pit after average tyre life % is below this value",
				function(v)
					RARE_CONFIG.data.AI.AI_SINGLE_TYRE_LIFE =
						math.clamp(RARE_CONFIG.data.AI.AI_SINGLE_TYRE_LIFE, 0, math.floor(v / 0.5 + 0.5) * 0.5)
					return math.floor(v / 0.5 + 0.5) * 0.5
				end
			)

			controls.slider(
				RARE_CONFIG,
				"AI",
				"AI_AVG_TYRE_LIFE_RANGE",
				0,
				15,
				1,
				false,
				"Variability: %.2f%%",
				"AI will pit if one tyre's life % is below this value",
				function(v)
					return math.floor(v / 0.5 + 0.5) * 0.5
				end
			)

			ui.newLine(1)

			controls.slider(
				RARE_CONFIG,
				"AI",
				"AI_SINGLE_TYRE_LIFE",
				0,
				RARE_CONFIG.data.AI.AI_AVG_TYRE_LIFE,
				1,
				false,
				"Pit Below Single Tyre Life: %.2f%%",
				"AI will pit if one tyre's life % is below this value",
				function(v)
					return math.floor(v / 0.5 + 0.5) * 0.5
				end
			)

			controls.slider(
				RARE_CONFIG,
				"AI",
				"AI_SINGLE_TYRE_LIFE_RANGE",
				0,
				15,
				1,
				false,
				"Variability: %.2f%%",
				"AI will pit if one tyre's life % is below this value",
				function(v)
					return math.floor(v / 0.5 + 0.5) * 0.5
				end
			)

			ui.newLine(1)

			ui.header("FUEL")
			controls.slider(
				RARE_CONFIG,
				"AI",
				"AI_TANK_FILL",
				0,
				1,
				1,
				true,
				RARE_CONFIG.data.AI.AI_TANK_FILL == 1 and "Fill Fuel Tank: ENABLED" or "Fill Fuel Tank: DISABLED",
				"Enable or disable refueling AI car's fuel tank with enough fuel for the whole race, given the capacity is high enough",
				function(v)
					return math.round(v, 0)
				end
			)

			if ac.getPatchVersionCode() >= 2278 then
				ui.newLine(1)

				ui.header("MISC")
				controls.slider(
					RARE_CONFIG,
					"AI",
					"AI_MGUK_CONTROL",
					0,
					1,
					1,
					true,
					RARE_CONFIG.data.AI.AI_MGUK_CONTROL == 1 and "AI Dynamic MGUK: ENABLED"
						or "AI Dynamic MGUK: DISABLED",
					"Enables AI to make MGUK changes during the race",
					function(v)
						return math.round(v, 0)
					end
				)
			end

			if not sim.isInMainMenu and ac.getPatchVersionCode() >= 2278 then
				if driver.car.isAIControlled then
					local buttonFlags = ui.ButtonFlags.None
					if driver.isAIPitting or driver.car.isInPitlane then
						buttonFlags = ui.ButtonFlags.Disabled
					end
					if ui.button("FORCE FOCUSED AI TO PIT NOW", vec2(ui.windowWidth() - 77, 25), buttonFlags) then
						physics.setAIPitStopRequest(driver.index, true)
					end

					-- if ui.button("Awaken Car", vec2(ui.windowWidth()-77,25), ui.ButtonFlags.None) then
					--     driver.aiPrePitFuel = 140
					--     physics.setCarFuel(driver.index,140)
					--     physics.awakeCar(driver.index)
					--     physics.setCarFuel(driver.index,140)
					--     physics.resetCarState(driver.index)
					--     physics.engageGear(driver.index,1)
					--     physics.setEngineRPM(driver.index, 13000)
					--     physics.setCarVelocity(driver.index,vec3(0,0,5))
					-- end
				else
					if ui.button("FORCE ALL AI TO PIT NOW", vec2(ui.windowWidth() - 77, 25), ui.ButtonFlags.None) then
						for i = 0, #DRIVERS do
							local driver = DRIVERS[i]
							if driver.car.isAIControlled then
								physics.setAIPitStopRequest(driver.index, true)
							end
						end
					end

					-- if ui.button("TELEPORT ALL AI TO PIT NOW", vec2(ui.windowWidth()-77,25), ui.ButtonFlags.None) then
					--     for i=0, #DRIVERS do
					--         local driver = DRIVERS[i]
					--         if driver.car.isAIControlled then
					--             physics.teleportCarTo(driver.index,ac.SpawnSet.Pits)
					--         end
					--     end
					-- end
				end
			end
		end

		ui.newLine(1)
	end)
end

local function audioTab()
	ui.tabItem("AUDIO", ui.TabItemFlags.None, function()
		ui.newLine(1)
		ui.header("VOLUME")
		local acVolume = ac.getAudioVolume(ac.AudioChannel.Main)

		controls.slider(
			RARE_CONFIG,
			"AUDIO",
			"MASTER",
			0,
			100,
			1,
			false,
			"Master: %.0f%%",
			SCRIPT_SHORT_NAME .. " Master Volume",
			function(v)
				return math.round(v, 0)
			end
		)

		controls.slider(
			RARE_CONFIG,
			"AUDIO",
			"DRS_BEEP",
			0,
			100,
			1,
			false,
			"DRS Beep: %.0f%%",
			"DRS Beep Volume",
			function(v)
				return math.round(v, 0)
			end
		)
		DRS_BEEP:setVolume(acVolume * RARE_CONFIG.data.AUDIO.MASTER / 100 * RARE_CONFIG.data.AUDIO.DRS_BEEP / 100)

		ui.sameLine(0, 2)
		if ui.button("##drsbeeptest", vec2(20, 20), ui.ButtonFlags.None) then
			DRS_BEEP:play()
		end
		ui.addIcon(ui.Icons.Play, 10, 0.5, nil, 0)
		if ui.itemHovered() then
			ui.setTooltip("Test DRS Beep")
		end

		controls.slider(
			RARE_CONFIG,
			"AUDIO",
			"DRS_FLAP",
			0,
			100,
			1,
			false,
			"DRS Flap: %.0f%%",
			"DRS Flap Volume",
			function(v)
				return math.round(v, 0)
			end
		)
		DRS_FLAP:setVolume(acVolume * RARE_CONFIG.data.AUDIO.MASTER / 100 * RARE_CONFIG.data.AUDIO.DRS_FLAP / 100)

		ui.sameLine(0, 2)
		if ui.button("##drsflaptest", vec2(20, 20), ui.ButtonFlags.None) then
			DRS_FLAP:play()
		end
		ui.addIcon(ui.Icons.Play, 10, 0.5, nil, 0)
		if ui.itemHovered() then
			ui.setTooltip("Test DRS Flap")
		end

		ui.newLine(1)
	end)
end

local function uiTab()
	ui.tabItem("UI", ui.TabItemFlags.None, function()
		ui.newLine(1)
		ui.header("RACE CONTROL BANNER")

		controls.slider(
			RARE_CONFIG,
			"NOTIFICATIONS",
			"X_POS",
			0,
			sim.windowWidth,
			1,
			false,
			"X Pos: %.0f",
			"X position on screen for the notification UI element",
			function(v)
				return math.round(v, 0)
			end
		)

		ui.sameLine(0, 2)

		if ui.button("##rcbannerxpos", vec2(20, 20), ui.ButtonFlags.None) then
			RARE_CONFIG:set("NOTIFICATIONS", "X_POS", (sim.windowWidth / 2 - 360))
		end
		ui.addIcon(ui.Icons.Target, 10, 0.5, nil, 0)
		if ui.itemHovered() then
			ui.setTooltip("Center X")
		end

		controls.slider(
			RARE_CONFIG,
			"NOTIFICATIONS",
			"Y_POS",
			0,
			sim.windowHeight,
			1,
			false,
			"Y Pos: %.0f",
			"Y position on screen for the notification UI element",
			function(v)
				return math.round(v, 0)
			end
		)

		ui.sameLine(0, 2)
		if ui.button("##rcbannerypos", vec2(20, 20), ui.ButtonFlags.None) then
			RARE_CONFIG.data.NOTIFICATIONS.Y_POS = sim.windowHeight / 2
		end
		ui.addIcon(ui.Icons.Target, 10, 0.5, nil, 0)
		if ui.itemHovered() then
			ui.setTooltip("Center Y")
		end

		controls.slider(
			RARE_CONFIG,
			"NOTIFICATIONS",
			"DURATION",
			0,
			10,
			1,
			false,
			"Timer: %.0f s",
			'Duration (seconds) that the "Race Control" banner will stay on screen',
			function(v)
				return math.round(v, 0)
			end
		)

		controls.slider(
			RARE_CONFIG,
			"NOTIFICATIONS",
			"SCALE",
			0.1,
			5,
			1,
			false,
			"Scale: %.1f",
			"Scale of the notification UI element",
			function(v)
				return math.round(v, 2)
			end
		)

		local buttonFlags = ui.ButtonFlags.None

		if ui.button("TEST BANNER", vec2(ui.windowWidth() - 77, 25), ui.ButtonFlags.None) then
			notifications.popup("RACE CONTROL BANNER", 10)
		end

		ui.newLine(1)
	end)
end

local compoundConfigDir = ac.dirname() .. "\\configs"
local uniqueCarIDs = {}

for i = 0, sim.carsCount - 1 do
	local carID = ac.getCarID(i)
	if not table.contains(uniqueCarIDs, carID) then
		table.insert(uniqueCarIDs, carID)
	end
end

local selectedCarID = uniqueCarIDs[1]

local selectedCarIDConfigFile, selectedCarConfigINI, selectedCarConfig

local function updateCarConfig()
	selectedCarIDConfigFile = compoundConfigDir .. "\\" .. selectedCarID .. ".ini"
	selectedCarConfigINI = ac.INIConfig.load(selectedCarIDConfigFile, ac.INIFormat.Default)
	selectedCarConfig = MappedConfig(selectedCarIDConfigFile, {
		COMPOUND_DEFAULTS = {
			SOFT_COMPOUND = (ac.INIConfig.OptionalNumber == nil) and ac.INIConfig.OptionalNumber or 0,
			MEDIUM_COMPOUND = (ac.INIConfig.OptionalNumber == nil) and ac.INIConfig.OptionalNumber or 0,
			HARD_COMPOUND = (ac.INIConfig.OptionalNumber == nil) and ac.INIConfig.OptionalNumber or 0,
			INTER_COMPOUND = (ac.INIConfig.OptionalNumber == nil) and ac.INIConfig.OptionalNumber or 0,
			WET_COMPOUND = (ac.INIConfig.OptionalNumber == nil) and ac.INIConfig.OptionalNumber or 0,
		},
		COMPOUND_TEXTURES = {
			COMPOUND_TARGET_MATERIAL = (ac.INIConfig.OptionalString == nil) and ac.INIConfig.OptionalString or "",
			SOFT_COMPOUND_TEXTURE = (ac.INIConfig.OptionalString == nil) and ac.INIConfig.OptionalString or "",
			MEDIUM_COMPOUND_TEXTURE = (ac.INIConfig.OptionalString == nil) and ac.INIConfig.OptionalString or "",
			HARD_COMPOUND_TEXTURE = (ac.INIConfig.OptionalNumber == nil) and ac.INIConfig.OptionalNumber or "",
			INTER_COMPOUND_TEXTURE = (ac.INIConfig.OptionalNumber == nil) and ac.INIConfig.OptionalNumber or "",
			WET_COMPOUND_TEXTURE = (ac.INIConfig.OptionalNumber == nil) and ac.INIConfig.OptionalNumber or "",
		},
	})
end

updateCarConfig()

if not io.fileExists(selectedCarIDConfigFile) then
	io.save(
		selectedCarIDConfigFile,
		[[
[COMPOUND_DEFAULTS]
SOFT_COMPOUND=1
MEDIUM_COMPOUND=2
HARD_COMPOUND=3
INTER_COMPOUND=5
WET_COMPOUND=6

[COMPOUND_TEXTURES]
COMPOUND_TARGET_MATERIAL=
SOFT_COMPOUND_TEXTURE=
MEDIUM_COMPOUND_TEXTURE=
HARD_COMPOUND_TEXTURE=
INTER_COMPOUND_TEXTURE=
WET_COMPOUND_TEXTURE=
]]
	)
end

local trackCompoundKeys = {
	"SOFT_COMPOUND",
	"MEDIUM_COMPOUND",
	"HARD_COMPOUND",
}

local compoundDefaultsKeys = {
	"SOFT_COMPOUND",
	"MEDIUM_COMPOUND",
	"HARD_COMPOUND",
	"INTER_COMPOUND",
	"WET_COMPOUND",
}

local compoundTexturesKeys = {
	"COMPOUND_TARGET_MATERIAL",
	"SOFT_COMPOUND_TEXTURE",
	"MEDIUM_COMPOUND_TEXTURE",
	"HARD_COMPOUND_TEXTURE",
	"INTER_COMPOUND_TEXTURE",
	"WET_COMPOUND_TEXTURE",
}

local function compoundsTab()
	ui.tabItem("COMPOUNDS", ui.TabItemFlags.None, function()
		if sim.raceSessionType == 3 then
			if not sim.isInMainMenu or sim.isSessionStarted then
				ui.newLine(1)

				ui.text("Can only edit COMPOUND configs while\nin the setup menu before a race session has started.")
				return
			end
		end

		ui.newLine(1)
		ui.pushFont(ui.Font.Small)
		ui.header("CONFIG CAR: ")

		ui.setNextItemWidth(ui.windowWidth() - 75)
		local changed = false
		ui.combo("##carIDs", selectedCarID, ui.ComboFlags.None, function()
			for i = 1, #uniqueCarIDs do
				if ui.selectable(uniqueCarIDs[i]) then
					selectedCarID, changed = uniqueCarIDs[i], true
				end
			end
		end)
		if changed then
			updateCarConfig()
		end

		ui.newLine(1)
		ui.popFont()
		ui.header("CURRENT TRACK")
		ui.pushFont(ui.Font.Small)
		ui.newLine(1)

		for i = 1, #trackCompoundKeys do
			local key = trackCompoundKeys[i]
			local prefix = ""
			ui.text(prefix .. key:gsub("_", " ") .. ":")
			ui.sameLine(190)
			ui.setNextItemWidth(206)

			local value, changed = ui.inputText(
				"##track" .. key .. "label",
				selectedCarConfigINI:get(ac.getTrackID(), key, 0),
				ui.InputTextFlags.None
			)
			if changed then
				selectedCarConfigINI:setAndSave(ac.getTrackID(), key, value, false)
				for i = 0, #DRIVERS do
					DRIVERS[i]:updateTyreCompoundConfig()
					DRIVERS[i]:setAITyreCompound()
				end
			end
		end
		ui.popFont()
		ui.newLine(1)

		ui.header("COMPOUND DEFAULTS")
		ui.pushFont(ui.Font.Small)
		ui.newLine(1)

		for i = 1, #compoundDefaultsKeys do
			local key = compoundDefaultsKeys[i]
			local prefix = ""
			if key == "SOFT_COMPOUND" or key == "MEDIUM_COMPOUND" or key == "HARD_COMPOUND" then
				prefix = "DEFAULT "
			end
			ui.text(prefix .. key:gsub("_", " ") .. ":")
			ui.sameLine(190)
			ui.setNextItemWidth(206)

			local value, changed = ui.inputText(
				"##" .. key .. "label",
				selectedCarConfig.data.COMPOUND_DEFAULTS[key],
				ui.InputTextFlags.None
			)
			if changed then
				selectedCarConfig:set("COMPOUND_DEFAULTS", key, value, false)
				for i = 0, #DRIVERS do
					DRIVERS[i]:updateTyreCompoundConfig()
					DRIVERS[i]:setAITyreCompound()
				end
			end
		end
		ui.popFont()
		ui.newLine(1)

		ui.header("COMPOUND TEXTURES")
		ui.pushFont(ui.Font.Small)
		ui.newLine(1)
		for i = 1, #compoundTexturesKeys do
			local key = compoundTexturesKeys[i]
			ui.text(key:gsub("_", " ") .. ":")
			ui.sameLine(190)
			ui.setNextItemWidth(206)

			local value, changed = ui.inputText(
				"##" .. key .. "label",
				selectedCarConfig.data.COMPOUND_TEXTURES[key],
				ui.InputTextFlags.None
			)
			if changed then
				selectedCarConfig:set("COMPOUND_TEXTURES", key, value, false)
				for i = 0, #DRIVERS do
					DRIVERS[i]:updateTyreCompoundConfig()
					DRIVERS[i]:setAITyreCompound()
				end
			end
		end
		ui.newLine(1)
		ui.popFont()
	end)
end

local function driverTab()
	ui.tabItem("DRIVER", ui.TabItemFlags.None, function()
		ui.newLine(1)

		ui.header("FUEL")
		controls.slider(
			RARE_CONFIG,
			"DRIVER",
			"TANK_FILL",
			0,
			1,
			1,
			true,
			RARE_CONFIG.data.DRIVER.TANK_FILL == 1 and "Fill Fuel Tank: ENABLED" or "Fill Fuel Tank: DISABLED",
			"Enable or disable refueling driver's car's fuel tank with enough fuel for the whole race, given the capacity is high enough",
			function(v)
				if v == 1 then
					DRIVERS[0]:setFuelTankRace()
				end
				return math.round(v, 0)
			end
		)
	end)
end

function settingsMenu(sim)
	local rareEnable = ac.isWindowOpen("rare")

	if sim.isInMainMenu then
		ui.newLine(3)

		ui.pushFont(ui.Font.Title)
		ui.textAligned(SCRIPT_NAME, vec2(0.5, 0.5), vec2(ui.availableSpaceX(), 34))
		ui.popFont()

		ui.sameLine(0, 0)
		ui.drawRectFilled(
			vec2(380, 30),
			vec2(420, 60),
			(rareEnable and injected) and rgbm(0, 1, 0, 0.5) or rgbm(1, 0, 0, 0.5)
		)

		ui.sameLine(380, 0)
		ui.setCursor(vec2(380, 30))

		local buttonLabel = (rareEnable and injected) and "ON" or "OFF"
		if ui.button(buttonLabel, vec2(40, 30), ui.ButtonFlags.None) then
			if injected then
				ac.setWindowOpen("rare", not ac.isWindowOpen("rare"))
			else
				inject.injectRare()
			end
		end

		if ui.itemHovered() then
			if not physics.allowed() then
				ui.setTooltip("Inject " .. SCRIPT_SHORT_NAME .. " App")
			else
				ui.setTooltip("Enable or Disable " .. SCRIPT_SHORT_NAME .. " App")
			end
		end
	end

	if ac.isWindowOpen("rare") and INITIALIZED and injected then
		ui.newLine(3)
	else
		ui.newLine(0)
		return
	end

	ui.tabBar("settingstabbar", ui.TabBarFlags.None, function()
		rulesTab()
		driverTab()
		compoundsTab()
		aiTab()
		audioTab()
		uiTab()
	end)

	ui.setCursor(vec2(0, 601))
end
