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
		local storeKey = "app.RARE:" .. self.filename
		ac.store(storeKey, stringify(self.data))
	end, 0.02, section .. key)
end
