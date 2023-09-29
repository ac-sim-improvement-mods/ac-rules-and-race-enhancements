require("app/version")
require("src/helpers/ac_ext")
require("src/init")
require("src/ui/windows/debug_window")
require("src/ui/windows/settings_window")
require("src/ui/windows/notification_window")
require("src/classes/audio")
local racecontrol = require("src/controllers/race_control")
local pirellilimits = require("src/controllers/pirelli_limits")

INITIALIZED = false
RARE_CONFIG = nil
RESTARTED = false

local sim = ac.getSim()
local rc = nil
local sfx = nil
local delay = 0

ac.onSessionStart(function(sessionIndex, restarted)
	delay = os.clock() + 6
end)

function script.update(dt)
	if sim.sessionsCount > 1 and ac.getPatchVersionCode() == 2501 then
		return
	end

	sim = ac.getSim()

	local error = ac.getLastError()
	if error then
		ui.toast(ui.Icons.Warning, "[RARE] AN ERROR HAS OCCURED")
		log(error)
	end

	if not sim.isOnlineRace then
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
	end

	if INITIALIZED then
		if not sfx then
			sfx = Audio()
		end

		if sim.isLive and os.clock() > delay then
			rc = racecontrol.getRaceControl(dt, sim)
			sfx:update()
			pirellilimits.update()
		end
	else
		if sim.isInMainMenu then
			INITIALIZED = initialize(sim)
		end
	end
end

function script.windowMain(dt)
	-- JUST TO KEEP THE SCRIPT ALIVE

	if INITIALIZED then
		ui.transparentWindow(
			"notifications",
			vec2(RARE_CONFIG.data.NOTIFICATIONS.X_POS - 1742, RARE_CONFIG.data.NOTIFICATIONS.Y_POS - 204),
			vec2(10000, 7500),
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
	if os.clock() < delay then
		return
	end

	local scriptVersion = SCRIPT_VERSION .. " (" .. SCRIPT_VERSION_CODE .. ")"
	ac.setWindowTitle("settings", SCRIPT_NAME .. " Settings | " .. scriptVersion)

	settingsMenu()
end
