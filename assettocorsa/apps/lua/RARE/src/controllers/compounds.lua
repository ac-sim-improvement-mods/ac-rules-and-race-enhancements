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

local previousIndex = 0
local function restrictCompoundChoice()
	local driver = DRIVERS[0]
	local compoundIndex = driver.car.compoundIndex
	local isIndexIncreasing = compoundIndex > previousIndex and true or false
	local validTyreCompoundIndex = table.containsValue(driver.tyreCompoundsAvailable, compoundIndex)

	if not validTyreCompoundIndex then
		ac.log("not valid " .. compoundIndex)
		ac.setSetupSpinnerValue("COMPOUND", compoundIndex + (isIndexIncreasing and 1 or -1))
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
