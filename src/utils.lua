
function log(message)
    ac.log("[F1Regs] "..message)
end

function inLineBulletText(label,text,space)
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
    elseif string.find(label, "Life") and not string.find(label, "Limit") then
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

--- Converts session type number to the corresponding session type string
---@return string
function sessionTypeString(sim)
    local sessionTypes = {
        "UNDEFINED",
        "PRACTICE",
        "QUALIFY",
        "RACE",
        "HOTLAP",
        "TIME ATTACK",
        "DRIFT",
        "DRAG"
    }

    return sessionTypes[sim.raceSessionType + 1]
end

function weatherTypeString(sim)
    local weatherTypes = {  
        "Light Thunderstorm", ---Value: 0.
        "Thunderstorm", ---Value: 1.
        "Heavy Thunderstorm", ---Value: 2.
        "Light Drizzle", ---Value: 3.
        "Drizzle", ---Value: 4.
        "Heavy Drizzle", ---Value: 5.
        "Light Rain", ---Value: 6.
        "Rain", ---Value: 7.
        "Heavy Rain", ---Value: 8.
        "Light Snow", ---Value: 9.
        "Snow", ---Value: 10.
        "Heavy Snow", ---Value: 11.
        "Light Sleet", ---Value: 12.
        "Sleet", ---Value: 13.
        "Heavy Sleet", ---Value: 14.
        "Clear", ---Value: 15.
        "Few Clouds", ---Value: 16.
        "Scattered Clouds", ---Value: 17.
        "Broken Clouds", ---Value: 18.
        "Overcast Clouds", ---Value: 19.
        "Fog", ---Value: 20.
        "Mist", ---Value: 21.
        "Smoke", ---Value: 22.
        "Haze", ---Value: 23.
        "Sand", ---Value: 24.
        "Dust", ---Value: 25.
        "Squalls", ---Value: 26.
        "Tornado", ---Value: 27.
        "Hurricane", ---Value: 28.
        "Cold", ---Value: 29.
        "Hot", ---Value: 30.
        "Windy", ---Value: 31.
        "Hail", ---Value: 32.
    }

    return weatherTypes[sim.weatherType + 1]
end

function upperBool(s)
    return string.upper(tostring(s))
end

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