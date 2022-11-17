local connect = require 'src/connection'
require 'src/driver'

--- Initialize RARE and returns initialized state
--- @return boolean
function initialize(sim)
    log(SCRIPT_NAME.." version: "..SCRIPT_VERSION)
    log(SCRIPT_NAME.." version: "..SCRIPT_VERSION_CODE)
    log("CSP version: "..ac.getPatchVersionCode())

    if not compatibleCspVersion() then
        ui.toast(ui.Icons.Warning, "[RARE] Incompatible CSP version. CSP "..CSP_MIN_VERSION.." ".."("..CSP_MIN_VERSION_CODE..")".." required!")
        log("[WARN] Incompatible CSP version. CSP "..CSP_MIN_VERSION.." ".."("..CSP_MIN_VERSION_CODE..")".." required!")
        return false
    end

    try(function ()
        local configFile = "settings.ini"
        RARECONFIG = MappedConfig(ac.getFolder(ac.FolderID.ACApps).."/lua/RARE/"..configFile, {
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
        log("[Loaded] Config file: "..ac.getFolder(ac.FolderID.ACApps).."/lua/RARE/"..configFile)
        return true
    end,function (err)

    end,function ()

    end)


    if RARECONFIG.data.RULES.PHYSICS_REBOOT == 1 then
        if not physics.allowed() then
            local trackSurfaces = MappedConfig(ac.getTrackDataFilename('surfaces.ini'), {
                _SCRIPTING_PHYSICS = { ALLOW_APPS = 'nil' },
                SURFACE_0 = { WAV_PITCH = 'nil' }
            })

            trackSurfaces:set('_SCRIPTING_PHYSICS', 'ALLOW_APPS', '1')
            trackSurfaces:set('SURFACE_0', 'WAV_PITCH', 'extended-0')

            REBOOT = true
            return true
        end
    end

    -- Get DRS Zones from track data folder
    try(function ()
        DRS_ZONES = DrsZones("drs_zones.ini")
        return true
    end, function (err)
        log("[ERROR]"..err)
        log("[ERROR] Failed to load DRS Zones!")
    end, function ()
    end)

    for i=0, ac.getSim().carsCount-1 do
        DRIVERS[i] = Driver(i)

        local driver = DRIVERS[i]

        if driver.car.isAIControlled then
            driver.aiLevel = connect.aiLevelDefault(i) ~= 0 and connect.aiLevelDefault(i) or driver.car.aiLevel
            ac.debug(i, math.lerp(0.5,1,1-((1-driver.aiLevel)/0.3)))
            driver.aiThrottleLimitBase = math.lerp(0.5,1,1-((1-driver.aiLevel)/0.3))
            driver.aiAggression = connect.aiAggressionDefault(i) ~= 0 and connect.aiAggressionDefault(i) or driver.car.aiAggression
        end

        physics.setAILevel(driver.index, driver.aiLevel)
        physics.setAIAggression(driver.index, driver.aiAggression)
        connect.storeDefaultAIData(driver)
    end

    log("[Initialized]")
    return true
end