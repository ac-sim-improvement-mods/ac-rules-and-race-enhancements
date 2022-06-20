local Sim = ac.getSim()
local Session = ac.getSession(0)
local CarInputs = physics.getCarInputControls()

local Initialized = false
local SessionTypeInt = Session.type
local SessionTypeString = ""

local LapsEngageDRS = 2
local Lap_Count = 0

local Drivers = {}

local DRS_Current_Zone = 0
local DRS_Enabled = false
local DRS_Zones = {}

local Max_MGUK_Change = 4
local Max_ERS = 4000
local Timer0 = 0

---@class Driver
---@generic T
---@param carIndex any
---@return Driver|{data: T, original: T}
local Driver = class('Driver', function(carIndex)
    local car = ac.getCar(carIndex)
    local index = carIndex
    local aiControlled = car.isAIControlled
    local lapsCompleted = car.lapCount

    local isInPit = car.isInPit
    local isInPitLane = car.isInPitLane

    local drsPresent = car.drsPresent
    local drsLocked = false
    local drsActivationZone = false
    local drsZone = car.drsAvailable
    local drsActive = car.drsActive

    local mgukPresent = car.hasCockpitERSDelivery
    local mgukLocked = false
    local mgukDelivery = 0
    local mgukDeliveryCount = 0
    return {aiControlled = aiControlled, lapsCompleted = lapsCompleted,
        drsPresent = drsPresent, drsLocked = drsLocked, drsActivationZone = drsActivationZone, drsZone = drsZone, drsActive = drsActive,
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

        dData = try(function()
            return ini.sections['ZONE_'..index]['DETECTION'][1]
        end, function () end)
        sData = try(function()
            return ini.sections['ZONE_'..index]['START'][1]
        end, function () end)
        eData = try(function()
            return ini.sections['ZONE_'..index]['END'][1]
        end, function () end)

        if dData == nil or sData == nil or eData == nil then break end
        detectionZones[index] = tonumber(dData)
        startZones[index] = tonumber(sData)
        endZones[index] = tonumber(eData)

        index = index + 1
    end

    local zoneCount = index
    return {detectionZones = detectionZones, startZones = startZones, endZones = endZones, zoneCount = zoneCount}
end, class.NoInitialize)

---@return sessionTypeString
local function sessionTypeString(sessionType)
    local sessionTypes = {"Undefined", "Practice", "Qualify", "Race", "Hotlap", "Time Attack", "Drift", "Drag"}

    return sessionTypes[sessionType+1]
end

local function inActivationZone(driver)
    local trackPos = ac.worldCoordinateToTrackProgress(driver.car.position)

    --- Get next detection line
    for zoneIndex=0, DRS_Zones.zoneCount-1 do
        local prevZone = zoneIndex-1
        if zoneIndex == 0 then
            prevZone = DRS_Zones.zoneCount-1
        end
        if trackPos <= DRS_Zones.detectionZones[zoneIndex] and trackPos >= DRS_Zones.endZones[prevZone] then
            DRS_Current_Zone = zoneIndex
            return true
        end
        if trackPos >= DRS_Zones.startZones[zoneIndex] then
            DRS_Current_Zone = zoneIndex + 1
        end
    end

    return false
end

local function getDelta(driver)
    local carAhead = 0

    for driverIndex = 0, Sim.carsCount-1 do
        local pos = ac.getCar(driverIndex).racePosition
        if driver.car.racePosition == pos+1 then
            carAhead = driverIndex
        end
    end

    return round(ac.getGapBetweenCars(driver.index, carAhead),5)
end

local function checkGap(driver)
    local delta = getDelta(driver)

    if delta < 1.0 and delta >= 0.0 then
        return true
    else
        return false
    end
end

local function inPits(driver)
    if driver.isInPit or driver.isInPitlane then
        return true
    else
        return false
    end
end

local function lockDRS(driver)
    driver.drsLocked = true
    ac.setDRS(false)
end

local function drsAvailable(driver)
    if not inPits(driver) then
        if inActivationZone(driver) then
            driver.drsLocked = false
            return checkGap(driver)

        elseif not driver.drsZone then
            --- Check if car is within 1 second of leading car
            if driver.drsAvailable then
                return true
            else
                lockDRS(driver)
                return false
            end

        elseif driver.drsZone then
            --- Lock DRS if it was not available upon entering DRS zone
            if not driver.drsLocked then
                if driver.drsAvailable then
                    return true
                else
                    lockDRS(driver)
                    return false
                end
            else
                lockDRS(driver)
                return false
            end
        else
            lockDRS(driver)
            return false
        end
    else
        lockDRS(driver)
        return false
    end
end

local function enableDRS(driver)
    for driverIndex = 0, Sim.carsCount-1 do
        if ac.getCar(driverIndex).racePosition == 1 then
            --- CarState index starts at 1...
            if ac.getCarState(driverIndex+1).lapCount >= LapsEngageDRS then
                driver.drsLocked = false
                return true
            else
                driver.drsLocked = true
                return false
            end
        end
    end
end

local function controlDRS()
    if DRS_Enabled == false then
        ac.setDRS(false)
        DRS_Enabled = enableDRS()
    else
        for driver in Drivers do
            driver.drsAvailable = drsAvailable(driver)
        end
    end
end

local function controlMGUK(driver)
    if Lap_Count < driver.car.lapCount then
        driver.mgukDeliveryCount = 0
        Lap_Count = driver.car.lapCount
    end
    if driver.mgukDeliveryCount < Max_MGUK_Change then
        if CarInputs.mgukDeliveryUp or CarInputss.mgukDeliveryDown then
            Timer0 = 0
        end

        if Timer0 > 250 then
            Timer0 = 0
            if  driver.car.mgukDelivery ~= driver.mgukDelivery then
                driver.mgukDeliveryCount = driver.mgukDeliveryCount + 1

                driver.mgukDelivery = driver.car.mgukDelivery
            end
        else
            Timer0 = Timer0 + 1
        end
    else
        ac.setMGUKDelivery(driver.mgukDelivery)
    end
end

local function controlERS(driver)
    if driver.car.kersCurrentKJ >= Max_ERS then
        ac.setKERS(false)
    end
end

local function initialize()
    Initialized = true
    DRS_Enabled = false

    DRS_Zones = DRS_Points("drs_zones.ini")

    for driverIndex = 0, Sim.carsCount-1 do
        table.insert(Drivers,driverIndex,Driver(driverIndex))
    end

    SessionTypeString = sessionTypeString(SessionTypeInt)
end

local function getTrackPositionM()
    return ac.worldCoordinateToTrackProgress(Drivers[0].car.position)/Sim.trackLengthM
end

local function getDetectionDistance()
    return math.round(math.clamp((DRS_Zones.detectionZones[DRS_Current_Zone]/Sim.trackLengthM)-getTrackPositionM(),0,10000), 3)
end

function script.windowMain(dt)
    if not Initialized then initialize() end

    ---if SessionTypeInt == 3 or SessionTypeInt == 2 then
    if true then
        controlDRS()
        controlMGUK()
        controlERS()

        ui.pushFont(ui.Font.Main)
        ui.text("SESSION")
        ui.pushFont(ui.Font.Small)
        ui.text("Type: "..SessionTypeString)
        ui.text("Locked: "..tostring(CarInputs.kers))
        ui.text("Race Position: "..Drivers[0].car.racePosition.."/"..Sim.carsCount)
        ui.text("Delta: "..getDelta(Drivers[0]))
        ui.text("Detection Line in: "..tostring(getDetectionDistance()).." m")

        ui.pushFont(ui.Font.Main)
        ui.text("\nERS")
        ui.pushFont(ui.Font.Small)
        ui.text("ERS Spent: "..string.format("%2.1f", Drivers[0].car.kersCurrentKJ).."/"..Max_ERS)
        ui.text("MGUK Mode: "..MGUK_Delivery)
        ui.text("MGUK Switch Count: "..Drivers[0].mgukDeliveryCount)

        ui.pushFont(ui.Font.Main)
        ui.text("\nDRS")
        ui.pushFont(ui.Font.Small)
        if Drivers[0].drsPresent then
            if DRS_Enabled == true then
                ui.text("Enabled: "..tostring(DRS_Enabled))
            else
                ui.text("Endabled: in "..LapsEngageDRS.." laps")
            end
            ui.text("Locked: "..tostring(Drivers[0].drsLocked))
            ui.text("Within Gap: "..tostring(checkGap()))
            ui.text("Act Zone: "..tostring(inActivationZone()))
            ui.text("Deploy Zone: "..tostring(Drivers[0].drsZone))
            ui.text("Available: "..tostring(Drivers[0].drsAvailable))
            ui.text("Activated: "..tostring(Drivers[0].drsActive))
        else
            ui.text("DRS not present")
        end
    else
        ui.pushFont(ui.Font.Main)
        ui.text("Not a race session")
    end
end