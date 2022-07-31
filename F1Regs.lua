---
--- Script v0.6.0-alpha
---
local SIM = ac.getSim()

local INITIALIZED = false
local RACE_STARTED = false

--- local DRS_LAPS = 0

local F1R_CONFIG = nil
local DRS_ZONES = nil
local DRIVERS = {}
local DRIVERS_ON_TRACK = 0

--- local MGUK_CHANGE_LIMIT = 4
--- local MAX_ERS = 4000

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
    
    local lapCount = 0

    return {drsCheck = drsCheck, drsEnabled = drsEnabled, lapCount = lapCount, racePosition = racePosition, trackPosition = trackPosition, mgukChangeTime = mgukChangeTime, drsZoneId = drsZoneId, name = name, car = car, carAhead = carAhead, index = index, isInPit = isInPit, isInPitLane = isInPitLane, aiControlled = aiControlled, lapsCompleted = lapsCompleted, trackProgress = trackProgress,
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
    return ac.worldCoordinateToTrackProgress(ac.getCar(index).position)*SIM.trackLengthM
end

--- Enable DRS functionality if the lead driver has completed the specified numbers of laps
---@param driver Driver
---@return boolean
local function enableDRS(driver)
    if driver.lapCount >= F1R_CONFIG.data.RULES.DRS_LAPS then
        return true
    else
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
    return math.round(math.clamp((DRS_ZONES.detectionZones[driver.drsZoneId]*SIM.trackLengthM)-getTrackPositionM(0),0,10000), 5)
end

--- Converts session type number to the corresponding session type string 
---@param driver Driver
---@return boolean
local function inActivationZone(driver)
    local trackPos = ac.worldCoordinateToTrackProgress(driver.car.position)

    --- Get next detection line
    for zoneIndex=0, DRS_ZONES.zoneCount-1 do
        local prevZone = zoneIndex-1
        -- Sets the previous DRS zone to the last DRS zone
        if zoneIndex == 0 then
            prevZone = DRS_ZONES.zoneCount-1
        end
        -- If driver is between the end zone of the previous DRS zone, and the detection line of the upcoming DRS zone
        if trackPos <= DRS_ZONES.detectionZones[zoneIndex] and trackPos >= DRS_ZONES.endZones[prevZone] then
            driver.drsZoneId = zoneIndex
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
    ac.store("f1r.drs."..driver.index,0)
    -- Need API update
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
    local trackOrder = {}
    for index=0, #DRIVERS do
        trackOrder[index+1] = DRIVERS[index]
    end

    DRIVERS_ON_TRACK = #trackOrder
    
    -- Remove drivers in the pits from the track order
    for index=1, #trackOrder do
        if index <= DRIVERS_ON_TRACK then
            if inPits(trackOrder[index]) then
                table.remove(trackOrder, index)
                DRIVERS_ON_TRACK = DRIVERS_ON_TRACK - 1
            end
        end
    end

    -- Sort drivers by position on track, and ignore drivers in the pits
    table.sort(trackOrder, function (a,b) return a.trackProgress > b.trackProgress end)

    return trackOrder
end

--- Returns time delta between the driver and driver ahead on track
---@param driver Driver
---@return number
local function getDelta(driver)
    local TrackOrder = getTrackOrder()

    -- Determine the driver ahead's driver index
    -- If the driver has the most track progress, then the next driver is the driver with the least track progress
    for index=1, #TrackOrder do
        if driver.index == TrackOrder[index].index then
            driver.trackPosition = index
            if index == 1 then
                driver.carAhead = TrackOrder[#TrackOrder].index
            else
                driver.carAhead = TrackOrder[index - 1].index
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

    -- Store variables in AC memory
    -- Data format {f1r.drs.0=true} or {f1r.drs.0=false}
    if driver.drsAvailable then
        ac.store("f1r.drs."..driver.index,1)
    else
        ac.store("f1r.drs."..driver.index,0)
    end

    -- Helps with reseting the values after a restart
    if not RACE_STARTED then
        ac.store("f1r.drs."..driver.index,0)
    end
end

--- Control the MGUK functionality
---@param driver Driver
local function controlMGUK(driver)
    if ac.getSim().timeToSessionStart < -5000 then
        -- Reset MGUK count
        if driver.lapCount < driver.car.lapCount then
            driver.mgukDeliveryCount = 0
            driver.mgukDelivery = driver.car.mgukDelivery
            driver.lapCount = driver.car.lapCount
        end
        -- Allow the driver to change MGUK settings if below the max change count
        if driver.mgukDeliveryCount < F1R_CONFIG.data.RULES.MGUK_CHANGE_LIMIT then
            if physics.getCarInputControls().mgukDeliveryUp or physics.getCarInputControls().mgukDeliveryDown then
                driver.mgukChangeTime = ac.getSim().time
            end
            
            -- Solidify the MGUK Delivery selection
            if ac.getSim().time > (driver.mgukChangeTime + 4900) then ---4900 is the time it takes for the top banner to disappear
                
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
        if not driver.drsEnabled then driver.drsEnabled = enableDRS(driver) end
        drsAvailable(driver)
    else
        lockDRS(driver)
    end
end

--- Controls all the regulated systems
local function controlSystems()
    for driverIndex=0, #DRIVERS do
        local driver = DRIVERS[driverIndex]
        driver:refresh()
        controlMGUK(driver)
        controlERS(driver)
        controlDRS(driver)
    end
end

--- Initialize
local function initialize()
    RACE_STARTED = false
    DRIVERS = nil
    DRIVERS = {}

    F1R_CONFIG = MappedConfig(ac.getFolder(ac.FolderID.ACApps).."/lua/F1Regs/settings_defaults.ini", {
        RULES = { DRS_LAPS = ac.INIConfig.OptionalNumber, DRS_DELTA = ac.INIConfig.OptionalNumber, 
        MGUK_CHANGE_LIMIT = ac.INIConfig.OptionalNumber, MAX_ERS = ac.INIConfig.OptionalNumber },
    })

    ac.log("Loaded config file: "..ac.getFolder(ac.FolderID.ACApps).."/lua/F1Regs/settings_defaults.ini")

    -- Get DRS Zones from track data folder
    DRS_ZONES = DRS_Points("drs_zones.ini")

    -- Populate DRIVERS array
    for driverIndex = 0, SIM.carsCount-1 do
        table.insert(DRIVERS, driverIndex, Driver(driverIndex))
        local driver = DRIVERS[driverIndex]
        driver:refresh()
        driver.trackPosition = driver.racePosition
        driver.lapCount = 0
    end

    print("Initialized")
    INITIALIZED = true
end

function script.update()
    if ac.getSim().raceSessionType == 3 then
        -- Initialize the session
        if not INITIALIZED then initialize() end
        -- Handle users restarting the session
        if ac.getSim().timeToSessionStart > 0 and RACE_STARTED then
            initialize()
        -- Race session has started
        elseif ac.getSim().timeToSessionStart <= 0 and not RACE_STARTED then
            RACE_STARTED = true
        end
        controlSystems()
    end
end

function script.windowMain(dt)
    if ac.getSim().raceSessionType == 3 then
        local driver = DRIVERS[3]

        ui.pushFont(ui.Font.Small)
        ui.treeNode("["..sessionTypeString().." SESSION]", ui.TreeNodeFlags.DefaultOpen, function ()
            ui.text("- Laps: "..driver.lapCount)
            ui.text("- Race Position: "..driver.car.racePosition.."/"..SIM.carsCount)
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
                ui.text("- ERS Spent: "..string.format("%2.1f", driver.car.kersCurrentKJ).."/"..F1R_CONFIG.data.RULES.MAX_ERS)
                ui.text("- MGUK Mode: "..driver.mgukDelivery)
                ui.text("- MGUK Switch Count: "..driver.mgukDeliveryCount.."/"..F1R_CONFIG.data.RULES.MGUK_CHANGE_LIMIT)
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
                    ui.text("- DRS: in ".. F1R_CONFIG.data.RULES.DRS_LAPS-driver.car.lapCount.." laps")
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