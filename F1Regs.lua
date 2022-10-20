local SCRIPT_VERSION = "v0.9.5-alpha"
local SCRIPT_VERSION_ID = 9500

local INITIALIZED = false
local RESTARTED = false
local REBOOT = false

local F1RegsConfig = nil
local DRS_ZONES = nil
local DRIVERS = {}
local DRIVERS_ON_TRACK = 0
local LEADER_LAPS = 1
local DRS_ENABLED_LAP = 0
local WET_TRACK = false
local DRS_ENABLED = false

local VSC_CALLED = false
local VSC_DEPLOYED = false
local VSC_LAP_TIME = 180000
local VSC_START_TIMER = 1000
local VSC_END_TIMER = 3000

function log(message)
    ac.log("[F1Regs] "..message)
end

local F1RegsData = ac.connect({
    ac.StructItem.key('F1RegsData'),
    connected = ac.StructItem.boolean(),
    scriptVersionId = ac.StructItem.int16(),
    drsEnabled = ac.StructItem.boolean(),
    drsAvailable = ac.StructItem.array(ac.StructItem.boolean(),32),
    carAhead = ac.StructItem.array(ac.StructItem.int16(),32),
    carAheadDelta = ac.StructItem.array(ac.StructItem.float(),32),
},false,ac.SharedNamespace.Shared)

local function storeData(driver)
    F1RegsData.connected = true
    F1RegsData.scriptVersionId = SCRIPT_VERSION_ID
    F1RegsData.drsEnabled = DRS_ENABLED
    F1RegsData.drsAvailable[driver.index] = driver.drsAvailable
    F1RegsData.carAhead[driver.index] = driver.carAhead
    F1RegsData.carAheadDelta[driver.index] = driver.carAheadDelta
end

---@param MappedConfig
---@param filename string
---@param ini ac.INIConfig
---@param data table
---@param original table
---@param map table
local MappedConfig = class('MappedConfig', function(filename, map)
  local ini = ac.INIConfig.load(filename)
  local data = ini:mapConfig(map)
  local key = 'app.F1Regs:'..filename
  -- local original = stringify.tryParse(ac.load(key))
  local original = nil -- TODO: REMOVE THIS LINE
  if not original then
    ac.store(key, stringify(data))
    original = stringify.parse(stringify(data))
  end
  return {filename = filename, ini = ini, map = map, data = data, original = original}
end, class.NoInitialize)

function MappedConfig:reload()
  self.ini = ac.INIConfig.load(self.filename) or self.ini
  self.data = self.ini:mapConfig(self.map)
end

---@param section string
---@param key string
---@param value number|boolean
function MappedConfig:set(section, key, value, hexFormat)
  if not self.data[section] then self.data[section] = {} end
  if type(value) == 'number' and not (value > -1e9 and value < 1e9) then error('Sanity check failed: '..tostring(value)) end
  if self.data[section][key] == value then return end
  self.data[section][key] = value
  setTimeout(function ()
    log('Saving updated ['..section..']['..key..']: '..tostring(value))
    self.ini:setAndSave(section, key, hexFormat and string.format('0x%x', self.data[section][key]) or self.data[section][key])
  end, 0.02, section..key)
end

---@class Driver
---@param carIndex number
---@return Driver
local Driver = class('Driver', function(carIndex)
    local car = ac.getCar(carIndex)

    local index = carIndex
    local lapsCompleted = car.lapCount
    local name = ac.getDriverName(carIndex)

    local aiLevel = car.aiLevel
    local aiAggression = car.aiAggression
    local aiPrePitFuel = 0
    local aiPitCall = false
    local aiPitting = false

    local trackPosition = -1
    local carAhead = -1
    local carAheadDelta = -1

    local drsActivationZone = false
    local drsZoneId = 0
    local drsZonePrevId = 0
    local drsCheck = false
    local drsAvailable = false
    local drsDeployable = false

    local timePenalty = 0
    local illegalOvertake = false
    local returnRacePosition = -1
    local returnPostionTimer = -1

    return {
    drsDeployable = drsDeployable, drsZonePrevId = drsZonePrevId, drsZoneId = drsZoneId, 
    drsActivationZone = drsActivationZone, drsAvailable = drsAvailable, drsCheck = drsCheck,
    aiPitting = aiPitting, aiPitCall = aiPitCall, aiPrePitFuel = aiPrePitFuel, aiLevel = aiLevel, aiAggression = aiAggression, 
    returnPostionTimer = returnPostionTimer, returnRacePosition = returnRacePosition, timePenalty = timePenalty, illegalOvertake = illegalOvertake,
    carAheadDelta = carAheadDelta, carAhead = carAhead, trackPosition = trackPosition,
    lapsCompleted = lapsCompleted, index = index,  name = name, car = car
    }
end, class.NoInitialize)

