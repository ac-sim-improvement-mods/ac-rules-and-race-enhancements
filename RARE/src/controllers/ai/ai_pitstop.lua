local ai_pitstop = {}

local function avgTyreWearBelowLimit(driver)
	local avgTyreLimit = 1 - driver.aiTyrePitBelowAvg / 100
	local avgTyreWear = (
		driver.car.wheels[0].tyreWear
		+ driver.car.wheels[1].tyreWear
		+ driver.car.wheels[2].tyreWear
		+ driver.car.wheels[3].tyreWear
	) / 4
	return avgTyreWear > avgTyreLimit and true or false
end

local function singleTyreWearBelowLimit(driver)
	local singleTyreLimit = 1 - driver.aiTyrePitBelowSingle / 100

	if
		driver.car.wheels[0].tyreWear > singleTyreLimit
		or driver.car.wheels[1].tyreWear > singleTyreLimit
		or driver.car.wheels[2].tyreWear > singleTyreLimit
		or driver.car.wheels[3].tyreWear > singleTyreLimit
	then
		return true
	else
		return false
	end
end

local function getNextTyreCompound(driver)
	local compoundsAvailable = driver.tyreDryCompounds
	local compoundNext = driver.car.compoundIndex

	math.randomseed(os.clock() * driver.index)
	math.random()

	if not driver.hasChangedTyreCompound then
		table.removeItem(compoundsAvailable, driver.car.compoundIndex)
		compoundNext = compoundsAvailable[math.random(1, #compoundsAvailable)]
	else
		compoundNext = compoundsAvailable[math.random(1, #compoundsAvailable)]
	end

	return compoundNext
end

local function triggerPitStopRequest(driver, trigger)
	if ac.getPatchVersionCode() >= 2278 then
		physics.setAIPitStopRequest(driver.index, trigger)
	else
		if trigger and not driver.isAIPitting then
			driver.aiPrePitFuel = driver.car.fuel
			physics.setCarFuel(driver.index, 0.1)
			driver.isAIPitCall = true
		end
	end

	driver.isAIPitting = trigger
	if trigger then
		driver.tyreCompoundNext = getNextTyreCompound(driver)
	end
end

local function pitStrategyCall(driver, forced)
	local carAhead = DRIVERS[driver.carAhead]
	local trigger = true
	local lapsTotal = ac.getSession(ac.getSim().currentSessionIndex).laps
	local lapsRemaining = lapsTotal - driver.lapsCompleted

	if not forced then
		if lapsRemaining <= 7 or (driver.carAheadDelta < 1 and carAhead.isAIPitting) then
			trigger = false
		end
	end

	triggerPitStopRequest(driver, trigger)
end

local function pitstop(raceRules, driver)
	if driver.isAIPitting then
		if not driver.hasChangedTyreCompound and driver.tyreCompoundNext ~= driver.tyreCompoundStart then
			driver.hasChangedTyreCompound = true
		end

		driver.tyreStints[#driver.tyreStints] = {
			ac.getTyresName(driver.index, driver.car.compoundIndex),
			driver.tyreLaps,
		}

		table.insert(driver.tyreStints, {
			ac.getTyresName(driver.index, driver.tyreCompoundNext),
			0,
		})

		driver.tyreLaps = 0

		if ac.getPatchVersionCode() >= 2278 then
			physics.setAITyres(driver.index, driver.tyreCompoundNext)
		end
	end

	if raceRules.RACE_REFUELING ~= 1 then
		physics.setCarFuel(driver.index, driver.aiPrePitFuel)
	end

	driver.isAIPitting = false
end

function ai_pitstop.run(raceRules, driver)
	if not driver.car.isInPitlane and not driver.isAIPitting then
		if singleTyreWearBelowLimit(driver) then
			pitStrategyCall(driver, true)
		elseif avgTyreWearBelowLimit(driver) then
			pitStrategyCall(driver, false)
		end
	else
		if driver.car.isInPit then
			pitstop(raceRules, driver)
			-- if driver.pitstopTime < 3 then
			-- 	if not driver.aiPitFix then
			-- 		physics.teleportCarTo(driver.index, ac.SpawnSet.Pits)
			-- 		physics.resetCarState(driver.index, 1)
			-- 		driver.aiPitFix = true
			-- 		physics.setAIPitStopRequest(driver.index, true)
			-- 	end
			-- else
			-- 	physics.setAIPitStopRequest(driver.index, false)
			-- end
			-- elseif not driver.car.isInPit and driver.aiPitFix then
			-- 	driver.aiPitFix = false
		end

		if driver.isAIPitCall then
			physics.setCarFuel(driver.index, driver.aiPrePitFuel)
			driver.isAIPitCall = false
		end
	end
end

return ai_pitstop
