local Sim = ac.getSim()
local Session = ac.getSession(0)
local CarInputs = physics.getCarInputControls()

local Initialized = false

local LapsEngageDRS = 0
local Lap_Count = 0

local Drivers = {}
local TrackOrder = {}

local DRS_Enabled = false
local DRS_Zones = nil

local Max_MGUK_Change = 4
local Max_ERS = 4000
local Timer0 = 0
local Timer1 = 0
local Timer2 = 0

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

    return sessionTypes[Session.type + 1]
end

--- Returns the main driver's track position in meters
---@param index number
---@return number
local function getTrackPositionM(index)
    return ac.worldCoordinateToTrackProgress(ac.getCar(index).position)*Sim.trackLengthM
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
    return math.round(math.clamp((DRS_Zones.detectionZones[driver.drsZoneId]*Sim.trackLengthM)-getTrackPositionM(0),0,10000), 3)
end

--- Converts session type number to the corresponding session type string 
---@param driver Driver
---@return boolean
local function inActivationZone(driver)
    local trackPos = ac.worldCoordinateToTrackProgress(driver.car.position)

    --- Get next detection line
    for zoneIndex=0, DRS_Zones.zoneCount-1 do
        local prevZone = zoneIndex-1
        --- Sets the previous DRS zone to the last DRS zone
        if zoneIndex == 0 then
            prevZone = DRS_Zones.zoneCount-1
        end
        --- If driver is between the end zone of the previous DRS zone, and the detection line of the upcoming DRS zone
        if trackPos <= DRS_Zones.detectionZones[zoneIndex] and trackPos >= DRS_Zones.endZones[prevZone] then
            driver.drsZoneId = zoneIndex
            driver.drsLocked = false
            return true
        end
    end

    return false
end

local function compare(carA,carB)
    return carA.trackPosition < carB.trackPosition
end

function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
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
    for index=0, #Drivers do
        trackOrder[index+1] = Drivers[index]
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

    if Timer2 > 1 then
        Timer2 = 0
        if ac.getDriverName(driver.index) == "Yuki Tsunoda" then
            --ac.log(ac.getDriverName(driver.carAhead).." is ahead of "..ac.getDriverName(driver.index))
        end
    end

    Timer2 = Timer2 + 1

    local driverSpeed = driver.car.speedKmh / 3.6
    local test = (getTrackPositionM(driver.carAhead) - getTrackPositionM(driver.index)) / driverSpeed

    return math.round(test,5)
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
    local inActivationZone = inActivationZone(driver)
    local inGap = checkGap(driver)
    
    if inPits(driver) then
        return false
    elseif inActivationZone then
        return inGap
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
    for driverIndex = 0, Sim.carsCount-1 do
        if ac.getCar(driverIndex).racePosition == 1 then
            --- CarState index starts at 1...
            if ac.getCarState(driverIndex+1).lapCount >= LapsEngageDRS then
                Drivers[driverIndex].drsLocked = false
                return true
            else
                Drivers[driverIndex].driver.drsLocked = true
                return false
            end
        end --- end if driver is 1st
    end --- end for drivers in Drivers
end

--- Control the DRS functionality
local function controlDRS()
    if DRS_Enabled == false then
        ac.setDRS(false)
        DRS_Enabled = enableDRS()
    else
        --- Set DRS availability for all drivers
        for driverIndex=0, #Drivers do
            Drivers[driverIndex].drsAvailable = drsAvailable(Drivers[driverIndex])
        end
    end
end

