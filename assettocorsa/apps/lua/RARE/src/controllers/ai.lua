local ai = {}

AI_COMP_OVERRIDE = false
AI_THROTTLE_LIMIT = 0.8
AI_LEVEL = 0.9
AI_AGGRESSION = 0.25

--- Returns whether driver's average tyre life is below
--- the limit or not
---@param driver Driver
---@return bool
local function avgTyreWearBelowLimit(driver)
	local avgTyreLimit = 1 - (RARECONFIG.data.AI.AI_AVG_TYRE_LIFE + driver.aiTyreAvgRandom) / 100
	local avgTyreWear = (
		driver.car.wheels[0].tyreWear
		+ driver.car.wheels[1].tyreWear
		+ driver.car.wheels[2].tyreWear
		+ driver.car.wheels[3].tyreWear
	) / 4
	return avgTyreWear > avgTyreLimit and true or false
end

---@alias ai.QualifyLap
---| `ai.QualifyLap.OutLap` @Value: 0.
---| `ai.QualifyLap.FlyingLap` @Value: 1.
---| `ai.QualifyLap.InLap` @Value: 2.
ai.QualifyLap = { OutLap = 0, FlyingLap = 1, InLap = 2 }

--- Returns whether one of a driver's tyre life is below
--- the limit or not
---@param driver Driver
---@return bool
local function singleTyreWearBelowLimit(driver)
	local singleTyreLimit = 1 - (RARECONFIG.data.AI.AI_SINGLE_TYRE_LIFE + driver.aiTyreSingleRandom) / 100

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
	local compoundsAvailable = driver.tyreCompoundsAvailable
	local compoundNext = driver.car.compoundIndex

	math.randomseed(os.clock() * driver.index)
	math.random()

	if not driver.tyreCompoundChange then
		table.removeItem(compoundsAvailable, driver.car.compoundIndex)
		compoundNext = compoundsAvailable[math.random(1, #compoundsAvailable)]
	else
		compoundNext = compoundsAvailable[math.random(1, #compoundsAvailable)]
	end

	return compoundNext
end

--- Force AI driver to drive to the pits
--- @param driver Driver
local function triggerPitStopRequest(driver, trigger)
	if ac.getPatchVersionCode() >= 2278 then
		physics.setAIPitStopRequest(driver.index, trigger)
	else
		if trigger and not driver.aiPitting then
			driver.aiPrePitFuel = driver.car.fuel
			physics.setCarFuel(driver.index, 0.1)
			driver.aiPitCall = true
		end
	end

	driver.aiPitting = trigger
	if trigger then
		driver.tyreCompoundNext = getNextTyreCompound(driver)
	end
end

--- Determine if going to the pits is advantageous or not
--- @param driver Driver
--- @param forced boolean
local function pitStrategyCall(driver, forced)
	local carAhead = DRIVERS[driver.carAhead]
	local trigger = true
	local lapsTotal = ac.getSession(ac.getSim().currentSessionIndex).laps
	local lapsRemaining = lapsTotal - driver.lapsCompleted

	if not forced then
		if lapsRemaining <= 7 or (driver.carAheadDelta < 1 and carAhead.aiPitting) then
			trigger = false
		end
	end

	triggerPitStopRequest(driver, trigger)
end
--- Occurs when a driver is in the pit
---@param driver Driver
local function pitstop(raceRules, driver)
	if driver.aiPitting then
		if not driver.tyreCompoundChange and driver.tyreCompoundNext ~= driver.tyreCompoundStart then
			driver.tyreCompoundChange = true
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

	driver.aiPitting = false
end

--- Determines when an AI driver should pit for new tyres
--- @param driver Driver
function ai.pitNewTyres(raceRules, driver)
	if not driver.car.isInPitlane and not driver.aiPitting then
		if singleTyreWearBelowLimit(driver) then
			pitStrategyCall(driver, true)
		elseif avgTyreWearBelowLimit(driver) then
			pitStrategyCall(driver, false)
		end
	else
		if driver.car.isInPit then
			pitstop(raceRules, driver)
		end

		if driver.aiPitCall then
			physics.setCarFuel(driver.index, driver.aiPrePitFuel)
			driver.aiPitCall = false
		end
	end
end

local function moveOffRacingLine(driver)
	local delta = driver.carAheadDelta
	local driverAhead = DRIVERS[driver.carAhead]
	local splineSideLeft = ac.getTrackAISplineSides(driverAhead.splinePosition).x
	local splineSideRight = ac.getTrackAISplineSides(driverAhead.splinePosition).y
	local offset = splineSideLeft > splineSideLeft and -3 or 3

	if not driverAhead.flyingLap then
		if delta < 2 and delta > 0.1 then
			if driverAhead.car.isInPitlane then
				physics.setAITopSpeed(driverAhead.index, 0)
			else
				if ac.getTrackUpcomingTurn(driverAhead.index).x > 100 then
					physics.setAISplineOffset(driverAhead.index, math.lerp(0, offset, driverAhead.aiSplineOffset))
					physics.setAISplineOffset(driver.index, math.lerp(0, -offset, driver.aiSplineOffset))
					physics.setAITopSpeed(driverAhead.index, 200)
					driverAhead.aiMoveAside = true
					driverAhead.aiSpeedUp = false
				else
					driverAhead.aiSplineOffset = math.lerp(offset, 0, driverAhead.aiSplineOffset)
					driver.aiSplineOffset = math.lerp(-offset, 0, driver.aiSplineOffset)
					physics.setAISplineOffset(driverAhead.index, driverAhead.aiSplineOffset)
					physics.setAISplineOffset(driver.index, driver.aiSplineOffset)
					physics.setAITopSpeed(driverAhead.index, 1e9)
					driverAhead.aiMoveAside = false
					driverAhead.aiSpeedUp = true
				end
			end
		else
			driverAhead.aiSplineOffset = math.lerp(offset, 0, driverAhead.aiSplineOffset)
			driver.aiSplineOffset = math.lerp(-offset, 0, driver.aiSplineOffset)
			physics.setAISplineOffset(driverAhead.index, driverAhead.aiSplineOffset)
			physics.setAISplineOffset(driver.index, driver.aiSplineOffset)
			driverAhead.aiMoveAside = false
			driverAhead.aiSpeedUp = false
		end
	end
end

function ai.qualifying(driver)
	if driver.car.isInPitlane then
		physics.allowCarDRS(driver.index, true)
		if driver.car.isInPit then
			local qualiRunFuel = driver.fuelPerLap * 3.5
			physics.setCarFuel(driver.index, qualiRunFuel)
		end
		driver.inLap = false
		driver.flyingLap = false
		driver.outLap = true
	else
		if driver.flyingLap then
			moveOffRacingLine(driver)
			if ac.getTrackUpcomingTurn(driver.index).x > 200 then
				physics.setAIAggression(driver.index, 1)
			else
				physics.setAIAggression(driver.index, 0.25)
			end

			if driver.car.lapCount >= driver.inLapCount then
				driver.outLap = false
				driver.flyingLap = false
				driver.inLap = true
			end
		elseif driver.outLap then
			if driver.car.splinePosition <= 0.8 then
				if not driver.aiMoveAside and not driver.aiSpeedUp then
					physics.setAITopSpeed(driver.index, 250)
					physics.setAILevel(driver.index, 0.8)
					physics.setAIAggression(driver.index, 1)
					physics.allowCarDRS(driver.index, true)

					if driver.carAheadDelta < 5 then
						physics.setAITopSpeed(driver.index, 200)
					end
				elseif driver.aiSpeedUp then
					moveOffRacingLine(driver)
				end
			else
				physics.setAITopSpeed(driver.index, 1e9)
				physics.setAILevel(driver.index, 1)
				physics.setAIAggression(driver.index, 1)
				physics.allowCarDRS(driver.index, false)
				driver.outLap = false
				driver.flyingLap = true
				driver.inLapCount = driver.car.lapCount + 2
			end
		elseif driver.inLap then
			if not driver.aiMoveAside and not driver.aiSpeedUp then
				physics.setAITopSpeed(driver.index, 200)
				physics.setAILevel(driver.index, 0.65)
				physics.setAIAggression(driver.index, 0)
			elseif driver.aiSpeedUp then
				moveOffRacingLine(driver)
			end
		end
	end
end

local function altAIAggression(driver, upcomingTurn)
	local delta = driver.carAheadDelta

	if upcomingTurn.x > 150 and delta < 0.5 then
		return 1
	elseif delta < 1 then
		return driver.aiAggression
	else
		return 0
	end
end

local function altAIBrakeHint(driver, upcomingTurn)
	local delta = driver.carAheadDelta
	local brakeHint = driver.aiBaseBrakeHint

	if upcomingTurn.x > 150 and delta < 0.15 then
		return brakeHint + (brakeHint * 0.05)
	elseif upcomingTurn.x > 150 and delta < 0.4 then
		return brakeHint + (brakeHint * 0.10)
	elseif not (upcomingTurn.x > 0) and delta < 0.75 then
		return brakeHint
	else
		return brakeHint - (brakeHint * 0.05)
	end
end

local function altAIThrottleLimit(driver, upcomingTurn)
	if upcomingTurn.x > 50 then
		return math.applyLag(driver.aiThrottleLimit, 1, 0.99, ac.getScriptDeltaT())
	else
		return math.applyLag(driver.aiThrottleLimit, driver.aiThrottleLimitBase, 0.96, ac.getScriptDeltaT())
	end
end

--- Variable aggression function for AI drivers
--- @param driver Driver
function ai.alternateLevel(driver)
	local upcomingTurn = ac.getTrackUpcomingTurn(driver.index)

	local aiAggression = altAIAggression(driver, upcomingTurn)
	driver.aiBrakeHint = altAIBrakeHint(driver, upcomingTurn)
	driver.aiThrottleLimit = altAIThrottleLimit(driver, upcomingTurn)

	physics.setAIAggression(driver.index, aiAggression)
	physics.setAIThrottleLimit(driver.index, driver.aiThrottleLimit)

	if ac.getPatchVersionCode() >= 2278 then
		physics.setAIBrakeHint(driver.index, driver.aiBrakeHint)
	end
end

local function mgukBuild(driver)
	if driver.aiMgukDelivery ~= 1 then
		driver.aiMgukDelivery = 1
		physics.setMGUKDelivery(driver.index, driver.aiMgukDelivery)
	end

	if driver.aiMgukRecovery ~= 10 then
		driver.aiMgukRecovery = 10
		physics.setMGUKRecovery(driver.index, driver.aiMgukRecovery)
	end
end

local function mgukLow(driver)
	if driver.aiMgukDelivery ~= 2 then
		driver.aiMgukDelivery = 2
		physics.setMGUKDelivery(driver.index, driver.aiMgukDelivery)
	end

	-- driver.car.kersCurrentKJ
	if driver.car.kersCharge > 0.8 then
		if driver.aiMgukRecovery ~= 0 then
			driver.aiMgukRecovery = 0
			physics.setMGUKRecovery(driver.index, driver.aiMgukRecovery)
		end
	elseif driver.car.kersCharge > 0.15 then
		if driver.aiMgukRecovery ~= 7 then
			driver.aiMgukRecovery = 7
			physics.setMGUKRecovery(driver.index, driver.aiMgukRecovery)
		end
	else
		mgukBuild(driver)
	end
end

local function mgukBalanced(driver)
	if driver.aiMgukDelivery ~= 3 then
		driver.aiMgukDelivery = 3
		physics.setMGUKDelivery(driver.index, driver.aiMgukDelivery)
	end

	-- driver.car.kersCurrentKJ
	if driver.car.kersCharge > 0.8 then
		if driver.aiMgukRecovery ~= 0 then
			driver.aiMgukRecovery = 0
			physics.setMGUKRecovery(driver.index, driver.aiMgukRecovery)
		end
	elseif driver.car.kersCharge > 0.25 then
		if driver.aiMgukRecovery ~= 7 then
			driver.aiMgukRecovery = 7
			physics.setMGUKRecovery(driver.index, driver.aiMgukRecovery)
		end
	else
		mgukLow(driver)
	end
end

local function mgukHigh(driver)
	if driver.aiMgukDelivery ~= 4 then
		driver.aiMgukDelivery = 4
		physics.setMGUKDelivery(driver.index, driver.aiMgukDelivery)
	end

	-- driver.car.kersCurrentKJ
	if driver.car.kersCharge > 0.8 then
		if driver.aiMgukRecovery ~= 0 then
			driver.aiMgukRecovery = 0
			physics.setMGUKRecovery(driver.index, driver.aiMgukRecovery)
		end
	elseif driver.car.kersCharge > 0.45 then
		if driver.aiMgukRecovery ~= 7 then
			driver.aiMgukRecovery = 7
			physics.setMGUKRecovery(driver.index, driver.aiMgukRecovery)
		end
	else
		mgukBalanced(driver)
	end
end

local function mgukAttack(driver)
	if driver.aiMgukDelivery ~= 5 then
		driver.aiMgukDelivery = 5
		physics.setMGUKDelivery(driver.index, driver.aiMgukDelivery)
	end

	if driver.aiMgukRecovery ~= 0 then
		driver.aiMgukRecovery = 0
		physics.setMGUKRecovery(driver.index, driver.aiMgukRecovery)
	end
end

function ai.mgukController(driver)
	if driver.carAheadDelta < 0.5 and driver.car.kersCharge > 0.25 then
		mgukAttack(driver)
	elseif driver.carAheadDelta < 1.5 then
		mgukHigh(driver)
	else
		mgukBalanced(driver)
	end
end

function ai.tyreWarmup(driver, turnDistance)
	if driver.isReturningPosition or driver.isRetakingPosition then
		return
	end

	if turnDistance > 150 then
		local target = 0
		if driver.isWarmingRight then
			target = 3
			driver.isWarmingLeft = false
			driver.aiSplineOffset = driver.aiSplineOffset + 0.1
		elseif driver.isWarmingLeft then
			target = -3
			driver.isWarmingRight = false
			driver.aiSplineOffset = driver.aiSplineOffset - 0.1
		else
			target = math.random(0, 1) == 1 and 3 or -3
			driver.isWarmingRight = target == 3 and true or false
			driver.isWarmingLeft = target == 3 and false or true
		end

		if driver.aiSplineOffset >= 2 then
			driver.isWarmingRight = false
			driver.isWarmingLeft = true
		elseif driver.aiSplineOffset <= -2 then
			driver.isWarmingRight = true
			driver.isWarmingLeft = false
		end

		driver.isWarmingTyres = true
	else
		driver.aiSplineOffset = 0
		driver.isWarmingTyres = false
		driver.isWarmingRight = false
		driver.isWarmingLeft = false
	end

	physics.setAISplineOffset(driver.index, driver.aiSplineOffset)
end

function ai.speedControl(driver, speed, splineDelta, turnDistance)
	if driver.startingGridRacePosition == 1 then
		speed = 200
	else
		if driver.carAheadDelta > 10 then
			speed = speed + 40
		elseif driver.carAheadDelta > 5.5 then
			speed = speed + 30
		elseif driver.carAheadDelta > 3.5 then
			speed = speed + 20
		elseif driver.carAheadDelta > 1.5 then
			speed = speed + 10
		elseif driver.carAheadDelta < 0.25 then
			speed = speed - 40
		elseif driver.carAheadDelta < 0.50 then
			speed = speed - 30
		elseif driver.carAheadDelta < 0.75 then
			speed = speed - 20
		elseif driver.carAheadDelta < 1 then
			speed = speed - 15
		end
	end

	if driver.isAligningToGrid then
		if splineDelta < 0.01 then
			speed = 5
		elseif splineDelta < 0.02 then
			speed = 10
		elseif splineDelta < 0.03 then
			speed = 20
		elseif splineDelta < 0.05 then
			speed = 50
		elseif splineDelta < 0.1 then
			speed = 100
		elseif splineDelta < 0.15 then
			driver.aiSplineOffset = 0
		end
	else
		if driver.car.racePosition > driver.startingGridRacePosition then
			speed = 195 + 10
		elseif driver.car.racePosition < driver.startingGridRacePosition then
			speed = 195 - 40
		end
	end

	physics.setAITopSpeed(driver.index, speed)
	physics.setAIAggression(driver.index, 0)
end

function ai.parkOnGrid(driver, connection, splineDelta)
	if not driver.isParkingOnGrid and splineDelta < 0.0005 then
		driver.isParkingOnGrid = true
		connection.brake = true
		physics.setAITopSpeed(driver.index, 0)
		physics.setAIAggression(driver.index, 1)
	end

	if splineDelta < 0.002 then
		connection.steerLock = true
	end
end

function ai.alignToGrid(driver, connection, sideDelta, splineDelta)
	physics.setCarCollisions(driver.index, false)

	if sideDelta > 0 then
		driver.aiSplineOffset = math.clamp(driver.aiSplineOffset + 0.01, 0, 10)
	elseif sideDelta < 0 then
		driver.aiSplineOffset = math.clamp(driver.aiSplineOffset - 0.01, 0, 10)
	end
	physics.setAISplineOffset(driver.index, driver.aiSplineOffset)

	ai.parkOnGrid(driver, connection, splineDelta)
end

function ai.releaseAlignToGrid(driver, connection)
	connection.brake = false
	connection.steerLock = false

	if not driver.isWarmingTyres then
		driver.aiSplineOffset = 0
		physics.setAISplineOffset(driver.index, driver.aiSplineOffset)
	end
end

function ai.standingStart(driver, connection, speed, sideDelta, splineDelta, sidePos, turnDistance)
	ai.speedControl(driver, speed, splineDelta, turnDistance)
	ai.tyreWarmup(driver, turnDistance)

	if driver.isAligningToGrid then
		ai.alignToGrid(driver, connection, sideDelta, splineDelta)
	elseif not driver.isAligningToGrid then
		ai.releaseAlignToGrid(driver, connection)
	end
end

function ai.rollingStart() end

function ai.runFormationLap(driver, connection)
	local speed = 180
	local sidePos = ac.worldCoordinateToTrack(driver.car.position).x
	local splineDelta = math.abs(driver.startingGridSplinePosition - driver.car.splinePosition)
	local sideDelta = math.abs(math.round(sidePos - driver.startingGridSideline, 1))
	local turnDistance = ac.getTrackUpcomingTurn(driver.index).x

	if true then
		ai.standingStart(driver, connection, speed, sideDelta, splineDelta, sidePos, turnDistance)
	else
		ai.rollingStart()
	end
end

function ai.controller(raceRules, aiRules, driver)
	local connection = ac.connect({
		ac.StructItem.key("ext_car_" .. driver.car.index),
		brake = ac.StructItem.boolean(),
		steerLock = ac.StructItem.boolean(),
		brakeBiasBase = ac.StructItem.float(),
		brakeBiasFine = ac.StructItem.float(),
		brakeMigration = ac.StructItem.float(),
		brakeMigrationRamp = ac.StructItem.float(),
		diffEntry = ac.StructItem.float(),
		diffMid = ac.StructItem.float(),
		diffHispd = ac.StructItem.float(),
	}, true, ac.SharedNamespace.CarScript)

	if true then
		ai.runFormationLap(driver, connection)
	else
		if aiRules.AI_FORCE_PIT_TYRES == 1 then
			ai.pitNewTyres(raceRules, driver)
		end
		if aiRules.AI_ALTERNATE_LEVEL == 1 then
			ai.alternateLevel(driver)
		end
		if aiRules.AI_MGUK_CONTROL == 1 and ac.getPatchVersionCode() >= 2555 then
			ai.mgukController(driver)
		end
	end
end

return ai
