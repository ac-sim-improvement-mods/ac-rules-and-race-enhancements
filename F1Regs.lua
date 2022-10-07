---
--- Script v0.9.0-alpha
---
local INITIALIZED = false

local F1R_CONFIG = nil
local DRS_ZONES = nil
local DRIVERS = {}
local DRIVERS_ON_TRACK = 0
local LEADER_LAPS = 0
local DRS_LAPS = 0
local WET_TRACK = false
local DRS_ENABLED = false

local VSC_CALLED = false
local VSC_DEPLOYED = false
local VSC_LAP_TIME = 180000
local VSC_START_TIMER = 1000
local VSC_END_TIMER = 3000

local function log(msg)
    ac.log("[F1Regs] "..msg)
end

---@class MappedConfig
---@field filename string
---@field ini ac.INIConfig
---@field data table
---@field original table
---@field map table
---@generic T
---@param filename string
---@param map T
---@return MappedConfig|{data: T, original: T}
local MappedConfig = class('MappedConfig', function(filename, map)
  local ini = ac.INIConfig.load(filename)
  local data = ini:mapConfig(map)
  return {filename = filename, ini = ini, map = map, data = data}
end, class.NoInitialize)

function MappedConfig:reload()
  self.ini = ac.INIConfig.load(self.filename) or self.ini
  self.data = self.ini:mapConfig(self.map)
end

