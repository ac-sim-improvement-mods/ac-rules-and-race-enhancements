local Sim = ac.getSim()
local Car = ac.getCar(0)
local Session = ac.getSession(0)

local Initialized = false
local SessionTypeInt = Session.type
local SessionTypeString = ""

local LapsEngageDRS = 2
local Lap_Count = 0

local DRS_Current_Zone = 0
local DRS_Locked = false
local DRS_Available = false
local DRS_Enabled = false
local DRS_Zones = {}

local Max_MGUK_Change = 4
local Max_ERS = 4000
local MGUK_Delivery = 0
local MGUK_Count = 0
local Timer0 = 0

---@class Driver
---@generic T
---@param carIndex any
---@return Driver|{data: T, original: T}
local Driver = class('Driver', function(carIndex)
    local car = ac.getCar(carIndex)
    local aiControlled = car.isAIControlled
    local lapsCompleted = car.lapCount

    local drsPresent = car.drsPresent
    local drsLocked = false
    local drsActivationZone = false
    local drsZone = car.drsAvailable
    local drsActive = car.drsActive

    local mgukPresent = car.hasCockpitERSDelivery
    local mgukLocked = false
    local mgukDelivery = car.mgukDelivery
    local mgukDeliveryCount = car.mgukDeliveryCount
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


local function sessionTypeString(sessionType)
    local sessionTypes = {"Undefined", "Practice", "Qualify", "Race", "Hotlap", "Time Attack", "Drift", "Drag"}

    return sessionTypes[sessionType+1]
end

local function inActivationZone()
    local trackPos = ac.worldCoordinateToTrackProgress(Car.position)

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

local function getDelta()
    local carAhead = 0

    for driver = 0, Sim.carsCount-1 do
        local pos = ac.getCar(driver).racePosition
        ac.getCar(driver).position
        if Car.racePosition == pos+1 then
            carAhead = driver
        end
    end

    return ac.getGapBetweenCars(Car.index, carAhead)
end

local function checkGap()
    local delta = getDelta()

    if delta < 1.0 and delta >= 0.0 then
        return true
    else
        return false
    end
end

local function inPits()
    if Car.isInPit or Car.isInPitlane then 
        return true
    else
        return false
    end
end

local function lockDRS()
    DRS_Locked = true
    ac.setDRS(false)
end

local function drsAvailable()

    if not inPits() then
        if inActivationZone() then
            DRS_Locked = false
            return checkGap()
    
        elseif not Car.drsAvailable then
            --- Check if car is within 1 second of leading car
            if DRS_Available then
                return true
            else
                lockDRS()
                return false
            end                     
    
        elseif Car.drsAvailable then
            --- Lock DRS if it was not available upon entering DRS zone
            if not DRS_Locked then
                if DRS_Available then
                    return true
                else
                    lockDRS()
                    return false
                end
            else
                lockDRS()
                return false
            end
        else
            lockDRS()
            return false
        end
    else
        lockDRS()
        return false
    end
end

local function enableDRS()
    for driver = 0, Sim.carsCount-1 do
        if ac.getCar(driver).racePosition == 1 then
            --- CarState index starts at 1...
            local leaderLapsCompleted = ac.getCarState(driver+1).lapCount
            LapsEngageDRS = LapsEngageDRS - leaderLapsCompleted
            if leaderLapsCompleted >= 0 then
                DRS_Locked = false
                return true
            else
                DRS_Locked = true
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
        DRS_Available = drsAvailable()
    end
end

local function controlMGUK()
    if Lap_Count < Car.lapCount then
        MGUK_Count = 0
        Lap_Count = Car.lapCount
    end
    if MGUK_Count < Max_MGUK_Change then
        if physics.getCarInputControls().mgukDeliveryUp or physics.getCarInputControls().mgukDeliveryDown then
            Timer0 = 0
        end

        if Timer0 > 250 then
            Timer0 = 0
            if  Car.mgukDelivery ~= MGUK_Delivery then
                MGUK_Count = MGUK_Count + 1
    
                MGUK_Delivery = Car.mgukDelivery
            end
        else
            Timer0 = Timer0 + 1
        end
    else
        ac.setMGUKDelivery(MGUK_Delivery)
    end
end

local function controlERS()
    if Car.kersCurrentKJ >= Max_ERS then
        ac.setKERS(false)
    end
end

local function initialize()
    Initialized = true
    DRS_Locked = false
    DRS_Available = false
    DRS_Enabled = false

    DRS_Zones = DRS_Points("drs_zones.ini")


    SessionTypeString = sessionTypeString(SessionTypeInt)
    MGUK_Delivery = Car.mgukDelivery
end

local function getTrackPositionM()
    return ac.worldCoordinateToTrackProgress(Car.position)/Sim.trackLengthM
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
        ui.text("Activated: "..tostring(ac.race))
        ui.text("Type: "..SessionTypeString)
        ui.text("Locked: "..tostring(physics.getCarInputControls().kers))
        ui.text("Race Position: "..Car.racePosition.."/"..Sim.carsCount)
        ui.text("Delta: "..getDelta())
        ui.text("Detection Line in: "..tostring(getDetectionDistance()).." m")
        
        ui.pushFont(ui.Font.Main)
        ui.text("\nERS")
        ui.pushFont(ui.Font.Small)
        ui.text("ERS Spent: "..string.format("%2.1f", Car.kersCurrentKJ).."/"..Max_ERS)
        ui.text("MGUK Mode: "..MGUK_Delivery)
        ui.text("MGUK Switch Count: "..MGUK_Count)
    
        ui.pushFont(ui.Font.Main)
        ui.text("\nDRS")
        ui.pushFont(ui.Font.Small)
        if Car.drsPresent then
            if DRS_Enabled == true then
                ui.text("Enabled: "..tostring(DRS_Enabled))
            else
                ui.text("Endabled: in "..LapsEngageDRS.." laps")
            end
            ui.text("Locked: "..tostring(DRS_Locked))
            ui.text("Within Gap: "..tostring(checkGap()))
            ui.text("Act Zone: "..tostring(inActivationZone()))
            ui.text("Deploy Zone: "..tostring(Car.drsAvailable))
            ui.text("Available: "..tostring(DRS_Available))
            ui.text("Activated: "..tostring(Car.drsActive))
        else
            ui.text("DRS not present")
        end
    else
        ui.pushFont(ui.Font.Main)
        ui.text("Not a race session")
    end
end

