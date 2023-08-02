
--DrBaja/Braden_J

-- ROBLOX Services
local players = game:GetService('Players')

-- API Initialisation
local detectionAPI = {}

local rAPI = _G.Area39:GetService("RotatedRegionAPI")


local function isValueInTable(tableToSearch, tableValue)
	for i, v in pairs(tableToSearch) do
		if v == tableValue then
			return true
		end
	end
	return false
end

function detectionAPI.createRegion3FromPart(part)
	return rAPI.new(part.CFrame, part.Size)
end

function detectionAPI.returnRegionFromPlayer(player, regionList)
	if player and player.Character and player.Character:FindFirstChild('HumanoidRootPart') then
		for regionName, region in pairs(regionList) do
			local partsInRegion = region:cast(nil, 10000)
			if #partsInRegion >= 1 then
				return regionName, region
			end
		end
	end
	return nil
end



function detectionAPI.getPlayersInRegion(region)
	local playersInRegion = {}
	
	local playersa = {}
	for _, v in pairs(players:GetPlayers()) do
		if v and v.Character then
			table.insert(playersa, v.Character)
		end
	end
	
	local parts = region:castwhite(playersa, 10000)
	for _, part in pairs(parts) do
		if part.Name == 'HumanoidRootPart' then
			local player = players:GetPlayerFromCharacter(part.Parent)
			if player and player.Character and not isValueInTable(playersInRegion, player) then
				table.insert(playersInRegion, player)
			end
		end
	end
	return playersInRegion
end

return detectionAPI