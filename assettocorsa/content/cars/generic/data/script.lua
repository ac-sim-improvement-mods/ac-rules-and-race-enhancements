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

    data.controllerInputs[0] = total_brake_bias
end

function script.update(dt)
    local data = ac.accessCarPhysics()

    control_brake_bias(data)
end