local pitstalls = {}

-- local moved = false
-- local pit0Location = ac.findNodes("staticRoot:yes")
-- 	:findMeshes("CREW:polymsh_detached1_SUB1.001")
-- 	:getParent()
-- 	:getParent()
-- 	:setPosition(vec3(183.348, -19, 41))
-- local pit1Location = ac.findNodes("staticRoot:yes"):findMeshes("AC_PIT_1"):getParent():getPosition()
-- ac.log(ac.findNodes("staticRoot:yes"):findMeshes("CREW:polymsh_detached1_SUB1.001"):getParent():getPosition())
-- ac.log(pit1Location)

ac.findNodes("trackRoot:yes"):createNode("PIT_ROOT", true)
ac.findNodes("trackRoot:yes"):findNodes("PIT_ROOT"):setPosition(vec3(653.193 + 2.3, -27.85 + 2, -33.36 - 2.7))

ac.findNodes("trackRoot:yes")
	:findNodes("AC_CREW_0_LODB2_002")
	:setParent(ac.findNodes("trackRoot:yes"):findNodes("PIT_ROOT"))
	:setVisible(true)
ac.findNodes("trackRoot:yes")
	:findNodes("AC_CREW_0_LODB4")
	:setParent(ac.findNodes("trackRoot:yes"):findNodes("PIT_ROOT"))
ac.findNodes("trackRoot:yes")
	:findNodes("AC_CREW_0_LODB3")
	:setParent(ac.findNodes("trackRoot:yes"):findNodes("PIT_ROOT"))
ac.findNodes("trackRoot:yes")
	:findNodes("AC_CREW_0_LODB2")
	:setParent(ac.findNodes("trackRoot:yes"):findNodes("PIT_ROOT"))
ac.findNodes("trackRoot:yes")
	:findNodes("AC_CREW_0_LODA7")
	:setParent(ac.findNodes("trackRoot:yes"):findNodes("PIT_ROOT"))
ac.findNodes("trackRoot:yes")
	:findNodes("AC_CREW_0_LODA4")
	:setParent(ac.findNodes("trackRoot:yes"):findNodes("PIT_ROOT"))
ac.findNodes("trackRoot:yes")
	:findNodes("AC_CREW_0_LODA3")
	:setParent(ac.findNodes("trackRoot:yes"):findNodes("PIT_ROOT"))
ac.findNodes("trackRoot:yes")
	:findNodes("AC_CREW_0_LODA1")
	:setParent(ac.findNodes("trackRoot:yes"):findNodes("PIT_ROOT"))
ac.findNodes("trackRoot:yes")
	:findNodes("AC_CREW_0_LODB2_003")
	:setParent(ac.findNodes("trackRoot:yes"):findNodes("PIT_ROOT"))

function pitstalls.mergeTeammates()
	local pitLocations = {}

	for i = 0, ac.getSim().carsCount - 1 do
		local driverTeam = ac.getDriverTeam(i)

		if not pitLocations[driverTeam] then
			local teamPitLocation = ac.findNodes("trackRoot:yes"):findNodes("AC_PIT_" .. i):getPosition()
			pitLocations[driverTeam] = teamPitLocation
			ac.log(driverTeam .. " " .. tostring(teamPitLocation))
			ac.log(ac.findNodes("trackRoot:yes"):findNodes("AC_PIT_" .. i):getPosition())
		else
			local teamPitLocation = pitLocations[driverTeam]
			local driverPitLocation = ac.findNodes("trackRoot:yes"):findNodes("AC_PIT_" .. i):getPosition()
			ac.log("Setting pit location to " .. tostring(teamPitLocation) .. " from " .. tostring(driverPitLocation))
			ac.findNodes("trackRoot:yes"):findNodes("AC_PIT_" .. i):setPosition(pitLocations[driverTeam])
		end
	end
end

return pitstalls
