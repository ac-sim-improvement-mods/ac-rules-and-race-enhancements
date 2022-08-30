---
--- Script v0.8.0-alpha
---
local OFF_TRACK_TIMER = 0

if not car.isAIControlled then
    return nil
end

function temp_drag_reduction(data)
    data.brake = 0.1001

    if car.speedKmh < 100 then
        ac.setWingGain(9, 250, 1)
    elseif car.speedKmh < 150 then
        ac.setWingGain(9, 200, 1)
    elseif car.speedKmh < 275 then
        ac.setWingGain(9, 30, 1)
    else
        ac.setWingGain(9, 1, 1)
    end
end

function temp_drag_reset()
    ac.setWingGain(9, 1, 1)
end

function car_launch(data, launch)
    local rear_slip = data.wheels[2].ndSlip + data.wheels[3].ndSlip / 2
    if data.brake <= 0.1001 then
        
        if launch then
            data.gas = math.clamp(1/math.clamp((rear_slip-0.5),1,4),0,1)
            data.steer = math.clamp(data.steer, -0.05, 0.05)
        else
            car.gear = 2
            data.gas = math.clamp(1/(rear_slip*2),0,0.5)
        end
    end
end

function script.update(dt)
    local data = ac.accessCarPhysics()
    local sim = ac.getSim()

    if sim.raceSessionType == 3 then
        if sim.isSessionStarted then
            local drs_available = stringify.parse(ac.load("F1Reg"))[car.index..".drsAvailable"]

            if drs_available == false then
                if car.drsActive then
                    if sim.timeToSessionStart < -5000 and data.brake <= 0.1001 then
                        data.gas = 1
                    end
                    temp_drag_reduction(data)
                else
                    temp_drag_reset()
                end
            else
                temp_drag_reset()
            end

            if car.wheelsOutside == 4 then
                OFF_TRACK_TIMER = OFF_TRACK_TIMER+1
                if OFF_TRACK_TIMER > 3000 then
                    
                    car_launch(data, false)
                end
            else
                OFF_TRACK_TIMER = 0
            end

            if sim.timeToSessionStart > -5000 then
                car_launch(data, true)
            end
        end
    end
end