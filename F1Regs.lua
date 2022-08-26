---
--- Script v0.8.0-alpha
---
local INITIALIZED = false

local F1R_CONFIG = nil
local DRS_ZONES = nil
local DRIVERS = {}
local DRIVERS_ON_TRACK = 0
local LEADER_LAPS = 0
local DRS_LAPS = 0
local WET_TRACK = false

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
    local aiControlled = car.isAIControlled
    local lapsCompleted = car.lapCount
    local name = ac.getDriverName(carIndex)

    local racePosition = car.racePosition
    local trackPosition = -1
    local trackProgress = 0
    local carAhead = -1
    local carAheadDelta = -1

    local isInPit = car.isInPit
    local isInPitLane = car.isInPitlane

    local drsEnabled = false
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

    return {carAheadDelta = carAheadDelta, drsCheck = drsCheck, drsEnabled = drsEnabled, mgukLapCheck = mgukLapCheck, racePosition = racePosition, trackPosition = trackPosition, mgukChangeTime = mgukChangeTime, drsZoneId = drsZoneId, name = name, car = car, carAhead = carAhead, index = index, isInPit = isInPit, isInPitLane = isInPitLane, aiControlled = aiControlled, lapsCompleted = lapsCompleted, trackProgress = trackProgress,
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

        index = index + 1
    end

    local zoneCount = index
    
    return {detectionZones = detectionZones, startZones = startZones, endZones = endZones, zoneCount = zoneCount}
end, class.NoInitialize)

--- Converts session type number to the corresponding session type string
---@return string
local function sessionTypeString()
    local sessionTypes = {"UNDEFINED", "PRACTICE", "QUALIFY", "RACE", "HOTLAP", "TIME ATTACK", "DRIFT", "DRAG"}

    return sessionTypes[ac.getSim().raceSessionType + 1]
end

--- Returns the main driver's track position in meters
---@param index number
---@return number
local function getTrackPositionM(index)
    return ac.worldCoordinateToTrackProgress(ac.getCar(index).position)*ac.getSim().trackLengthM
end

--- Enable DRS functionality if the lead driver has completed the specified numbers of laps
---@return boolean
local function enableDRS()
    if not rainCheck() then
        if LEADER_LAPS >= DRS_LAPS then
            return true
        else
            return false
        end  
    else
        return false 
    end 
end

-- Determines if the track is too wet for DRS to be enabled
---@return boolean
local function rainCheck()
    local wetness = csp.wetness
    if wetness > F1R_CONFIG.data.RULES.WET_DRS_LIMIT then
        if not WET_TRACK then
            ac.log("Track is too wet. Wetness: "..wetness)
        end
        WET_TRACK = true
        return true
    else
        if WET_TRACK then
            ac.log("Track is drying. DRS enabled in 2 laps")
            DRS_LAPS = LEADER_LAPS + F1R_CONFIG.data.RULES.DRS_LAPS
            WET_TRACK = false
        end 
        return false
    end
end


function Driver:refresh()
    self.lapsCompleted = self.car.lapCount
    self.isInPit = self.car.isInPit
    self.isInPitLane = self.car.isInPitlane
    self.drsZone = self.car.drsAvailable
    self.drsActive = self.car.drsActive
    self.racePosition = self.car.racePosition
    self.trackProgress = getTrackPositionM(self.index)
    self.drsEnabled = enableDRS(self)
end

--- Returns the main driver's distance to the detection line in meters
---@param driver Driver
---@return number
local function getDetectionDistanceM(driver)
    return math.round(math.clamp((DRS_ZONES.detectionZones[driver.drsZoneId]*ac.getSim().trackLengthM)-getTrackPositionM(0),0,10000), 5)
end

--- Converts session type number to the corresponding session type string 
---@param driver Driver
---@return boolean
local function inActivationZone(driver)
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
        if track_pos <= drs_zones.detectionZones[zone_index] and track_pos >= drs_zones.endZones[prev_zone] then
            driver.drsZoneId = zone_index
            driver.drsLocked = false
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
    -- Need SDK update
    if driver.index == 0 then ac.setDRS(false) end
end

--- Check if driver is on track or in pits
---@param driver Driver
---@return boolean
local function inPits(driver)
    return ((driver.isInPitlane or driver.isInPit) and true or false)
end

--- Check if driver is on track or in pits
---@return table
local function getTrackOrder()
    local track_order = {}
    local driver_count = #DRIVERS
    for index=0, driver_count do
        track_order[index+1] = DRIVERS[index]
    end

    local drivers_on_track = #track_order
    
    -- Remove drivers in the pits from the track order
    for index=1, #track_order do
        if index <= drivers_on_track then
            if inPits(track_order[index]) then
                table.remove(track_order, index)
                drivers_on_track = drivers_on_track - 1
            end
        end
    end

    DRIVERS_ON_TRACK = drivers_on_track

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
        local bInActivationZone = inActivationZone(driver)
        local bCheckGap = checkGap(driver)

        if driver.drsEnabled and not driver.drsLocked then
            if bInActivationZone then
                driver.drsCheck = bCheckGap
                driver.drsAvailable = false
            elseif driver.drsCheck then
                driver.drsAvailable = true
            else
                lockDRS(driver)
            end
        else
            lockDRS(driver)
        end
    else
        lockDRS(driver)
    end
end

--- Control the MGUK functionality
---@param driver Driver
local function controlMGUK(driver)
    local sim = ac.getSim()
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
local function controlDRS(driver)
    if ac.getSim().timeToSessionStart < -5000 then
        drsAvailable(driver)
    else
        lockDRS(driver)
    end
end

