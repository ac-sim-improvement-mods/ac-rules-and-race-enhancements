---
--- Script v0.9.0-alpha
---
local OFF_TRACK_TIMER = 0

if not car.isAIControlled then
   return nil
end

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

function script.update(dt)
    local data = ac.accessCarPhysics()
    local sim = ac.getSim()

    if sim.raceSessionType == 3 then
        if sim.isSessionStarted then
            local drs_available = stringify.tryParse(ac.load("F1Regs"))[car.index..".drsAvailable"]
            
            if sim.timeToSessionStart > -3000 then
                car_control(data, true)
            elseif sim.timeToSessionStart > -5000 then
                data.steer = math.clamp(data.steer, -0.15, 0.15)
            else
                if car.drsAvailable and data.speedKmh > 150 then
                    if data.clutch < 0.1 then
                        data.brake = 0
                        if car.brake < 0.1 then
                            data.gas = 1
                        end
                    end
                end
            end

            if drs_available == false then
                if car.drsAvailable then
                    if sim.timeToSessionStart < -3000 and data.brake <= 0.11 and data.steer < 0.05 and data.steer > -0.05 then
                        data.gas = 1
                    end
                end
            end

            if car.wheelsOutside == 4 then
                OFF_TRACK_TIMER = OFF_TRACK_TIMER+1
                if OFF_TRACK_TIMER > 5000 then
                    
                    car_control(data, false)
                end
            else
                OFF_TRACK_TIMER = 0
            end
        else
            if sim.timeToSessionStart < 7000 then
                data.gas = 0.3
                data.brake = 0.1001
            end
        end
    end
end