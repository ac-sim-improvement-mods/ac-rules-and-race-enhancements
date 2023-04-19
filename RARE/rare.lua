require("app/version")
require("src/helpers/ac_ext")
require("src/init")
require("src/ui/windows/debug_window")
require("src/ui/windows/settings_window")
require("src/ui/windows/notification_window")
require("src/classes/audio")
local racecontrol = require("src/controllers/race_control")
local cc = require("src/controllers/compounds")

FIRST_LAUNCH = true
INITIALIZED = false
RESTARTED = false
RARE_CONFIG = nil

local sim = ac.getSim()
local rc = nil
local sfx = nil

ac.onSessionStart(function(sessionIndex, restarted)
	if restarted then
		RESTARTED = true
		INITIALIZED = false
		log("Session restarted")
	end
end)

function script.update(dt)
	sim = ac.getSim()

	if sim.isOnlineRace then
		ac.unloadApp()
		return
	end

	local error = ac.getLastError()
	if error then
		ui.toast(ui.Icons.Warning, "[RARE] AN ERROR HAS OCCURED")
		log(error)
	end

	if sim.isInMainMenu then
		ac.setWindowOpen("settings_setup", true)
	end

	if not ac.isWindowOpen("rare") then
		return
	elseif not physics.allowed() then
		ui.toast(
			ui.Icons.Warning,
			"[RARE] INJECT THE APP! Inject the app by clicking the 'OFF' button in the RARE window while in the setup menu."
		)
		return
	end

	if INITIALIZED then
		if not sfx then
			sfx = Audio()
		end

		if sim.isLive then
			rc = racecontrol.getRaceControl(dt, sim)
			sfx:update(sim)
			cc.update(sim)
		end
	else
		if sim.isInMainMenu or sim.isSessionStarted then
			INITIALIZED = initialize(sim)
		end
	end
end

function script.windowMain(dt)
	-- JUST TO KEEP THE SCRIPT ALIVE

	if INITIALIZED then
		ui.transparentWindow(
			"notifications",
			vec2(RARE_CONFIG.data.NOTIFICATIONS.X_POS, RARE_CONFIG.data.NOTIFICATIONS.Y_POS),
			vec2(1200, 500),
			function()
				notificationHandler(dt)
			end
		)
	end
end

function script.windowDebug(dt)
	local rareEnabled = ac.isWindowOpen("rare")
	local windowName = SCRIPT_SHORT_NAME .. " Debug"
	local scriptVersion = SCRIPT_VERSION .. " (" .. SCRIPT_VERSION_CODE .. ")"
	local windowTitle = windowName .. " | " .. scriptVersion .. " | " .. (rareEnabled and "ENABLED" or "DISABLED")
	local error = ac.getLastError()
	ac.setWindowTitle("debug", windowTitle)

	if INITIALIZED and not sim.isInMainMenu and rc ~= nil then
		debug_window(sim, rc, error)
	end
end

function script.windowSettings()
	local scriptVersion = SCRIPT_VERSION .. " (" .. SCRIPT_VERSION_CODE .. ")"
	ac.setWindowTitle("settings", SCRIPT_NAME .. " Settings | " .. scriptVersion)

	settingsMenu(sim)
end
