local ai_alternate_level = require("src/controllers/ai/ai_alternate_level")
local ai_pitstop = require("src/controllers/ai/ai_pitstop")
local ai_session_behavior = require("src/controllers/ai/ai_session_behavior")

local sim = ac.getSim()

local ai = {}

function ai.controller(racecontrol, raceRules, aiRules, driver)
	if aiRules.FORCE_PIT_TYRES == 1 then
		ai_pitstop.run(raceRules, driver)
	end
	if aiRules.ALTERNATE_LEVEL == 1 then
		ai_alternate_level.run(driver)
	end

	if sim.raceSessionType == ac.SessionType.Practice then
		ai_session_behavior.practice(racecontrol, driver)
	elseif sim.raceSessionType == ac.SessionType.Qualify or sim.raceSessionType == ac.SessionType.Hotlap then
		ai_session_behavior.qualifying(racecontrol, driver)
	elseif sim.raceSessionType == ac.SessionType.Race then
	end
end

return ai
