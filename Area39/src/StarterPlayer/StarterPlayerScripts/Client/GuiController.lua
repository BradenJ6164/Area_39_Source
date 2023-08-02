local GuiLoader = require(script.Parent.GuiLoader)
local MenuGui = game.Players.LocalPlayer.PlayerGui:WaitForChild("MenuGui")
local CoreGui = game.Players.LocalPlayer.PlayerGui:WaitForChild("CoreGui")

local TeamData = require(game.ReplicatedStorage:WaitForChild("Common")
                             :WaitForChild("TeamData"))
local MarketPlaceService = game:GetService("MarketplaceService")
local TeamService = _G.Area39:GetService("Teams")
local TweenService = game:GetService("TweenService")

local LocalPlayer = game:GetService("Players").LocalPlayer
local TopBar = _G.Area39:GetService("CoreIconController")
local TeamName = ""
local VariationName = ""

local functions = {
	['Suggestion'] = function(btn)

	end,
    ['ReportPlayer'] = function(btn)
    
    end,
    ['Play'] = function(btn) 
        MenuGui.Menu.teams:TweenPosition(UDim2.new(1.5,0,0.4,-5),"Out","Quad",0.2)
        MenuGui.Menu.details:TweenPosition(UDim2.new(1.5,0,0.75,5),"Out","Quad",0.2)
        if TeamName == "" then
            _G.Area39:SendSnackBar("You need to choose a team to play.")
            return
        end
        if VariationName == "" then
            local var 
            for i,v in pairs(TeamData[TeamName]['Variations']) do
                if v['Order'] == 0 then
                    var = i
                end
            end
            if var then
                VariationName = var
            else
                VariationName = TeamName
            end
            
        end
        CoreGui.Parent.Leaderboard.Enabled = true
        _G.Area39:Post("ChangeTeam",TeamName,VariationName)
        local transitionService = _G.Area39:GetService("TransitionGuis")
        local transition = transitionService.new("Wipe")
        transition:Play(1)
        _G.Area39:GetService("MenuUICameras"):Disable()
        wait(0.29)
        MenuGui.Menu.Visible = false
        CoreGui.Keybinds.Visible = true
        CoreGui.SideBarInfo.Visible = true
        TopBar:setTopbarEnabled(true, false)
        local Tween = TweenService:Create(MenuGui.Music,TweenInfo.new(2),{Volume = 0})
        Tween:Play()
       CoreGui.Parent.Backpack.Enabled = true
        game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)

        _G.LoadedIn = true
    end, 
    ['Teams'] = function(btn) 
        MenuGui.Menu.teams:TweenPosition(UDim2.new(0.675,0,0.4,-5),"Out","Quad",0.2)
    end
}

game.Players.LocalPlayer:WaitForChild("leaderstats"):WaitForChild("XP").Changed:Connect(function()
    MenuGui.Menu.xp.Text = "XP: " .. game.Players.LocalPlayer:WaitForChild("leaderstats"):WaitForChild("XP").Value
end)
MenuGui.Menu.xp.Text = "XP: " .. game.Players.LocalPlayer:WaitForChild("leaderstats"):WaitForChild("XP").Value

for i, v in pairs(MenuGui:GetDescendants()) do
    if v:IsA("TextButton") and v:FindFirstChild("Material") and v.Parent.Name ~=
        "template" and v.Name ~= "template" then

        local btn = GuiLoader:RegisterObject(v)
        if functions[btn.Name] then
            btn.OnPressed:Connect(function() functions[btn.Name](btn) end) 
        end
    end
end


