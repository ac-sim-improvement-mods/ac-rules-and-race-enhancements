require("src/helpers/ui_helper")

local notifications = {}

local notificationTimer = 0
local notificationText = ""

local function drawRaceControl(text)
	ui.beginScale()
	ui.pushDWriteFont("Formula1 Display;Weight=Bold")
	-- ui.pushDWriteFont("Formula1 Display Bold Bold:fonts/f1.ttf")

	local leftAlign = 147
	local yAlign = -145
	local fontSize = 32
	local bannerHeight = 95
	local bannerWidth = ui.measureDWriteText(text, fontSize * 0.8125).x + 40

	-- Race Control dark blue rect
	ui.drawRectFilled(vec2(0, 0), vec2(360, bannerHeight), rgbm(0.07, 0.12, 0.23, 1))

	-- Information white rect
	ui.drawRectFilled(vec2(360, 0), vec2(360 + bannerWidth, bannerHeight), rgbm(1, 1, 1, 1))

	ui.drawText({
		string = "RACE",
		fontSize = fontSize,
		xPos = leftAlign,
		yPos = yAlign,
		xAlign = ui.Alignment.Start,
		yAlign = ui.Alignment.Center,
		color = rgbm(1, 1, 1, 1),
	})

	ui.drawText({
		string = "CONTROL",
		fontSize = fontSize,
		xPos = leftAlign,
		yPos = yAlign + 35,
		xAlign = ui.Alignment.Start,
		yAlign = ui.Alignment.Center,
		color = rgbm(1, 1, 1, 1),
	})

	ui.drawText({
		string = text,
		fontSize = fontSize * 0.8125,
		xPos = 110 + bannerWidth / 2,
		yPos = yAlign + 21,
		xAlign = ui.Alignment.Center,
		yAlign = ui.Alignment.Center,
		color = rgbm(0.07, 0.12, 0.23, 1),
		margin = vec2(500, 350),
	})

	ui.beginScale()
	local pos_x = 7
	local pos_y = -2
	local size_x = pos_x + 146
	local size_y = pos_y + 100

	ui.drawImage("assets/icons/fia_logo.png", vec2(pos_x, pos_y), vec2(size_x, size_y), rgbm(1, 1, 1, 1), true)
	ui.endScale(0.60)

	ui.popDWriteFont()
	ui.endScale(RARE_CONFIG.data.NOTIFICATIONS.SCALE)
end

local function drawNotification()
	drawRaceControl(notificationText)
end

local fadingTimer = ui.FadingElement(drawNotification, false)

function notifications.popup(text, timer)
	if not timer then
		timer = RARE_CONFIG.data.NOTIFICATIONS.DURATION
	end

	notificationTimer = timer
	notificationText = text
end

function notificationHandler(dt)
	local timer = notificationTimer
	timer = timer - dt
	notificationTimer = timer
	fadingTimer(timer > 0 and timer < 60)
end

return notifications