--- Controls all the regulated systems
local function controlSystems()
    local drivers = DRIVERS
    local leader_laps = LEADER_LAPS
    local data = {}
    for index=0, #drivers do
        local driver = drivers[index]
        if driver.car.racePosition == 1 then
            leader_laps = driver.lapsCompleted
        end
        driver:refresh()
        controlMGUK(driver)
        controlERS(driver)
        controlDRS(driver)

        data[index..".drsAvailable"] = driver.drsAvailable
        data[index..".carAhead"] = driver.carAhead
        data[index..".carAheadDelta"] = driver.carAheadDelta
    end
    ac.store("F1Reg",stringify(data, true))

    -- Example of how to load the data
    -- local test = stringify.parse(ac.load("F1Reg"))["0.carAheadDelta"]
    -- ac.log(test)

    LEADER_LAPS = leader_laps
end

--- Initialize
local function initialize()
    INITIALIZED = true
    RACE_STARTED = false
    LEADER_LAPS = 0
    DRS_LAPS = F1R_CONFIG.data.RULES.DRS_LAPS

    for index in pairs(DRIVERS) do
        DRIVERS[index] = nil
    end

    DRIVERS = {}

    F1R_CONFIG = MappedConfig(ac.getFolder(ac.FolderID.ACApps).."/lua/F1Regs/settings_defaults.ini", {
        RULES = { DRS_LAPS = ac.INIConfig.OptionalNumber, DRS_DELTA = ac.INIConfig.OptionalNumber, 
        MGUK_CHANGE_LIMIT = ac.INIConfig.OptionalNumber, MAX_ERS = ac.INIConfig.OptionalNumber },
    })

    ac.log("Loaded config file: "..ac.getFolder(ac.FolderID.ACApps).."/lua/F1Regs/settings_defaults.ini")

    -- Get DRS Zones from track data folder
    DRS_ZONES = DRS_Points("drs_zones.ini")

    -- Populate DRIVERS array
    for driverIndex = 0, ac.getSim().carsCount-1 do
        table.insert(DRIVERS, driverIndex, Driver(driverIndex))
        local driver = DRIVERS[driverIndex]
        driver:refresh()
        driver.trackPosition = driver.racePosition
        driver.mgukDeliveryCount = 0
    end

    print("Initialized")
end

function script.update()
    local sim = ac.getSim()

    if sim.raceSessionType == 3 then
        -- Initialize the session
        if not sim.isSessionStarted then
            if not INITIALIZED then initialize() end
        -- Race session has started
        else
            INITIALIZED = false
        end
        controlSystems()
    end
end

function script.windowMain(dt)
    local sim = ac.getSim()
  
    if sim.raceSessionType == 3 then
        local driver = DRIVERS[sim.focusedCar]
        local math = math
        local rules = F1R_CONFIG.data.RULES

        ui.pushFont(ui.Font.Small)
        ui.treeNode("["..sessionTypeString().." SESSION]", ui.TreeNodeFlags.DefaultOpen, function ()
            ui.text("- Race Started: "..tostring(sim.isSessionStarted))
            ui.text("- Leader Laps: "..LEADER_LAPS)
            ui.text("- Laps: "..driver.lapsCompleted.."/"..ac.getSession(sim.currentSessionIndex).laps)
            ui.text("- Race Position: "..driver.car.racePosition.."/"..sim.carsCount)
            ui.text("- Track Position: "..driver.trackPosition.."/"..DRIVERS_ON_TRACK)
            ui.text("- Driver: "..driver.name)
            if not inPits(driver) then
                ui.text("- Driver Ahead: "..tostring(ac.getDriverName(driver.carAhead)))
                ui.text("- Delta: "..math.round(getDelta(driver),1))
            else
                ui.text("- IN PITS")
            end
            ui.text("\n")
        end)

        ui.treeNode("[MGUK]", ui.TreeNodeFlags.DefaultOpen, function ()
            if driver.mgukPresent then
                ui.text("- ERS Spent: "..string.format("%2.1f", driver.car.kersCurrentKJ).."/"..rules.MAX_ERS)
                ui.text("- MGUK Mode: "..driver.mgukDelivery)
                ui.text("- MGUK Switch Count: "..driver.mgukDeliveryCount.."/"..rules.MGUK_CHANGE_LIMIT)
            else
                ui.text("MGUK not present")
            end
            ui.text("\n")
        end)

        ui.treeNode("[DRS]", ui.TreeNodeFlags.DefaultOpen, function ()
            if driver.drsPresent then
                if driver.drsEnabled == true then
                    ui.text("- DRS: enabled")
                else
                    ui.text("- DRS: in ".. rules.DRS_LAPS-driver.lapsCompleted.." laps")
                end
                ui.text("- Zone ID: "..tostring(driver.drsZoneId))
                ui.text("- Locked: "..tostring(driver.drsLocked))
                if not inPits(driver) then ui.text("- In Gap: "..tostring(checkGap(driver))) end
                ui.text("- Available: "..tostring(driver.drsAvailable))
                ui.text("- Active: "..tostring(driver.drsActive))
                ui.text("- Deploy Zone: "..tostring(driver.drsZone))
                ui.text("- Detection Zone: "..tostring(inActivationZone(driver)))
                ui.text("- Detection: "..tostring(getDetectionDistanceM(driver)).." m")
                ui.text("- Track Prog: "..tostring(math.round(driver.trackProgress,5)).." m")

            else
                ui.text("DRS not present")
            end
        end)
    else
        ui.pushFont(ui.Font.Main)
        ui.text("This is a "..sessionTypeString().." not a RACE session")
    end
end