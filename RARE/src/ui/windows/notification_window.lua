require("src/helpers/ui_helper")

local notifications = {}

local notificationTimer = 0
local notificationText = ""

local bannerHeight = 95
local bannerDrsEnabled = ui.decodeImage(io.loadFromZip(ac.findFile("assets\\img.zip"), "banner_drs_enabled.png"))
local bannerDrsEnabledWidth = 512.4
local bannerDrsEnabledLaps =
	ui.decodeImage(io.loadFromZip(ac.findFile("assets\\img.zip"), "banner_drs_enabled_laps.png"))
local bannerDrsEnabledLapsWidth = 783.9
local bannerDrsDisabled = ui.decodeImage(io.loadFromZip(ac.findFile("assets\\img.zip"), "banner_drs_disabled.png"))
local bannerDrsDisabledWidth = 881.1

local function drawRaceControl(text)
	ui.beginScale()
	ui.setCursorX(1800)
	ui.setCursorY(200)

	if text == "DRS ENABLED" or text == "RACE CONTROL BANNER" then
		ui.image(bannerDrsEnabled, vec2(bannerDrsEnabledWidth, bannerHeight))
	elseif text == "DRS DISABLED - WET TRACK" then
		ui.image(bannerDrsDisabled, vec2(bannerDrsDisabledWidth, bannerHeight))
	elseif text == "DRS ENABLED IN 2 LAPS" then
		ui.image(bannerDrsEnabledLaps, vec2(bannerDrsEnabledLapsWidth, bannerHeight))
	end

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
