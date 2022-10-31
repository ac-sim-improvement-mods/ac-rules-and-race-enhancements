SCRIPT_VERSION = "0.9.7.5-alpha"
SCRIPT_VERSION_ID = 9750
SCRIPT_RELEASE_DATE = "2022-10-28"
CSP_MIN_VERSION_ID = 2144

require 'src/connection'
require 'src/ac-ext'
require 'src/utils'
require 'src/init'
require 'src/controller'
require 'src/driver'
require 'src/debug'
require 'src/ui/notifications'
require 'src/ui/settings-menu'
require 'src/systems/drs'
require 'src/systems/vsc'
require 'src/systems/ai'

INITIALIZED = false

local RESTARTED = false
local REBOOT = false

function script.update(dt)
    local sim = ac.getSim()
    local error = ac.getLastError()

    if error then
        log(error)
        INITIALIZED = false
        INITIALIZED = initialize(sim)
    end

    if not ac.isWindowOpen("main") then return end

    if sim.raceSessionType == 3 then
        if not RESTARTED and sim.isInMainMenu then
            RESTARTED = true
            INITIALIZED = false
        end

        -- Initialize the session
        if (sim.isInMainMenu or sim.isSessionStarted) and not INITIALIZED then INITIALIZED = initialize(sim)
        elseif not sim.isInMainMenu and not sim.isSessionStarted and RESTARTED and INITIALIZED then
            if REBOOT and F1RegsConfig.data.RULES.PHYSICS_REBOOT == 1 then ac.restartAssettoCorsa() end
            REBOOT = false
            RESTARTED = false
        -- Race session has started
        elseif INITIALIZED then controlSystems(sim) end
    end

    if INITIALIZED and sim.isSessionStarted then audioHandler(sim) end

end

function script.windowMain(dt)
    -- JUST TO KEEP THE SCRIPT ALIVE
end