---@class DRS_Points
---@param fileName string
---@return DRS_Points
local DRS_Points = class('DRS_Points', function(fileName)
    local ini = ac.INIConfig.trackData(fileName)
    local detectionZones = {}
    local startZones = {}
    local endZones = {}

    local index = 0
    while true do
        local dData = ''
        local sData = ''
        local eData = ''

        -- Extract DRS detection points from drs_zones.ini
        dData = try(function()
            return ini.sections['ZONE_'..index]['DETECTION'][1]
        end, function () end)
        sData = try(function()
            return ini.sections['ZONE_'..index]['START'][1]
        end, function () end)
        eData = try(function()
            return ini.sections['ZONE_'..index]['END'][1]
        end, function () end)

        -- If data is nil, break the while loop
        if dData == nil or sData == nil or eData == nil then break end

        -- Add data to appropriate arrays
        detectionZones[index] = tonumber(dData)
        startZones[index] = tonumber(sData)
        endZones[index] = tonumber(eData)

        log("[Loaded] DRS Zone "..index.." ["..dData..","..sData..","..eData.."]")

        index = index + 1
    end
    
    local zoneCount = index
    
    return {detectionZones = detectionZones, startZones = startZones, endZones = endZones, zoneCount = zoneCount}
end, class.NoInitialize)

--- Converts session type number to the corresponding session type string
---@return string
local function sessionTypeString(sim)
    local sessionTypes = {"UNDEFINED", "PRACTICE", "QUALIFY", "RACE", "HOTLAP", "TIME ATTACK", "DRIFT", "DRAG"}

    return sessionTypes[sim.raceSessionType + 1]
end

local function weatherTypeString(sim)
    local weatherTypes = {  
        "Light Thunderstorm", ---Value: 0.
        "Thunderstorm", ---Value: 1.
        "Heavy Thunderstorm", ---Value: 2.
        "Light Drizzle", ---Value: 3.
        "Drizzle", ---Value: 4.
        "Heavy Drizzle", ---Value: 5.
        "Light Rain", ---Value: 6.
        "Rain", ---Value: 7.
        "Heavy Rain", ---Value: 8.
        "Light Snow", ---Value: 9.
        "Snow", ---Value: 10.
        "Heavy Snow", ---Value: 11.
        "Light Sleet", ---Value: 12.
        "Sleet", ---Value: 13.
        "Heavy Sleet", ---Value: 14.
        "Clear", ---Value: 15.
        "Few Clouds", ---Value: 16.
        "Scattered Clouds", ---Value: 17.
        "Broken Clouds", ---Value: 18.
        "Overcast Clouds", ---Value: 19.
        "Fog", ---Value: 20.
        "Mist", ---Value: 21.
        "Smoke", ---Value: 22.
        "Haze", ---Value: 23.
        "Sand", ---Value: 24.
        "Dust", ---Value: 25.
        "Squalls", ---Value: 26.
        "Tornado", ---Value: 27.
        "Hurricane", ---Value: 28.
        "Cold", ---Value: 29.
        "Hot", ---Value: 30.
        "Windy", ---Value: 31.
        "Hail", ---Value: 32.
    }

    return weatherTypes[sim.weatherType + 1]
end

--- Returns the main driver's track position in meters
---@param index number
---@return number
local function getTrackPositionM(index)
    return ac.worldCoordinateToTrackProgress(ac.getCar(index).position)*ac.getSim().trackLengthM
end

-- Determines if the track is too wet for DRS to be enabled
---@return boolean
local function rainCheck(sim)
    local wet_limit = F1RegsConfig.data.RULES.DRS_WET_LIMIT/100
    local track_rain_intensity = sim.rainIntensity
    local track_wetness = sim.rainWetness
    local track_puddles = sim.rainWater

    local total_wetness = ((track_wetness/5) + (track_puddles*10))/2
    if total_wetness >= wet_limit then
        if not WET_TRACK then
            ui.toast(ui.Icons.Bell, "DRS Disabled | Conditions too wet")
            log("[Race Control] DRS Disabled | Conditions too wet")
            log("[Race Control] Puddles: "..track_puddles)
            log("[Race Control] Wetness: "..track_wetness)
            log("[Race Control] Intensity: "..track_rain_intensity)
        end

        WET_TRACK = true
        DRS_ENABLED = false
    else
        if WET_TRACK then
            if total_wetness >= wet_limit - 0.05 and
            track_rain_intensity > 0.70 then
            else
                DRS_ENABLED_LAP = LEADER_LAPS + 2
                WET_TRACK = false

                ui.toast(ui.Icons.Bell, "DRS Enabled in 2 laps on lap "..DRS_ENABLED_LAP)
                log("[Race Control] Track is drying. DRS enabled in 2 laps on lap "..DRS_ENABLED_LAP)
            end
        end
    end
end

--- Enable DRS functionality if the lead driver has completed the specified numbers of laps
---@return boolean
local function enableDRS(sim)
    rainCheck(sim)
    if not WET_TRACK then
        if LEADER_LAPS >= DRS_ENABLED_LAP then
            if not DRS_ENABLED then
                ui.toast(ui.Icons.Bell, "DRS Enabled")
                log("[Race Control] DRS Enabled")
            end
            return true
        else
            return false
        end
    else
        return false
    end
end

--- Returns the main driver's distance to the detection line in meters
---@param driver Driver
---@return numberW
local function getStartDistanceM(sim,driver)
    local distance = (DRS_ZONES.startZones[driver.drsZoneId]-driver.car.splinePosition)*sim.trackLengthM
    if distance <= 0 then distance = distance + sim.trackLengthM end
    return math.round(math.clamp(distance,0,10000), 5)
end

--- Returns the main driver's distance to the detection line in meters
---@param driver Driver
---@return number
local function getEndDistanceM(sim,driver)
    local distance = (DRS_ZONES.endZones[driver.drsZonePrevId]-driver.car.splinePosition)*sim.trackLengthM
    if distance <= 0 then distance = distance + sim.trackLengthM end

    return math.round(math.clamp(distance,0,10000), 5)
end

