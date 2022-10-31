---@param cfg MappedConfig
---@param section string
---@param key string
---@param from number
---@param to number
---@param mult number
---@param format string
---@param tooltip string?
local function slider(cfg, section, key, from, to, mult, isbool, format, tooltip, preprocess)
  if not cfg.data[section] then error('No such section: '..section, 2) end
  if not cfg.data[section][key] then error('No such key: '..key, 2) end
  local curValue = ui.slider('##'..section..key, mult < 0 and -mult / cfg.data[section][key] or cfg.data[section][key] * mult, from, to, format)
  if tooltip and (ui.itemHovered() or ui.itemActive()) then
    (type(tooltip) == 'function' and ui.tooltip or ui.setTooltip)(tooltip)
  end
  if preprocess then
    curValue = preprocess(curValue)
  end
  ui.sameLine(0, 4)
  local changed = math.abs(cfg.original[section][key] - (mult < 0 and -mult / curValue or curValue / mult)) > 0.0001
  if ui.button('##r'..section..key, vec2(20, 20), changed and ui.ButtonFlags.None or ui.ButtonFlags.Disabled) then
    if isbool then
        curValue = cfg.original[section][key]
    else
        curValue = mult < 0 and -mult / cfg.original[section][key] or cfg.original[section][key] * mult
    end
  end
  ui.addIcon(ui.Icons.Restart, 10, 0.5, nil, 0)
  if ui.itemHovered() then
    local v = ""
    if isbool then
        v = cfg.original[section][key] == 1 and "ENABLED" or "DISABLED"
    else
        v = string.format(format:match('%%.+'), mult < 0 and -mult / cfg.original[section][key] or cfg.original[section][key] * mult)

    end
    ui.setTooltip(string.format(changed and 'Click to restore original value: %s' or 'Original value: %s', v))
  end
  cfg:set(section, key, curValue, false)

  return curValue
end

