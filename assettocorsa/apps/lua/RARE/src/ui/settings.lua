local utils = require("src/utils")
local notifications = require("src/ui/notifications")

SPLINE_OFFSET = 0

function settingsMenu(sim)
	local scriptVersion = SCRIPT_VERSION .. " (" .. SCRIPT_VERSION_CODE .. ")"
	local rareEnable = ac.isWindowOpen("rare")
	ac.setWindowTitle("settings", SCRIPT_NAME .. " Settings | " .. scriptVersion)

	if sim.isInMainMenu then
		ui.newLine(3)

		ui.pushFont(ui.Font.Title)
		ui.textAligned(SCRIPT_NAME, vec2(0.5, 0.5), vec2(ui.availableSpaceX(), 34))
		ui.popFont()

		ui.sameLine(0, 0)
		ui.drawRectFilled(vec2(380, 30), vec2(420, 60), rareEnable and rgbm(0, 1, 0, 0.5) or rgbm(1, 0, 0, 0.5))

		ui.sameLine(380, 0)
		ui.setCursor(vec2(380, 30))

		-- local enabledButtonFlags = physics.allowed() and ui.ButtonFlags.None or ui.ButtonFlags.Disabled
		if ui.button(rareEnable and "ON" or "OFF", vec2(40, 30), ui.ButtonFlags.None) then
			ac.setWindowOpen("rare", not ac.isWindowOpen("rare"))
		end

		if ui.itemHovered() then
			ui.setTooltip("Enable or Disable " .. SCRIPT_SHORT_NAME .. " app")
		end
	end

	if ac.isWindowOpen("rare") and INITIALIZED then
		ui.newLine(3)
	else
		ui.newLine(0)
		return
	end

	ui.tabBar("settingstabbar", ui.TabBarFlags.None, function()
		if ac.getSim().isInMainMenu then
			ui.tabItem("RULES", ui.TabItemFlags.None, function()
				ui.newLine(1)
				ui.header("DRS")
				utils.slider(
					RARECONFIG,
					"RULES",
					"DRS_RULES",
					0,
					1,
					1,
					true,
					RARECONFIG.data.RULES.DRS_RULES == 1 and "DRS Rules: ENABLED" or "DRS Rules: DISABLED",
					"Enable DRS being controlled by the app",
					function(v)
						return math.round(v, 0)
					end
				)

				if RARECONFIG.data.RULES.DRS_RULES == 1 then
					DRS_ENABLED_LAP = utils.slider(
						RARECONFIG,
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
					utils.slider(
						RARECONFIG,
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

					utils.slider(
						RARECONFIG,
						"RULES",
						"DRS_WET_DISABLE",
						0,
						1,
						1,
						true,
						RARECONFIG.data.RULES.DRS_WET_DISABLE == 1 and "Disable DRS When Wet: ENABLED"
							or "Disable DRS When Wet: DISABLED",
						"Disable DRS activation if track wetness gets above the limit below",
						function(v)
							return math.round(v, 0)
						end
					)
				end
				ui.newLine(1)

				-- ui.header("VSC:")
				-- utils.slider(RARECONFIG, 'RULES', 'VSC_RULES', 0, 1, 1, true, RARECONFIG.data.RULES.VSC_RULES == 1 and "VSC Rules: ENABLED" or "VSC Rules: DISABLED",
				-- 'Enable a Virtual Safety Car to be deployed',
				-- function (v) return math.round(v, 0) end)
				-- if RARECONFIG.data.RULES.VSC_RULES == 1 then
				--     utils.slider(RARECONFIG, 'RULES', 'VSC_INIT_TIME', 0, 300, 1, false, 'Call After Yellow Flag For: %.0f s',
				--     'Time a yellow flag must be up before calling the VSC',
				--     function (v) return math.round(v, 0) end)
				--     utils.slider(RARECONFIG, 'RULES', 'VSC_DEPLOY_TIME', 0, 300, 1, false, 'Ends After Deployed For: %.0f s',
				--     'Time that the VSC is deployed before ending',
				--     function (v) return math.round(v, 0) end)
				-- end
				-- ui.newLine(1)

				ui.header("FUEL")
				utils.slider(
					RARECONFIG,
					"RULES",
					"RACE_REFUELING",
					0,
					1,
					1,
					true,
					RARECONFIG.data.RULES.RACE_REFUELING == 1 and "Race Refueling: ENABLED"
						or "Race Refueling: DISABLED",
					"Enable or disable refueling during a race",
					function(v)
						return math.round(v, 0)
					end
				)

				ui.newLine(1)

				ui.header("TYRE COMPOUNDS")
				utils.slider(
					RARECONFIG,
					"RULES",
					"RESTRICT_COMPOUNDS",
					0,
					1,
					1,
					true,
					RARECONFIG.data.RULES.RESTRICT_COMPOUNDS == 1 and "Restrict Compound Choice: ENABLED"
						or "Restrict Compound Choice: DISABLED",
					"Enable or disable restricting compound choice to user defined set\nRequires configration in order to work",
					function(v)
						return math.round(v, 0)
					end
				)
				utils.slider(
					RARECONFIG,
					"RULES",
					"CORRECT_COMPOUNDS_COLORS",
					0,
					1,
					1,
					true,
					RARECONFIG.data.RULES.CORRECT_COMPOUNDS_COLORS == 1 and "HMS Compound Colors: ENABLED"
						or "HMS Compound Colors: DISABLED",
					"Enable or disable changing the compound colors to reflect the Hard (white) Medium (yellow) and Soft (red) compound\nRequires configration in order to work",
					function(v)
						return math.round(v, 0)
					end
				)

				-- ui.newLine(5)

				-- if ui.button("APPLY SETTINGS", vec2(ui.windowWidth()-40,25), ui.ButtonFlags.None) then
				--     -- Load config file
				--     RARECONFIG = MappedConfig(ac.getFolder(ac.FolderID.ACApps).."/lua/RARE/settings.ini", {
				--         RULES = { DRS_RULES = ac.INIConfig.OptionalNumber, DRS_ACTIVATION_LAP = ac.INIConfig.OptionalNumber,
				--         DRS_GAP_DELTA = ac.INIConfig.OptionalNumber, DRS_WET_DISABLE = ac.INIConfig.OptionalNumber,
				--         VSC_RULES = ac.INIConfig.OptionalNumber, VSC_INIT_TIME = ac.INIConfig.OptionalNumber, VSC_DEPLOY_TIME = ac.INIConfig.OptionalNumber,
				--         AI_FORCE_PIT_TYRES = ac.INIConfig.OptionalNumber, AI_AVG_TYRE_LIFE = ac.INIConfig.OptionalNumber, AI_ALTERNATE_LEVEL = ac.INIConfig.OptionalNumber,
				--         PHYSICS_REBOOT = ac.INIConfig.OptionalNumber
				--     }})
				--     log("[Loaded] Applied config")
				--     DRS_ENABLED_LAP = RARECONFIG.data.RULES.DRS_ACTIVATION_LAP
				-- end
				ui.newLine(1)
			end)

			ui.tabItem("AI", ui.TabItemFlags.None, function()
				ui.newLine(1)

				ui.header("LEVEL")
				utils.slider(
					RARECONFIG,
					"AI",
					"AI_ALTERNATE_LEVEL",
					0,
					1,
					1,
					true,
					RARECONFIG.data.AI.AI_ALTERNATE_LEVEL == 1 and "Alternate AI Strength: ENABLED"
						or "Alternate AI Strength: DISABLED",
					"Changes the default AI level to be more competitive",
					function(v)
						return math.round(v, 0)
					end
				)

				ui.newLine(1)

				utils.slider(
					RARECONFIG,
					"AI",
					"AI_RELATIVE_SCALING",
					0,
					1,
					1,
					true,
					RARECONFIG.data.AI.AI_RELATIVE_SCALING == 1 and "Relative AI Scaling: ENABLED"
						or "Relative AI Scaling: DISABLED",
					"Enables relative AI scaling",
					function(v)
						return math.round(v, 0)
					end
				)

				utils.slider(
					RARECONFIG,
					"AI",
					"AI_RELATIVE_LEVEL",
					70,
					100,
					1,
					true,
					RARECONFIG.data.AI.AI_RELATIVE_LEVEL == 1 and "Relative AI Level %.0f%%"
						or "Relative AI Level %.0f%%",
					"Relative AI level, for easier scaling with BoP'd grids",
					function(v)
						FIRST_LAUNCH = false
						initialize(sim)
						return math.round(v, 0)
					end
				)

				ui.newLine(1)

				ui.header("TYRES")
				utils.slider(
					RARECONFIG,
					"AI",
					"AI_FORCE_PIT_TYRES",
					0,
					1,
					1,
					true,
					RARECONFIG.data.AI.AI_FORCE_PIT_TYRES == 1 and "Pit When Tyres Worn: ENABLED"
						or "Pit When Tyres Worn: DISABLED",
					"Force AI to pit for new tyres when their average tyre life is below AI TYRE LIFE",
					function(v)
						return math.round(v, 0)
					end
				)

				ui.newLine(1)

				local driver = DRIVERS[sim.focusedCar]
				if RARECONFIG.data.AI.AI_FORCE_PIT_TYRES == 1 then
					utils.slider(
						RARECONFIG,
						"AI",
						"AI_AVG_TYRE_LIFE",
						0,
						100,
						1,
						false,
						"Pit Below Avg Tyre Life: %.2f%%",
						"AI will pit after average tyre life % is below this value",
						function(v)
							RARECONFIG.data.AI.AI_SINGLE_TYRE_LIFE =
								math.clamp(RARECONFIG.data.AI.AI_SINGLE_TYRE_LIFE, 0, math.floor(v / 0.5 + 0.5) * 0.5)
							return math.floor(v / 0.5 + 0.5) * 0.5
						end
					)

					utils.slider(
						RARECONFIG,
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

					utils.slider(
						RARECONFIG,
						"AI",
						"AI_SINGLE_TYRE_LIFE",
						0,
						RARECONFIG.data.AI.AI_AVG_TYRE_LIFE,
						1,
						false,
						"Pit Below Single Tyre Life: %.2f%%",
						"AI will pit if one tyre's life % is below this value",
						function(v)
							return math.floor(v / 0.5 + 0.5) * 0.5
						end
					)

					utils.slider(
						RARECONFIG,
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
					utils.slider(
						RARECONFIG,
						"AI",
						"AI_TANK_FILL",
						0,
						1,
						1,
						true,
						RARECONFIG.data.AI.AI_TANK_FILL == 1 and "Fill Fuel Tank: ENABLED" or "Fill Fuel Tank: DISABLED",
						"Enable or disable refueling AI car's fuel tank with enough fuel for the whole race, given the capacity is high enough",
						function(v)
							return math.round(v, 0)
						end
					)

					if ac.getPatchVersionCode() >= 2278 then
						ui.newLine(1)

						ui.header("MISC")
						utils.slider(
							RARECONFIG,
							"AI",
							"AI_MGUK_CONTROL",
							0,
							1,
							1,
							true,
							RARECONFIG.data.AI.AI_MGUK_CONTROL == 1 and "AI Dynamic MGUK: ENABLED"
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
							if driver.aiPitting or driver.car.isInPitlane then
								buttonFlags = ui.ButtonFlags.Disabled
							end
							if
								ui.button("FORCE FOCUSED AI TO PIT NOW", vec2(ui.windowWidth() - 77, 25), buttonFlags)
							then
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
							if
								ui.button(
									"FORCE ALL AI TO PIT NOW",
									vec2(ui.windowWidth() - 77, 25),
									ui.ButtonFlags.None
								)
							then
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

		ui.tabItem("AUDIO", ui.TabItemFlags.None, function()
			ui.newLine(1)
			ui.header("VOLUME")
			local acVolume = ac.getAudioVolume(ac.AudioChannel.Main)

			utils.slider(
				RARECONFIG,
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

			utils.slider(
				RARECONFIG,
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
			DRS_BEEP:setVolume(acVolume * RARECONFIG.data.AUDIO.MASTER / 100 * RARECONFIG.data.AUDIO.DRS_BEEP / 100)

			ui.sameLine(0, 2)
			if ui.button("##drsbeeptest", vec2(20, 20), ui.ButtonFlags.None) then
				DRS_BEEP:play()
			end
			ui.addIcon(ui.Icons.Play, 10, 0.5, nil, 0)
			if ui.itemHovered() then
				ui.setTooltip("Test DRS Beep")
			end

			utils.slider(
				RARECONFIG,
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
			DRS_FLAP:setVolume(acVolume * RARECONFIG.data.AUDIO.MASTER / 100 * RARECONFIG.data.AUDIO.DRS_FLAP / 100)

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

		ui.tabItem("UI", ui.TabItemFlags.None, function()
			ui.newLine(1)
			ui.header("RACE CONTROL BANNER")

			utils.slider(
				RARECONFIG,
				"NOTIFICATIONS",
				"X_POS",
				0,
				sim.windowWidth,
				1,
				false,
				"X Pos: %.0f",
				'Duration (seconds) that the "Race Control" banner will stay on screen',
				function(v)
					return math.round(v, 0)
				end
			)

			ui.sameLine(0, 2)

			if ui.button("##rcbannerxpos", vec2(20, 20), ui.ButtonFlags.None) then
				RARECONFIG:set("NOTIFICATIONS", "X_POS", (sim.windowWidth / 2 - 360))
			end
			ui.addIcon(ui.Icons.Target, 10, 0.5, nil, 0)
			if ui.itemHovered() then
				ui.setTooltip("Center X")
			end

			utils.slider(
				RARECONFIG,
				"NOTIFICATIONS",
				"Y_POS",
				0,
				sim.windowHeight,
				1,
				false,
				"Y Pos: %.0f",
				'Duration (seconds) that the "Race Control" banner will stay on screen',
				function(v)
					return math.round(v, 0)
				end
			)

			ui.sameLine(0, 2)
			if ui.button("##rcbannerypos", vec2(20, 20), ui.ButtonFlags.None) then
				RARECONFIG.data.NOTIFICATIONS.Y_POS = sim.windowHeight / 2
			end
			ui.addIcon(ui.Icons.Target, 10, 0.5, nil, 0)
			if ui.itemHovered() then
				ui.setTooltip("Center Y")
			end

			utils.slider(
				RARECONFIG,
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

			utils.slider(
				RARECONFIG,
				"NOTIFICATIONS",
				"SCALE",
				0.1,
				5,
				1,
				false,
				"Scale: %.1f",
				'Duration (seconds) that the "Race Control" banner will stay on screen',
				function(v)
					return math.round(v, 2)
				end
			)

			local buttonFlags = ui.ButtonFlags.None

			if ui.isWindowAppearing() then
				buttonFlags = ui.ButtonFlags.Disabled
			end

			if ui.button("TEST BANNER", vec2(ui.windowWidth() - 77, 25), buttonFlags) then
				notifications.popup("RACE CONTROL BANNER", 10)
			end

			ui.newLine(1)
		end)

		-- ui.tabItem("MISC", ui.TabItemFlags.None, function()
		-- 	ui.newLine(1)

		-- 	utils.slider(
		-- 		RARECONFIG,
		-- 		"MISC",
		-- 		"PHYSICS_REBOOT",
		-- 		0,
		-- 		1,
		-- 		1,
		-- 		true,
		-- 		RARECONFIG.data.MISC.PHYSICS_REBOOT == 1 and "Auto App Injection Reboot: ENABLED"
		-- 			or "Auto App Injection Reboot: DISABLED",
		-- 		"If the app can't access physics\nAutomatically inject necessary lines into surfaces.ini\nReboot Assetto Corsa",
		-- 		function(v)
		-- 			return math.round(v, 0)
		-- 		end
		-- 	)

		-- 	ui.newLine(1)

		-- 	local injectionButtonFlag = physics.allowed() and ui.ButtonFlags.Disabled or ui.ButtonFlags.None
		-- 	if ui.button("App Injection", vec2(ui.windowWidth() - 77, 25), injectionButtonFlag) then
		-- 		setTrackSurfaces()
		-- 	end
		-- 	if ui.itemHovered() then
		-- 		ui.setTooltip("Inject necessary lines into surfaces.ini\nReboot Assetto Corsa")
		-- 	end

		-- 	local revertButtonFlag = physics.allowed() and ui.ButtonFlags.None or ui.ButtonFlags.Disabled
		-- 	if ui.button("Revert App Injection", vec2(ui.windowWidth() - 77, 25), revertButtonFlag) then
		-- 		resetTrackSurfaces()
		-- 	end
		-- 	if ui.itemHovered() then
		-- 		ui.setTooltip("NECESSARY FOR PLAYING ONLINE\n\nRevert surfaces.ini\nReboot Assetto Corsa")
		-- 	end

		-- 	-- if ui.button("AI COMP OVERRIDE "..upperBool(AI_COMP_OVERRIDE), vec2(ui.windowWidth()-77,25), ui.ButtonFlags.None) then
		-- 	--     AI_COMP_OVERRIDE = not AI_COMP_OVERRIDE
		-- 	-- end

		-- 	-- SPLINE_OFFSET = ui.utils.slider("SPLINE", SPLINE_OFFSET, -10, 10, '%.3f')
		-- 	-- physics.setAISplineOffset(sim.focusedCar, SPLINE_OFFSET)

		-- 	-- if ui.button("RESET TRACK PHYSICS", vec2(40,30), ui.ButtonFlags.None) then
		-- 	--     ac.setWindowOpen('rare', not ac.isWindowOpen('rare'))
		-- 	-- end

		-- 	ui.newLine(1)
		-- end)
	end)

	ui.setCursor(vec2(0, 601))
end
