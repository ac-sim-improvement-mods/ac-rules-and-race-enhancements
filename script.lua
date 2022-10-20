---
--- Script v0.9.5-alpha
---
local OFF_TRACK_TIMER = 0

local F1RegsData = ac.connect({
    ac.StructItem.key('F1RegsData'),
    connected = ac.StructItem.boolean(),
    scriptVersionId = ac.StructItem.int16(),
    drsEnabled = ac.StructItem.boolean(),
    drsAvailable = ac.StructItem.array(ac.StructItem.boolean(),32),
    carAhead = ac.StructItem.array(ac.StructItem.int16(),32),
    carAheadDelta = ac.StructItem.array(ac.StructItem.float(),32),
},false,ac.SharedNamespace.Shared)

local function car_control(data, launch)
    local rear_slip = data.wheels[2].ndSlip + data.wheels[3].ndSlip / 2
    
    -- if car.index == 1 then
    --     ac.log(rear_slip)
    -- end

    if data.brake <= 0.11 then
        if launch then
            data.gas = math.clamp(1/rear_slip,0.25,1)
            data.steer = math.clamp(data.steer, -0.15, 0.15)
        else
            data.gas = math.clamp(1/(rear_slip*2),0,0.5)
            data.brake = 0
        end
    end
end

local function force_full_throttle_on_straights(data)
    if car.drsAvailable and data.brake <= 0.1001 then
        data.gas = 1
    end
end

local function off_track_recovery(data)
    if car.wheelsOutside == 4 then
        OFF_TRACK_TIMER = OFF_TRACK_TIMER+1
        if OFF_TRACK_TIMER > 5000 then
            car_control(data, false)
        end
    else
        OFF_TRACK_TIMER = 0
    end
end

local function start_prep(data,sim)
    if sim.timeToSessionStart < 7000 then
        data.gas = 0.3
        data.brake = 0.1001
    end
end

local function launch_control(data,sim)
    if sim.timeToSessionStart > -3000 then
        car_control(data, true)
        return true
    elseif sim.timeToSessionStart > -5000 then
        data.steer = math.clamp(data.steer, -0.15, 0.15)
        data.gas = 1
        return true
    else
        return false
    end
end

local lastAState = false
local lastBState = false
local bmig = 0.03
local bmigMax = 0.09
local bmigMin = 0.00
local ramp = 0.3

local function control_brake_bias(data)
    local datac = ac.getCarPhysics(car.index)

    if lastAState ~= car.extraA then
        if bmig == bmigMax then
            bmig = bmigMin
        else
            bmig = math.clamp(bmig+0.01,bmigMin,bmigMax)
        end
        lastAState = car.extraA
    end

    if lastBState ~= car.extraB then
        if bmig == bmigMin then
            bmig = bmigMax
        else
            bmig = math.clamp(bmig-0.01,bmigMin,bmigMax)
        end
        lastBState = car.extraB
    end

    local set_brake_bias = car.brakeBias
    if car.isAIControlled then
        --set_brake_bias = 0.5
        ramp = 0.3
        bmig = 0.03
    end

    data.controllerInputs[1] = bmig * 100

    local total_brake_bias = set_brake_bias + ((math.clamp(data.brake-ramp,0,1)/(1-ramp)) * bmig * set_brake_bias)
    local bbb = set_brake_bias*100
    local bbt = total_brake_bias*100
    local bmigcalc = math.round((bbt - bbb) / bbb * 100,0)

    local front_torq = datac.wheels[0].brakeTorque + datac.wheels[1].brakeTorque
    local rear_torq = datac.wheels[2].brakeTorque + datac.wheels[3].brakeTorque
    local total = front_torq + rear_torq
    local bb_a = front_torq/total*100
    local bbdiff = bbt-bb_a

    -- ac.debug("BBB",math.round(bbb,6).." %")
    -- ac.debug("BMIG",(bmig*100).." %")
    -- ac.debug("BBT",math.round(bbt,2).." %")
    -- ac.debug("BMIG Calc",bmigcalc.." %")

    -- ac.debug("BMIG Ramp",(ramp*100).." %")
    -- ac.debug("Brake",(math.round(car.brake,2)*100).." %")
    -- ac.debug("T Torque",total)
    -- ac.debug("F Torque",front_torq)
    -- ac.debug("R Torque",rear_torq)
    -- ac.debug("BB_Actual",math.round(bb_a,2).." %")
    -- ac.debug("BB_DIFF",math.round(bbdiff,0).." %")
    
    -- ac.debug("ExtraA",car.extraA)
    -- ac.debug("ExtraB",car.extraB)
    -- ac.debug("ExtraC",car.extraC)

    data.controllerInputs[0] = total_brake_bias
end

local function lock_drs(data)
    if not F1RegsData.drsAvailable[car.index] then
        if car.drsAvailable and car.drsActive then
            data.brake = 0.1001
        end   
    elseif data.brake <= 0.025 and car.drsAvailable then
        data.brake = 0.025
    end
end

local function control_ai(data,sim)
    if sim.isSessionStarted then
        if F1RegsData.connected and ac.getPatchVersionCode() < 2066 then
            lock_drs(data)
        end

        if not launch_control(data,sim) then
            if not car.isInPitlane then
                force_full_throttle_on_straights(data)
            end
        end

        off_track_recovery(data)
    else
        start_prep(data,sim)
    end
end

local entrydiff = 25
local middiff = 50
local exitdiff = 75
local hispddiff = 90

local function control_differential(data)
    ac.debug("G Forces", data.gForces)
    ac.debug("LOCKING", car.differentialPreload)


    data.controllerInputs[2] = 250
end

function script.update(dt)
    local data = ac.accessCarPhysics()
    local sim = ac.getSim()
    --ac.log(car.index.." "..tostring(F1RegsData.drsAvailable[car.index]))
    ac.log(car.drsAvailable)

    control_brake_bias(data)
    --control_differential(data)

    if not car.isAIControlled or not sim.raceSessionType == 3 then
        return
     end

    control_ai(data,sim)
end