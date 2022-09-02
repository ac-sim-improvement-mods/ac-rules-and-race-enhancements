---
--- Script v0.8.0-alpha
---
local OFF_TRACK_TIMER = 0

if not car.isAIControlled then
   return nil
end

local function temp_drag_reset()
    ac.setWingGain(9, 1, 1)
end

local function temp_drag_reduction(data)
    data.brake = 0.1001

    if car.speedKmh < 100 then
        ac.setWingGain(9, 100, 0)
    elseif car.speedKmh < 160 then
        ac.setWingGain(9, 100, 0)
    elseif car.speedKmh < 200 then
        ac.setWingGain(9, 50, 0)
    elseif car.speedKmh < 250 then
        ac.setWingGain(9, 25, 0)
    elseif car.speedKmh < 280 then
        ac.setWingGain(9, 15, 0)
    elseif car.speedKmh < 340 then
        ac.setWingGain(9, 14, 0)
    else
        temp_drag_reset()
    end
end

local function car_control(data, launch)
    local rear_slip = data.wheels[2].ndSlip + data.wheels[3].ndSlip / 2
    
    if car.index == 1 then
        ac.log(rear_slip)
    end

    ac.setWingGain(9, 250, 0)

    if data.brake <= 0.11 then
        if launch then
            data.gas = math.clamp(1/math.clamp((rear_slip),1,100),0.55,1)
            data.steer = math.clamp(data.steer, -0.15, 0.15)
        else
            data.gas = math.clamp(1/(rear_slip*2),0,0.5)
            data.brake = 0
        end
    end
end

function script.update(dt)
    local data = ac.accessCarPhysics()
    local sim = ac.getSim()

    if sim.raceSessionType == 3 then
        if sim.isSessionStarted then
            local drs_available = stringify.parse(ac.load("F1Reg"))[car.index..".drsAvailable"]

            if sim.timeToSessionStart < 5000 and sim.timeToSessionStart > 0 then
                data.gas = 0.55
            elseif sim.timeToSessionStart > -1500 then
                car_control(data, true)
            elseif sim.timeToSessionStart > -5000 then
                data.steer = math.clamp(data.steer, -0.15, 0.15)
            end

            if drs_available == false then
                if car.drsAvailable then
                    if sim.timeToSessionStart < -1500 and data.brake <= 0.11 and data.steer < 0.05 and data.steer > -0.05 then
                        data.gas = 1
                    end
                end

                if car.drsActive then
                    temp_drag_reduction(data)
                else
                    temp_drag_reset()
                end
            else
                temp_drag_reset()
            end

            if car.wheelsOutside == 4 then
                OFF_TRACK_TIMER = OFF_TRACK_TIMER+1
                if OFF_TRACK_TIMER > 5000 then
                    
                    car_control(data, false)
                end
            else
                OFF_TRACK_TIMER = 0
            end
        end
    end
end