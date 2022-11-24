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

    local configFile = "settings.ini"
    try(function ()
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
                AI_ALTERNATE_LEVEL = (ac.INIConfig.OptionalNumber == nil) and ac.INIConfig.OptionalNumber or 1,
                AI_RELATIVE_SCALING = (ac.INIConfig.OptionalNumber == nil) and ac.INIConfig.OptionalNumber or 0,
                AI_RELATIVE_LEVEL = (ac.INIConfig.OptionalNumber == nil) and ac.INIConfig.OptionalNumber or 1,
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
        log("[ERROR] Failed to load config")
        return false
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
        log("[WARN]"..err)
        log("[WARN] Failed to load DRS Zones!")
    end, function ()
    end)

    local driverIni = ac.INIConfig.load(ac.getFolder(ac.FolderID.ACApps).."/lua/RARE/drivers.ini",ac.INIFormat.Default)

    for i=0, ac.getSim().carsCount-1 do
        DRIVERS[i] = Driver(i)

        local driver = DRIVERS[i]

        if driver.car.isAIControlled then
            local fuelcons = ac.INIConfig.carData(driver.index, 'fuel_cons.ini'):get('FUEL_EVAL', 'KM_PER_LITER', 0.0)
            local fuelload = 0
            local fuelPerLap =  (sim.trackLengthM / 1000) / (fuelcons - (fuelcons * 0.1))

            if sim.raceSessionType == ac.SessionType.Race then 
                fuelload = ((ac.getSession(sim.currentSessionIndex).laps + 2) * fuelPerLap)
            elseif sim.raceSessionType == ac.SessionType.Qualify then
                fuelload = 3.5 * fuelPerLap
            end

            physics.setCarFuel(driver.index, fuelload)

            if FIRST_LAUNCH and ((sim.raceSessionType == ac.SessionType.Race and not sim.isSessionStarted) or sim.raceSessionType == ac.SessionType.Qualify)then
                log("First initialization")
                if RARECONFIG.data.RULES.AI_RELATIVE_SCALING == 1 then
                    driver.aiLevel = driver.car.aiLevel * RARECONFIG.data.RULES.AI_RELATIVE_LEVEL/100
                    log("Using relative AI level scaling")
                else
                    log("Using default AI level scaling")
                    driver.aiLevel = driver.car.aiLevel
                end

                driver.aiThrottleLimitBase = math.lerp(0.5,1,1-((1-driver.aiLevel)/0.3))
                driver.aiAggression = driver.car.aiAggression

                driverIni:setAndSave('AI_'..driver.index, 'AI_LEVEL', driver.aiLevel)
                driverIni:setAndSave('AI_'..driver.index, 'AI_THROTTLE_LIMIT', driver.aiThrottleLimitBase)
                driverIni:setAndSave('AI_'..driver.index, 'AI_AGGRESSION', driver.car.aiAggression)
            else
                log("Loading saved AI values")
                driver.aiLevel = driverIni:get('AI_'..driver.index, 'AI_LEVEL', driver.car.aiLevel)
                driver.aiThrottleLimitBase = driverIni:get('AI_'..driver.index, 'AI_THROTTLE_LIMIT', math.lerp(0.5,1,1-((1-driver.car.aiLevel)/0.3)))
                driver.aiAggression = driverIni:get('AI_'..driver.index, 'AI_AGGRESSION', driver.car.aiAggression)
            end
        end

        physics.setAILevel(driver.index, driver.aiLevel)
        physics.setAIAggression(driver.index, driver.aiAggression)
    end

    log("[Initialized]")
    FIRST_LAUNCH = false
    return true
end