--- Returns the main driver's distance to the detection line in meters
---@param driver Driver
---@return number
local function getDetectionDistanceM(sim,driver)
    local distance = (DRS_ZONES.detectionZones[driver.drsZoneId]-driver.car.splinePosition)*sim.trackLengthM
    if distance <= 0 then distance = distance + sim.trackLengthM end

    return math.round(math.clamp(distance,0,10000), 5)
end

--- Converts session type number to the corresponding session type string 
---@param driver Driver
---@return boolean
local function getNextDetectionLine(sim,driver)
    --ac.perfBegin("getNextDetection")
    local drs_zones = DRS_ZONES
    local closestStart = 0
    local drsZone = 0
    local drsZonePrev = 0

    --- Get next detection line
    for zone_index=0, drs_zones.zoneCount-1 do
        local startDistance = (DRS_ZONES.startZones[zone_index])-driver.car.splinePosition
        if startDistance <= 0 then startDistance = startDistance + 1 end

        if zone_index == 0 then
            closestStart = startDistance
            drsZone = 0
            drsZonePrev = drs_zones.zoneCount-1
        else
            if startDistance < closestStart then
                closestStart = startDistance
                drsZone = zone_index
                drsZonePrev = zone_index - 1
            end
        end
    end

    driver.drsZoneId = drsZone
    driver.drsZonePrevId = drsZonePrev

    --ac.perfEnd("getNextDetection")
    return false
end

local function crossedDetectionLine(driver)
    local drs_zones = DRS_ZONES
    local track_pos = driver.car.splinePosition

    -- If driver is between the end zone of the previous DRS zone, and the detection line of the upcoming DRS zone
    if track_pos >= drs_zones.detectionZones[driver.drsZoneId] and track_pos < drs_zones.startZones[driver.drsZoneId] then
        return true
    else
        return false
    end
end

--- Locks the specified driver's DRS
---@param driver Driver
local function setDriverDRS(driver,allowed)
    if ac.getPatchVersionCode() >= 2066 then
        physics.allowCarDRS(driver.index,not allowed)
        if driver.car.isAIControlled then
            if allowed and driver.car.brake < 0.5 and driver.car.speedKmh > 50 then
                physics.setCarDRS(driver.index, true)
            elseif not allowed then
                physics.setCarDRS(driver.index, false)
            end
        end
    else
        if not driver.index == 0 then
            ac.setDRS(false)
        end
    end
end

--- Check if driver is on track or in pits
---@param driver Driver
---@return boolean
local function inPits(driver)
    return ((driver.car.isInPitlane or driver.car.isInPit) and true or false)
end

