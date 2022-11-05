audio = {}

local acMainVolume = ac.getAudioVolume(ac.AudioChannel.Main)

local DRS_FLAP = ui.MediaPlayer()
local DRS_BEEP = ui.MediaPlayer()

DRS_BEEP:setSource("./assets/audio/drs-available-beep.wav"):setAutoPlay(false)
DRS_BEEP:setVolume(acMainVolume * F1RegsConfig.data.AUDIO.MASTER/100 * F1RegsConfig.data.AUDIO.DRS_BEEP/100)

DRS_FLAP:setSource("./assets/audio/drs-flap.wav"):setAutoPlay(false)
DRS_FLAP:setVolume(acMainVolume * F1RegsConfig.data.AUDIO.MASTER/100 * F1RegsConfig.data.AUDIO.DRS_FLAP/100)
    
local function audio.formula1(sim,driver)
    if sim.cameraMode < 3 and sim.isWindowForeground then
        if driver.drsBeepFx and driver.car.drsAvailable and driver.drsAvailable then
            driver.drsBeepFx = false
            DRS_BEEP:play()
        elseif not driver.car.drsAvailable and driver.drsAvailable then
            driver.drsBeepFx = true
        end
    
        if driver.drsFlapFx ~= driver.car.drsActive then
            driver.drsFlapFx = driver.car.drsActive
            DRS_FLAP:play()
        end
    end 
end 

function audio.driver()
    local sim = ac.getSim()
    local driver = DRIVERS[sim.focusedCar]
 
    audio.formula1  (sim,driver)
end

return audio