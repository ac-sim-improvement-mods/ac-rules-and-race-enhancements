---
--- Script v0.6-alpha
---
function script.update(dt)
    local data = ac.accessCarPhysics()

    if ac.load("f1r.drsAvailable."..car.index) == 0 then
        ac.log(car.index..":[LOCKED] "..ac.getDriverName(car.index))
        if car.isAIControlled then
            ac.setWingGain(9, 1, 1) -- Mildly tested on RSS FH2022S
            if car.drsActive then
                ac.setWingGain(9, 15, 1) -- Mildly tested on RSS FH2022S
                data.brake = 0.1001
                data.gas = 1
            else
                ac.setWingGain(9, 1, 1) -- Mildly tested on RSS FH2022S
            end
        end
    else
        ac.setWingGain(9, 1, 1) -- Mildly tested on RSS FH2022S
        if car.drsActive then
            ac.log(car.index..":[OPEN] "..ac.getDriverName(car.index))
        else
            ac.log(car.index..":[CLOSED] "..ac.getDriverName(car.index))
        end
    end
end