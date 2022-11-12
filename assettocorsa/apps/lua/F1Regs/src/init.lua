require 'src/driver'

--- Initialize F1 Regs and returns initialized state
--- @return boolean
function initialize(sim)
    log("F1 Regs version: "..SCRIPT_VERSION)
    log("F1 Regs version: "..SCRIPT_VERSION_CODE)
    log("CSP version: "..ac.getPatchVersionCode())

    if not compatibleCspVersion() then
        ui.toast(ui.Icons.Warning, "[F1Regs] Incompatible CSP version. CSP "..CSP_MIN_VERSION.." ".."("..CSP_MIN_VERSION_CODE..")".." required!")
        log("[WARN] Incompatible CSP version. CSP "..CSP_MIN_VERSION.." ".."("..CSP_MIN_VERSION_CODE..")".." required!")
        initialize()
        return false
    end

    local configFile = "settings.ini"

    F1RegsConfig = MappedConfig(ac.getFolder(ac.FolderID.ACApps).."/lua/F1Regs/"..configFile, {
        RULES = { 
            DRS_RULES = (ac.INIConfig.OptionalNumber == nil) and ac.INIConfig.OptionalNumber or 1,
            DRS_ACTIVATION_LAP = (ac.INIConfig.OptionalNumber == nil) and ac.INIConfig.OptionalNumber or 3,
            DRS_GAP_DELTA = (ac.INIConfig.OptionalNumber == nil) and ac.INIConfig.OptionalNumber or 1000,
            DRS_WET_DISABLE = (ac.INIConfig.OptionalNumber == nil) and ac.INIConfig.OptionalNumber or 1,
            DRS_WET_LIMIT = (ac.INIConfig.OptionalNumber == nil) and ac.INIConfig.OptionalNumber or 15,
            VSC_RULES = (ac.INIConfig.OptionalNumber == nil) and ac.INIConfig.OptionalNumber or 0,
            VSC_INIT_TIME = (ac.INIConfig.OptionalNumber == nil) and ac.INIConfig.OptionalNumber or 300,
            VSC_DEPLOY_TIME = (ac.INIConfig.OptionalNumber == nil) and ac.INIConfig.OptionalNumber or 300,
            AI_FORCE_PIT_TYRES = (ac.INIConfig.OptionalNumber == nil) and ac.INIConfig.OptionalNumber or 1,
            AI_AVG_TYRE_LIFE = (ac.INIConfig.OptionalNumber == nil) and ac.INIConfig.OptionalNumber or 45,
            AI_AVG_TYRE_LIFE_RANGE = (ac.INIConfig.OptionalNumber == nil) and ac.INIConfig.OptionalNumber or 15,
            AI_SINGLE_TYRE_LIFE = (ac.INIConfig.OptionalNumber == nil) and ac.INIConfig.OptionalNumber or 30,
            AI_SINGLE_TYRE_LIFE_RANGE = (ac.INIConfig.OptionalNumber == nil) and ac.INIConfig.OptionalNumber or 2.5,
            AI_AGGRESSION_RUBBERBAND = (ac.INIConfig.OptionalNumber == nil) and ac.INIConfig.OptionalNumber or 1,
            RACE_REFUELING = (ac.INIConfig.OptionalNumber == nil) and ac.INIConfig.OptionalNumber or 0,
            PHYSICS_REBOOT = (ac.INIConfig.OptionalNumber == nil) and ac.INIConfig.OptionalNumber or 1
        },
        AUDIO = { 
            MASTER = (ac.INIConfig.OptionalNumber == nil) and ac.INIConfig.OptionalNumber or 100,
            DRS_BEEP = (ac.INIConfig.OptionalNumber == nil) and ac.INIConfig.OptionalNumber or 50,
            DRS_FLAP = (ac.INIConfig.OptionalNumber == nil) and ac.INIConfig.OptionalNumber or 50
        },
        NOTIFICATIONS = {
            X_POS = (ac.INIConfig.OptionalNumber == nil) and ac.INIConfig.OptionalNumber or (sim.windowWidth / 2 - 360),
            Y_POS = (ac.INIConfig.OptionalNumber == nil) and ac.INIConfig.OptionalNumber or 50,
            SCALE = (ac.INIConfig.OptionalNumber == nil) and ac.INIConfig.OptionalNumber or 1,   
            DURATION = (ac.INIConfig.OptionalNumber == nil) and ac.INIConfig.OptionalNumber or 5
        }
    })

    log("[Loaded] Config file: "..ac.getFolder(ac.FolderID.ACApps).."/lua/F1Regs/"..configFile)

    if F1RegsConfig.data.RULES.PHYSICS_REBOOT == 1 then
        if not physics.allowed() then
            local trackSurfaces = MappedConfig(ac.getTrackDataFilename('surfaces.ini'), {
                _SCRIPTING_PHYSICS = { ALLOW_APPS = 'bullshit' },
                SURFACE_0 = { WAV_PITCH = 'bullshit' }
            })
        
            trackSurfaces:set('_SCRIPTING_PHYSICS', 'ALLOW_APPS', '1')
            trackSurfaces:set('SURFACE_0', 'WAV_PITCH', 'extended-0')
    
            REBOOT = true
            return true
        else
            physics.overrideRacingFlag(ac.FlagType.None)
        end
    end

    -- Get DRS Zones from track data folder
    DRS_ZONES = DrsZones("drs_zones.ini")

    for i=0, ac.getSim().carsCount-1 do
        DRIVERS[i] = Driver(i)

        local driver = DRIVERS[i]

        driver.aiThrottleLimitBase = driver.car.aiLevel

        if driver.car.isAIControlled and ac.load("app.F1Regs."..driver.index..".AI_Aggression") == nil then
            ac.store("app.F1Regs."..driver.index..".AI_Aggression",DRIVERS[i].aiAggression + 0.03)
        end
    end

    log("[Initialized]")
    return true
end