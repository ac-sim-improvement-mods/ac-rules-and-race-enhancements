SCRIPT_VERSION = "0.9.8.1-alpha"
SCRIPT_VERSION_ID = 0981
SCRIPT_RELEASE_DATE = "2022-10-28"
CSP_MIN_VERSION = "1.79"
CSP_MIN_VERSION_ID = 2144

require 'src/ac_ext'
require 'src/utils'
require 'src/init'
require 'src/ui/debug_menu'
require 'src/ui/settings_menu'
require 'src/ui/notifications'
local audio = 'src/audio'
local _rc = require 'src/race_control'
local rc = _rc.getRaceControl()

INITIALIZED = false
RESTARTED = false
REBOOT = false

DRS_ZONES = {}

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
        INITIALIZED = initialize()
    end
end

function script.update(dt)
    errorCheck()
    restartCheck(sim)

    -- A simple On/Off for F1 Regs
    if not ac.isWindowOpen("main") then return end

    if INITIALIZED then
        if REBOOT and F1RegsConfig.data.RULES.PHYSICS_REBOOT == 1 then ac.restartAssettoCorsa() end
        if not sim.isInMainMenu and not sim.isSessionStarted then
            RESTARTED = false
        else
            rc = _rc.getRaceControl()
            audio.driver()
        end
    else
        if sim.isInMainMenu or sim.isSessionStarted then
            INITIALIZED = initialize()
        end
    end
end

function script.windowMain(dt)
    -- JUST TO KEEP THE SCRIPT ALIVE
end

function script.windowDebug(dt)
    debugMenu(rc)
end

function script.windowSettings(dt)
    settingsMenu(rc)
end