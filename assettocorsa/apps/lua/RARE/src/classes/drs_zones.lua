---@class DRS_Points
---@param fileName string
---@return DRS_Points
DrsZones = class("DRS_Points", function()
	local drsIni = ac.INIConfig.trackData("drs_zones.ini")
	local detectionLines = {}
	local startLines = {}
	local endLines = {}

	local zoneCount = 0
	for index, section in drsIni:iterate("ZONE") do
		index = index - 1
		detectionLines[index] = drsIni:get(section, "DETECTION", -1)
		startLines[index] = drsIni:get(section, "START", -1)
		endLines[index] = drsIni:get(section, "END", -1)

		log(
			"Loaded DRS Zone "
				.. index
				.. " ["
				.. detectionLines[index]
				.. ","
				.. startLines[index]
				.. ","
				.. endLines[index]
				.. "]"
		)

		zoneCount = index
	end

	return {
		detectionLines = detectionLines,
		startLines = startLines,
		endLines = endLines,
		count = zoneCount,
	}
end, class.NoInitialize)
