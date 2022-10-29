DRS_FLAP = ui.MediaPlayer()
DRS_BEEP = ui.MediaPlayer()

function audioHandler(sim)
    local driver = DRIVERS[ac.getSim().focusedCar]

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

        DRIVERS[ac.getSim().focusedCar] = driver
    end
end