--- Control the MGUK functionality
---@param driver Driver
local function controlMGUK(driver)
    --- Reset MGUK count
    if Lap_Count < driver.car.lapCount then
        driver.mgukDeliveryCount = 0
        Lap_Count = driver.car.lapCount
    end
    --- Allow the driver to change MGUK settings if below the max change count
    if driver.mgukDeliveryCount < Max_MGUK_Change then
        if CarInputs.mgukDeliveryUp or CarInputs.mgukDeliveryDown then
            Timer0 = 0
        end

        --- Solidify the MGUK Delivery selection
        if Timer0 > 250 then ---250 is the time it takes for the top banner to disappear
            Timer0 = 0
            --- Check if MGUK Delivery has changed
            if  driver.car.mgukDelivery ~= driver.mgukDelivery then
                driver.mgukDeliveryCount = driver.mgukDeliveryCount + 1
                driver.mgukDelivery = driver.car.mgukDelivery
            end
        else
            Timer0 = Timer0 + 1
        end
    else
        --- Keep MGUK setting locked
        ac.setMGUKDelivery(driver.mgukDelivery)  -- Need API update
    end
end

--- Control the ERS functionality
---@param driver Driver
local function controlERS(driver)
    if driver.car.kersCurrentKJ >= Max_ERS then
        ac.setKERS(false)  -- Need API update
    end
end

--- Initialize
local function initialize()
    DRS_Enabled = false

    --- Get DRS Zones from track data folder
    DRS_Zones = DRS_Points("drs_zones.ini")

    --- Populate Drivers array
    for driverIndex = 0, Sim.carsCount-1 do
        table.insert(Drivers, driverIndex, Driver(driverIndex))
    end

    Initialized = true
end



function script.windowMain(dt)
    if not Initialized then initialize() end


    ---if SessionTypeInt == 3 or SessionTypeInt == 2 then
    if true then
        controlDRS()
        ---controlMGUK(driver)
        ---controlERS(driver)

        --- SESSION INFO
        ui.pushFont(ui.Font.Main)
        ui.text("SESSION")
        ui.pushFont(ui.Font.Small)
        ui.text("Type: "..sessionTypeString())
        ui.text("Race Position: "..Drivers[0].car.racePosition.."/"..Sim.carsCount)

        ui.text("\nDriver Ahead: "..tostring(ac.getDriverName(Drivers[0].carAhead)))
        ui.text("Delta: "..math.round(getDelta(Drivers[0]),1))

        --- ERS DEBUG
        ui.pushFont(ui.Font.Main)
        ui.text("\nERS")
        ui.pushFont(ui.Font.Small)
        ui.text("ERS Spent: "..string.format("%2.1f", Drivers[0].car.kersCurrentKJ).."/"..Max_ERS)
        ---ui.text("MGUK Mode: "..MGUK_Delivery)
        ui.text("MGUK Switch Count: "..Drivers[0].mgukDeliveryCount)

        --- DRS DEBUG
      
        if Drivers[0].drsPresent then
            ui.pushFont(ui.Font.Main)
            if DRS_Enabled == true then
                ui.text("\nDRS [ENABLED]")
            else
                ui.text("DRS ["..LapsEngageDRS.." laps]")
            end
            ui.pushFont(ui.Font.Small)
            
            ui.text("DRS Enabled: "..tostring(DRS_Enabled))
            ui.text("DRS Zone ID: "..tostring(Drivers[0].drsZoneId))
            ui.text("Locked: "..tostring(Drivers[0].drsLocked))
            ui.text("Within Gap: "..tostring(checkGap(Drivers[0])))
            ui.text("Before Detection Line: "..tostring(inActivationZone(Drivers[0])))
            ui.text("Deploy Zone: "..tostring(Drivers[0].drsZone))
            ui.text("Available: "..tostring(Drivers[0].drsAvailable))
            ui.text("Activated: "..tostring(Drivers[0].drsActive))
            ui.text("Detection Line in: "..tostring(getDetectionDistanceM(Drivers[0])).." m")
            ui.text("Track Pos: "..tostring(Drivers[0].trackPosition).." m")

        else
            ui.text("DRS not present")
        end
    else
        ui.pushFont(ui.Font.Main)
        ui.text("Not a race session")
    end
end