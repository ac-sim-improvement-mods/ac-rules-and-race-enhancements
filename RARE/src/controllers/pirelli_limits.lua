local sim = ac.getSim()
local pirelliLimits = {}

local function setTyreCompoundsColor(driver, force)
	local driverCompound = driver.car.compoundIndex

	local compoundHardness = ""

	if tonumber(driver.tyreCompoundSoft) == driverCompound then
		compoundHardness = driver.tyreCompoundSoftTexture
	elseif tonumber(driver.tyreCompoundMedium) == driverCompound then
		compoundHardness = driver.tyreCompoundMediumTexture
	elseif tonumber(driver.tyreCompoundHard) == driverCompound then
		compoundHardness = driver.tyreCompoundHardTexture
	elseif tonumber(driver.tyreCompoundInter) == driverCompound then
		compoundHardness = driver.tyreCompoundInterTexture
	elseif tonumber(driver.tyreCompoundWet) == driverCompound then
		compoundHardness = driver.tyreCompoundWetTexture
	end

	if compoundHardness == "" or compoundHardness == nil then
		return
	end

	local compoundTexture = driver.extensionDir .. compoundHardness .. ".dds"
	local compoundBlurTexture = driver.extensionDir .. compoundHardness .. "_Blur.dds"

	driver.tyreCompoundNode:setMaterialTexture("txDiffuse", compoundTexture)
	driver.tyreCompoundNode:setMaterialTexture("txBlur", compoundBlurTexture)
end

local previousIndex = 0
local function restrictCompoundChoice(driver)
	local compoundIndex = driver.car.compoundIndex
	local isIndexIncreasing = compoundIndex > previousIndex and true or false
	local validTyreCompoundIndex = table.containsValue(driver.tyreCompoundsAvailable, compoundIndex)

	if not validTyreCompoundIndex then
		local nextValidTyreCompound = math.clamp(
			tonumber(compoundIndex + (isIndexIncreasing and 1 or -1)),
			tonumber(driver.tyreCompoundsAvailable[1]),
			tonumber(driver.tyreCompoundsAvailable[#driver.tyreCompoundsAvailable])
		)
		ac.setSetupSpinnerValue("COMPOUND", nextValidTyreCompound)
	end

	previousIndex = compoundIndex
end

local wheelPostfix = {
	[0] = "LF",
	[1] = "RF",
	[2] = "LR",
	[3] = "RR",
}

local eosCamber = { [0] = 0, [1] = 0, [2] = 0, [3] = 0 }

local infringed = false
local function restrictEOSCamber(driver)
	for i = 0, 1 do
		if driver.car.speedKmh >= 280 and math.abs(driver.car.steer) < 1.5 then
			if driver.car.wheels[i].camber < eosCamber[i] then
				eosCamber[i] = math.applyLag(eosCamber[i], driver.car.wheels[i].camber, 0.98, ac.getScriptDeltaT())
			end
		elseif driver.eosCamberLimitFront <= eosCamber[i] then
			eosCamber[i] = 0
		end
	end

	for i = 2, 3 do
		if driver.car.speedKmh >= 280 and math.abs(driver.car.steer) < 1.5 then
			if driver.car.wheels[i].camber < eosCamber[i] then
				eosCamber[i] = math.applyLag(eosCamber[i], driver.car.wheels[i].camber, 0.98, ac.getScriptDeltaT())
			end
		elseif driver.eosCamberLimitRear <= eosCamber[i] then
			eosCamber[i] = 0
		end
	end

	local infringementString = ""
	for i = 0, 1 do
		if eosCamber[i] < driver.eosCamberLimitFront then
			infringed = true
			infringementString = infringementString
				.. "CAMBER "
				.. wheelPostfix[i]
				.. ": "
				.. math.round(eosCamber[i], 3)
				.. " < "
				.. driver.eosCamberLimitFront

			if i ~= 3 then
				infringementString = infringementString .. "	"
			end
		end
	end

	for i = 2, 3 do
		if eosCamber[i] < driver.eosCamberLimitRear then
			infringed = true
			infringementString = infringementString
				.. "CAMBER "
				.. wheelPostfix[i]
				.. ": "
				.. math.round(eosCamber[i], 3)
				.. " < "
				.. driver.eosCamberLimitRear

			if i ~= 3 then
				infringementString = infringementString .. "	"
			end
		end
	end

	if infringed then
		ac.setSystemMessage("Pirelli EOS Camber Limits Infringed", infringementString)
	end
end

local function restrictStartingTyrePressure(driver)
	for i = 0, 1 do
		if driver.car.wheels[i].tyrePressure < driver.tyreMinimumStartingPressureFront - 0.5 then
			ac.setSetupSpinnerValue(
				"PRESSURE_" .. wheelPostfix[i],
				ac.getSetupSpinnerValue("PRESSURE_" .. wheelPostfix[i]) + 1
			)
		end
	end

	for i = 2, 3 do
		if driver.car.wheels[i].tyrePressure < driver.tyreMinimumStartingPressureRear - 0.5 then
			ac.setSetupSpinnerValue(
				"PRESSURE_" .. wheelPostfix[i],
				ac.getSetupSpinnerValue("PRESSURE_" .. wheelPostfix[i]) + 1
			)
		end
	end
end

function pirelliLimits.update()
	if sim.isOnlineRace or RARE_CONFIG.data.RULES.PIRELLI_LIMITS ~= 1 then
		return
	end

	local driver = DRIVERS[0]

	if sim.isInMainMenu then
		restrictCompoundChoice(driver)
		restrictStartingTyrePressure(driver)
		for i = 0, 3 do
			eosCamber[i] = 0
		end
		infringed = false
	else
		restrictEOSCamber(driver)
	end

	if sim.isInMainMenu then
		for i = 0, #DRIVERS do
			local driver = DRIVERS[i]
			setTyreCompoundsColor(driver, false)
			driver.tyreCompoundTextureIndex = driver.car.compoundIndex
		end
	else
		for i = 0, #DRIVERS do
			local driver = DRIVERS[i]
			if driver.car.isInPit then
				setTyreCompoundsColor(driver, false)
				driver.tyreCompoundTextureIndex = driver.car.compoundIndex
			end
		end
	end
end

return pirelliLimits