--- Check if driver is on track or in pits
local function setTrackOrder()
    --ac.perfBegin("3.setTrackOrder")
    local track_order = {}
    local drivers = DRIVERS
    for index=0, #drivers do
        if not inPits(drivers[index]) then
            table.insert(track_order,drivers[index])
        else
            drivers[index].trackPosition = -1
        end
    end

    DRIVERS_ON_TRACK = #track_order

    -- Sort drivers by position on track, and ignore drivers in the pits
    table.sort(track_order, function (a,b) return a.car.splinePosition > b.car.splinePosition end)

    for index=1, #track_order do
        drivers[track_order[index].index].trackPosition = index

        if index == 1 then
            drivers[track_order[index].index].carAhead = track_order[#track_order].index
        else
            drivers[track_order[index].index].carAhead = track_order[index - 1].index
        end
    end

    DRIVERS = drivers

    --ac.perfEnd("3.setTrackOrder")
end

--- Returns time delta between the driver and driver ahead on track
---@param driver Driver
---@return number
local function getDelta(driver)
---@diagnostic disable-next-line: return-type-mismatch
    return math.round((DRIVERS[driver.carAhead].car.splinePosition - driver.car.splinePosition) / (driver.car.speedKmh / 3.6) * ac.getSim().trackLengthM,5)
end

--- Checks if delta is within 1 second
---@param driver Driver
---@return boolean
local function checkGap(driver)
    local delta = getDelta(driver)
    driver.carAheadDelta = delta
    return ((delta <= F1RegsConfig.data.RULES.DRS_GAP_DELTA/1000 and delta > 0.0) and true or false)
end

--- Checks if driver is before the detection line, not in the pits, 
--- not in a drs zone, and within 1 second of the car ahead on track
---@param driver Driver
local function drsAvailable(driver)
    if not inPits(driver) then
        local inGap = checkGap(driver)
        local inDrsZone = driver.car.drsAvailable

        if crossedDetectionLine(driver) == false then
            driver.drsCheck = inGap
            if driver.drsAvailable and inDrsZone and driver.car.drsActive then 
                driver.drsDeployable = true
            elseif driver.drsAvailable and not inDrsZone and driver.drsDeployable then
                driver.drsAvailable = false
                driver.drsDeployable = false
            end
        else
            driver.drsAvailable = driver.drsCheck
            driver.drsDeployable = false
        end
    else
        driver.drsAvailable = false
    end
end

--- Control the DRS functionality
---@param driver Driver
local function controlDRS(sim,driver)
    --ac.perfBegin("drs")
    DRS_ENABLED = enableDRS(sim)
    if sim.isSessionStarted then
        drsAvailable(driver)
        
        if DRS_ENABLED then
            setDriverDRS(driver,driver.drsAvailable)
        else
            setDriverDRS(driver,false)
        end
        
    end

    --ac.perfEnd("drs")
end

-- local function overtake_check(driver)
--     if driver.illegalOvertake then
--         if driver.returnPostionTimer == -1 then
--             ui.toast(ui.Icons.Bell, "Illegal overtake, give back that position in 30 seconds")
--             driver.returnPostionTimer = ac.getSim().timeSeconds + 30
--         elseif driver.car.racePosition >= driver.returnRacePosition then
--             ui.toast(ui.Icons.Bell, "You returned the race position")
--             driver.illegalOvertake = false
--             driver.returnPostionTimer = -1
--         elseif driver.returnPostionTimer >= ac.getSim().timeSeconds then
--             ui.toast(ui.Icons.Bell, "Failed to return the position, driver through penalty receieved")
--             driver.car.currentPenaltyType = 3
--             driver.car.currentPenaltyParameter = 5
--             driver.illegalOvertake = false
--             driver.returnPostionTimer = -1
--         end
--     end
-- end

local function alternateAIAttack(driver)
    --ac.perfBegin("attack")
    local delta = driver.carAheadDelta
    local defaultAgression = driver.aiAggression
    local defaultLevel = driver.aiLevel
    
    if delta < 0.6 and delta >= 0.3 then
        physics.setAIAggression(driver.index, math.clamp(defaultAgression + 0.15,0,0.60))
    elseif delta < 0.3 and delta >= 0 then
        physics.setAIAggression(driver.index, math.clamp(defaultAgression + 0.05,0,0.60))
    else
        physics.setAIAggression(driver.index, 0)
    end

    --ac.perfEnd("attack")
end

function math.average(t)
    local sum = 0
    for _,v in pairs(t) do -- Get the sum of all numbers in t
      sum = sum + v
    end
    return sum / #t
end
  

local function enableVSC(sim,best_lap_times)
    if VSC_CALLED and not VSC_DEPLOYED then
        VSC_LAP_TIME = math.average(best_lap_times) / 0.31
        if VSC_LAP_TIME == 0 or VSC_LAP_TIME == nil then
            VSC_LAP_TIME = 180000
        end
        ac.log(VSC_LAP_TIME)
        VSC_DEPLOYED = true
        ac.log("Virtual Safety Car Deployed. No overtaking!")
        ui.toast(ui.Icons.Warning, "[F1Regs] Virtual Safety Car Deployed. No overtaking!")
        physics.overrideRacingFlag(ac.FlagType.Caution)
    end

    if not VSC_CALLED and not VSC_DEPLOYED then
        if sim.raceFlagType == ac.FlagType.Caution then
            if VSC_START_TIMER > 0 then
                VSC_START_TIMER = VSC_START_TIMER - 1
            else
                VSC_CALLED = true
            end
        else
            VSC_START_TIMER = 1000
        end
    elseif VSC_DEPLOYED then
        VSC_CALLED = false
        VSC_START_TIMER = 5

        if VSC_END_TIMER > 0 then
            
            if VSC_END_TIMER == 1000 and sim.raceFlagType == not ac.FlagType.Caution then
                ac.log("Virtual Safety Car is ending soon!")
                ui.toast(ui.Icons.Warning, "[F1Regs] Virtual Safety Car is ending soon!")
            end
            VSC_END_TIMER = VSC_END_TIMER - 1
        else
            physics.overrideRacingFlag(ac.FlagType.None)
            if sim.raceFlagType == not ac.FlagType.Caution then
                ac.log("Virtual Safety Car ended!")
                ui.toast(ui.Icons.Warning, "[F1Regs] Virtual Safety Car ended!")
                VSC_DEPLOYED = false
            else
                VSC_END_TIMER = 500
            end
        end
    end
end

local function controlVSC(sim,driver)
    local vsc_lap_time = VSC_LAP_TIME
    setDriverDRS(driver,false)

    if driver.car.estimatedLapTimeMs < vsc_lap_time then
        ac.log(driver.index.." estimated: "..driver.car.estimatedLapTimeMs)

        if driver.car.isAIControlled then
            physics.setAIThrottleLimit(driver.index, 0.3)
        else
            ui.toast(ui.Icons.Warning, "[F1Regs] Exceeding the pace of the Virtual Safety Car!")
        end
    end
end

local function setLeaderLaps(driver)
    --ac.perfBegin("5.leaderlaps")
    if driver.car.racePosition == 1 then
        LEADER_LAPS = driver.car.lapCount+1
    end
    --ac.perfEnd("5.leaderlaps")
end

local function aiPitNewTires(sim,driver)
    --ac.perfBegin("5.aiPitNewTires")

    if driver.car.isAIControlled then
        if not driver.car.isInPitlane then
            if driver.aiPrePitFuel ~= 0 then
                if driver.aiPitCall then
                    driver.aiPitCall = false
                    driver.aiPitting = true
                    physics.setCarFuel(driver.index, driver.aiPrePitFuel)
                end
            else
                if LEADER_LAPS < ac.getSession(sim.currentSessionIndex).laps - 5 then
                    local avg_tyre_wear = ((driver.car.wheels[0].tyreWear + 
                                            driver.car.wheels[1].tyreWear +
                                            driver.car.wheels[2].tyreWear +
                                            driver.car.wheels[3].tyreWear) / 4)
                    if avg_tyre_wear > 1-(F1RegsConfig.data.RULES.AI_TYRE_LIFE/100) then                  
                        --physics.setCarPenalty(ac.PenaltyType.MandatoryPits,1)
                        driver.aiPrePitFuel = driver.car.fuel
                        physics.setCarFuel(driver.index, 0.1)
                        driver.aiPitCall = true
                        
                    end
                end
            end
        else
            if driver.aiPrePitFuel ~= 0 then
                physics.setCarFuel(driver.index, driver.aiPrePitFuel + 3)
            end
            if driver.car.isInPit then
                driver.aiPitting = false
                driver.aiPrePitFuel = 0
            end
        end
    end

    --ac.perfEnd("5.aiPitNewTires")
end

--- Controls all of the regulated systems
local function controlSystems(sim)
    --ac.perfBegin("2.controlSystems")
    local drivers = DRIVERS
    local best_lap_times = {}
    local vsc_deployed = VSC_DEPLOYED
    local vsc_called = VSC_CALLED
    local config = F1RegsConfig.data.RULES

    setTrackOrder()

    --ac.perfBegin("3.driversLoop")
    for index=0, #drivers do
        --ac.perfBegin("4.driver")
        local driver = drivers[index]
        setLeaderLaps(driver)
        getNextDetectionLine(sim,driver)

        if config.AI_FORCE_PIT_TYRES == 1 then aiPitNewTires(sim,driver) end
        if config.AI_AGGRESSION_RUBBERBAND == 1 then alternateAIAttack(driver) end
        if config.DRS_RULES == 1 then controlDRS(sim,driver) else driver.drsAvailable = true end

        -- if not vsc_deployed then
        --     -- controlDRS(sim,driver)
        --     -- if config.AI_AGGRESSION_RUBBERBAND == 1 then alternateAIAttack(driver) end
        -- elseif vsc_called and not vsc_deployed then
        --     if driver.car.bestLapTimeMs then
        --         best_lap_times[index] = driver.car.bestLapTimeMs
        --     end
        -- else
        --     controlVSC(sim,driver)
        -- end

        -- overtake_check(driver)
        storeData(driver)
        --ac.perfEnd("4.driver")
    end
    --ac.perfEnd("3.driversLoop")

    if LEADER_LAPS >= 2 then
        if config.VSC_RULES == 1 then enableVSC(sim,best_lap_times) end
    end

    --ac.perfEnd("2.controlSystems")
end

--- Initialize
local function initialize(sim)
    LEADER_LAPS = 0
    VSC_DEPLOYED = false
    VSC_CALLED = false
    F1RegsData.connected = false
    local csp_version = ac.getPatchVersionCode()

    log("F1 Regs version: "..SCRIPT_VERSION)
    log("F1 Regs version: "..SCRIPT_VERSION_ID)
    log("CSP version: "..csp_version)


    -- Load config file
    F1RegsConfig = MappedConfig(ac.getFolder(ac.FolderID.ACApps).."/lua/F1Regs/settings.ini", {
        RULES = { DRS_RULES = ac.INIConfig.OptionalNumber, DRS_ACTIVATION_LAP = ac.INIConfig.OptionalNumber, 
        DRS_GAP_DELTA = ac.INIConfig.OptionalNumber, DRS_WET_DISABLE = ac.INIConfig.OptionalNumber, DRS_WET_LIMIT = ac.INIConfig.OptionalNumber,
        VSC_RULES = ac.INIConfig.OptionalNumber, VSC_INIT_TIME = ac.INIConfig.OptionalNumber, VSC_DEPLOY_TIME = ac.INIConfig.OptionalNumber,
        AI_FORCE_PIT_TYRES = ac.INIConfig.OptionalNumber, AI_TYRE_LIFE = ac.INIConfig.OptionalNumber, AI_AGGRESSION_RUBBERBAND = ac.INIConfig.OptionalNumber,
        PHYSICS_REBOOT = ac.INIConfig.OptionalNumber
    }})
    log("[Loaded] Config file: "..ac.getFolder(ac.FolderID.ACApps).."/lua/F1Regs/settings.ini")


    if not sim.raceSessionType == 3 then
        log("[Race Control] "..sessionTypeString(sim).." session detected")
        return false
    end

    if csp_version < 2051 then
        ui.toast(ui.Icons.Warning, "[F1Regs] Incompatible CSP version. CSP v0.1.78 required!")
        log("[WARN] Incompatible CSP version")
        return false
    end

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
        setLeaderLaps(driver)
        if driver.car.isAIControlled then
            physics.setCarFuel(driver.index, 140)
        end

        storeData(driver)
        log("[Loaded] Driver "..driver.index..": "..driver.name)
    end

    if F1RegsConfig.data.RULES.DRS_RULES == 1 then
        ui.toast(ui.Icons.Bell, "DRS Enabled in "..DRS_ENABLED_LAP-LEADER_LAPS.." laps")
        log("[Race Control] DRS Enabled in "..DRS_ENABLED_LAP-LEADER_LAPS.." laps")
    end

    log("[Initialized]")
    return true
end

function script.update()
    --ac.perfBegin("1.main")
    local sim = ac.getSim()
    local error = ac.getLastError()

    if error then
        log(error)
        INITIALIZED = initialize(sim)
    end

    if not ac.isWindowOpen("main") then
        return
    end

    if sim.raceSessionType == 3 then
        if not RESTARTED and sim.isInMainMenu then
            RESTARTED = true
            INITIALIZED = false
        end

        -- Initialize the session
        if (sim.isInMainMenu or sim.isSessionStarted) and not INITIALIZED then INITIALIZED = initialize(sim)
        elseif not sim.isInMainMenu and not sim.isSessionStarted and RESTARTED and INITIALIZED then
            if REBOOT and F1RegsConfig.data.RULES.PHYSICS_REBOOT == 1 then ac.restartAssettoCorsa() end
            REBOOT = false
            RESTARTED = false
        -- Race session has started
        elseif INITIALIZED then controlSystems(sim) end
    end

    --ac.perfEnd("1.main")
end

function script.windowNotifications(dt)

end

local function upperBool(s)
    return string.upper(tostring(s))
end

function script.windowMain(dt)
    -- JUST TO KEEP THE SCRIPT ALIVE
end

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

function script.windowSettings(dt)
    ac.setWindowTitle("settings", "F1 Regs Settings    "..SCRIPT_VERSION.." ("..SCRIPT_VERSION_ID..")")

    ui.pushFont(ui.Font.Small)
    ui.header("DRS:")
    slider(F1RegsConfig, 'RULES', 'DRS_RULES', 0, 1, 1, true, F1RegsConfig.data.RULES.DRS_RULES == 1 and 'DRS Rules: ENABLED' or 'DRS Rules: DISABLED', 
    'Enable DRS being controlled by the app',
    function (v) return math.round(v, 0) end)
    if F1RegsConfig.data.RULES.DRS_RULES == 1 then
        DRS_ENABLED_LAP = slider(F1RegsConfig, 'RULES', 'DRS_ACTIVATION_LAP', 1, ac.getSession(ac.getSim().currentSessionIndex).laps, 1, false, 'Activation Lap: %.0f', 
        'First lap to allow DRS activation',
        function (v) return v end)
        slider(F1RegsConfig, 'RULES', 'DRS_GAP_DELTA', 100, 2000, 1, false, 'Gap Delta: %.0f ms',
        'Max gap to car when crossing detection line to allow DRS for the next zone',
        function (v) return math.floor(v / 50 + 0.5) * 50 end)
        slider(F1RegsConfig, 'RULES', 'DRS_WET_DISABLE', 0, 1, 1, true, F1RegsConfig.data.RULES.DRS_WET_DISABLE == 1 and 'Wet Weather Rule: ENABLED' or 'Wet Weather Rule: DISABLED', 
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
    if F1RegsConfig.data.RULES.AI_FORCE_PIT_TYRES == 1 then
        slider(F1RegsConfig, 'RULES', 'AI_TYRE_LIFE', 0, 100, 1, false, 'Pit Below Tyre Life: %.2f%%', 
        'AI will pit after average tyre life % is below this value',
        function (v) return math.floor(v / 0.5 + 0.5) * 0.5 end)
    end
    -- slider(F1RegsConfig, 'RULES', 'AI_AGGRESSION_RUBBERBAND', 0, 1, 1, true, F1RegsConfig.data.RULES.AI_AGGRESSION_RUBBERBAND == 1 and "Alt Aggression: ENABLED" or "Alt Aggression: DISABLED", 
    -- 'Increase AI aggression when attacking',
    -- function (v) return math.round(v, 0) end)

    local driver = DRIVERS[ac.getSim().focusedCar]
    if F1RegsConfig.data.RULES.AI_FORCE_PIT_TYRES == 1 and driver.car.isAIControlled then
        if ui.button("FORCE FOCUSED AI TO PIT NOW", vec2(ui.windowWidth()-40,25), ui.ButtonFlags.None) then
            driver.aiPrePitFuel = driver.car.fuel
            physics.setCarFuel(driver.index, 0.1)
            driver.aiPitCall = true
        end
    end
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
    --         AI_FORCE_PIT_TYRES = ac.INIConfig.OptionalNumber, AI_TYRE_LIFE = ac.INIConfig.OptionalNumber, AI_AGGRESSION_RUBBERBAND = ac.INIConfig.OptionalNumber,
    --         PHYSICS_REBOOT = ac.INIConfig.OptionalNumber
    --     }})
    --     log("[Loaded] Applied config")
    --     DRS_ENABLED_LAP = F1RegsConfig.data.RULES.DRS_ACTIVATION_LAP
    -- end