---@class Driver
---@param carIndex number
---@return Driver
local Driver = class('Driver', function(carIndex)
    local car = ac.getCar(carIndex)

    local index = carIndex
    local lapsCompleted = car.lapCount
    local name = ac.getDriverName(carIndex)

    local aiControlled = car.isAIControlled
    local aiLevel = car.aiLevel
    local aiAggression = car.aiAggression
    local aiPrePitFuel = 0

    local racePosition = car.racePosition
    local trackPosition = -1
    local trackProgress = -1
    local carAhead = -1
    local carAheadDelta = -1

    local isInPit = car.isInPit
    local isInPitLane = car.isInPitlane

    local drsPresent = car.drsPresent
    local drsLocked = true
    local drsActivationZone = false
    local drsZone = car.drsAvailable
    local drsZoneId = 0
    local drsActive = car.drsActive
    local drsCheck = false
    local drsAvailable = false

    local mgukPresent = car.hasCockpitERSDelivery
    local mgukLocked = false
    local mgukDelivery = 0
    local mgukDeliveryCount = 0
    local mgukChangeTime = 5
    local mgukLapCheck = 0

    local timePenalty = 0
    local illegalOvertake = false
    local returnRacePosition = -1
    local returnPostionTimer = -1



    return {aiPrePitFuel = aiPrePitFuel, aiLevel = aiLevel, aiAggression = aiAggression, trackProgress = trackProgress, returnPostionTimer = returnPostionTimer, returnRacePosition = returnRacePosition, timePenalty = timePenalty, illegalOvertake = illegalOvertake, carAheadDelta = carAheadDelta, drsCheck = drsCheck, mgukLapCheck = mgukLapCheck, racePosition = racePosition, trackPosition = trackPosition, mgukChangeTime = mgukChangeTime, drsZoneId = drsZoneId, name = name, car = car, carAhead = carAhead, index = index, isInPit = isInPit, isInPitLane = isInPitLane, aiControlled = aiControlled, lapsCompleted = lapsCompleted,
        drsPresent = drsPresent, drsLocked = drsLocked, drsActivationZone = drsActivationZone, drsZone = drsZone, drsActive = drsActive, drsAvailable = drsAvailable,
        mgukPresent = mgukPresent, mgukLocked = mgukLocked, mgukDelivery = mgukDelivery, mgukDeliveryCount = mgukDeliveryCount}
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

--- Returns the main driver's track position in meters
---@param index number
---@return number
local function getTrackPositionM(index)
    return ac.worldCoordinateToTrackProgress(ac.getCar(index).position)*ac.getSim().trackLengthM
end

-- Determines if the track is too wet for DRS to be enabled
---@return boolean
local function rainCheck(sim)
    -- rainIntensity number
    -- rainWetness number
    -- rainWater number

    local track_rain_intensity = sim.rainIntensity
    local track_wetness = sim.rainWetness
    local track_puddles = sim.rainWater
    if track_wetness >= F1R_CONFIG.data.RULES.WET_DRS_LIMIT and
        track_puddles >= F1R_CONFIG.data.RULES.WET_DRS_LIMIT then

        if not WET_TRACK then
            ui.toast(ui.Icons.Bell, "DRS Disabled | Conditions too wet")
            log("[Race Control] DRS Disabled | Conditions too wet")
            log("[Race Control] Puddles: "..track_puddles)
            log("[Race Control] Wetness: "..track_wetness)
            log("[Race Control] Intensity: "..track_rain_intensity)
        end

        WET_TRACK = true

        return true
    else
        if WET_TRACK then
            if track_wetness >= F1R_CONFIG.data.RULES.WET_DRS_LIMIT - 0.05 and
            track_puddles >= F1R_CONFIG.data.RULES.WET_DRS_LIMIT - 0.05 and
            track_rain_intensity > 0.70 then
                return true
            else
                DRS_LAPS = LEADER_LAPS + F1R_CONFIG.data.RULES.DRS_LAPS
                WET_TRACK = false

                ui.toast(ui.Icons.Bell, "DRS Enabled in "..DRS_LAPS.." laps")
                log("[Race Control] Track is drying. DRS enabled in "..F1R_CONFIG.data.RULES.DRS_LAPS.." laps on lap "..DRS_LAPS)
                return false
            end
        end
    end
end

--- Enable DRS functionality if the lead driver has completed the specified numbers of laps
---@return boolean
local function enableDRS(sim)
    if not rainCheck(sim) then
        if LEADER_LAPS >= DRS_LAPS then
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

function Driver:refresh()
    local car = self.car
    self.lapsCompleted = car.lapCount
    self.drsZone = car.drsAvailable
    self.drsActive = car.drsActive
    self.racePosition = car.racePosition
    self.trackProgress = getTrackPositionM(car.index)
end

--- Returns the main driver's distance to the detection line in meters
---@param driver Driver
---@return number
local function getDetectionDistanceM(sim,driver)
    return math.round(math.clamp((DRS_ZONES.detectionZones[driver.drsZoneId]*sim.trackLengthM)-getTrackPositionM(driver.index),0,10000), 5)
end

--- Converts session type number to the corresponding session type string 
---@param driver Driver
---@return boolean
local function inDetectionZone(driver)
    local track_pos = ac.worldCoordinateToTrackProgress(driver.car.position)
    local drs_zones = DRS_ZONES

    --- Get next detection line
    for zone_index=0, drs_zones.zoneCount-1 do
        local prev_zone = zone_index-1
        -- Sets the previous DRS zone to the last DRS zone
        if zone_index == 0 then
            prev_zone = drs_zones.zoneCount-1
        end
        -- If driver is between the end zone of the previous DRS zone, and the detection line of the upcoming DRS zone
        if track_pos <= drs_zones.detectionZones[zone_index] and track_pos >= drs_zones.startZones[prev_zone] then
            driver.drsZoneId = zone_index
            return true
        end
    end

    return false
end

--- Locks the specified driver's DRS
---@param driver Driver
local function lockDRS(driver)
    driver.drsLocked = true
    driver.drsAvailable = false
    driver.drsCheck = false

    physics.allowCarDRS(driver.index, false)
    physics.setCarDRS(driver.index, false)
end

--- Check if driver is on track or in pits
---@param driver Driver
---@return boolean
local function inPits(driver)
    return ((driver.car.isInPitlane or driver.car.isInPit) and true or false)
end

--- Check if driver is on track or in pits
---@return table
local function getTrackOrder()
    local track_order = {}
    for index=0, #DRIVERS do
        if not inPits(DRIVERS[index]) then
            table.insert(track_order,DRIVERS[index])
        end
    end

    DRIVERS_ON_TRACK = #track_order

    -- Sort drivers by position on track, and ignore drivers in the pits
    table.sort(track_order, function (a,b) return a.trackProgress > b.trackProgress end)

    return track_order
end

--- Returns time delta between the driver and driver ahead on track
---@param driver Driver
---@return number
local function getDelta(driver)
    local track_order = getTrackOrder()

    -- Determine the driver ahead's driver index
    -- If the driver has the most track progress, then the next driver is the driver with the least track progress
    for index=1, #track_order do
        if driver.index == track_order[index].index then
            driver.trackPosition = index
            if index == 1 then
                driver.carAhead = track_order[#track_order].index
            else
                driver.carAhead = track_order[index - 1].index
            end
        end
    end

    return math.round((getTrackPositionM(driver.carAhead) - getTrackPositionM(driver.index)) / (driver.car.speedKmh / 3.6),5)
end

--- Checks if delta is within 1 second
---@param driver Driver
---@return boolean
local function checkGap(driver)
    local delta = getDelta(driver)
    driver.carAheadDelta = delta
    return ((delta < F1R_CONFIG.data.RULES.DRS_DELTA and delta >= 0.0) and true or false)
end

--- Checks if driver is before the detection line, not in the pits, 
--- not in a drs zone, and within 1 second of the car ahead on track
---@param driver Driver
local function drsAvailable(driver)
    if not inPits(driver) then
        local binDetectionZone = inDetectionZone(driver)
        local bCheckGap = checkGap(driver)
        local bInDrsZone = driver.car.drsAvailable

        if binDetectionZone then
            driver.drsCheck = bCheckGap
            if not bInDrsZone then
                driver.drsLocked = false
            elseif driver.drsLocked then
                return false
            end
            if driver.drsAvailable and bInDrsZone then
                return true
            elseif bCheckGap then
                return true
            elseif not bCheckGap and bInDrsZone then
                return false
            end
        else
            if driver.drsCheck and not driver.drsLocked then
                return true
            else
                return false
            end
        end
    else
        return false
    end
end

--- Control the MGUK functionality
---@param driver Driver
local function controlMGUK(sim,driver)
    if sim.timeToSessionStart < -5000 then
        -- Reset MGUK count
        if driver.mgukLapCheck < driver.car.lapCount then
            driver.mgukDeliveryCount = 0
            driver.mgukDelivery = driver.car.mgukDelivery
            driver.mgukLapCheck = driver.car.lapCount
        end
        -- Allow the driver to change MGUK settings if below the max change count
        if driver.mgukDeliveryCount < F1R_CONFIG.data.RULES.MGUK_CHANGE_LIMIT then
            if physics.getCarInputControls().mgukDeliveryUp or physics.getCarInputControls().mgukDeliveryDown then
                driver.mgukChangeTime = sim.time
            end
            
            -- Solidify the MGUK Delivery selection
            if sim.time > (driver.mgukChangeTime + 4900) then ---4900 is the time it takes for the top banner to disappear
                
                -- Check if MGUK Delivery has changed
                if  driver.car.mgukDelivery ~= driver.mgukDelivery then
                    driver.mgukDeliveryCount = driver.mgukDeliveryCount + 1
                    driver.mgukDelivery = driver.car.mgukDelivery
                end
            end
        else
            -- Keep MGUK setting locked
            ac.setMGUKDelivery(driver.mgukDelivery)  -- Need API update
        end
    else
        driver.mgukDelivery = driver.car.mgukDelivery
    end
end

--- Control the ERS functionality
---@param driver Driver
local function controlERS(driver)
    if driver.car.kersCurrentKJ >= F1R_CONFIG.data["RULES"]["MAX_ERS"] then
        ac.setKERS(false)  -- Need API update
    end
end

--- Control the DRS functionality
---@param driver Driver
local function controlDRS(sim,driver)
    DRS_ENABLED = enableDRS(sim)
    if sim.isSessionStarted then
        driver.drsAvailable = drsAvailable(driver)
        
        if driver.drsAvailable then
            physics.setAIThrottleLimit(driver.index, 1)
            if driver.drsZone and driver.car.gas > 0.8 and driver.car.isAIControlled then
                physics.setCarDRS(driver.index, true)
            end
        else
            lockDRS(driver)
        end
    end
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
    local delta = driver.carAheadDelta
    local defaultAgression = driver.aiAggression
    local defaultLevel = driver.aiLevel

    if delta < 0.6 and delta >= 0.3 then
        physics.setAIAggression(driver.index, defaultAgression + 0.15)
    elseif delta < 0.3 and delta >= 0 then
        physics.setAIAggression(driver.index, defaultAgression + 0.05)
    else
        physics.setAIAggression(driver.index, defaultAgression - 0.10)
    end
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
    lockDRS(driver)

    if driver.car.estimatedLapTimeMs < vsc_lap_time then
        ac.log(driver.index.." estimated: "..driver.car.estimatedLapTimeMs)

        if driver.aiControlled then
            physics.setAIThrottleLimit(driver.index, 0.3)
        else
            ui.toast(ui.Icons.Warning, "[F1Regs] Exceeding the pace of the Virtual Safety Car!")
        end
    end
end

local function setLeaderLaps(driver)
    if driver.car.racePosition == 1 then
        LEADER_LAPS = driver.lapsCompleted
    end
end

local function aiPitNewTires(sim,driver)
    if driver.aiControlled then
        if LEADER_LAPS < ac.getSession(sim.currentSessionIndex).laps - 5 and driver.aiPrePitFuel == 0 then
            local avg_tyre_wear = ((driver.car.wheels[0].tyreWear + 
                                    driver.car.wheels[1].tyreWear +
                                    driver.car.wheels[2].tyreWear +
                                    driver.car.wheels[3].tyreWear) / 4)
            if avg_tyre_wear > 0.4 then                  
                --physics.setCarPenalty(ac.PenaltyType.MandatoryPits,1)
                driver.aiPrePitFuel = driver.car.fuel
                physics.setCarFuel(driver.index, 0.5)
            end
        end
    end
end

local F1RegsData = ac.connect{
    drsAvailable = ac.StructItem.boolean(),
    carAhead = ac.StructItem.int16(),
    carAheadDelta = ac.StructItem.float()
}

local function storeData(driver)
    F1RegsData.drsAvailable = driver.drsAvailable
    F1RegsData.carAhead = driver.carAhead
    F1RegsData.carAheadDelta = driver.carAheadDelta
end

--- Controls all of the regulated systems
local function controlSystems(sim)
    local drivers = DRIVERS
    local best_lap_times = {}
    local vsc_deployed = VSC_DEPLOYED
    local vsc_called = VSC_CALLED

    for index=0, #drivers do
        local driver = drivers[index]
        driver:refresh()
        setLeaderLaps(driver)

        if not inPits(driver) then
            aiPitNewTires(sim,driver)
        else
            if driver.car.isInPit then
                physics.setCarFuel(driver.index, driver.aiPrePitFuel + 2)
                ac.log(driver.name.." "..driver.aiPrePitFuel)
            end
        end
        
        if not vsc_deployed then
            controlMGUK(sim,driver)
            controlERS(driver)
            controlDRS(sim,driver)
            alternateAIAttack(driver)
        elseif vsc_called and not vsc_deployed then
            if driver.car.bestLapTimeMs then
                best_lap_times[index] = driver.car.bestLapTimeMs
            end
        else
            controlVSC(sim,driver)
        end

        -- overtake_check(driver)

        if driver.index == 0 then
            storeData(driver)
        end
    end

    if LEADER_LAPS >= 0 then
        enableVSC(sim,best_lap_times)
    end
end

--- Initialize
local function initialize(sim)
    RACE_STARTED = false
    LEADER_LAPS = 0
    VSC_DEPLOYED = false
    VSC_CALLED = false
    local csp_version = ac.getPatchVersionCode()

    physics.overrideRacingFlag(ac.FlagType.None)

    log("CSP version: "..csp_version)

    if csp_version < 2066 then
        ui.toast(ui.Icons.Warning, "[F1Regs] Incompatible CSP version. CSP v0.1.79 required!")
        log("[WARN] Incompatible CSP version")
        return false
    end

    log("[Race Control] "..sessionTypeString(sim).." session detected")

    if not sim.raceSessionType == 3 then
        log("[Race Control] Not a race session")
        return false
    end

    -- Empty DRIVERS table
    for index in pairs(DRIVERS) do
        DRIVERS[index] = nil
    end
    DRIVERS = {}

    -- Load config file
    F1R_CONFIG = MappedConfig(ac.getFolder(ac.FolderID.ACApps).."/lua/F1Regs/settings.ini", {
        RULES = { DRS_LAPS = ac.INIConfig.OptionalNumber, DRS_DELTA = ac.INIConfig.OptionalNumber,
        MGUK_CHANGE_LIMIT = ac.INIConfig.OptionalNumber, MAX_ERS = ac.INIConfig.OptionalNumber,
        WET_DRS_LIMIT = ac.INIConfig.OptionalNumber },

    })
    log("[Loaded] Config file: "..ac.getFolder(ac.FolderID.ACApps).."/lua/F1Regs/settings.ini")

    -- Get DRS Zones from track data folder
    DRS_ZONES = DRS_Points("drs_zones.ini")
    DRS_LAPS = F1R_CONFIG.data.RULES.DRS_LAPS

    -- Populate DRIVERS array
    for driverIndex = 0, sim.carsCount-1 do
        table.insert(DRIVERS, driverIndex, Driver(driverIndex))
        local driver = DRIVERS[driverIndex]
        driver:refresh()
        driver.trackPosition = driver.racePosition
        driver.mgukDeliveryCount = 0
        lockDRS(driver)

        if driver.car.isAIControlled then
            physics.setCarFuel(driver.index, 140)
            physics.setExtraAIGrip(driver.index,1.5)
        end

        log("[Loaded] Driver "..driver.index..": "..driver.name)
    end

    ui.toast(ui.Icons.Bell, "DRS Enabled in "..DRS_LAPS.." laps")
    log("[Race Control] DRS Enabled in "..DRS_LAPS.." laps")

    log("[Initialized]")
    return true
end

function script.update()
    local sim = ac.getSim()
    local error = ac.getLastError()

    if error then
        ac.log(error)
        INITIALIZED = initialize(sim)
    end

    if sim.timeToSessionStart >= 10000 then
        INITIALIZED = false
    end

    if sim.raceSessionType == 3 then
        -- Initialize the session
        if sim.timeToSessionStart < 10000 and not INITIALIZED then INITIALIZED = initialize(sim)
        -- Race session has started
        elseif sim.isSessionStarted and not INITIALIZED then INITIALIZED = initialize(sim)
        elseif INITIALIZED then
            controlSystems(sim)
        end
    end
end

function script.windowNotifications(dt)

end

function script.windowMain(dt)
    local sim = ac.getSim()

    if sim.raceSessionType == 3 and INITIALIZED then
        local driver = DRIVERS[sim.focusedCar]
        local math = math
        local rules = F1R_CONFIG.data.RULES

        ui.pushFont(ui.Font.Small)
        ui.treeNode("["..sessionTypeString(sim).." SESSION]", ui.TreeNodeFlags.DefaultOpen, function ()
            ui.text("- Physics: "..tostring(physics.allowed()))
            ui.text("- Race Started: "..tostring(sim.isSessionStarted))
            ui.text("- Leader Laps: "..LEADER_LAPS)
            ui.text("- Laps: "..driver.lapsCompleted.."/"..ac.getSession(sim.currentSessionIndex).laps)
            ui.text("- Race Position: "..driver.car.racePosition.."/"..sim.carsCount)

            ui.text("- Track Position: "..driver.trackPosition.."/"..DRIVERS_ON_TRACK)

            ui.text("\n")
        end)

        if driver.aiControlled then
            ui.treeNode("[AI]", ui.TreeNodeFlags.DefaultOpen, function ()
                ui.text("- AI Level: ["..math.round(driver.aiLevel*100,2).."] "..math.round(driver.car.aiLevel*100,2))
                ui.text("- AI Aggr : ["..math.round(driver.aiAggression*100,2).."] "..math.round(driver.car.aiAggression*100,2))
                ui.text("\n")
            end)
        end

        ui.treeNode("[Tyres]", ui.TreeNodeFlags.DefaultOpen, function ()
            ui.text("- Wear [FL]: "..math.round(100-(driver.car.wheels[0].tyreWear*100),5))
            ui.text("- Wear [RL]: "..math.round(100-(driver.car.wheels[2].tyreWear*100),5))
            ui.text("- Wear [FR]: "..math.round(100-(driver.car.wheels[1].tyreWear*100),5))
            ui.text("- Wear [RR: "..math.round(100-(driver.car.wheels[3].tyreWear*100),5))
            ui.text("\n")
        end)

        ui.treeNode("[MGUK]", ui.TreeNodeFlags.DefaultOpen, function ()
            if driver.mgukPresent then
                ui.text("- ERS Spent: "..string.format("%2.1f", driver.car.kersCurrentKJ).."/"..rules.MAX_ERS.." KJ")
                ui.text("- MGUK Mode: "..driver.mgukDelivery)
                ui.text("- MGUK Switch Count: "..driver.mgukDeliveryCount.."/"..rules.MGUK_CHANGE_LIMIT)
            else
                ui.text("MGUK not present")
            end
            ui.text("\n")
        end)

        local drs_title = ""

        if not WET_TRACK then
            if DRS_ENABLED == true then
                drs_title = "[DRS Enabled]"
            else
                drs_title = "[DRS Enabled in "..DRS_LAPS-LEADER_LAPS.." laps]"
            end
        else
            drs_title = "[DRS Disabled | Wet Conditions]"
        end


        ui.treeNode(drs_title, ui.TreeNodeFlags.DefaultOpen, function ()
            if driver.drsPresent then
                if not inPits(driver) then
                    ui.text("- Ahead : ["..driver.carAhead.."] "..tostring(ac.getDriverName(driver.carAhead)))
                    ui.text("- Driver:  ["..driver.index.."] "..driver.name)
                    if driver.car.speedKmh >= 1 then ui.text("- Delta: "..math.round(getDelta(driver),3))
                    else ui.text("- Delta: ---") end
                    ui.text("- In Gap: "..tostring(checkGap(driver)))
                    ui.text("- Locked: "..tostring(driver.drsLocked))
                    ui.text("- Available: "..tostring(driver.drsAvailable))
                    ui.text("- Deploy Zone: "..tostring(driver.car.drsAvailable))
                    ui.text("- Active: "..tostring(driver.drsActive))
                    ui.text("- Next Detect Zone ID: "..tostring(driver.drsZoneId))
                    ui.text("- Detection Zone: "..tostring(inDetectionZone(driver)))
                    ui.text("- Detection Line: "..tostring(getDetectionDistanceM(sim,driver)).." m")
                    ui.text("- Track Prog: "..tostring(math.round(getTrackPositionM(driver.index),5)).." m")
                else ui.text("- IN PITS") end
            else
                ui.text("DRS not present")
            end
        end)
    else
        ui.pushFont(ui.Font.Main)
        ui.text("This is a "..sessionTypeString(sim).." not a RACE session")
    end
end