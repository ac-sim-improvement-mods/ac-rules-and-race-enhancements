local compounds = {}
local driverCompounds = {}

local function setTyreCompoundsColor(driver, time, force)
	local driverCompound = driver.car.compoundIndex

	if (driver.tyreCompoundTextureTimer < os.clock() and driverCompound ~= driverCompounds[driver.index]) or force then
		driver.tyreCompoundTextureTimer = os.clock() + time
	end

	if driver.tyreCompoundTextureTimer >= os.clock() then
		local extensionDir = ac.getFolder(ac.FolderID.ContentCars) .. "/" .. ac.getCarID(driver.index) .. "/extension/"

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
		else
			return
		end

		if compoundHardness == "" then
			return
		end

		local compoundTexture = extensionDir .. compoundHardness .. ".dds"
		local compoundBlurTexture = extensionDir .. compoundHardness .. "_Blur.dds"

		ac.findNodes("carRoot:" .. driver.index)
			:findMeshes("material:" .. driver.tyreCompoundMaterialTarget)
			:setMaterialTexture("txDiffuse", compoundTexture)
		ac.findNodes("carRoot:" .. driver.index)
			:findMeshes("material:" .. driver.tyreCompoundMaterialTarget)
			:setMaterialTexture("txBlur", compoundBlurTexture)

		driverCompounds[driver.index] = driverCompound
	end
end

local previousIndex = 0
local function restrictCompoundChoice()
	local driver = DRIVERS[0]
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

function compounds.update(sim)
	if RARE_CONFIG.data.RULES.RESTRICT_COMPOUNDS == 1 then
		if sim.isInMainMenu then
			restrictCompoundChoice()
		end
	end

	if RARE_CONFIG.data.RULES.CORRECT_COMPOUNDS_COLORS == 1 then
		if sim.isInMainMenu then
			if sim.raceSessionType == 3 and not sim.isSessionStarted then
				for i = 0, #DRIVERS do
					local driver = DRIVERS[i]
					setTyreCompoundsColor(driver, 15, true)
				end
			else
				for i = 0, #DRIVERS do
					local driver = DRIVERS[i]
					setTyreCompoundsColor(driver, 15, true)
				end
			end
		else
			for i = 0, #DRIVERS do
				local driver = DRIVERS[i]
				if driver.car.isInPit then
					setTyreCompoundsColor(driver, 0.2, false)
				end
			end
		end
	end
end

return compounds
