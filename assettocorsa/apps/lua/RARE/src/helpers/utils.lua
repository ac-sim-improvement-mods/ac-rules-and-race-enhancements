local utils = {}

--- Log messages
--- @param message string
function log(message)
	ac.log("[RARE] " .. message)
end

function utils.randomizer(index, range)
	math.randomseed(os.clock() + index)
	math.random()
	return math.random(-range, range)
end

--- Lines up bullet text label with text
--- @param label string
--- @param text string
--- @param space number
function utils.inLineBulletText(label, text, space)
	if not space then
		space = 10
	end

	local driver = DRIVERS[ac.getSim().focusedCar]
	ui.bulletText(label)
	ui.sameLine(space, 0)
	if text == "TRUE" then
		ui.textColored(text, rgbm(0, 1, 0, 1))
	elseif text == "FALSE" then
		ui.textColored(text, rgbm(1, 0, 0, 1))
	elseif label == "Delta" then
		if text == "---" then
			ui.textColored("---", rgbm(1, 1, 1, 1))
		elseif text <= RARECONFIG.data.RULES.DRS_GAP_DELTA / 1000 and text > 0 then
			ui.textColored(text, rgbm(0, 1, 0, 1))
		else
			ui.textColored(text, rgbm(1, 0, 0, 1))
		end
	elseif string.find(label, "Tyre Life") and not string.find(label, "Limit") then
		if
			text < RARECONFIG.data.AI.AI_SINGLE_TYRE_LIFE + driver.aiTyreSingleRandom
			or (string.find(label, "Average") and text < RARECONFIG.data.AI.AI_AVG_TYRE_LIFE + driver.aiTyreAvgRandom)
		then
			ui.textColored(text .. " %", rgbm(1, 0, 0, 1))
		elseif text < RARECONFIG.data.AI.AI_AVG_TYRE_LIFE + driver.aiTyreAvgRandom then
			ui.textColored(text .. " %", rgbm(1, 1, 0, 1))
		else
			ui.textColored(text .. " %", rgbm(1, 1, 1, 1))
		end
	else
		ui.text(text)
	end
end

--- Converts boolean to uppercase string
---@param bool boolean
---@return string
function utils.upperBool(bool)
	return string.upper(tostring(bool))
end

--- Returns average number of a table
---@param t Table
---@return average number
function math.average(t)
	local sum = 0
	for _, v in pairs(t) do -- Get the sum of all numbers in t
		sum = sum + v
	end
	return sum / #t
end

--- Returns state of installed CSP version being compatible with this app
--- @return boolean
function utils.compatibleCspVersion()
	return ac.getPatchVersionCode() >= CSP_MIN_VERSION_CODE and true or false
end

function utils.resetTrackSurfaces()
	-- local config = ac.INIConfig.load(ac.getFolder(ac.FolderID.ACApps) .. "/lua/RARE/settings.ini", ac.INIFormat.Default)
	-- local surfacesFile = ac.getTrackDataFilename("surfaces.ini")
	-- local surfacesFileBackup = ac.getTrackDataFilename("_surfaces.ini")
	-- if physics.allowed() then
	-- 	if config:get("MISC", "PHYSICS_REBOOT", 1) == 0 then
	-- 		if io.fileExists(surfacesFileBackup) then
	-- 			io.deleteFile(surfacesFile)
	-- 			io.copyFile(surfacesFileBackup, surfacesFile, false)
	-- 			REBOOT = true
	-- 		end
	-- 	else
	-- 		RARECONFIG.data.MISC.PHYSICS_REBOOT = 0
	-- 		config:setAndSave("MISC", "PHYSICS_REBOOT", 0)
	-- 		resetTrackSurfaces()
	-- 	end
	-- end
end

local function editUiFIle(inputFile)
	local file = io.open(inputFile, "r")
	local fileContent = {}
	for line in file:lines() do
		table.insert(fileContent, line)
	end
	io.close(file)

	fileContent[2] = "\t" .. '"name": "' .. ac.getTrackName() .. ' RARE",'

	file = io.open(inputFile, "w")
	for index, value in ipairs(fileContent) do
		file:write(value .. "\n")
	end
	io.close(file)
end

local trackLayout = ac.getTrackLayout() ~= "" and ac.getTrackLayout() or ac.getTrackID()
local trackDir = ac.getFolder(ac.FolderID.ContentTracks) .. "\\" .. ac.getTrackID()
local currentTrackLayoutDir = trackDir .. "\\" .. trackLayout
local rareTrackLayoutDir = trackDir .. "\\" .. trackLayout .. "_rare"
local currentTrackUIDir = trackDir .. "\\ui\\" .. trackLayout
local rareTrackUIDir = trackDir .. "\\ui\\" .. trackLayout .. "_rare"

