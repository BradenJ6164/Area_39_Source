-- // DrBaja/Braden_J
local MarketPlaceService = _G.Area39:GetService("MarketplaceService")
local TeamData = require(game.ReplicatedStorage:WaitForChild("Common")
                             :WaitForChild("TeamData"))
local module = {}
_G.Teams = {}

function module:CheckPermission(plr, teamName)
    if TeamData[teamName] then
        local team = TeamData[teamName]
        local permission = false

        

        if team['GamepassId'] ~= 0 then
            if MarketPlaceService:UserOwnsGamePassAsync(plr.UserId,
                                                        team['GamepassId']) then
                permission = true
            end
        end
        if team['XPNeeded'] then
            if plr.leaderstats.XP.Value >= team['XPNeeded'] then
                if team['GamepassRequired'] == false then
                    permission = true
                end
            end
        end
        return permission
    end
end
function module:CheckVariationPermission(plr, teamName, variationName)
    local reducer = 0
    if TeamData[teamName] then
        local team = TeamData[teamName]
        local variation = team['Variations'][variationName]
        local permission = false
        
        if variation then
            if variation['GamepassId'] == 11284552 then
            
                if game.Teams:FindFirstChild(teamName):FindFirstChild("O5") then
            
                    if game.Teams:FindFirstChild(teamName):FindFirstChild("O5").Value ~= 0 then
                    
                        return false,0,true
                    end
                end
            end
        end
        if variation then
            if variation['GamepassId'] ~= 0 then
                if MarketPlaceService:UserOwnsGamePassAsync(plr.UserId,
                                                            variation['GamepassId']) then
                    permission = true
                end
            end
            if variation['XPNeeded'] then
               reducer = 0
                if team['XPNeeded'] ~= 0 then
                    if MarketPlaceService:UserOwnsGamePassAsync(plr.UserId,
                                                                team['GamepassId']) then
                        reducer = team['XPNeeded']
                    end
                end
                
                if plr.leaderstats.XP.Value >= (variation['XPNeeded']-reducer) then
                    if variation['GamepassRequired'] == false then
                        permission = true
                    end
                end
            end
        else
            permission = true
        end

        return permission,reducer
    end
end
function module:SpawnOnTeam(plr, teamName, variationName, noload)
    for i,v in pairs(game.Teams:GetChildren()) do
        if v:FindFirstChild("O5") and v.O5.Value == plr.UserId then
            v.O5.Value = 0
        end
    end
    
    if module:CheckPermission(plr, teamName) and
        module:CheckVariationPermission(plr, teamName, variationName) then

            
        
        local team = TeamData[teamName]
        if team['Variations'][variationName] then
            plr.Variation.Value = variationName
        else
            plr.Variation.Value = teamName
        end
        plr.TeamColor = team['TeamColor']
        _G.Teams[plr] = {teamName, variationName}
        
        

        if variationName then
            if team['Variations'][variationName] then
                plr.Clearance.Value =
                    team['Variations'][variationName]['Clearance']
                if team['Variations'][variationName]['Tools'] then
                    for i, v in
                        pairs(team['Variations'][variationName]['Tools']) do
                        local tool = game.ServerStorage.Tools:FindFirstChild(v)
                       
                        if tool then
                            tool:Clone().Parent = plr.Backpack
                        end
                    end
                end
            else
                plr.Clearance.Value = team['Clearance']
                if team['Tools'] then
                    for i, v in pairs(team['Tools']) do
                        local tool = game.ServerStorage.Tools:FindFirstChild(v)
                        
                        if tool then
                            tool:Clone().Parent = plr.Backpack
                        end
                    end
                end
            end

        else
            if team then
                plr.Clearance.Value = team['Clearance']
                if team['Tools'] then
                    for i, v in pairs(team['Tools']) do
                        local tool = game.ServerStorage.Tools:FindFirstChild(v)
                        
                        if tool then
                            tool:Clone().Parent = plr.Backpack
                        end
                    end
                end
            else
                plr.Clearance.Value = -1
            end
        end
        if not noload then plr:LoadCharacter() end
    else
        return "No Permission"
    end
end

return module