end

local function inLineBulletText(label,text,space)
    ui.bulletText(label)
    ui.sameLine(space, 0)
    if text == "TRUE" then
        ui.textColored(text, rgbm(0,1,0,1))
    elseif text == "FALSE" then
        ui.textColored(text, rgbm(1,0,0,1))
    elseif label == "Delta" then
        if text == "---" then
        ui.textColored("---", rgbm(1,1,1,1))
        elseif text <= F1RegsConfig.data.RULES.DRS_GAP_DELTA/1000 and text > 0 then
            ui.textColored(text, rgbm(0,1,0,1))
        else
            ui.textColored(text, rgbm(1,0,0,1))
        end
    elseif string.find(label, "Life") then
        if text < F1RegsConfig.data.RULES.AI_TYRE_LIFE then
            ui.textColored(text.." %", rgbm(1,0,0,1))
        else
            ui.textColored(text.." %", rgbm(1,1,1,1))
        end
    elseif string.find(label, "Wear") then
        if text >= 100-F1RegsConfig.data.RULES.AI_TYRE_LIFE then
            ui.textColored(text.." %", rgbm(1,0,0,1))
        else
            ui.textColored(text.." %", rgbm(1,1,1,1))
        end
    else
        ui.text(text)
    end
end

function script.windowDebug(dt)
    local sim = ac.getSim()
    ac.setWindowTitle("debug", "F1 Regs Debug                "..SCRIPT_VERSION.." ("..SCRIPT_VERSION_ID..")")

    if sim.raceSessionType ~= 3 then
        ui.pushFont(ui.Font.Main)
        ui.text("This is a "..sessionTypeString(sim).." not a RACE session")
        return
    end

    if INITIALIZED and not sim.isInMainMenu then
        local driver = DRIVERS[sim.focusedCar]
        local math = math
        local space = 200



        ui.pushFont(ui.Font.Small)

        ui.treeNode("["..sessionTypeString(sim).." SESSION]", ui.TreeNodeFlags.DefaultOpen and ui.TreeNodeFlags.Framed, function ()
            inLineBulletText("F1 Regs Enabled", upperBool(ac.isWindowOpen("main")),space)
            inLineBulletText("Physics Allowed", upperBool(physics.allowed()),space)
            inLineBulletText("Race Started", upperBool(sim.isSessionStarted),space)
            inLineBulletText("Time", string.format("%02d:%02d:%02d", sim.timeHours, sim.timeMinutes, sim.timeSeconds),space)
            inLineBulletText("Leader Lap", LEADER_LAPS.."/"..ac.getSession(sim.currentSessionIndex).laps,space)
        end)

        if F1RegsConfig.data.RULES.VSC_RULES == 1 then
            ui.treeNode("[VSC]", ui.TreeNodeFlags.DefaultOpen and ui.TreeNodeFlags.Framed, function ()
                inLineBulletText("VSC Called", upperBool(VSC_CALLED),space)
                inLineBulletText("VSC Deployed", upperBool(VSC_DEPLOYED),space)
                inLineBulletText("VSC Lap TIme", ac.lapTimeToString(VSC_LAP_TIME),space)
            end)
        end

        if driver.car.isAIControlled then
            ui.treeNode("[AI]", ui.TreeNodeFlags.DefaultOpen and ui.TreeNodeFlags.Framed, function ()
                inLineBulletText("Driver ["..driver.index.."]", driver.name,space)
                inLineBulletText("Ahead ["..driver.carAhead.."]", tostring(ac.getDriverName(driver.carAhead)),space)
                inLineBulletText("Track Position", driver.trackPosition.."/"..DRIVERS_ON_TRACK,space)
                inLineBulletText("Race Position", driver.car.racePosition.."/"..sim.carsCount,space)
                inLineBulletText("Lap", (driver.car.lapCount+1).."/"..ac.getSession(sim.currentSessionIndex).laps,space)
                inLineBulletText("Pitting New Tyres", upperBool(driver.aiPitting),space)
                inLineBulletText("Pre-Pit Fuel", math.round(driver.aiPrePitFuel,5).." L",space)
                inLineBulletText("Fuel", math.round(driver.car.fuel,5).." L",space)
                inLineBulletText("Fuel Map", driver.car.fuelMap,space)
                inLineBulletText("AI Level", "["..math.round(driver.aiLevel*100,2).."] "..math.round(driver.car.aiLevel*100,2),space)
                inLineBulletText("AI Aggr", "["..math.round(driver.aiAggression*100,2).."] "..math.round(driver.car.aiAggression*100,2),space)
            end)
        else
            ui.treeNode("[DRIVER]", ui.TreeNodeFlags.DefaultOpen and ui.TreeNodeFlags.Framed, function ()
                inLineBulletText("Driver ["..driver.index.."]", driver.name,space)
                if not inPits(driver) then
                    inLineBulletText("Ahead ["..driver.carAhead.."]", tostring(ac.getDriverName(driver.carAhead)),space)
                    inLineBulletText("Track Position", driver.trackPosition.."/"..DRIVERS_ON_TRACK,space)
                end
                inLineBulletText("Race Position", driver.car.racePosition.."/"..sim.carsCount,space)
                inLineBulletText("Lap", (driver.car.lapCount+1).."/"..ac.getSession(sim.currentSessionIndex).laps,space)
                inLineBulletText("Fuel", math.round(driver.car.fuel,5).." L",space)
                inLineBulletText("Fuel Map", driver.car.fuelMap,space)
            end)
        end

        ui.treeNode("[TYRES]", ui.TreeNodeFlags.DefaultOpen and ui.TreeNodeFlags.Framed, function ()
            local avg_tyre_wear = ((driver.car.wheels[0].tyreWear + 
            driver.car.wheels[1].tyreWear +
            driver.car.wheels[2].tyreWear +
            driver.car.wheels[3].tyreWear) / 4)
            inLineBulletText("Wear Average", math.round(avg_tyre_wear*100,5),space)

            inLineBulletText("Tyre Life [FL]", math.round(100-(driver.car.wheels[0].tyreWear*100),5),space)
            inLineBulletText("Tyre Life [RL]", math.round(100-(driver.car.wheels[2].tyreWear*100),5),space)
            inLineBulletText("Tyre Life [FR]", math.round(100-(driver.car.wheels[1].tyreWear*100),5),space)
            inLineBulletText("Tyre Life [RR]", math.round(100-(driver.car.wheels[3].tyreWear*100),5),space)
        end)

        if driver.car.kersPresent then
            ui.treeNode("[HYBRID SYSTEMS]", ui.TreeNodeFlags.DefaultOpen and ui.TreeNodeFlags.Framed, function ()
                local mguhMode = ""
                if driver.car.mguhChargingBatteries then
                    mguhMode = "BATTERY"
                else
                    mguhMode = "ENGINE"
                end

                inLineBulletText("ERS Spent", string.format("%2.1f", driver.car.kersCurrentKJ).."/"..math.round(driver.car.kersMaxKJ,0).." KJ",space)
                inLineBulletText("ERS Input", math.round(driver.car.kersInput*100,2).." %",space)
                inLineBulletText("MGU-K Delivery", string.upper(ac.getMGUKDeliveryName(driver.index)),space)
                inLineBulletText("MGU-K Recovery", math.round(driver.car.mgukRecovery*10).."%",space)
                inLineBulletText("MGU-H Mode", string.upper(mguhMode),space)
            end)
        end

        if F1RegsConfig.data.RULES.DRS_RULES == 1 then
    
            ui.treeNode("[DRS]", ui.TreeNodeFlags.DefaultOpen and ui.TreeNodeFlags.Framed, function ()
                if driver.car.drsPresent then
                    if not inPits(driver) then
                        local delta = driver.carAheadDelta
                        inLineBulletText("Enabled on Lap", DRS_ENABLED_LAP,space)
                        inLineBulletText("Enabled", upperBool(DRS_ENABLED),space)
                        if driver.car.speedKmh >= 1 then inLineBulletText("Delta", math.round(delta,3),space)
                        else inLineBulletText("Delta","---",space )end
                        inLineBulletText("In Gap", upperBool((delta <= F1RegsConfig.data.RULES.DRS_GAP_DELTA/1000 and delta > 0.0) and true or false),space)
                        inLineBulletText("Check", upperBool(driver.drsCheck),space)
                        inLineBulletText("Crossed Detection", upperBool(crossedDetectionLine(driver)),space)
                        inLineBulletText("Available", upperBool(driver.drsAvailable),space)
                        inLineBulletText("Deploy Zone", upperBool(driver.car.drsAvailable),space)
                        inLineBulletText("Deployable", upperBool(driver.drsDeployable),space)
                        inLineBulletText("Active", upperBool(driver.car.drsActive),space)
                        inLineBulletText("Zone ID", driver.drsZonePrevId,space)
                        inLineBulletText("Zone Next ID", driver.drsZoneId,space)
                        inLineBulletText("Detection Line", tostring(getDetectionDistanceM(sim,driver)).." m",space)
                        inLineBulletText("Start Line", tostring(getStartDistanceM(sim,driver)).." m",space)
                        inLineBulletText("End Line", tostring(getEndDistanceM(sim,driver)).." m",space)
                        inLineBulletText("Track Progress M", tostring(math.round(driver.car.splinePosition*sim.trackLengthM,5)).." m",space)
                        inLineBulletText("Track Progress %", tostring(math.round(driver.car.splinePosition*100,2)).." %",space)
                    else ui.bulletText("IN PITS") end
                else
                    ui.bulletText("DRS not present")
                end
            end)
        end

        ui.treeNode("[WEATHER]", ui.TreeNodeFlags.DefaultOpen and ui.TreeNodeFlags.Framed, function ()
            local totalWetness = ((sim.rainWetness/5) + (sim.rainWater*10))/2
            inLineBulletText("Weather Type", weatherTypeString(sim),space)
            inLineBulletText("Rain Intensity", math.round(sim.rainIntensity*100,2).."%",space)
            inLineBulletText("Track Wetness", math.round(sim.rainWetness*100,2).."%",space)
            inLineBulletText("Track Puddles", math.round(sim.rainWater*100,2).."%",space)
            inLineBulletText("Total Wetness", math.round(totalWetness*100,2).."%",space)
            inLineBulletText("Total Wetness Limit", math.round(F1RegsConfig.data.RULES.DRS_WET_LIMIT,2).."%",space)
            inLineBulletText("Wet Track", upperBool(WET_TRACK),space)
        end)

        ui.treeNode("[INPUTS]", ui.TreeNodeFlags.DefaultOpen and ui.TreeNodeFlags.Framed, function ()
            inLineBulletText("Gas", math.round(driver.car.gas,5),space)
            inLineBulletText("Brake", math.round(driver.car.brake,5),space)
            inLineBulletText("Clutch", math.round(driver.car.clutch,5),space)
            inLineBulletText("Steer",  math.round(driver.car.steer,5),space)
        end)

        ui.treeNode("[SCRIPT CONTROLLER INPUTS]", ui.TreeNodeFlags.DefaultOpen and ui.TreeNodeFlags.Framed, function ()
            inLineBulletText("[0] Total Brake Balance", math.round(ac.getCarPhysics(driver.index).scriptControllerInputs[0],5),space)
            inLineBulletText("[1] Brake Migration %", ac.getCarPhysics(driver.index).scriptControllerInputs[1],space)
            inLineBulletText("[2]", ac.getCarPhysics(driver.index).scriptControllerInputs[2],space)
            inLineBulletText("[3]", ac.getCarPhysics(driver.index).scriptControllerInputs[3],space)
            inLineBulletText("[4]", ac.getCarPhysics(driver.index).scriptControllerInputs[4],space)
            inLineBulletText("[5]", ac.getCarPhysics(driver.index).scriptControllerInputs[5],space)
            inLineBulletText("[6]", ac.getCarPhysics(driver.index).scriptControllerInputs[6],space)
            inLineBulletText("[7]", ac.getCarPhysics(driver.index).scriptControllerInputs[7],space)
        end)
    end
end