for i, v in next, TeamData do
    local clo = MenuGui.Menu.teams.ScrollingFrame.template:Clone()
    clo.Parent = MenuGui.Menu.teams.ScrollingFrame
    clo.Name = i
    clo.teamName.Text = i
    clo.gfx.Image = v['Image']
    clo.LayoutOrder = v['Order']

    local btn = GuiLoader:RegisterObject(clo.teamButton)
    btn.OnPressed:Connect(function()
        if TeamService:CheckPermission(LocalPlayer, i) then
            TeamName = i
            VariationName = ""
            
            MenuGui.Menu.detailtext2.Text = ""
            MenuGui.Menu.detailtext.Text = "Selected Team: " .. i
            MenuGui.Menu.details.teamName.Text = i
            MenuGui.Menu.details.teamDescription.Text = v['Description']
            MenuGui.Menu.details:TweenPosition(UDim2.new(0.675,0,0.75,5),"Out","Quad",0.2)
            for _, x in pairs(MenuGui.Menu.details.variations:GetChildren()) do
                if x.Name ~= "UIGridLayout" and x.Name ~= "template" then
                    x:Destroy()
                end
            end
            for z, x in pairs(v['Variations']) do
                local varClo = MenuGui.Menu.details.variations.template:Clone()
                varClo.Parent = MenuGui.Menu.details.variations
                varClo.Name = z
                varClo.btn.Text = z
                local variation = TeamData[i]['Variations'][z]
                varClo.requiredXP.Text = variation['XPNeeded'] .. " XP Required"
                if variation['GamepassRequired'] == true then
                    varClo.requiredXP.Text = "Gamepass Required"
                else
                    if variation['XPNeeded'] <= 0 then
                        varClo.requiredXP.Visible = false
                    end
                end
                

                

                local varBtn = GuiLoader:RegisterObject(varClo.btn)
                varBtn.OnPressed:Connect(
                    function()
                        MenuGui.Menu.details:TweenPosition(UDim2.new(0.675,0,0.75,5),"Out","Quad",0.2)
                        if TeamService:CheckVariationPermission(LocalPlayer, i,
                                                                z) then
                            VariationName = z
                            MenuGui.Menu.detailtext2.Text = "Select Variation: " .. z
                        else
                            local _,reducer,filled = TeamService:CheckVariationPermission(LocalPlayer, i,
                            z)
                            if filled then
                                _G.Area39:SendSnackBar("There is already an O5 on this team", "Ok!")
                                return
                            end
                           
                            if variation then
                                if variation['GamepassId'] ~= 0 and
                                    variation['GamepassRequired'] == true then
                                    _G.Area39:SendSnackBar(
                                        "This variation requires a gamepass.",
                                        "Ok!")
                                elseif variation['GamepassId'] ~= 0 then
                                    _G.Area39:SendSnackBar(
                                        "You do not have enough XP for this variation. You can bypass with a gamepass!",
                                        "Ok!")
                                else
                                    _G.Area39:SendSnackBar(
                                        "You do not have enough XP for this variation. You need " ..
                                            variation['XPNeeded']-reducer .. " XP!",
                                        "Ok!")
                                end
                            end
                        end
                    end)

                varClo.LayoutOrder = x['Order']

                varClo.Visible = true

                MenuGui.Menu.details.variations.Visible = true
            end

        else
            
            if TeamData[i]['GamepassId'] ~= 0 and
                TeamData[i]['GamepassRequired'] == true then
                MarketPlaceService:PromptGamePassPurchase(
                    LocalPlayer,
                    TeamData[i]['GamepassId'])
                _G.Area39:SendSnackBar("This team requires a gamepass.", "Ok!")
            elseif TeamData[i]['GamepassId'] ~= 0 then
                MarketPlaceService:PromptGamePassPurchase(
                    LocalPlayer,
                    TeamData[i]['GamepassId'])
                _G.Area39:SendSnackBar(
                    "You do not have enough XP for this team. You can bypass with a gamepass!",
                    "Ok!")
            else
                _G.Area39:SendSnackBar(
                    "You do not have enough XP for this team. You need " ..
                        TeamData[i]['XPNeeded'] .. " XP!", "Ok!")
            end

        end
    end)

    clo.Visible = true
end

return {}
