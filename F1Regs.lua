SCRIPT_VERSION = "0.9.8.0-alpha"
SCRIPT_VERSION_ID = 0980
SCRIPT_RELEASE_DATE = "2022-10-28"
CSP_MIN_VERSION = "1.79"
CSP_MIN_VERSION_ID = 2144

require 'src/ac_ext'
require 'src/utils'
require 'src/init'
require 'src/ui/debug_menu'
require 'src/ui/settings_menu'
require 'src/ui/notifications'

local rc = require 'src/race_control'

INITIALIZED = false
RESTARTED = false
REBOOT = false

DRS_ZONES = {}
DRIVERS = {}

DRS_FLAP = ui.MediaPlayer()
DRS_BEEP = ui.MediaPlayer()

--- Run the audio handler and race control session
--- @param sim ac.getSim()
local function run(sim)
        audioHandler()
        rc.session(sim.sessionType)
end

--- Check if AC has restarted
--- @param sim ac.getSim()
local function restartCheck(sim)
    if not RESTARTED and sim.isInMainMenu then
        RESTARTED = true
        INITIALIZED = false
    end
end

--- Check and log last error
local function errorCheck()
    local error = ac.getLastError()
    if error then
        log(error)
        INITIALIZED = false
        INITIALIZED = initialize()
    end
end

function script.update(dt)
    local sim = ac.getSim()
    
    errorCheck()
    restartCheck(sim)

    -- A simple On/Off for F1 Regs
    if not ac.isWindowOpen("main") then return end

    -- Initialize the session
    if (sim.isInMainMenu or sim.isSessionStarted) and not INITIALIZED then INITIALIZED = initialize()
    elseif not sim.isInMainMenu and not sim.isSessionStarted and RESTARTED and INITIALIZED then
        if REBOOT and F1RegsConfig.data.RULES.PHYSICS_REBOOT == 1 then ac.restartAssettoCorsa() end
        REBOOT = false
        RESTARTED = false
    -- Race session has started
    elseif INITIALIZED then
        run(sim)
    end
end

function script.windowMain(dt)
    -- JUST TO KEEP THE SCRIPT ALIVE
end

function script.windowDebug(dt)
    debugMenu(rc.getRaceControl())
end

function script.windowSettings(dt)
    settingsMenu(rc.getRaceControl())
end