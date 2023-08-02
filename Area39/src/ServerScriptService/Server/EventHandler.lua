-- // DrBaja/Braden_J
local TeamsService = _G.Area39:GetService("Teams")
local MessageEmbed = _G.Area39:GetService("MessageEmbed")

local PlayerSuggestionUrl = "https://discord.com/api/webhooks/821481437785227294/FKs5x9dfYVJvsCqzIon4BhgvpMCruQ6WRKXtOWzPCrvxZNg5EY5nlhh9VqDp19l_V9QI"
local PlayerReportUrl = "https://discord.com/api/webhooks/821063449441206282/hnhvd_infaLZnTMj8FZ4RARM_pSMuJmnLprXFTLturmQuTKMJA4yzNYaAmXmAPsPI1AE"

local ShopData = require(game.ReplicatedStorage.Common.ShopData)
local DataService = _G.Area39:GetService("DataStore2")
local LastRadioChat = {}
local LastReport = {}
local LastSuggestion = {}
_G.AFKPlayers = {}


local functions = {
	['Suggestion'] = function(plr,text)
		if not LastSuggestion[plr]  or math.abs(LastSuggestion[plr] - tick()) >= 300  then
			LastSuggestion[plr] = tick()
			local embed = MessageEmbed.new(PlayerSuggestionUrl)
			embed:SetTitle("Suggestion by " .. plr.Name)
			embed:SetDescription(text)
			embed:AddField("ServerId",game.JobId)
			embed:SetFooter("Powered by Baja's Lab","https://bajaslab.com/images/bajaslablogov4.png")

			embed:SetUrl("https://www.roblox.com/users/" .. tostring(plr.UserId) .. "/profile")

			embed:PostAsync()
			_G.Area39:SendSnackBar(plr,"Your suggestion has been submitted. Thank you!")
		else
			_G.Area39:SendSnackBar(plr,"You must wait 5 minutes before sending another suggestion.")
		end
	end,
    ['Report'] = function(plr,target,reason)
        if not LastReport[plr]  or math.abs(LastReport[plr] - tick()) >= 300  then
            LastReport[plr] = tick()
            local embed = MessageEmbed.new(PlayerReportUrl)
            embed:SetTitle("Player Report by " .. plr.Name)
            embed:AddField("Suspect",target.Name)
            embed:AddField("Reason",reason)
            embed:AddField("ServerId",game.JobId)
            embed:AddField("Reported By",plr.Name)
            embed:SetFooter("Powered by Baja's Lab","https://bajaslab.com/images/bajaslablogov4.png")

            embed:SetUrl("https://www.roblox.com/users/" .. tostring(target.UserId) .. "/profile")

            embed:PostAsync()
            _G.Area39:SendSnackBar(plr,"Your report has been submitted. Thank you!")
        else
            _G.Area39:SendSnackBar(plr,"You must wait 5 minutes before sending another report.")
        end
    end,
    ['ChangeTeam'] = function(plr,teamName,variationName)
        if not variationName then variationName = "" end
        return TeamsService:SpawnOnTeam(plr,teamName,variationName)
    end,
    ['Radio'] = function(plr,text)
        
        if not LastRadioChat[plr]  or math.abs(LastRadioChat[plr] - tick()) >= 2  then
            LastRadioChat[plr] = tick()
            if plr.Team.Name ~= "Class D" and plr.Team.Name ~= "Chaos Insurgency" and plr.Team.Name ~= "Choosing" then
            
                for i,v in pairs(game.Players:GetPlayers()) do
                    text = game:GetService("Chat"):FilterStringAsync(text,plr,v)
                    game.ReplicatedStorage.Remotes.Post:FireClient(v,"Radio",plr.Name .. ":",text)
                end
                
            end
        end
    end,
    ['BuyProduct'] = function(plr,title)
       
        for i,v in pairs(ShopData['Ingame']) do
           
            if string.lower(tostring(v['Title'])) == string.lower(tostring(title)) then
              
                if plr.leaderstats.Credits.Value >= v['Price'] then
                    plr.leaderstats.Credits.Value = plr.leaderstats.Credits.Value - v['Price']
                    
                    if v['Tools'] then
                        for i,x in pairs(v['Tools']) do
                            local t = game.ServerStorage.Tools:FindFirstChild(x)
                            if t then
                                t:Clone().Parent = plr.Backpack
                            end
                        end
                    end
                else
                    _G.Area39:SendSnackBar(plr,"You don't have enough credits for this.")
                end
            end
        end
    end,
    ['AFK'] = function(plr)
        _G.AFKPlayers[plr] = 0
    end,
    ['NoAFK'] = function(plr)
        _G.AFKPlayers[plr] = false
    end,
    ['GetQuests'] = function(plr)
       
        local currentQuests = _G.Area39:GetService("Quests")
        if not currentQuests[plr.Team.Name] then return {} end
             local plrStore = DataService("PlayerQuestData", plr)
            local data = plrStore:Get({})
        
            if not data then data = {} end
            local function shallowCopy(original) -- function to copy the table so we can remove values from it.
                local copy = {}
                for key, value in pairs(original) do
                    copy[key] = value
                end
                return copy
            end
    
            local quests = shallowCopy(currentQuests[plr.Team.Name])
           
            for i,v in pairs(quests) do
                for z,x in pairs(data or {}) do
                    if tostring(z) == tostring(v) then
                        table.remove(quests,i)
                    end
                end
            end
          
            return quests
        
    end,
}

function handle(plr,action,...)
    if functions[action] then
       return functions[action](plr,...) 
    end
end
game.ReplicatedStorage.Remotes.Get.Bind.OnInvoke = handle
game.ReplicatedStorage.Remotes.Post.OnServerEvent:Connect(handle)
game.ReplicatedStorage.Remotes.Get.OnServerInvoke = handle

local module = {}
return module