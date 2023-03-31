--- Log messages
--- @param message string
function log(message)
	ac.log("[RARE] " .. message)
end

function randomizer(index, range)
	math.randomseed(os.clock() * index)
	math.random()
	for i = 0, math.random(index) do
		math.random()
	end
	return math.random(-range, range)
end

--- Lines up bullet text label with text
--- @param label string
--- @param text string
--- @param space number
function inLineBulletText(label, text, space)
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
function upperBool(bool)
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

---@param MappedConfig
---@param filename string
---@param ini ac.INIConfig
---@param data table
---@param original table
---@param map table
MappedConfig = class("MappedConfig", function(filename, map)
	local ini = ac.INIConfig.load(filename)
	local data = ini:mapConfig(map)
	local key = "app.RARE:" .. filename
	-- local original = stringify.tryParse(ac.load(key))
	local original = nil -- TODO: REMOVE THIS LINE
	if not original then
		ac.store(key, stringify(data))
		original = stringify.parse(stringify(data))
	end
	return {
		filename = filename,
		ini = ini,
		map = map,
		data = data,
		original = original,
	}
end, class.NoInitialize)

function MappedConfig:reload()
	self.ini = ac.INIConfig.load(self.filename) or self.ini
	self.data = self.ini:mapConfig(self.map)
end

---@param section string
---@param key string
---@param value number|boolean
function MappedConfig:set(section, key, value, hexFormat)
	if not self.data[section] then
		self.data[section] = {}
	end
	if type(value) == "number" and not (value > -1e9 and value < 1e9) then
		error("Sanity check failed: " .. tostring(value))
	end
	if self.data[section][key] == value then
		return
	end
	self.data[section][key] = value
	setTimeout(function()
		log("Saving updated [" .. section .. "][" .. key .. "]: " .. tostring(value))
		self.ini:setAndSave(
			section,
			key,
			hexFormat and string.format("0x%x", self.data[section][key]) or self.data[section][key]
		)
	end, 0.02, section .. key)
end

---@param cfg MappedConfig
---@param section string
---@param key string
---@param from number
---@param to number
---@param mult number
---@param format string
---@param tooltip string?
function slider(cfg, section, key, from, to, mult, isbool, format, tooltip, preprocess)
	if not cfg.data[section] then
		error("No such section: " .. section, 2)
	end
	if not cfg.data[section][key] then
		error("No such key: " .. key, 2)
	end
	ui.setNextItemWidth(ui.windowWidth() - 75)
	local curValue = ui.slider(
		"##" .. section .. key,
		mult < 0 and -mult / cfg.data[section][key] or cfg.data[section][key] * mult,
		from,
		to,
		format
	)
	if tooltip and (ui.itemHovered() or ui.itemActive()) then
		(type(tooltip) == "function" and ui.tooltip or ui.setTooltip)(tooltip)
	end
	if preprocess then
		curValue = preprocess(curValue)
	end
	ui.sameLine(0, 4)
	local changed = math.abs(cfg.original[section][key] - (mult < 0 and -mult / curValue or curValue / mult)) > 0.0001
	if ui.button("##r" .. section .. key, vec2(20, 20), changed and ui.ButtonFlags.None or ui.ButtonFlags.Disabled) then
		if isbool then
			curValue = cfg.original[section][key]
		else
			curValue = mult < 0 and -mult / cfg.original[section][key] or cfg.original[section][key] * mult
		end
	end
	ui.addIcon(ui.Icons.Restart, 10, 0.5, nil, 0)
	if ui.itemHovered() then
		local v = ""
		if isbool then
			v = cfg.original[section][key] == 1 and "ENABLED" or "DISABLED"
		else
			v = string.format(
				format:match("%%.+"),
				mult < 0 and -mult / cfg.original[section][key] or cfg.original[section][key] * mult
			)
		end
		ui.setTooltip(string.format(changed and "Click to restore original value: %s" or "Original value: %s", v))
	end
	cfg:set(section, key, curValue, false)

	return curValue
end

--- Returns state of installed CSP version being compatible with this app
--- @return boolean
function compatibleCspVersion()
	return ac.getPatchVersionCode() >= CSP_MIN_VERSION_CODE and true or false
end

function resetTrackSurfaces()
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

