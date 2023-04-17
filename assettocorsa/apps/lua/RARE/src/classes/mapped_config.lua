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