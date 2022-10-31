SCRIPT_VERSION = "0.9.7.5-alpha"
SCRIPT_VERSION_ID = 9750
SCRIPT_RELEASE_DATE = "2022-10-28"
CSP_MIN_VERSION = "1.79"
CSP_MIN_VERSION_ID = 2144

require 'src/ac_ext'
require 'src/utils'
require 'src/init'
require 'src/ui/debug_menu'
require 'src/ui/settings_menu'
require 'src/ui/notifications'

local rc = require 'src/racecontrol'

INITIALIZED = false
RESTARTED = false
REBOOT = false

local function run()
        audioHandler()
        if sim.raceSessionType == 3 then
            rc.getRaceControl()
            rc.race()
        end
end

local function restartCheck(sim)
    if not RESTARTED and sim.isInMainMenu then
        RESTARTED = true
        INITIALIZED = false
    end
end

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
        run()
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