local trackDir = ac.getFolder(ac.FolderID.ContentTracks) .. "\\" .. ac.getTrackID()
local currentTrackLayoutDir = trackDir .. "\\" .. ac.getTrackLayout()
local rareTrackLayoutDir = trackDir .. "\\" .. ac.getTrackLayout() .. "_rare"
local currentTrackLayoutUIDir = trackDir .. "\\ui\\" .. ac.getTrackLayout()
local rareTrackLayoutUIDir = trackDir .. "\\ui\\" .. ac.getTrackLayout() .. "_rare"
local currentTrackModels = trackDir .. "\\models_" .. ac.getTrackLayout() .. ".ini"
local rareTrackModels = trackDir .. "\\models_" .. ac.getTrackLayout() .. "_rare.ini"

function createRareTrackConfig()
	local roboargs = " /E /COPY:DAT /DCOPY:DAT /R:10 /W:3"

	log("Checking for _rare layout")
	if ac.getTrackLayout() ~= "" then
		if not string.find(currentTrackLayoutDir, "_rare") then
			log("Current track layout is not _rare")
			if not io.dirExists(rareTrackLayoutDir) then
				log("Created RARE track layout directory")

				os.execute("robocopy " .. currentTrackLayoutDir .. " " .. rareTrackLayoutDir .. roboargs, 30000, true)
				os.execute(
					"robocopy " .. currentTrackLayoutUIDir .. " " .. rareTrackLayoutUIDir .. roboargs,
					30000,
					true
				)
				io.copyFile(currentTrackModels, rareTrackModels, true)

				setTimeout(function()
					ac.log(ac.getFolder(ac.FolderID.ACApps) .. "\\lua\\rare\\icon.png")
					ac.log(rareTrackLayoutUIDir .. "\\outline.png")
					io.deleteFile(rareTrackLayoutUIDir .. "\\outline.png")
					io.copyFile(
						ac.getFolder(ac.FolderID.ACApps) .. "\\lua\\rare\\icon.png",
						rareTrackLayoutUIDir .. "\\outline.png"
					)
				end, 2, "png")
			end
		end
	else
		log("Created RARE track layout directory")
		local currentTrackLayoutUIDir = trackDir .. "\\ui"
		rareTrackLayoutDir = trackDir .. "\\" .. ac.getTrackID() .. "_rare"

		os.execute(
			"robocopy "
				.. currentTrackLayoutDir
				.. "\\data"
				.. " "
				.. currentTrackLayoutDir
				.. "\\"
				.. ac.getTrackID()
				.. "\\data"
				.. " /E /MOVE /R:10 /W:3",
			30000,
			true
		)
		os.execute(
			"robocopy "
				.. currentTrackLayoutDir
				.. "\\ai"
				.. " "
				.. currentTrackLayoutDir
				.. "\\"
				.. ac.getTrackID()
				.. "\\ai"
				.. " /E /MOVE /R:10 /W:3",
			30000,
			true
		)
		io.copyFile(
			currentTrackLayoutDir .. "\\map.png",
			currentTrackLayoutDir .. "\\" .. ac.getTrackID() .. "\\map.png",
			true
		)

		os.execute(
			"robocopy "
				.. currentTrackLayoutDir
				.. "\\"
				.. ac.getTrackID()
				.. " "
				.. currentTrackLayoutDir
				.. "\\"
				.. ac.getTrackID()
				.. "_rare"
				.. roboargs,
			30000,
			true
		)

		io.copyFile(currentTrackLayoutDir .. "\\map.png", rareTrackLayoutDir .. "\\map.png", true)

		os.execute(
			"robocopy "
				.. currentTrackLayoutUIDir
				.. " "
				.. currentTrackLayoutUIDir
				.. "\\"
				.. ac.getTrackID()
				.. " /MOV /R:10 /W:3",
			30000,
			true
		)

		os.execute(
			"robocopy "
				.. currentTrackLayoutUIDir
				.. "\\"
				.. ac.getTrackID()
				.. " "
				.. currentTrackLayoutUIDir
				.. "\\"
				.. ac.getTrackID()
				.. "_rare"
				.. roboargs,
			30000,
			true
		)
		io.copyFile(trackDir .. "\\models.ini", trackDir .. "\\models_" .. ac.getTrackID() .. "_rare.ini", true)
	end
end

function setPhysicsAllowed()
	local surfacesFile = rareTrackLayoutDir .. "\\data\\surfaces.ini"
	local surfacesIni = ac.INIConfig.load(surfacesFile, ac.INIFormat.Default)

	surfacesIni:setAndSave("SURFACE_0", "WAV_PITCH", "extended-0")
	surfacesIni:setAndSave("_SCRIPTING_PHYSICS", "ALLOW_APPS", "1")
end