function utils.createRareTrackConfig()
	if trackLayout == ac.getTrackID() then
		currentTrackLayoutDir = trackDir
		currentTrackUIDir = trackDir .. "\\ui"

		io.copyFile(
			trackDir .. "\\" .. trackLayout .. ".vao-patch",
			trackDir .. "\\" .. trackLayout .. "_rare.vao-patch",
			true
		)

		if not io.fileExists(trackDir .. "\\models.ini") then
			io.save(trackDir .. "\\models_" .. trackLayout .. "_rare.ini")
			local modelIni = ac.INIConfig.load(trackDir .. "\\models_" .. trackLayout .. "_rare.ini")
			modelIni:setAndSave("MODEL_0", "FILE", trackLayout .. ".kn5")
			modelIni:setAndSave("MODEL_0", "POSITION", "0,0,0")
			modelIni:setAndSave("MODEL_0", "ROTATION", "0,0,0")
		end

		io.copyFile(trackDir .. "\\models.ini", trackDir .. "\\models_" .. trackLayout .. "_rare.ini", true)
		io.copyFile(trackDir .. "\\models.vao-patch", trackDir .. "\\models_" .. trackLayout .. "_rare.vao-patch", true)
	else
		io.copyFile(
			trackDir .. "\\models_" .. trackLayout .. ".ini",
			trackDir .. "\\models_" .. trackLayout .. "_rare.ini",
			true
		)

		io.copyFile(
			trackDir .. "\\models_" .. trackLayout .. ".vao-patch",
			trackDir .. "\\models_" .. trackLayout .. "_rare.vao-patch",
			true
		)
	end

	io.createDir(rareTrackLayoutDir)

	io.createDir(rareTrackLayoutDir .. "\\ai")
	io.scanDir(currentTrackLayoutDir .. "\\ai", function(fileName)
		io.copyFile(currentTrackLayoutDir .. "\\ai\\" .. fileName, rareTrackLayoutDir .. "\\ai\\" .. fileName)
	end)

	io.createDir(rareTrackLayoutDir .. "\\data")
	io.scanDir(currentTrackLayoutDir .. "\\data", function(fileName)
		io.copyFile(currentTrackLayoutDir .. "\\data\\" .. fileName, rareTrackLayoutDir .. "\\data\\" .. fileName)
	end)

	if io.dirExists(currentTrackLayoutDir .. "\\extension") then
		io.createDir(rareTrackLayoutDir .. "\\extension")
		io.scanDir(currentTrackLayoutDir .. "\\extension", function(fileName)
			io.copyFile(
				currentTrackLayoutDir .. "\\extension\\" .. fileName,
				rareTrackLayoutDir .. "\\extension\\" .. fileName
			)
		end)
	end

	io.copyFile(currentTrackLayoutDir .. "\\map.png", rareTrackLayoutDir .. "\\map.png")

	io.createDir(rareTrackUIDir)
	io.deleteFile(rareTrackUIDir .. "\\outline.png")
	io.scanDir(currentTrackUIDir, function(fileName)
		io.copyFile(currentTrackUIDir .. "\\" .. fileName, rareTrackUIDir .. "\\" .. fileName)
	end)

	editUiFIle(rareTrackUIDir .. "\\ui_track.json")
end

function utils.setPhysicsAllowed()
	local surfacesFile = rareTrackLayoutDir .. "\\data\\surfaces.ini"
	local surfacesIni = ac.INIConfig.load(surfacesFile, ac.INIFormat.Default)

	surfacesIni:setAndSave("SURFACE_0", "WAV_PITCH", "extended-0")
	surfacesIni:setAndSave("_SCRIPTING_PHYSICS", "ALLOW_APPS", "1")
end

function utils.injectRare()
	if not physics.allowed() then
		if string.find(currentTrackLayoutDir, "_rare") then
			return
		else
			utils.createRareTrackConfig()
		end
		utils.setPhysicsAllowed()
		local rareLayout = "[RACE]"
			.. "\nCONFIG_TRACK="
			.. (ac.getTrackLayout() ~= "" and ac.getTrackLayout() or ac.getTrackID())
			.. "_rare"
		ac.restartAssettoCorsa(rareLayout)
	end
end

return utils
