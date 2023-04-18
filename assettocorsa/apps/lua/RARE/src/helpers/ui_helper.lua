--- Lines up bullet text label with text
--- @param label string
--- @param text string
--- @param space number
function ui.inLineBulletText(label, text, space)
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
function ui.upperBool(bool)
	return string.upper(tostring(bool))
end

--- Override function to add clarity and default values for drawing text
function ui.drawText(textdraw)
	if not textdraw.margin then
		textdraw.margin = vec2(350, 350)
	end
	if not textdraw.color then
		textdraw.color = rgbm(0.95, 0.95, 0.95, 1)
	end
	if not textdraw.fontSize then
		textdraw.fontSize = 70
	end

	ui.setCursorX(textdraw.xPos)
	ui.setCursorY(textdraw.yPos)
	ui.dwriteTextAligned(
		textdraw.string,
		textdraw.fontSize,
		textdraw.xAlign,
		textdraw.yAlign,
		textdraw.margin,
		false,
		textdraw.color
	)
end
