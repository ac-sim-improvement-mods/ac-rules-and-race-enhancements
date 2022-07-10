local SIM = ac.getSim()
local CAR_INPUTS = physics.getCarInputControls()

local INITIALIZED = false
local RACE_STARTED = false

local DRS_LAPS = 2
local LEADER_LAP_COUNT = 0
local LAP_COUNT = 0

local DRIVERS = {}

local DRS_ENABLED = false
local DRS_ZONES = nil

local MGUK_CHANGE_LIMIT = 4
local ERS_LIMIT = 4000
local TIMER_0 = 0

---@class Driver
---@param carIndex number
---@return Driver
local Driver = class('Driver', function(carIndex)
    local car = ac.getCar(carIndex)
    local index = carIndex
    local aiControlled = car.isAIControlled
    local lapsCompleted = car.lapCount
    local name = ac.getDriverName(carIndex)

    local trackPosition = 0
    local carAhead = -1

    local isInPit = car.isInPit
    local isInPitLane = car.isInPitlane

    local drsPresent = car.drsPresent
    local drsLocked = true
    local drsActivationZone = false
    local drsZone = car.drsAvailable
    local drsZoneId = 0
    local drsActive = car.drsActive
    local drsAvailable = false

    local mgukPresent = car.hasCockpitERSDelivery
    local mgukLocked = false
    local mgukDelivery = 0
    local mgukDeliveryCount = 0
    return {drsZoneId = drsZoneId, name = name, car = car, carAhead = carAhead, index = index, isInPit = isInPit, isInPitLane = isInPitLane, aiControlled = aiControlled, lapsCompleted = lapsCompleted, trackPosition = trackPosition,
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

        --- Extract DRS detection points from drs_zones.ini
        dData = try(function()
            return ini.sections['ZONE_'..index]['DETECTION'][1]
        end, function () end)
        sData = try(function()
            return ini.sections['ZONE_'..index]['START'][1]
        end, function () end)
        eData = try(function()
            return ini.sections['ZONE_'..index]['END'][1]
        end, function () end)

        --- If data is nil, break the while loop
        if dData == nil or sData == nil or eData == nil then break end

        --- Add data to appropriate arrays
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
    local sessionTypes = {"Undefined", "Practice", "Qualify", "Race", "Hotlap", "Time Attack", "Drift", "Drag"}

    return sessionTypes[ac.getSimState().raceSessionType + 1]
end

--- Returns the main driver's track position in meters
---@param index number
---@return number
local function getTrackPositionM(index)
    return ac.worldCoordinateToTrackProgress(ac.getCar(index).position)*SIM.trackLengthM
end

function Driver:refresh()
    self.lapsCompleted = self.car.lapCount
    self.isInPit = self.car.isInPit
    self.isInPitLane = self.car.isInPitlane
    self.drsZone = self.car.drsAvailable
    self.drsActive = self.car.drsActive
    self.trackPosition = getTrackPositionM(self.index)
end

--- Returns the main driver's distance to the detection line in meters
---@param driver Driver
---@return number
local function getDetectionDistanceM(driver)
    return math.round(math.clamp((DRS_ZONES.detectionZones[driver.drsZoneId]*SIM.trackLengthM)-getTrackPositionM(0),0,10000), 3)
end

--- Converts session type number to the corresponding session type string 
---@param driver Driver
---@return boolean
local function inActivationZone(driver)
    local trackPos = ac.worldCoordinateToTrackProgress(driver.car.position)

    --- Get next detection line
    for zoneIndex=0, DRS_ZONES.zoneCount-1 do
        local prevZone = zoneIndex-1
        --- Sets the previous DRS zone to the last DRS zone
        if zoneIndex == 0 then
            prevZone = DRS_ZONES.zoneCount-1
        end
        --- If driver is between the end zone of the previous DRS zone, and the detection line of the upcoming DRS zone
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

    --- Need API update
    if driver.index == 0 then
        ac.setDRS(false)
    end
end

--- Check if driver is on track or in pits
---@param driver Driver
---@return boolean
local function inPits(driver)
    if driver.isInPitlane or driver.isInPit then
        lockDRS(driver)
        return true
    else
        return false
    end
end

--- Check if driver is on track or in pits
---@return table
local function getTrackOrder()
    local trackOrder = {}
    for index=0, #DRIVERS do
        trackOrder[index+1] = DRIVERS[index]
    end
    local trackOrderSize = #trackOrder

    for index=1, #trackOrder do
        if index <= trackOrderSize then
            if inPits(trackOrder[index]) then
                table.remove(trackOrder, index)
                trackOrderSize = trackOrderSize - 1
            end
        end
    end

    table.sort(trackOrder, function (a,b) return a.trackPosition > b.trackPosition end)

    local newTrackOrder = {}
    for index=0, #trackOrder do
        newTrackOrder[index] = trackOrder[index+1]
    end

    return newTrackOrder
end

--- Returns time delta between the driver and driver ahead on track
---@param driver Driver
---@return number
local function getDelta(driver)
    local TrackOrder = getTrackOrder()

    for index=0, #TrackOrder do
        if driver.index == TrackOrder[index].index then
            if index == 0 then
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

    if delta < 1.0 and delta >= 0.0 then
        return true
    else
        return false
    end
end

--- Checks if driver is before the detection line, not in the pits, 
--- not in a drs zone, and within 1 second of the car ahead on track
---@param driver Driver
---@return boolean
local function drsAvailable(driver)
    driver:refresh()
    
    if not DRS_ENABLED then
        lockDRS(driver)
        return false
    elseif inPits(driver) then
        return false
    elseif inActivationZone(driver) then
        return checkGap(driver)
    elseif not driver.drsZone then
        if driver.drsAvailable then
            return true
        else
            lockDRS(driver)
            return false
        end
    elseif driver.drsZone then
        if not driver.drsLocked and driver.drsAvailable then
            return true
        else
            lockDRS(driver)
            return false
        end
    end

    lockDRS(driver)
    return false
end

--- Enable DRS functionality if the lead driver has completed the specified numbers of laps
---@return boolean
local function enableDRS()
    for driverIndex = 0, SIM.carsCount-1 do
        if ac.getCar(driverIndex).racePosition == 1 then
            LEADER_LAP_COUNT = ac.getCarState(driverIndex+1).lapCount
            --- CarState index starts at 1...
            if LEADER_LAP_COUNT >= DRS_LAPS then
                return true
            else
                return false
            end
        end --- end if driver is 1st
    end --- end for drivers in DRIVERS
end


--- Control the MGUK functionality
---@param driver Driver
local function controlMGUK(driver)
    --- Reset MGUK count
    if LAP_COUNT < driver.car.lapCount then
        driver.mgukDeliveryCount = 0
        LAP_COUNT = driver.car.lapCount
    end
    --- Allow the driver to change MGUK settings if below the max change count
    if driver.mgukDeliveryCount < MGUK_CHANGE_LIMIT then
        if CAR_INPUTS.mgukDeliveryUp or CAR_INPUTS.mgukDeliveryDown then
            TIMER_0 = 0
        end

        --- Solidify the MGUK Delivery selection
        if TIMER_0 > 250 then ---250 is the time it takes for the top banner to disappear
            TIMER_0 = 0
            --- Check if MGUK Delivery has changed
            if  driver.car.mgukDelivery ~= driver.mgukDelivery then
                driver.mgukDeliveryCount = driver.mgukDeliveryCount + 1
                driver.mgukDelivery = driver.car.mgukDelivery
            end
        else
            TIMER_0 = TIMER_0 + 1
        end
    else
        --- Keep MGUK setting locked
        ac.setMGUKDelivery(driver.mgukDelivery)  -- Need API update
    end
end

--- Control the ERS functionality
---@param driver Driver
local function controlERS(driver)
    if driver.car.kersCurrentKJ >= ERS_LIMIT then
        ac.setKERS(false)  -- Need API update
    end
end

--- Control the DRS functionality
local function controlSystems()
    --- Set DRS availability for all DRIVERS
    for driverIndex=0, #DRIVERS do
        local driver = DRIVERS[driverIndex]
        controlMGUK(driver)
        controlERS(driver)

        if DRS_ENABLED == false then
            ac.setDRS(false)
            DRS_ENABLED = enableDRS()
        end

        driver.drsAvailable = drsAvailable(driver)
        if driver.drsAvailable then
            ac.store(driverIndex,1)
        else
            ac.store(driverIndex,0)
        end
    end
end

--- Initialize
local function initialize()
    DRS_ENABLED = false
    LEADER_LAP_COUNT = 0
    RACE_STARTED = false

    --- Get DRS Zones from track data folder
    DRS_ZONES = DRS_Points("drs_zones.ini")

    --- Populate DRIVERS array
    for driverIndex = 0, SIM.carsCount-1 do
        table.insert(DRIVERS, driverIndex, Driver(driverIndex))
        DRIVERS[driverIndex]:refresh()
        ac.store(driverIndex,0)
    end

    print("Initialized")
    INITIALIZED = true
end

function script.update(dt)
    if ac.getSimState().raceSessionType == 3 then
        if not INITIALIZED then initialize() end
        if ac.getSimState().timeToSessionStart > 0 and RACE_STARTED then
            initialize()
        elseif ac.getSimState().timeToSessionStart <= 0 then
            RACE_STARTED = true
        end

        controlSystems()
    end
end

function script.windowMain(dt)
    local driver = DRIVERS[0]
    if ac.getSimState().raceSessionType == 3 then
        --- SESSION INFO
        ui.pushFont(ui.Font.Main)
        ui.text("SESSION")
        ui.pushFont(ui.Font.Small)
        ui.text("Type: "..sessionTypeString())
        ui.text("Race Position: "..driver.car.racePosition.."/"..SIM.carsCount)

        ui.text("\nDriver Ahead: "..tostring(ac.getDriverName(driver.carAhead)))
        if not inPits(driver) then ui.text("Delta: "..math.round(getDelta(driver),1)) end

        --- ERS DEBUG
        ui.pushFont(ui.Font.Main)
        ui.text("\nERS")
        ui.pushFont(ui.Font.Small)
        ui.text("ERS Spent: "..string.format("%2.1f", driver.car.kersCurrentKJ).."/"..ERS_LIMIT)
        ui.text("MGUK Mode: "..driver.mgukDelivery)
        ui.text("MGUK Switch Count: "..driver.mgukDeliveryCount)

        --- DRS DEBUG
        if driver.drsPresent then
            ui.pushFont(ui.Font.Main)
            if DRS_ENABLED == true then
                ui.text("\nDRS [ENABLED]")
            else
                ui.text("\nDRS ["..DRS_LAPS-LEADER_LAP_COUNT.." laps]")
            end
            ui.pushFont(ui.Font.Small)
            
            ui.text("DRS Enabled: "..tostring(DRS_ENABLED))
            ui.text("DRS Zone ID: "..tostring(driver.drsZoneId))
            ui.text("Locked: "..tostring(driver.drsLocked))
            if not inPits(driver) then ui.text("Within Gap: "..tostring(checkGap(driver))) end
            ui.text("Before Detection Line: "..tostring(inActivationZone(driver)))
            ui.text("Deploy Zone: "..tostring(driver.drsZone))
            ui.text("Available: "..tostring(driver.drsAvailable))
            ui.text("Activated: "..tostring(driver.drsActive))
            ui.text("Detection Line in: "..tostring(getDetectionDistanceM(driver)).." m")
            ui.text("Track Pos: "..tostring(driver.trackPosition).." m")

        else
            ui.text("DRS not present")
        end
    else
        ui.pushFont(ui.Font.Main)
        ui.text(sessionTypeString())
        ui.text("Not a race session")
    end
end