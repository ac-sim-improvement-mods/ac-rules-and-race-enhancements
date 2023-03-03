local connect = require 'rare/connection'
require 'src/driver'

--- Initialize RARE and returns initialized state
--- @return boolean
function initialize(sim)
    if FIRST_LAUNCH then
        log("First initialization")
    else
        log("Reinitializing")
    end

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
                RACE_REFUELING = (ac.INIConfig.OptionalNumber == nil) and ac.INIConfig.OptionalNumber or 0,
            },
            AI = {
                AI_FORCE_PIT_TYRES = (ac.INIConfig.OptionalNumber == nil) and ac.INIConfig.OptionalNumber or 1,
                AI_AVG_TYRE_LIFE = (ac.INIConfig.OptionalNumber == nil) and ac.INIConfig.OptionalNumber or 45,
                AI_AVG_TYRE_LIFE_RANGE = (ac.INIConfig.OptionalNumber == nil) and ac.INIConfig.OptionalNumber or 15,
                AI_SINGLE_TYRE_LIFE = (ac.INIConfig.OptionalNumber == nil) and ac.INIConfig.OptionalNumber or 30,
                AI_SINGLE_TYRE_LIFE_RANGE = (ac.INIConfig.OptionalNumber == nil) and ac.INIConfig.OptionalNumber or 2.5,
                AI_ALTERNATE_LEVEL = (ac.INIConfig.OptionalNumber == nil) and ac.INIConfig.OptionalNumber or 0,
                AI_RELATIVE_SCALING = (ac.INIConfig.OptionalNumber == nil) and ac.INIConfig.OptionalNumber or 0,
                AI_RELATIVE_LEVEL = (ac.INIConfig.OptionalNumber == nil) and ac.INIConfig.OptionalNumber or 100
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
            },
            MISC = {
                PHYSICS_REBOOT = (ac.INIConfig.OptionalNumber == nil) and ac.INIConfig.OptionalNumber or 1
            }
        })
        log("[Loaded] Config file: "..ac.getFolder(ac.FolderID.ACApps).."/lua/RARE/"..configFile)
        return true
    end,function (err)
        log("[ERROR] Failed to load config")
        return false
    end,function ()

    end)

    if RARECONFIG.data.MISC.PHYSICS_REBOOT == 1 then
        setTrackSurfaces()
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

    if not io.dirExists(ac.getFolder(ac.FolderID.ACApps).."/lua/RARE/data") then
        io.createDir(ac.getFolder(ac.FolderID.ACApps).."/lua/RARE/data")
    end
    local driverIni = ac.INIConfig.load(ac.getFolder(ac.FolderID.ACApps).."/lua/RARE/data/drivers.ini",ac.INIFormat.Default)

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

            if FIRST_LAUNCH then
                driver.aiLevel = driver.car.aiLevel
                driver.aiThrottleLimitBase = math.lerp(0.5,1,1-((1-driver.aiLevel)/0.3))
                driver.aiAggression = driver.car.aiAggression
                math.random()
                for i=0, math.random(0,20) do
                    math.randomseed(os.time()*(i+1))
                    math.random()
                end
                local tyrevalue = math.random(2,4)
                physics.setAITyres(driver.index,tyrevalue)
                log(tyrevalue)
                driverIni:setAndSave('AI_'..driver.index, 'AI_LEVEL', driver.car.aiLevel)
                driverIni:setAndSave('AI_'..driver.index, 'AI_THROTTLE_LIMIT', driver.aiThrottleLimitBase)
                driverIni:setAndSave('AI_'..driver.index, 'AI_AGGRESSION', driver.car.aiAggression)
            else
                driver.aiLevel = driverIni:get('AI_'..driver.index, 'AI_LEVEL', driver.car.aiLevel)
                driver.aiThrottleLimitBase = driverIni:get('AI_'..driver.index, 'AI_THROTTLE_LIMIT', math.lerp(0.5,1,1-((1-driver.car.aiLevel)/0.3)))
                driver.aiAggression = driverIni:get('AI_'..driver.index, 'AI_AGGRESSION', driver.car.aiAggression)
            end
        end

        if RARECONFIG.data.AI.AI_RELATIVE_SCALING == 1 then
            driver.aiLevel = driver.aiLevel * RARECONFIG.data.AI.AI_RELATIVE_LEVEL/100
            driver.aiThrottleLimitBase = math.lerp(0.5,1,1-((1-driver.aiLevel)/0.3))
        end

        physics.setAILevel(driver.index, driver.aiLevel)
        physics.setAIAggression(driver.index, driver.aiAggression)
    end

    log("[Initialized]")
    FIRST_LAUNCH = false
    return true
end