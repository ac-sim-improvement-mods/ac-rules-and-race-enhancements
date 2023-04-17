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

		if tonumber(driver.tyreCompoundsAvailable[1]) == driverCompound then
			compoundHardness = driver.tyreCompoundSoftTexture
		elseif tonumber(driver.tyreCompoundsAvailable[2]) == driverCompound then
			compoundHardness = driver.tyreCompoundMediumTexture
		elseif tonumber(driver.tyreCompoundsAvailable[3]) == driverCompound then
			compoundHardness = driver.tyreCompoundHardTexture
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

local function restrictCompoundChoice()
	local driver = DRIVERS[0]
	local compoundCount = #driver.tyreCompoundsAvailable
	if compoundCount > 1 then
		if driver.car.compoundIndex < tonumber(driver.tyreCompoundsAvailable[1]) then
			ac.setSetupSpinnerValue("COMPOUND", driver.tyreCompoundsAvailable[1])
		elseif driver.car.compoundIndex > tonumber(driver.tyreCompoundsAvailable[compoundCount]) then
			ac.setSetupSpinnerValue("COMPOUND", driver.tyreCompoundsAvailable[compoundCount])
		end
	end
end

function compounds.update(sim)
	if RARECONFIG.data.RULES.RESTRICT_COMPOUNDS == 1 then
		if sim.isInMainMenu then
			restrictCompoundChoice()
		end
	end

	if RARECONFIG.data.RULES.CORRECT_COMPOUNDS_COLORS == 1 then
		if not sim.isSessionStarted and sim.isInMainMenu then
			for i = 0, #DRIVERS do
				local driver = DRIVERS[i]
				setTyreCompoundsColor(driver, 15, true)
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