function settingsMenu()
    local scriptVersion = SCRIPT_VERSION.." ("..SCRIPT_VERSION_ID..")"
    ac.setWindowTitle("settings", "F1 Regs Settings      "..scriptVersion)
    ui.pushFont(ui.Font.Small)

    ui.tabBar("settingstabbar", ui.TabBarFlags.None, function ()
        ui.tabItem("GAME", ui.TabItemFlags.None, function ()
            ui.newLine(1)
            ui.header("DRS:")
            slider(F1RegsConfig, 'RULES', 'DRS_RULES', 0, 1, 1, true, F1RegsConfig.data.RULES.DRS_RULES == 1 and 'DRS Rules: ENABLED' or 'DRS Rules: DISABLED', 
            'Enable DRS being controlled by the app',
            function (v) return math.round(v, 0) end)

            if F1RegsConfig.data.RULES.DRS_RULES == 1 then
                DRS_ENABLED_LAP = slider(F1RegsConfig, 'RULES', 'DRS_ACTIVATION_LAP', 1, ac.getSession(ac.getSim().currentSessionIndex).laps, 1, false, 'Activation Lap: %.0f', 
                'First lap to allow DRS activation',
                function (v) return v end)
                slider(F1RegsConfig, 'RULES', 'DRS_GAP_DELTA', 100, 2000, 1, false, 'Gap Delta: %.0f ms',
                'Max gap to car ahead when crossing detection line to allow DRS for the next zone',
                function (v) return math.floor(v / 50 + 0.5) * 50 end)

                ui.newLine(1)

                slider(F1RegsConfig, 'RULES', 'DRS_WET_DISABLE', 0, 1, 1, true, F1RegsConfig.data.RULES.DRS_WET_DISABLE == 1 and 'Disable DRS When Wet: ENABLED' or 'Disable DRS When Wet: DISABLED', 
                'Disable DRS activation if track wetness gets above the limit below',
                function (v) return math.round(v, 0) end)
                if F1RegsConfig.data.RULES.DRS_WET_DISABLE == 1 then
                    slider(F1RegsConfig, 'RULES', 'DRS_WET_LIMIT', 0, 100, 1, false, 'Wet Limit: %.0f%%', 
                    'Track wetness level that will disable DRS activation',
                    function (v) return math.round(v,0) end)
                end
            end
            ui.newLine(1)
        
            -- ui.header("VSC:")
            -- slider(F1RegsConfig, 'RULES', 'VSC_RULES', 0, 1, 1, true, F1RegsConfig.data.RULES.VSC_RULES == 1 and "VSC Rules: ENABLED" or "VSC Rules: DISABLED", 
            -- 'Enable a Virtual Safety Car to be deployed',
            -- function (v) return math.round(v, 0) end)
            -- if F1RegsConfig.data.RULES.VSC_RULES == 1 then
            --     slider(F1RegsConfig, 'RULES', 'VSC_INIT_TIME', 0, 300, 1, false, 'Call After Yellow Flag For: %.0f s', 
            --     'Time a yellow flag must be up before calling the VSC',
            --     function (v) return math.round(v, 0) end)
            --     slider(F1RegsConfig, 'RULES', 'VSC_DEPLOY_TIME', 0, 300, 1, false, 'Ends After Deployed For: %.0f s', 
            --     'Time that the VSC is deployed before ending',
            --     function (v) return math.round(v, 0) end)
            -- end
            -- ui.newLine(1)
        
            ui.header("AI:")
            slider(F1RegsConfig, 'RULES', 'AI_FORCE_PIT_TYRES', 0, 1, 1, true, F1RegsConfig.data.RULES.AI_FORCE_PIT_TYRES == 1 and "Pit New Tyres Rules: ENABLED" or "Pit New Tyres Rules: DISABLED", 
            'Force AI to pit for new tyres when their average tyre life is below AI TYRE LIFE',
            function (v) return math.round(v, 0) end)
            
            local driver = DRIVERS[ac.getSim().focusedCar]
            if F1RegsConfig.data.RULES.AI_FORCE_PIT_TYRES == 1 then
                if driver.car.isAIControlled then
                    local buttonFlags = ui.ButtonFlags.None
                    if driver.aiPitting or driver.car.isInPitlane then
                        buttonFlags = ui.ButtonFlags.Disabled
                    end
                    if ui.button("FORCE FOCUSED AI TO PIT NOW", vec2(ui.windowWidth()-77,25), buttonFlags) then
                        driver.aiPrePitFuel = driver.car.fuel
                        physics.setCarFuel(driver.index, 0.1)
                        driver.aiPitCall = true
                    end

                    
                    ui.newLine(1)
                end

                slider(F1RegsConfig, 'RULES', 'AI_AVG_TYRE_LIFE', 0, 100, 1, false, 'Pit Below Avg Tyre Life: %.2f%%', 
                'AI will pit after average tyre life % is below this value',
                function (v) 
                    F1RegsConfig.data.RULES.AI_SINGLE_TYRE_LIFE = math.clamp(F1RegsConfig.data.RULES.AI_SINGLE_TYRE_LIFE,0,math.floor(v / 0.5 + 0.5) * 0.5)
                    return math.floor(v / 0.5 + 0.5) * 0.5 
                end)

                slider(F1RegsConfig, 'RULES', 'AI_AVG_TYRE_LIFE_RANGE', 0, 15, 1, false, 'Variability: %.2f%%', 
                "AI will pit if one tyre's life % is below this value",
                function (v) return math.floor(v / 0.5 + 0.5) * 0.5 end)

                ui.newLine(1)

                slider(F1RegsConfig, 'RULES', 'AI_SINGLE_TYRE_LIFE', 0, F1RegsConfig.data.RULES.AI_AVG_TYRE_LIFE, 1, false, 'Pit Below Single Tyre Life: %.2f%%', 
                "AI will pit if one tyre's life % is below this value",
                function (v) return math.floor(v / 0.5 + 0.5) * 0.5 end)

                slider(F1RegsConfig, 'RULES', 'AI_SINGLE_TYRE_LIFE_RANGE', 0, 15, 1, false, 'Variability: %.2f%%', 
                "AI will pit if one tyre's life % is below this value",
                function (v) return math.floor(v / 0.5 + 0.5) * 0.5 end)
            end

            ui.newLine(1)
            slider(F1RegsConfig, 'RULES', 'AI_AGGRESSION_RUBBERBAND', 0, 1, 1, true, F1RegsConfig.data.RULES.AI_AGGRESSION_RUBBERBAND == 1 and "Alt Aggression: ENABLED" or "Alt Aggression: DISABLED", 
            'Increase AI aggression when attacking',
            function (v) return math.round(v, 0) end)
        

            ui.newLine(1)
        
            ui.header("MISC:")
            slider(F1RegsConfig, 'RULES', 'PHYSICS_REBOOT', 0, 1, 1, true, F1RegsConfig.data.RULES.PHYSICS_REBOOT == 1 and 'Physics Reboot: ENABLED' or 'Physics Reboot: DISABLED', 
            "Reboot Assetto Corsa if the app doesn't have access to Physics",
            function (v) return math.round(v, 0) end)
            -- ui.newLine(5)
        
            -- if ui.button("APPLY SETTINGS", vec2(ui.windowWidth()-40,25), ui.ButtonFlags.None) then
            --     -- Load config file
            --     F1RegsConfig = MappedConfig(ac.getFolder(ac.FolderID.ACApps).."/lua/F1Regs/settings.ini", {
            --         RULES = { DRS_RULES = ac.INIConfig.OptionalNumber, DRS_ACTIVATION_LAP = ac.INIConfig.OptionalNumber, 
            --         DRS_GAP_DELTA = ac.INIConfig.OptionalNumber, DRS_WET_DISABLE = ac.INIConfig.OptionalNumber, DRS_WET_LIMIT = ac.INIConfig.OptionalNumber,
            --         VSC_RULES = ac.INIConfig.OptionalNumber, VSC_INIT_TIME = ac.INIConfig.OptionalNumber, VSC_DEPLOY_TIME = ac.INIConfig.OptionalNumber,
            --         AI_FORCE_PIT_TYRES = ac.INIConfig.OptionalNumber, AI_AVG_TYRE_LIFE = ac.INIConfig.OptionalNumber, AI_AGGRESSION_RUBBERBAND = ac.INIConfig.OptionalNumber,
            --         PHYSICS_REBOOT = ac.INIConfig.OptionalNumber
            --     }})
            --     log("[Loaded] Applied config")
            --     DRS_ENABLED_LAP = F1RegsConfig.data.RULES.DRS_ACTIVATION_LAP
            -- end
            ui.newLine(1)
        end)

        ui.tabItem("AUDIO", ui.TabItemFlags.None, function ()
            ui.newLine(1)
            ui.header("VOLUME:")
            local acVolume = ac.getAudioVolume(ac.AudioChannel.Main)

            slider(F1RegsConfig, 'AUDIO', 'MASTER', 0, 100, 1, false, 'Master: %.0f%%', 
            'F1 Regs Master Volume',
            function (v) return math.round(v,0) end)

            slider(F1RegsConfig, 'AUDIO', 'DRS_BEEP', 0, 100, 1, false, 'DRS Beep: %.0f%%', 
            'DRS Beep Volume',
            function (v) return math.round(v,0) end)
            DRS_BEEP:setVolume(acVolume * F1RegsConfig.data.AUDIO.MASTER/100 * F1RegsConfig.data.AUDIO.DRS_BEEP/100)

            ui.sameLine(0,2)
            if ui.button("##drsbeeptest", vec2(20, 20), ui.ButtonFlags.None) then
                DRS_BEEP:play()
            end
            ui.addIcon(ui.Icons.Play, 10, 0.5, nil, 0)


            slider(F1RegsConfig, 'AUDIO', 'DRS_FLAP', 0, 100, 1, false, 'DRS Flap: %.0f%%', 
            'DRS Flap Volume',
            function (v) return math.round(v,0) end)
            DRS_FLAP:setVolume(acVolume * F1RegsConfig.data.AUDIO.MASTER/100 * F1RegsConfig.data.AUDIO.DRS_FLAP/100)
            
            ui.sameLine(0,2)
            if ui.button("##drsflaptest", vec2(20, 20), ui.ButtonFlags.None) then
                DRS_FLAP:play()
            end
            ui.addIcon(ui.Icons.Play, 10, 0.5, nil, 0)
            ui.newLine(1)
        end)

        ui.tabItem("UI", ui.TabItemFlags.None, function ()
            ui.newLine(1)
            ui.header("RACE CONTROL:")
            slider(F1RegsConfig, 'NOTIFICATIONS', 'DURATION', 0, 10, 1, false, 'Banner Timer: %.0f s', 
            'Duration (seconds) that the "Race Control" banner will stay on screen',
            function (v) return math.round(v,0) end)

            slider(F1RegsConfig, 'NOTIFICATIONS', 'SCALE', 0.1, 1, 1, false, 'Banner Scale: %.1f', 
            'Duration (seconds) that the "Race Control" banner will stay on screen',
            function (v) return math.round(v,2) end)

            local buttonFlags = ui.ButtonFlags.None

            if ui.isWindowAppearing() then
                buttonFlags = ui.ButtonFlags.Disabled
            end

            if ui.button("TEST BANNER", vec2(ui.windowWidth()-77,25), buttonFlags) then
                showNotification("TEST",10)
            end

            ui.newLine(1)
        end)
    end)
end