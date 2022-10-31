
--- Initialize
function initialize(sim)
    LEADER_LAPS = 0
    VSC_DEPLOYED = false
    VSC_CALLED = false

    log("F1 Regs version: "..SCRIPT_VERSION)
    log("F1 Regs version: "..SCRIPT_VERSION_ID)
    log("CSP version: "..ac.getPatchVersionCode())

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
            AI_AVG_TYRE_LIFE = (ac.INIConfig.OptionalNumber == nil) and ac.INIConfig.OptionalNumber or 60,
            AI_AVG_TYRE_LIFE_RANGE = (ac.INIConfig.OptionalNumber == nil) and ac.INIConfig.OptionalNumber or 5,
            AI_SINGLE_TYRE_LIFE = (ac.INIConfig.OptionalNumber == nil) and ac.INIConfig.OptionalNumber or 45,
            AI_SINGLE_TYRE_LIFE_RANGE = (ac.INIConfig.OptionalNumber == nil) and ac.INIConfig.OptionalNumber or 5,
            AI_AGGRESSION_RUBBERBAND = (ac.INIConfig.OptionalNumber == nil) and ac.INIConfig.OptionalNumber or 0,
            PHYSICS_REBOOT = (ac.INIConfig.OptionalNumber == nil) and ac.INIConfig.OptionalNumber or 1
        },
        AUDIO = { 
            MASTER = (ac.INIConfig.OptionalNumber == nil) and ac.INIConfig.OptionalNumber or 100,
            DRS_BEEP = (ac.INIConfig.OptionalNumber == nil) and ac.INIConfig.OptionalNumber or 50,
            DRS_FLAP = (ac.INIConfig.OptionalNumber == nil) and ac.INIConfig.OptionalNumber or 50
        },
        NOTIFICATIONS = {
            SCALE = (ac.INIConfig.OptionalNumber == nil) and ac.INIConfig.OptionalNumber or 1,
            DURATION = (ac.INIConfig.OptionalNumber == nil) and ac.INIConfig.OptionalNumber or 5
        }
    })

    log("[Loaded] Config file: "..ac.getFolder(ac.FolderID.ACApps).."/lua/F1Regs/"..configFile)

    if not compatibleCspVersion() then
        ui.toast(ui.Icons.Warning, "[F1Regs] Incompatible CSP version. CSP "..CSP_MIN_VERSION.." required!")
        log("[WARN] Incompatible CSP version")
        return false
    end

    if not F1RegsConfig.data.RULES.PHYSICS_REBOOT == 0 then
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

    local acVolume = ac.getAudioVolume(ac.AudioChannel.Main)

    DRS_BEEP:setSource("./assets/audio/drs-available-beep.wav"):setAutoPlay(false)
    DRS_BEEP:setVolume(acVolume * F1RegsConfig.data.AUDIO.MASTER/100 * F1RegsConfig.data.AUDIO.DRS_BEEP/100)

    DRS_FLAP:setSource("./assets/audio/drs-flap.wav"):setAutoPlay(false)
    DRS_FLAP:setVolume(acVolume * F1RegsConfig.data.AUDIO.MASTER/100 * F1RegsConfig.data.AUDIO.DRS_FLAP/100)

    -- Empty DRIVERS table
    for index in pairs(DRIVERS) do
        DRIVERS[index] = nil
    end
    DRIVERS = {}

    -- Get DRS Zones from track data folder
    DRS_ZONES = DRS_Points("drs_zones.ini")
    DRS_ENABLED_LAP = F1RegsConfig.data.RULES.DRS_ACTIVATION_LAP

    -- Populate DRIVERS array
    for driverIndex = 0, sim.carsCount-1 do
        table.insert(DRIVERS, driverIndex, Driver(driverIndex))
        local driver = DRIVERS[driverIndex]
        driver.drsAvailable = false
        driver.trackPosition = driver.car.racePosition
        driver.lapPitted = driver.car.lapCount

        for i=0, math.random(driverIndex + 1) do
            math.randomseed(os.time()*driverIndex + 1)
            math.random()
        end

        driver.aiTyreAvgRandom = math.random(-F1RegsConfig.data.RULES.AI_AVG_TYRE_LIFE_RANGE,F1RegsConfig.data.RULES.AI_AVG_TYRE_LIFE_RANGE)
        driver.aiTyreSingleRandom = math.random(-F1RegsConfig.data.RULES.AI_SINGLE_TYRE_LIFE_RANGE,F1RegsConfig.data.RULES.AI_SINGLE_TYRE_LIFE_RANGE)

        setLeaderLaps(driver)
        if driver.car.isAIControlled then
            physics.setCarFuel(driver.index, driver.car.maxFuel)
        end

        if not sim.isSessionStarted or driver.car.isInPit then
            physics.setGentleStop(driverIndex, true)
        end

        storeData(driver)
        log("[Loaded] Driver "..driver.index..": "..driver.name)
    end

    if F1RegsConfig.data.RULES.DRS_RULES == 1 then
        log("[Race Control] DRS Enabled in "..DRS_ENABLED_LAP-LEADER_LAPS.." laps")
    end

    log("[Initialized]")
    return true
end