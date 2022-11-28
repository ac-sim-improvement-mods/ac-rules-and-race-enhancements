SCRIPT_NAME = "Rules and Race Enhancements"
SCRIPT_SHORT_NAME = "RARE"
SCRIPT_VERSION = "1.0.6.1"
SCRIPT_VERSION_CODE = 10610
SCRIPT_BUILD_DATE = "2022-11-28"
CSP_MIN_VERSION_CODE = 2144
CSP_MIN_VERSION = "1.79"

require 'src/ac_ext'
require 'src/utils'
require 'src/init'
require 'src/ui/debug_menu'
require 'src/ui/settings_menu'
require 'src/ui/notifications'
require 'src/ui/leaderboard'
local sim = ac.getSim()
local audio = nil
local rc = require 'src/race_control'
local racecontrol = nil

FIRST_LAUNCH = true
INITIALIZED = false
RESTARTED = false
REBOOT = false
RARECONFIG = nil

--- Check if AC has restarted
--- @param sim StateSim
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
        INITIALIZED = initialize(sim)
        return error
    else
        return nil
    end
end

function script.update(dt)
    sim = ac.getSim()
    restartCheck(sim)

    if sim.isInMainMenu then
        ac.setWindowOpen('settings_setup', true)
        ac.setWindowOpen('main_setup', true)
    end

    if INITIALIZED then
        -- A simple On/Off for the app
        if not ac.isWindowOpen('main') then return end
        if REBOOT then ac.restartAssettoCorsa() end
        if not sim.isInMainMenu and not sim.isSessionStarted then
            RESTARTED = false
        else
            racecontrol = rc.getRaceControl(dt,sim)
            audio.driver(sim)
        end
    else
        if sim.isInMainMenu or sim.isSessionStarted then
            INITIALIZED = initialize(sim)
            audio = require 'src/audio'
        end
    end
end

function script.windowMain(dt)
    -- JUST TO KEEP THE SCRIPT ALIVE

    if INITIALIZED then
        ui.transparentWindow('notifications',vec2(RARECONFIG.data.NOTIFICATIONS.X_POS,RARECONFIG.data.NOTIFICATIONS.Y_POS),vec2(1200,500),function ()
            notificationHandler(dt)
        end)


        ui.transparentWindow('1',vec2(700,700),vec2(1000,1000),function ()
            drawF1Leaderboard()
        end)
    end
end

function script.windowDebug(dt)
    local windowName = SCRIPT_SHORT_NAME.." Debug"
    local scriptVersion = SCRIPT_VERSION.." ("..SCRIPT_VERSION_CODE..")"
    local windowTitle = windowName.." | "..scriptVersion
    local error = errorCheck()
    ac.setWindowTitle("debug", windowTitle)

    if INITIALIZED and not sim.isInMainMenu and racecontrol ~= nil then
        debugMenu(sim,racecontrol,error)
    end
end

function script.windowSettings()
   settingsMenu(sim)
end
