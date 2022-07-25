---
--- Script v0.5.3-alpha
---
if not car.isAIControlled then
    return nil
end

function script.update(dt)
    local data = ac.accessCarPhysics()

    if ac.load("f1r.drs."..car.index) == 0 then
        ac.log(car.index..":[LOCKED] "..ac.getDriverName(car.index))
        if car.drsActive then
            --ac.setWingGain(9, 8, 1)
            data.brake = 0.1001
        end
    else
        if car.drsActive then
            ac.log(car.index..":[OPEN] "..ac.getDriverName(car.index))
        else
            ac.log(car.index..":[CLOSED] "..ac.getDriverName(car.index))
        end
    end
end