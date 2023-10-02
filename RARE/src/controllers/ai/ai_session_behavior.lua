local ai_session_behavior = {}

---@alias ai.QualifyLap
---| `ai.QualifyLap.OutLap` @Value: 0.
---| `ai.QualifyLap.FlyingLap` @Value: 1.
---| `ai.QualifyLap.InLap` @Value: 2.
ai_session_behavior.QualifyLap = { OutLap = 0, FlyingLap = 1, InLap = 2 }

local function moveOffRacingLine(driver)
	-- local delta = driver.carAheadDelta
	-- local driverAhead = DRIVERS[driver.carAhead]
	-- local splineSideLeft = ac.getTrackAISplineSides(driverAhead.splinePosition).x
	-- local splineSideRight = ac.getTrackAISplineSides(driverAhead.splinePosition).y
	-- local offset = splineSideLeft > splineSideLeft and -3 or 3

	-- if not driverAhead.isOnFlyingLap then
	-- 	if delta < 2 and delta > 0.1 then
	-- 		if driverAhead.car.isInPitlane then
	-- 			physics.setAITopSpeed(driverAhead.index, 0)
	-- 		else
	-- 			if ac.getTrackUpcomingTurn(driverAhead.index).x > 100 then
	-- 				physics.setAISplineOffset(driverAhead.index, math.lerp(0, offset, driverAhead.aiSplineOffset))
	-- 				physics.setAISplineOffset(driver.index, math.lerp(0, -offset, driver.aiSplineOffset))
	-- 				physics.setAITopSpeed(driverAhead.index, 200)
	-- 				driverAhead.isAIMoveAside = true
	-- 				driverAhead.isAISpeedUp = false
	-- 			else
	-- 				driverAhead.aiSplineOffset = math.lerp(offset, 0, driverAhead.aiSplineOffset)
	-- 				driver.aiSplineOffset = math.lerp(-offset, 0, driver.aiSplineOffset)
	-- 				physics.setAISplineOffset(driverAhead.index, driverAhead.aiSplineOffset)
	-- 				physics.setAISplineOffset(driver.index, driver.aiSplineOffset)
	-- 				physics.setAITopSpeed(driverAhead.index, 1e9)
	-- 				driverAhead.isAIMoveAside = false
	-- 				driverAhead.isAISpeedUp = true
	-- 			end
	-- 		end
	-- 	else
	-- 		driverAhead.aiSplineOffset = math.lerp(offset, 0, driverAhead.aiSplineOffset)
	-- 		driver.aiSplineOffset = math.lerp(-offset, 0, driver.aiSplineOffset)
	-- 		physics.setAISplineOffset(driverAhead.index, driverAhead.aiSplineOffset)
	-- 		physics.setAISplineOffset(driver.index, driver.aiSplineOffset)
	-- 		driverAhead.isAIMoveAside = false
	-- 		driverAhead.isAISpeedUp = false
	-- 	end
	-- end
end

function ai_session_behavior.practice(racecontrol, driver)
	if driver.car.isInPitlane then
		if driver.car.drsActive then
			physics.setCarDRS(driver.index, false)
		end
	end
end

function ai_session_behavior.qualifying(racecontrol, driver)
	if racecontrol.sim.sessionTimeLeft <= 3000 then
		physics.setAIPitStopRequest(driver.index, false)
	end

	if driver.car.isInPitlane then
		physics.allowCarDRS(driver.index, false)
		driver.tyreCompoundStart = driver.tyreCompoundsAvailable[1]
		driver.tyreCompoundNext = driver.tyreCompoundsAvailable[1]

		if driver.car.isInPit then
			if driver.car.compoundIndex ~= driver.tyreCompoundsAvailable[1] then
				driver:setAITyreCompound(driver.tyreCompoundsAvailable[1])
			end
			driver:setFuelTankQuali()
			physics.setAIPitStopRequest(driver.index, false)
		end
		driver.isOnInLap = false
		driver.isOnFlyingLap = false
		driver.isOnOutlap = true
	else
		if driver.isOnFlyingLap then
			moveOffRacingLine(driver)
			physics.setAILevel(driver.index, driver.aiLevelRelative)
			physics.setAIAggression(driver.index, 1)

			if driver.car.lapCount >= driver.inLap then
				driver.isOnOutlap = false
				driver.isOnFlyingLap = false
				driver.isOnInLap = true
			end
		elseif driver.isOnOutlap then
			if driver.car.splinePosition <= 0.8 then
				if not driver.isAIMoveAside and not driver.isAISpeedUp then
					physics.setAITopSpeed(driver.index, 250)
					physics.setAILevel(driver.index, 0.8)
					physics.setAIAggression(driver.index, 0)
					physics.allowCarDRS(driver.index, true)

					if driver.carAheadDelta < 5 then
						physics.setAITopSpeed(driver.index, 200)
					end
				elseif driver.isAISpeedUp then
					moveOffRacingLine(driver)
				end
			else
				physics.setAITopSpeed(driver.index, 1e9)
				physics.setAILevel(driver.index, 1)
				physics.setAIAggression(driver.index, 1)
				physics.allowCarDRS(driver.index, false)
				driver.isOnOutlap = false
				driver.isOnFlyingLap = true
				driver.inLap = driver.car.lapCount + 2
			end
		elseif driver.isOnInLap then
			if not driver.isAIMoveAside and not driver.isAISpeedUp then
				physics.setAITopSpeed(driver.index, 200)
				physics.setAILevel(driver.index, 0.65)
				physics.setAIAggression(driver.index, 0)
			elseif driver.isAISpeedUp then
				moveOffRacingLine(driver)
			end
		end
	end
end

return ai_session_behavior
