---
--- Script v0.7.0-alpha
---
if not car.isAIControlled then
    return nil
end

function temp_drag_reduciton()
    local data = ac.accessCarPhysics()
    data.brake = 0.1001
    --ac.setWingGain(9, 15, 1)
end

function temp_drag_reset()
    --ac.setWingGain(9, 1, 1)
end

function script.update(dt)
    if sim.raceSessionType == 3 then
        local drs_available = stringify.parse(ac.load("F1Reg"))[car.index..".drsAvailable"]

        if drs_available == false then
            if car.drsActive then
                temp_drag_reduciton()
            else
                temp_drag_reset()
            end
        else
            temp_drag_reset()
        end
    end
end