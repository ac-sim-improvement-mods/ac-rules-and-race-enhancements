local inject = {}

local function editUiFIle(inputFile)
	local file = io.open(inputFile, "r")
	local fileContent = {}
	for line in file:lines() do
		table.insert(fileContent, line)
	end
	io.close(file)

	fileContent[2] = "\t" .. '"name": "' .. ac.getTrackName() .. ' RARE",'

	file = io.open(inputFile, "w")
	for index, value in ipairs(fileContent) do
		file:write(value .. "\n")
	end
	io.close(file)
end

local trackLayout = ac.getTrackLayout() ~= "" and ac.getTrackLayout() or ac.getTrackID()
local trackDir = ac.getFolder(ac.FolderID.ContentTracks) .. "\\" .. ac.getTrackID()
local currentTrackLayoutDir = trackDir .. "\\" .. trackLayout
local rareTrackLayoutDir = trackDir .. "\\" .. trackLayout .. "_rare"
local currentTrackUIDir = trackDir .. "\\ui\\" .. trackLayout
local rareTrackUIDir = trackDir .. "\\ui\\" .. trackLayout .. "_rare"

function inject.createRareTrackConfig()
	if trackLayout == ac.getTrackID() then
		currentTrackLayoutDir = trackDir
		currentTrackUIDir = trackDir .. "\\ui"

		io.copyFile(
			trackDir .. "\\" .. trackLayout .. ".vao-patch",
			trackDir .. "\\" .. trackLayout .. "_rare.vao-patch",
			true
		)

		if not io.fileExists(trackDir .. "\\models.ini") then
			io.save(trackDir .. "\\models_" .. trackLayout .. "_rare.ini")
			local modelIni = ac.INIConfig.load(trackDir .. "\\models_" .. trackLayout .. "_rare.ini")
			modelIni:setAndSave("MODEL_0", "FILE", trackLayout .. ".kn5")
			modelIni:setAndSave("MODEL_0", "POSITION", "0,0,0")
			modelIni:setAndSave("MODEL_0", "ROTATION", "0,0,0")
		end

		io.copyFile(trackDir .. "\\models.ini", trackDir .. "\\models_" .. trackLayout .. "_rare.ini", true)
		io.copyFile(trackDir .. "\\models.vao-patch", trackDir .. "\\models_" .. trackLayout .. "_rare.vao-patch", true)
	else
		io.copyFile(
			trackDir .. "\\models_" .. trackLayout .. ".ini",
			trackDir .. "\\models_" .. trackLayout .. "_rare.ini",
			true
		)

		io.copyFile(
			trackDir .. "\\models_" .. trackLayout .. ".vao-patch",
			trackDir .. "\\models_" .. trackLayout .. "_rare.vao-patch",
			true
		)
	end

	io.createDir(rareTrackLayoutDir)

	io.createDir(rareTrackLayoutDir .. "\\ai")
	io.scanDir(currentTrackLayoutDir .. "\\ai", function(fileName)
		io.copyFile(currentTrackLayoutDir .. "\\ai\\" .. fileName, rareTrackLayoutDir .. "\\ai\\" .. fileName)
	end)

	io.createDir(rareTrackLayoutDir .. "\\data")
	io.scanDir(currentTrackLayoutDir .. "\\data", function(fileName)
		io.copyFile(currentTrackLayoutDir .. "\\data\\" .. fileName, rareTrackLayoutDir .. "\\data\\" .. fileName)
	end)

	if io.dirExists(currentTrackLayoutDir .. "\\extension") then
		io.createDir(rareTrackLayoutDir .. "\\extension")
		io.scanDir(currentTrackLayoutDir .. "\\extension", function(fileName)
			io.copyFile(
				currentTrackLayoutDir .. "\\extension\\" .. fileName,
				rareTrackLayoutDir .. "\\extension\\" .. fileName
			)
		end)
	end

	io.copyFile(currentTrackLayoutDir .. "\\map.png", rareTrackLayoutDir .. "\\map.png")

	io.createDir(rareTrackUIDir)
	io.deleteFile(rareTrackUIDir .. "\\outline.png")
	io.scanDir(currentTrackUIDir, function(fileName)
		io.copyFile(currentTrackUIDir .. "\\" .. fileName, rareTrackUIDir .. "\\" .. fileName)
	end)

	editUiFIle(rareTrackUIDir .. "\\ui_track.json")
end

function inject.setPhysicsAllowed()
	local surfacesFile = rareTrackLayoutDir .. "\\data\\surfaces.ini"
	local surfacesIni = ac.INIConfig.load(surfacesFile, ac.INIFormat.Default)

	surfacesIni:setAndSave("SURFACE_0", "WAV_PITCH", "extended-0")
	surfacesIni:setAndSave("_SCRIPTING_PHYSICS", "ALLOW_APPS", "1")
end

function inject.injectRare()
	if not physics.allowed() then
		if string.find(currentTrackLayoutDir, "_rare") then
			return
		else
			inject.createRareTrackConfig()
		end
		inject.setPhysicsAllowed()
		local rareLayout = "[RACE]"
			.. "\nCONFIG_TRACK="
			.. (ac.getTrackLayout() ~= "" and ac.getTrackLayout() or ac.getTrackID())
			.. "_rare"
		ac.restartAssettoCorsa(rareLayout)
	end
end

return inject