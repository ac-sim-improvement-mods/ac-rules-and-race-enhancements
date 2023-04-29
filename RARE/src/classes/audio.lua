local sim = ac.getSim()

Audio = class("Audio")

function Audio:initialize()
	DRS_FLAP = ui.MediaPlayer()
	DRS_BEEP = ui.MediaPlayer()

	DRS_BEEP:setSource("./assets/audio/drs-available-beep.wav"):setAutoPlay(false)
	DRS_BEEP:setVolume(
		sim.audioMasterVolume * RARE_CONFIG.data.AUDIO.MASTER / 100 * RARE_CONFIG.data.AUDIO.DRS_BEEP / 100
	)

	DRS_FLAP:setSource("./assets/audio/drs-flap.wav"):setAutoPlay(false)
	DRS_FLAP:setVolume(
		sim.audioMasterVolume * RARE_CONFIG.data.AUDIO.MASTER / 100 * RARE_CONFIG.data.AUDIO.DRS_FLAP / 100
	)
end

local function formula1(driver)
	if driver.car.focusedOnInterior then
		if sim.raceSessionType == ac.SessionType.Race then
			if driver.drsBeepFx and driver.car.drsAvailable and driver.isDrsAvailable then
				driver.drsBeepFx = false
				DRS_BEEP:play()
			elseif not driver.car.drsAvailable and driver.isDrsAvailable then
				driver.drsBeepFx = true
			end
		else
			if driver.drsBeepFx and driver.car.drsAvailable then
				driver.drsBeepFx = false
				DRS_BEEP:play()
			elseif not driver.car.drsAvailable then
				driver.drsBeepFx = true
			end
		end

		if driver.drsFlapFx ~= driver.car.drsActive then
			driver.drsFlapFx = driver.car.drsActive
			DRS_FLAP:play()
		end
	else
		driver.drsBeepFx = false
		driver.drsFlapFx = false
	end
end

function Audio:update()
	local driver = DRIVERS[sim.focusedCar]
	formula1(driver)
end
