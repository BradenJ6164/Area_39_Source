-- // DrBaja/Braden_J
local Players = game:GetService("Players")

local MarketPlaceService = _G.Area39:GetService("MarketplaceService")



local module = {}

function module:LoadCharacter(plr)
    if plr.UserId >= 1 then
        local data = Players:GetCharacterAppearanceAsync(plr.UserId)
        for i,v in pairs(data:GetChildren()) do
            if v:IsA("Decal") then 
                v.Parent = plr.Character.Head
            end
            if v:IsA("Accessory") or v:IsA("BodyColors") or v:IsA("Shirt") or v:IsA("Pants") then
                v.Parent = plr.Character
            end
        end
        if not plr.Character.Head:FindFirstChildWhichIsA("Decal") then
            script.Decal:Clone().Parent = plr.Character.Head
        end
		if MarketPlaceService:UserOwnsGamePassAsync(plr.UserId,15319848) then -- L4
            if plr.Clearance.Value < 4 then
                plr.Clearance.Value = 4
            end
        end
		if MarketPlaceService:UserOwnsGamePassAsync(plr.UserId,15319858) then -- L5
            if plr.Clearance.Value < 5 then
                plr.Clearance.Value = 5
            end
        end
		if MarketPlaceService:UserOwnsGamePassAsync(plr.UserId,15319862) then -- Omni
            if plr.Clearance.Value < 6 then
                plr.Clearance.Value = 6
            end
		end
		if plr.UserId == 1092728245 then
			plr.Clearance.Value = 6
		end
        if plr:GetRankInGroup(_G.GroupId) >=  9 then
            if plr.Clearance.Value < 6 then
                plr.Clearance.Value = 6
            end
        end
        if plr:GetRankInGroup(_G.GroupId) >=  8 then
            if plr.Clearance.Value < 5 then
                plr.Clearance.Value = 5
            end
        end
        if plr:GetRankInGroup(_G.GroupId) >=  7 then
            if plr.Clearance.Value < 4 then
                plr.Clearance.Value = 4
            end
        end
        if plr:GetRankInGroup(_G.GroupId) >=  6 then
            if plr.Clearance.Value < 3 then
                plr.Clearance.Value = 3
            end
        end
        if plr:GetRankInGroup(_G.GroupId) >=  5 then
            if plr.Clearance.Value < 2 then
                plr.Clearance.Value = 2
            end
        end
        if plr:GetRankInGroup(_G.GroupId) >=  4 then
            if plr.Clearance.Value < 1 then
                plr.Clearance.Value = 1
            end
        end
        if plr:GetRankInGroup(_G.GroupId) >=  3 then
            if plr.Clearance.Value < 1 then
                plr.Clearance.Value = 1
            end
        end

        if _G.Area39:IsMod(plr) then
            if game.ServerStorage.Tools:FindFirstChild("Cuffs") then
                game.ServerStorage.Tools:FindFirstChild("Cuffs"):Clone().Parent = plr.Backpack
            end
        end

        if MarketPlaceService:UserOwnsGamePassAsync(plr.UserId,11284472) then -- Minigun
            if game.ServerStorage.Tools:FindFirstChild("M134") then
                game.ServerStorage.Tools:FindFirstChild("M134"):Clone().Parent = plr.Backpack
            end
        end
    end
    --[[if plr:IsInGroup(_G.GroupId) then
        game.ServerStorage.Tools['DEAGLE']:Clone().Parent = plr.Backpack
    end]]
    --[[delay(1,function()
        if plr.Character:FindFirstChild("Animate") then
            plr.Character:FindFirstChild("Animate").Disabled = true
            plr.Character:FindFirstChild("Animate"):Destroy()
        end
        game.ReplicatedStorage.Anima:Clone().Parent = plr.Character
    end)]]
   
end

return module 