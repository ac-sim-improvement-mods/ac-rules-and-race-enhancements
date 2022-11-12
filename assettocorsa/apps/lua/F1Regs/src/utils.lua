--- Log messages
--- @param message string
function log(message)
    ac.log("[F1Regs] "..message)
end

--- Lines up bullet text label with text
--- @param label string
--- @param text string
--- @param space number
function inLineBulletText(label,text,space)
    if not space then
        space = 10
    end
    
    local driver = DRIVERS[ac.getSim().focusedCar]
    ui.bulletText(label)
    ui.sameLine(space, 0)
    if text == "TRUE" then
        ui.textColored(text, rgbm(0,1,0,1))
    elseif text == "FALSE" then
        ui.textColored(text, rgbm(1,0,0,1))
    elseif label == "Delta" then
        if text == "---" then
        ui.textColored("---", rgbm(1,1,1,1))
        elseif text <= F1RegsConfig.data.RULES.DRS_GAP_DELTA/1000 and text > 0 then
            ui.textColored(text, rgbm(0,1,0,1))
        else
            ui.textColored(text, rgbm(1,0,0,1))
        end
    elseif string.find(label, "Tyre Life") and not string.find(label, "Limit") then
        if text < F1RegsConfig.data.RULES.AI_SINGLE_TYRE_LIFE + driver.aiTyreSingleRandom or
            (string.find(label, "Average") and text < F1RegsConfig.data.RULES.AI_AVG_TYRE_LIFE + driver.aiTyreAvgRandom) then
            ui.textColored(text.." %", rgbm(1,0,0,1))
        elseif text < F1RegsConfig.data.RULES.AI_AVG_TYRE_LIFE + driver.aiTyreAvgRandom then
            ui.textColored(text.." %", rgbm(1,1,0,1))
        else
            ui.textColored(text.." %", rgbm(1,1,1,1))
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
    for _,v in pairs(t) do -- Get the sum of all numbers in t
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
MappedConfig = class('MappedConfig', function(filename, map)
  local ini = ac.INIConfig.load(filename)
  local data = ini:mapConfig(map)
  local key = 'app.F1Regs:'..filename
  -- local original = stringify.tryParse(ac.load(key))
  local original = nil -- TODO: REMOVE THIS LINE
  if not original then
    ac.store(key, stringify(data))
    original = stringify.parse(stringify(data))
  end
  return {filename = filename, ini = ini, map = map, data = data, original = original}
end, class.NoInitialize)

function MappedConfig:reload()
  self.ini = ac.INIConfig.load(self.filename) or self.ini
  self.data = self.ini:mapConfig(self.map)
end

---@param section string
---@param key string
---@param value number|boolean
function MappedConfig:set(section, key, value, hexFormat)
  if not self.data[section] then self.data[section] = {} end
  if type(value) == 'number' and not (value > -1e9 and value < 1e9) then error('Sanity check failed: '..tostring(value)) end
  if self.data[section][key] == value then return end
  self.data[section][key] = value
  setTimeout(function ()
    log('Saving updated ['..section..']['..key..']: '..tostring(value))
    self.ini:setAndSave(section, key, hexFormat and string.format('0x%x', self.data[section][key]) or self.data[section][key])
  end, 0.02, section..key)
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
  if not cfg.data[section] then error('No such section: '..section, 2) end
  if not cfg.data[section][key] then error('No such key: '..key, 2) end
  ui.setNextItemWidth(ui.windowWidth()-75)
  local curValue = ui.slider('##'..section..key, mult < 0 and -mult / cfg.data[section][key] or cfg.data[section][key] * mult, from, to, format)
  if tooltip and (ui.itemHovered() or ui.itemActive()) then
    (type(tooltip) == 'function' and ui.tooltip or ui.setTooltip)(tooltip)
  end
  if preprocess then
    curValue = preprocess(curValue)
  end
  ui.sameLine(0, 4)
  local changed = math.abs(cfg.original[section][key] - (mult < 0 and -mult / curValue or curValue / mult)) > 0.0001
  if ui.button('##r'..section..key, vec2(20, 20), changed and ui.ButtonFlags.None or ui.ButtonFlags.Disabled) then
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
        v = string.format(format:match('%%.+'), mult < 0 and -mult / cfg.original[section][key] or cfg.original[section][key] * mult)

    end
    ui.setTooltip(string.format(changed and 'Click to restore original value: %s' or 'Original value: %s', v))
  end
  cfg:set(section, key, curValue, false)

  return curValue
end

--- Returns state of installed CSP version being compatible with F1 Regs
--- @return boolean
function compatibleCspVersion()
    return ac.getPatchVersionCode() >= CSP_MIN_VERSION_CODE and true or false
end