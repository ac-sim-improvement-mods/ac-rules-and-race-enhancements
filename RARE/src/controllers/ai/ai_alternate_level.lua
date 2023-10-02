local ai_alternate_level = {}

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
	local brakeHint = driver.aiBrakeHintBase
	local brakeHintDive = brakeHint - (brakeHint * 0.05)
	local brakeHintNormal = brakeHint
	local attemptDiveOvertake = upcomingTurn.x > 150 and delta < 0.2

	if attemptDiveOvertake then
		return brakeHintDive
	else
		return brakeHintNormal
	end
end

local function altAIThrottleLimit(driver, upcomingTurn)
	if upcomingTurn.x > 50 then
		return math.applyLag(driver.aiThrottleLimit, 1, 0.99, ac.getScriptDeltaT())
	else
		return math.applyLag(driver.aiThrottleLimit, driver.aiThrottleLimitBase, 0.96, ac.getScriptDeltaT())
	end
end

local function altAICaution(driver, upcomingTurn)
	local delta = driver.carAheadDelta
	local safeMoveOnStraight = upcomingTurn.x > 150 and delta <= 0.3 and delta > 0.15
	local safeMoveSlowTurns = driver.car.speedKmh < 150 and delta <= 0.5 and delta > 0.3

	if safeMoveOnStraight or safeMoveSlowTurns then
		return 0
	else
		return 1
	end
end

local function alignCarAhead(driver, upcomingTurn)
	local delta = driver.carAheadDelta
	local splineSides = ac.getTrackAISplineSides(driver.car.splinePosition)
	local splineSidesAhead = ac.getTrackAISplineSides(DRIVERS[driver.carAhead].car.splinePosition)
	local splineSideDelta = splineSides - splineSidesAhead

	if upcomingTurn.x > 200 and delta <= 0.4 and delta > 0.15 then
		if splineSideDelta > 0 then
			return math.clamp(driver.aiSplineOffset + 0.05, -5, 5)
		elseif splineSideDelta < 0 then
			return math.clamp(driver.aiSplineOffset - 0.05, -5, 5)
		end
	else
		return 0
	end
end

local function altAIGasBrakeLookAhead(driver, upcomingTurn)
	return 0
end

--- Variable aggression function for AI drivers
--- @param driver Driver
function ai_alternate_level.run(driver)
	if driver.car.isInPitlane then
		return
	end

	local upcomingTurn = ac.getTrackUpcomingTurn(driver.index)

	local aiAggression = altAIAggression(driver, upcomingTurn)
	driver.aiBrakeHint = altAIBrakeHint(driver, upcomingTurn)
	driver.aiThrottleLimit = altAIThrottleLimit(driver, upcomingTurn)
	driver.aiCaution = altAICaution(driver, upcomingTurn)
	driver.aiSplineOffset = alignCarAhead(driver, upcomingTurn)
	driver.aiGasBrakeLookAhead = altAIGasBrakeLookAhead(driver, upcomingTurn)

	physics.setAIAggression(driver.index, aiAggression)
	physics.setAIThrottleLimit(driver.index, driver.aiThrottleLimit)

	if ac.getPatchVersionCode() >= 2363 then
		physics.setAICaution(driver.index, driver.aiCaution)
		physics.setAISplineOffset(driver.index, driver.aiSplineOffset, driver.aiCaution == 0)
		physics.setAIBrakeHint(driver.index, driver.aiBrakeHint)
		-- physics.setAILookaheadGasBrake(driver.index, driver.aiGasBrakeLookAhead)
	end
end

return ai_alternate_level
