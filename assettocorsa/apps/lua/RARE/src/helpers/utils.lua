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
		elseif text <= RARE_CONFIG.data.RULES.DRS_GAP_DELTA / 1000 and text > 0 then
			ui.textColored(text, rgbm(0, 1, 0, 1))
		else
			ui.textColored(text, rgbm(1, 0, 0, 1))
		end
	elseif string.find(label, "Tyre Life") and not string.find(label, "Limit") then
		if
			text < RARE_CONFIG.data.AI.AI_SINGLE_TYRE_LIFE + driver.aiTyreSingleRandom
			or (string.find(label, "Average") and text < RARE_CONFIG.data.AI.AI_AVG_TYRE_LIFE + driver.aiTyreAvgRandom)
		then
			ui.textColored(text .. " %", rgbm(1, 0, 0, 1))
		elseif text < RARE_CONFIG.data.AI.AI_AVG_TYRE_LIFE + driver.aiTyreAvgRandom then
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

---@param cfg MappedConfig
---@param section string
---@param key string
---@param from number
---@param to number
---@param mult number
---@param format string
---@param tooltip string?
function utils.slider(cfg, section, key, from, to, mult, isbool, format, tooltip, preprocess)
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

return utils
