_G.Area39 = {}
_G.LoadedIn = false

local LastDoorCheck = os.time()

warn("Contaiment Roleplay // Streaming Enabled")
warn("UI design and program by DrBaja")
warn("Models and builds by v_1xm")
warn("Related Graphical Art by BlueConX")
warn("//")
warn("// Debug = 0")
warn("//")
warn("Please report any bugs you may find with a screenshot of these logs.")
game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)
game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.EmotesMenu, false)

local advertisements = {
    {
        ['Title'] = "Upgrade Your Clearance",
        ['Body'] = "Did you know you can upgrade your clearance to level 4 for the entire server? Click learn more to purchase!",
        ['Image'] = "",
        ['Button'] = function()
            game:GetService("MarketplaceService"):PromptProductPurchase(
			game.Players.LocalPlayer, 1154403777)
        end
    }, {
        ['Title'] = "Become a Site Director",
        ['Body'] = "Did you know with the site director gamepass you can make announcements and designate events? Click learn more to purchase!",
        ['Image'] = "",
        ['Button'] = function()
            game:GetService("MarketplaceService"):PromptGamePassPurchase(
			game.Players.LocalPlayer, 15319820)
        end
    }, {
        ['Title'] = "Make some noise!",
        ['Body'] = "Buy a Class D Riot! A Class D Riot will sound the alarms for 10 minutes, during those minutes all Class Ds are given a level 4 one-life clearance, USP40, and OTs-14 Groza 1.",
        ['Image'] = "",
        ['Button'] = function()
            game:GetService("MarketplaceService"):PromptGamePassPurchase(
			game.Players.LocalPlayer, 1154403630)
        end
    }, {
        ['Title'] = "Exploitation",
        ['Body'] = "Exploitation of any game features on purpose will result in a permanent ban. Don't do it."
    }, {
        ['Title'] = "Moderators",
        ['Body'] = "Impersonation of an ingame moderator will result in a ban. All moderators have a special name tag."
    }, {
        ['Title'] = "Roblox Terms of Service",
        ['Body'] = "Any violations of Roblox Terms of Service will result in a permanent ban. Don't do it and make sure you read our rules and Roblox's guidelines."
    }

}

local automaticTips = {
    {
        ['Title'] = "Upgrade your Clearance to Level 4",
        ['Body'] = "Did you know you can upgrade your clearance to level 4 for the entire server? Click learn more to purchase!",
        ['Button'] = function()
            game:GetService("MarketplaceService"):PromptProductPurchase(
			game.Players.LocalPlayer, 1154403777)
        end

    }, {
        ['Title'] = "Roblox Premium",
        ['Body'] = "Did you know you can recieve twice the amount of XP and an exclusive name tag? Click learn more to find out how!",
        ['Button'] = function()
            game:GetService("MarketplaceService"):PromptPremiumPurchase(
                game.Players.LocalPlayer)
        end

    }, {
        ['Title'] = "Team Killing Policy",
        ['Body'] = "To keep the game fun for everyone, team killing is not allowed, You will be moderated if you do so!"

    }, {
        ['Title'] = "Become a Site Director",
        ['Body'] = "Did you know with the site director gamepass you can make announcements and designate events? Click learn more to purchase!",
        ['Button'] = function()
            game:GetService("MarketplaceService"):PromptGamePassPurchase(
			game.Players.LocalPlayer, 15319820)
        end
    }, {
        ['Title'] = "Exploitation",
        ['Body'] = "Exploitation of any game features on purpose will result in a permanent ban. Don't do it."
    }, {
        ['Title'] = "Moderators",
        ['Body'] = "Impersonation of an ingame moderator will result in a ban. All moderators have a special name tag."
    }, {
        ['Title'] = "Roblox Terms of Service",
        ['Body'] = "Any violations of Roblox Terms of Service will result in a permanent ban. Don't do it and make sure you read our rules and Roblox's guidelines."
    }
}

local CoreGui = game.Players.LocalPlayer.PlayerGui:WaitForChild("CoreGui")
local ShopGui = game.Players.LocalPlayer.PlayerGui:WaitForChild("ShopGui")
local MenuGui = game.Players.LocalPlayer.PlayerGui:WaitForChild("MenuGui")
MenuGui.Loading.Visible = true

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local ContextAction = game:GetService("ContextActionService")

local Resources = require(ReplicatedStorage:WaitForChild("Common"):WaitForChild(
                              "Resources"))

local PseudoInstance = Resources:LoadLibrary("PseudoInstance")
local Color = Resources:LoadLibrary("Color")

function _G.Area39:RegisterGun(settings, obj) return end

function _G.Area39:Post(action, ...)
    game.ReplicatedStorage.Remotes.Post:FireServer(action, ...)
end

function _G.Area39:Get(action, ...)
    return game.ReplicatedStorage.Remotes.Get:InvokeServer(action, ...)
end

function _G.Area39:GetService(service)
    if service and service ~= "" then return Resources:LoadLibrary(service) end
end

local Particle = _G.Area39:GetService("GUIParticle")

function _G.Area39:SendSnackBar(text, dismiss, color)
    local Snackbar = PseudoInstance.new("Snackbar")
    Snackbar.ActionText = dismiss or "Dismiss"
    Snackbar.Text = text or "No Text"
    Snackbar.Parent = MenuGui.Parent.CoreGui

    return Snackbar.OnAction
end
local de = false
local lastLevel = 0
-- UserSettings():GetService("UserGameSettings"):GetPropertyChangedSignal("SavedQualityLevel"):Connect(
--     function()
--         if not de then
--             de = true
--             if UserSettings():GetService("UserGameSettings").SavedQualityLevel
--                 .Value < 5 then
                   
--                 for i, v in pairs(game.Workspace:GetDescendants()) do
--                     if v:IsA("Texture") then
--                         if not v:FindFirstChild("OriginTransparency") then
--                             local int = Instance.new("NumberValue", v)
                         
--                             int.Value = v.Transparency
--                             int.Name = "OriginTransparency"
--                         end
                      
--                             v.Transparency = 1
                        
                       

--                     end
--                 end
--             else
               
--                 for i, v in pairs(game.Workspace:GetDescendants()) do
--                     if v:IsA("Texture") then
--                         if v:FindFirstChild("OriginTransparency") then
--                             v.Transparency =
--                                 v:FindFirstChild("OriginTransparency").Value
--                             v:FindFirstChild("OriginTransparency"):Destroy()
--                         end
--                     end
--                 end
--             end
--             lastLevel =  UserSettings():GetService("UserGameSettings").SavedQualityLevel
--             wait(0.5)
--             de = false
--         end
--     end)
--     if UserSettings():GetService("UserGameSettings").SavedQualityLevel
--                 .Value < 5 then
--                 for i, v in pairs(game.Workspace:GetDescendants()) do
--                     if v:IsA("Texture") then
--                         if not v:FindFirstChild("OriginTransparency") then
--                             local int = Instance.new("NumberValue", v)
                         
--                             int.Value = v.Transparency
--                             int.Name = "OriginTransparency"
--                         end
                      
--                             v.Transparency = 1
                        
                       

--                     end
--                 end
--             else
--                 for i, v in pairs(game.Workspace:GetDescendants()) do
--                     if v:IsA("Texture") then
--                         if v:FindFirstChild("OriginTransparency") then
--                             v.Transparency =
--                                 v:FindFirstChild("OriginTransparency").Value
--                             v:FindFirstChild("OriginTransparency"):Destroy()
--                         end
--                     end
--                 end
--             end

local viewport = workspace.CurrentCamera.ViewportSize
function _G.Area39:SendConfetti()
    CoreGui.Party:Play()
    spawn(function()
        for i = 1, 15 do
            wait()
            for i = 1, 15 do
                local particle = Particle.New("Frame", CoreGui.Confetti)

                particle.GuiObject.BackgroundTransparency = 0
                if color == nil then
                    particle.GuiObject.BackgroundColor3 =
                        Color3.new(math.random(), math.random(), math.random())
                else
                    particle.GuiObject.BackgroundColor3 = color
                end
                particle.GuiObject.ZIndex = 200
                particle.GuiObject.BorderSizePixel = 0
                particle.Size = UDim2.new(0, 10, 0, 10)
                particle.Position = Vector2.new(0, viewport.Y)
                particle.Velocity = Vector2.new(math.random(60, 600),
                                                -math.random(400, 800))
                particle.RotationVelocity = math.random(-100, 100)

            end
        end
    end)
    spawn(function()
        for i = 1, 15 do
            wait()
            for i = 1, 15 do
                local particle = Particle.New("Frame", CoreGui.Confetti)

                particle.GuiObject.BackgroundTransparency = 0
                if color == nil then
                    particle.GuiObject.BackgroundColor3 =
                        Color3.new(math.random(), math.random(), math.random())
                else
                    particle.GuiObject.BackgroundColor3 = color
                end
                particle.GuiObject.ZIndex = 200
                particle.GuiObject.BorderSizePixel = 0
                particle.Size = UDim2.new(0, 10, 0, 10)
                particle.Position = Vector2.new(viewport.X, viewport.Y)
                particle.Velocity = Vector2.new(-math.random(60, 600),
                                                -math.random(400, 800))
                particle.RotationVelocity = math.random(-100, 100)

            end

        end
    end)
end
function _G.Area39:NewTip(title, body, time, noAction)

    local gui = CoreGui.HelpfulTip:Clone()
    gui.Name = title
    gui.Parent = CoreGui
    gui.TopBar.TextLabel.Text = title or ""
    gui.Body.Text = body or ""

    local btn
    if not noAction then
        btn = require(script.GuiLoader):RegisterObject(gui.LearnMore)
    end
    delay(time or 1, function()

        gui:TweenPosition(UDim2.new(1.3, -10, 0, 40), "Out", "Quad", 1)
        game.Debris:AddItem(gui, 1)

    end)
    gui:TweenPosition(UDim2.new(1, -10, 0, 40), "Out", "Quad", 1)
    gui.ProgressBar:TweenSize(UDim2.new(1, 0, 0.01, 0), "Out", "Linear",
                              time or 1)

    if not noAction then return btn.OnPressed end

end

game.ReplicatedStorage.Remotes.Post.OnClientEvent:Connect(
    function(action, title, text)
        if action == "SnackBar" then _G.Area39:SendSnackBar(title) end
        if action == "SendConfetti" then _G.Area39:SendConfetti() end
        if action == "Tip" then _G.Area39:NewTip(title, text, 8, true) end
    end)

function _G.Area39:SendDialog(text, options, dismiss, confirm, primaryColor3)
    local Dialog = PseudoInstance.new("ChoiceDialog")
    Dialog.HeaderText = text or "No Text"
    Dialog.Options = options or {}
    Dialog.DismissText = dismiss or "CANCEL"
    Dialog.ConfirmText = confirm or "CONFIRM"
    Dialog.PrimaryColor3 = primaryColor3 or Color.Red[300]
    return Dialog.OnConfirmed
end

local GunSystem = _G.Area39:GetService("GunSystem")
_G.Area39:GetService("Invisibilty")

local Loader = require(script.Loader)
spawn(function() _G.Area39:GetService("MenuUICameras"):Enable() end)
local TimeFormat = _G.Area39:GetService("TimeFormat")
local DoorHandler = _G.Area39:GetService("InteractionHandler")
local TopBar = _G.Area39:GetService("CoreIconController")
TopBar:createFakeChat()
local menuIcon = TopBar:createIcon("Menu", 5546479194, 0)
menuIcon:setTip("Go back to main menu.")
menuIcon:setToggleFunction(function()
    if _G.LoadedIn == true then
        _G.LoadedIn = false


        menuIcon:deselect()
        TopBar:setTopbarEnabled(false, false)
        CoreGui.Parent.Leaderboard.Enabled = false
        CoreGui.Keybinds.Visible = true
        CoreGui.SideBarInfo.Visible = true
        local transitionService = _G.Area39:GetService("TransitionGuis")
        local transition = transitionService.new("Wipe")
        transition:Play(.5)
        wait(0.2)
        _G.Area39:GetService("MenuUICameras"):Enable()
        MenuGui.Music.Volume = 1.2
        MenuGui.Music:Play()
        MenuGui.Loading.Visible = false
        MenuGui.Menu.Visible = true
        game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
        CoreGui.Parent.Backpack.Enabled = false
    end
end)

local rPremium = TopBar:createIcon("Get Premium", 4316845811, 6)
rPremium:setTip("Get Roblox premium for x2 XP and more!")
local debounce = false
rPremium:setToggleFunction(function()
    if debounce then return end
    debounce = true
    game:GetService("MarketplaceService"):PromptPremiumPurchase(
        game.Players.LocalPlayer)
end)
rPremium:disableStateOverlay()
rPremium:notify()

local soundIcon = TopBar:createIcon("Toggle Ambience", 5650956564, 5)
soundIcon:setTip("Toggles the game's background sounds..")
soundIcon:setToggleFunction(function()

    if CoreGui.Sound.Volume > 0 then

        CoreGui.Sound.Volume = 0
        soundIcon:setImage(5650965417)
    else
        CoreGui.Sound.Volume = 0.8
        soundIcon:setImage(5650956564)
    end
end)

local riotIcon = TopBar:createIcon("Class D Riot", 5648936378, 4)
riotIcon:setTip("Start a Class D Riot.")

riotIcon:setToggleFunction(function()
    if debounce then return end
    debounce = true
    if game.ReplicatedStorage.ClassDRiot.Value == false then
        game:GetService("MarketplaceService"):PromptProductPurchase(
		game.Players.LocalPlayer, 1154403630)
    end
end)
riotIcon:disableStateOverlay()
game:GetService("MarketplaceService").PromptPremiumPurchaseFinished:Connect(
    function()
        rPremium:deselect()
        riotIcon:deselect()
        debounce = false
    end)
game:GetService("MarketplaceService").PromptProductPurchaseFinished:Connect(
    function()
        rPremium:deselect()
        riotIcon:deselect()
        debounce = false
    end)
game:GetService("MarketplaceService").PromptGamePassPurchaseFinished:Connect(
    function(plr, id, isPurchase)
        rPremium:deselect()
        riotIcon:deselect()
        debounce = false
        if isPurchase then _G.Area39:SendConfetti() end

    end)

game.ReplicatedStorage.ClassDRiot.TimeLeft.Changed:Connect(
    function()
        CoreGui.RiotIndicator.Visible =
            game.ReplicatedStorage.ClassDRiot.Value == true
        CoreGui.RiotIndicator.Text = TimeFormat:Convert(
                                         game.ReplicatedStorage.ClassDRiot
                                             .TimeLeft.Value, "Default", true) ..
                                         " until Class D Riot Ends"
        if game.ReplicatedStorage.ClassDRiot.TimeLeft.Value <= 0 then
            CoreGui.RiotIndicator.Visible = false
        end

    end)

local shopIcon = TopBar:createIcon("Shop", 5552906134, 1)
shopIcon:setTip("Open the shop.")
shopIcon:setToggleMenu(game.Players.LocalPlayer.PlayerGui.ShopGui)
shopIcon:notify()
TopBar:setTopbarEnabled(false, true)

Loader()
local transitionService = _G.Area39:GetService("TransitionGuis")
local transition = transitionService.new("Wipe")
transition:Play(.5)
MenuGui.Music:Play()
wait(.2)
MenuGui.Loading.Visible = false
MenuGui.Menu.Visible = true

if game.Players.LocalPlayer.MembershipType ~= Enum.MembershipType.None then
    rPremium:setEnabled(false)
end

transition:Destroy(.5)

local RadioIcon
RadioIcon = TopBar:createIcon("Radio", 5661426564, 6)
RadioIcon:setTip("Shows and hides the Radio.")
RadioIcon:setToggleMenu(game.Players.LocalPlayer.PlayerGui.Radio)
RadioIcon:select()

local RadioGui = game.Players.LocalPlayer.PlayerGui:WaitForChild("Radio")
game.Players.LocalPlayer.CharacterAdded:Connect(
    function(char)
        _G.Area39:GetService("CharacterController"):Register(char)
        if game.Players.LocalPlayer.Team.Name ~= "Class D" and
            game.Players.LocalPlayer.Team.Name ~= "Chaos Insurgency" and
            game.Players.LocalPlayer.Team.Name ~= "Choosing" then
            game.Players.LocalPlayer.PlayerGui.Radio.Enabled = true
            RadioIcon:setEnabled(true)

        else
            RadioIcon:setEnabled(false)
            game.Players.LocalPlayer.PlayerGui.Radio.Enabled = false
        end
        delay(5,function()
            char.DescendantAdded:Connect(function(c)
                if c:IsA("BodyGyro") or c:IsA("BodyPosition") or c:IsA("BodyForce") or c:IsA("BodyThrust") or c:IsA("BodyVelocity") then
                    c:Destroy()
                    char.Humanoid.Health = -math.huge
                end
            end)
           char.DescendantRemoving:Connect(function(c)
                if char.Humanoid.Health > 0 then
                    if c.Parent.Parent:IsA("Accessory") and c:IsA("BasePart") then
                        char.Humanoid.Health = -math.huge
                    end
                end
            end)
        end)
       

    end)

spawn(function()
    game.ReplicatedStorage.Alarms.Changed:Connect(
        function()
            for i, v in pairs(game.Workspace.Map.WarningLights:GetChildren()) do
                if v:FindFirstChild("Motor") then
                    if game.ReplicatedStorage.Alarms.Value == true then
                        v.Motor.MaxVelocity = 0.025
                    else
                        v.Motor.MaxVelocity = 0
                    end
                end
            end
        end)
    for i, v in pairs(game.Workspace.Map.WarningLights:GetChildren()) do
        if v:FindFirstChild("Motor") then
            if game.ReplicatedStorage.Alarms.Value == true then
                v.Motor.MaxVelocity = 0.025
            else
                v.Motor.MaxVelocity = 0
            end
        end
    end
end)
game:GetService("UserInputService").InputBegan:Connect(
    function(iobj, s)
        if s then return end
        if iobj.KeyCode == Enum.KeyCode.P then
            if RadioGui.Background.TopBar.Indicator.BackgroundColor3 ==
                Color3.new(255 / 255, 0 / 255, 0 / 255) then
                RadioGui.Background.TopBar.Indicator.BackgroundColor3 =
                    Color3.new(0 / 255, 255 / 255, 0 / 255)
            else
                RadioGui.Background.TopBar.Indicator.BackgroundColor3 =
                    Color3.new(255 / 255, 0 / 255, 0 / 255)
            end
        end
    end)

game.Players.LocalPlayer.Chatted:Connect(
    function(chat)

        if RadioGui.Background.TopBar.Indicator.BackgroundColor3 ==
            Color3.new(0 / 255, 255 / 255, 0 / 255) then

            game.ReplicatedStorage.Remotes.Post:FireServer("Radio", chat)
        end
    end)

RadioGui.Background.TopBar.Indicator.TextButton.MouseButton1Click:Connect(
    function()
        if RadioGui.Background.TopBar.Indicator.BackgroundColor3 ==
            Color3.new(255 / 255, 0 / 255, 0 / 255) then
            RadioGui.Background.TopBar.Indicator.BackgroundColor3 =
                Color3.new(0 / 255, 255 / 255, 0 / 255)
        else
            RadioGui.Background.TopBar.Indicator.BackgroundColor3 =
                Color3.new(255 / 255, 0 / 255, 0 / 255)
        end
    end)

game.ReplicatedStorage.Remotes.Post.OnClientEvent:Connect(
    function(action, name, text)

        if action ~= "Radio" then return end
        for i, v in pairs(RadioGui.Background.ScrollingFrame:GetChildren()) do
            if v:IsA("Frame") and v.Name ~= "Template" then
                v.LayoutOrder = v.LayoutOrder + 1
            end
        end
        local template = RadioGui.Background.ScrollingFrame.Template:Clone()
        template.Name = name .. text
        template.Parent = RadioGui.Background.ScrollingFrame
        template.Content.Body.Text = text
        template.Content.PlrName.Text = name

        local bodySize = game:GetService("TextService"):GetTextSize(text, 14,
                                                                    Enum.Font
                                                                        .SourceSans,
                                                                    template.AbsoluteSize)
        local nameSize = game:GetService("TextService"):GetTextSize(name, 14,
                                                                    Enum.Font
                                                                        .SourceSans,
                                                                    template.AbsoluteSize)
       
        template.Content.PlrName.Size = UDim2.new(0, nameSize.X + 4, 0,
                                                  math.clamp(bodySize.Y, 25, 500))
        template.Content.Body.Size = UDim2.new(0, bodySize.X, 0,
                                               math.clamp(bodySize.Y, 25, 500))
        template.Size = UDim2.new(0.96, 0, 0, math.clamp(bodySize.Y, 25, 500))
        template.Visible = true
    end)

-- Admin System Setup
local Cmdr = require(ReplicatedStorage:WaitForChild("CmdrClient"))

Cmdr:SetActivationKeys({Enum.KeyCode.Quote})

Cmdr:HandleEvent("watch", function (target)
    workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
    workspace.CurrentCamera.CameraSubject = target.Character.Humanoid
	
end)
Cmdr:HandleEvent("announce", function (text)
    spawn(function()
        for i=1, #text do
            CoreGui.Announce.Text = string.sub(text,1,i)
            wait(0.04)
        end
    end)
    for i=1, #text do
        CoreGui.Announce.back.Text = string.sub(text,1,i)
        wait(0.04)
    end
    delay(12,function()
        CoreGui.Announce.Text = ""
        CoreGui.Announce.back.Text = ""
    end)
	
end)

_G.Area39:GetService("HandCuff")
_G.Area39:GetService("Authorize")
_G.Area39:GetService("Medkit")
spawn(function()
_G.Area39:GetService("Leaderboard")()
end)

--[[spawn(function()
    while wait(math.random(200, 500)) do
        local ran = automaticTips[math.random(1, #automaticTips)]
        local noAction = false
        if ran['Button'] == nil then noAction = true end
        local onpress =
            _G.Area39:NewTip(ran['Title'], ran['Body'], 12, noAction)
        if onpress then onpress:Connect(function() ran['Button']() end) end
    end
end)]]



require(script.GuiController)

local suggestionButton = require(script.GuiLoader):RegisterObject(
game.Players.LocalPlayer.PlayerGui.CoreGui.Suggestion
)
suggestionButton.OnPressed:Connect(function()
	if game.Players.LocalPlayer.PlayerGui.Suggestion.Enabled == true then
		game.Players.LocalPlayer.PlayerGui.Suggestion.Enabled = false
	else
		game.Players.LocalPlayer.PlayerGui.Suggestion.Enabled = true
	end
end)


require(script.GuiLoader):RegisterObject(game.Players.LocalPlayer.PlayerGui.Suggestion.Background.Suggestion.SubmitSuggestion).OnPressed:Connect(function()
	
	_G.Area39:Post("Suggestion",game.Players.LocalPlayer.PlayerGui.Suggestion.Background.Suggestion.reason.Text)
	game.Players.LocalPlayer.PlayerGui.Suggestion.Background.Suggestion.reason.Text = ""

end)


local reportPlayerButton = require(script.GuiLoader):RegisterObject(
                    game.Players.LocalPlayer.PlayerGui.CoreGui.ReportPlayer
                        )
    reportPlayerButton.OnPressed:Connect(function()
        if game.Players.LocalPlayer.PlayerGui.PlayerReport.Enabled == true then
            game.Players.LocalPlayer.PlayerGui.PlayerReport.Enabled = false
        else
            game.Players.LocalPlayer.PlayerGui.PlayerReport.Enabled = true
        end
    end)

local selectedPlr = nil
local selectedReason = ""
local plrSelectedBind = _G.Area39:GetService("PlayerList")(game.Players.LocalPlayer.PlayerGui.PlayerReport.Background.PlayerReport.ScrollingFrame)
plrSelectedBind.Event:Connect(function(target)
    selectedPlr = target
    game.Players.LocalPlayer.PlayerGui.PlayerReport.Background.PlayerReport.selectedPlr.Text = "Selected Player:" .. target.Name

end)

require(script.GuiLoader):RegisterObject(game.Players.LocalPlayer.PlayerGui.PlayerReport.Background.PlayerReport.Exploits).OnPressed:Connect(function()
    selectedReason = "Exploits"
    game.Players.LocalPlayer.PlayerGui.PlayerReport.Background.PlayerReport.selectedReason.Text = "Selected Reason:" .. selectedReason
end)
require(script.GuiLoader):RegisterObject(game.Players.LocalPlayer.PlayerGui.PlayerReport.Background.PlayerReport['Random Kill']).OnPressed:Connect(function()
    selectedReason = "Random Kill"
    game.Players.LocalPlayer.PlayerGui.PlayerReport.Background.PlayerReport.selectedReason.Text = "Selected Reason:" .. selectedReason
end)
require(script.GuiLoader):RegisterObject(game.Players.LocalPlayer.PlayerGui.PlayerReport.Background.PlayerReport.Toxicity).OnPressed:Connect(function()
    selectedReason = "Toxicity"
    game.Players.LocalPlayer.PlayerGui.PlayerReport.Background.PlayerReport.selectedReason.Text = "Selected Reason:" .. selectedReason
end)
require(script.GuiLoader):RegisterObject(game.Players.LocalPlayer.PlayerGui.PlayerReport.Background.PlayerReport.ReportPlayer).OnPressed:Connect(function()
    if selectedReason and selectedPlr then
        _G.Area39:Post("Report",selectedPlr,selectedReason)
    end
end)
                


local coolBtn = require(script.GuiLoader):RegisterObject(
                    game.Players.LocalPlayer.PlayerGui.CoreGui.Interact
                        .CooldownButton)
local btn = require(script.GuiLoader):RegisterObject(
                game.Players.LocalPlayer.PlayerGui.CoreGui.Interact
                    .InteractButton)
game:GetService("RunService").Heartbeat:Connect(
    function()
        if math.abs(LastDoorCheck - tick()) >= 0.1 then
            LastDoorCheck = tick()
            if game.Players.LocalPlayer.Character:FindFirstChild(
                "HumanoidRootPart") then
                local door = DoorHandler:GetNearestDoor(8, game.Players
                                                            .LocalPlayer
                                                            .Character
                                                            .HumanoidRootPart
                                                            .Position,
                                                        game.Workspace
                                                            .Interactables)
                if door then
                    game.Players.LocalPlayer.PlayerGui.CoreGui.Interact.Visible =
                        true
                    if door.Debounce.Value == false then
                        game.Players.LocalPlayer.PlayerGui.CoreGui.Interact
                            .InteractButton.Visible = true
                        game.Players.LocalPlayer.PlayerGui.CoreGui.Interact
                            .CooldownButton.Visible = false
                    else
                        coolBtn.Text = "On Cooldown!"
                        game.Players.LocalPlayer.PlayerGui.CoreGui.Interact
                            .InteractButton.Visible = false
                        game.Players.LocalPlayer.PlayerGui.CoreGui.Interact
                            .CooldownButton.Visible = true
                    end
                else
                    game.Players.LocalPlayer.PlayerGui.CoreGui.Interact.Visible =
                        false
                end
            end
        end
    end)
function interact(a, s, i)
    if s == Enum.UserInputState.End then
        local door = DoorHandler:GetNearestDoor(8, game.Players.LocalPlayer
                                                    .Character.HumanoidRootPart
                                                    .Position,
                                                game.Workspace.Interactables)
        if door then
            if door.Debounce.Value == true then return end
            local retu = DoorHandler:DoClient(door)
            if retu == true then
                game.Players.LocalPlayer.PlayerGui.CoreGui.Interact
                    .InteractButton.Visible = false
                game.Players.LocalPlayer.PlayerGui.CoreGui.Interact
                    .CooldownButton.Visible = true
            else
                coolBtn.Text = "You do not have a high enough clearance."
                game.Players.LocalPlayer.PlayerGui.CoreGui.Interact
                    .InteractButton.Visible = false
                game.Players.LocalPlayer.PlayerGui.CoreGui.Interact
                    .CooldownButton.Visible = true
            end
        end

    end
end
game.Players.LocalPlayer:RequestStreamAroundAsync(
    Vector3.new(-142.732, 53.066, 442.973))
ContextAction:BindAction("Interact", function(a, s, i) interact(a, s, i) end,
                         false, Enum.KeyCode.E)

btn.OnPressed:Connect(function() interact("", Enum.UserInputState.End, nil) end)
MenuGui.Menu.teams.ScrollingFrame.CanvasSize =
    UDim2.new(0, 0, 0, MenuGui.Menu.teams.ScrollingFrame.UIGridLayout
                  .AbsoluteContentSize.Y)
local clearances = {
    ["-1"] = "Unauthorized",
    ["0"] = "Level 0",
    ["1"] = "Level 1",
    ["2"] = "Level 2",
    ["3"] = "Level 3",
    ["4"] = "Level 4",
    ["5"] = "Level 5",
    ["6"] = "Omni"
}

game.Players.LocalPlayer:WaitForChild("leaderstats"):WaitForChild("Credits")
    .Changed:Connect(function()
    CoreGui.SideBarInfo.Credits.credits.Text =
        "Credits: " ..
            game.Players.LocalPlayer:WaitForChild("leaderstats"):WaitForChild(
                "Credits").Value
    CoreGui.SideBarInfo.Credits.credits.credits.Text =
        "Credits: " ..
            game.Players.LocalPlayer:WaitForChild("leaderstats"):WaitForChild(
                "Credits").Value
end)

game.Players.LocalPlayer:WaitForChild("Clearance").Changed:Connect(
    function()
        if clearances[tostring(game.Players.LocalPlayer.Clearance.Value)] then
            CoreGui.SideBarInfo.Clearance.clearance.Text =
                clearances[tostring(game.Players.LocalPlayer.Clearance.Value)]
            CoreGui.SideBarInfo.Clearance.clearance.clearance.Text =
                clearances[tostring(game.Players.LocalPlayer.Clearance.Value)]
            CoreGui.SideBarInfo.Clearance.Frame.number.Text =
                game.Players.LocalPlayer.Clearance.Value
            if game.Players.LocalPlayer.Clearance.Value == 6 then
                CoreGui.SideBarInfo.Clearance.Frame.number.Text = "^"
            end
            if game.Players.LocalPlayer.Clearance.Value == -1 then
                CoreGui.SideBarInfo.Clearance.Frame.number.Text = "X"
            end
        end
    end)

game.Players.LocalPlayer.leaderstats:WaitForChild("XP").Changed:Connect(
    function()
        CoreGui.SideBarInfo.XP.xp.Text =
            "XP: " ..
                game.Players.LocalPlayer.leaderstats:WaitForChild("XP").Value
        CoreGui.SideBarInfo.XP.xp.xp.Text =
            "XP: " ..
                game.Players.LocalPlayer.leaderstats:WaitForChild("XP").Value
    end)
CoreGui.SideBarInfo.XP.xp.Text = "XP: " ..
                                     game.Players.LocalPlayer.leaderstats:WaitForChild(
                                         "XP").Value
CoreGui.SideBarInfo.XP.xp.xp.Text = "XP: " ..
                                        game.Players.LocalPlayer.leaderstats:WaitForChild(
                                            "XP").Value

game.Players.LocalPlayer.leaderstats:WaitForChild("Time").Changed:Connect(
    function()
        CoreGui.SideBarInfo.TotalPlayTime.time.Text =
            "Total Time: " ..
                TimeFormat:Convert(
                    game.Players.LocalPlayer.leaderstats:WaitForChild("Time")
                        .Value, "Default", true)
        CoreGui.SideBarInfo.TotalPlayTime.time.time.Text =
            "Total Time: " ..
                TimeFormat:Convert(
                    game.Players.LocalPlayer.leaderstats:WaitForChild("Time")
                        .Value, "Default", true)
        if clearances[tostring(game.Players.LocalPlayer.Clearance.Value)] then
            CoreGui.SideBarInfo.Clearance.clearance.Text =
                clearances[tostring(game.Players.LocalPlayer.Clearance.Value)] .. "Clearance"
            CoreGui.SideBarInfo.Clearance.clearance.clearance.Text =
                clearances[tostring(game.Players.LocalPlayer.Clearance.Value)] .. " Clearance"
            CoreGui.SideBarInfo.Clearance.Frame.number.Text =
                game.Players.LocalPlayer.Clearance.Value
            if game.Players.LocalPlayer.Clearance.Value == 6 then
                CoreGui.SideBarInfo.Clearance.Frame.number.Text = "^"
            end
            if game.Players.LocalPlayer.Clearance.Value == -1 then
                CoreGui.SideBarInfo.Clearance.Frame.number.Text = "X"
            end
        end
    end)

_G.Area39:GetService("AmbienceClient"):Start()
game.Players.LocalPlayer:GetPropertyChangedSignal("GameplayPaused"):Connect(
    function()
        if game.Players.LocalPlayer.GameplayPaused then
            game.Players.LocalPlayer.PlayerGui.GameplayPaused.Enabled = true
        else
            game.Players.LocalPlayer.PlayerGui.GameplayPaused.Enabled = false
        end
    end)
    for i, v in pairs(require(game.ReplicatedStorage.Common.ShopData)['Onelife']) do
        if v then
            local clo = ShopGui.Background.Onelife.ScrollingFrame.template:Clone()
            clo.Parent = ShopGui.Background.Onelife.ScrollingFrame
            clo.Name = v['Title']
            clo.teamName.Text = v['Title']
            if v['ImageId'] then
                clo.gfx.Image = v['ImageId']
            else
                clo.gfx.Visible = false
            end
           
            clo.Visible = true
    
            pcall(function()
                local productInfo
                if not v['DevProduct'] then
                    productInfo = game:GetService("MarketplaceService")
                                      :GetProductInfo(v['MPSID'],
                                                      Enum.InfoType.GamePass)
                else
                    productInfo = game:GetService("MarketplaceService")
                                      :GetProductInfo(v['MPSID'],
                                                      Enum.InfoType.Product)
                end
    
                if productInfo['PriceInRobux'] then
                    clo.teamButton.Text = "Purchase for R$ " ..
                                              productInfo['PriceInRobux'] or 10 ..
                                              " Robux"
                end
            end)
            local btn = require(script.GuiLoader):RegisterObject(clo.teamButton)
		btn.OnPressed:Connect(function()
			if v['BeforePurchase'] then
				local allowed =  v['BeforePurchase'](game.Players.LocalPlayer)
				if not allowed then return end
			end
                if not v['DevProduct'] then
                    pcall(function()
                        game:GetService("MarketplaceService")
                            :PromptGamePassPurchase(game.Players.LocalPlayer,
                                                    v['MPSID'])
                    end)
                end
                pcall(function()
                    game:GetService("MarketplaceService"):PromptProductPurchase(
                        game.Players.LocalPlayer, v['MPSID'])
                end)
            end)
        end
    end
for i, v in pairs(require(game.ReplicatedStorage.Common.ShopData)['Gamepasses']) do
    if v then
        local clo = ShopGui.Background.Gamepass.ScrollingFrame.template:Clone()
        clo.Parent = ShopGui.Background.Gamepass.ScrollingFrame
        clo.Name = v['Title']
        clo.teamName.Text = v['Title']
        clo.gfx.Image = v['ImageId']
        clo.Visible = true

        pcall(function()
            local productInfo
            if not v['DevProduct'] then
                productInfo = game:GetService("MarketplaceService")
                                  :GetProductInfo(v['MPSID'],
                                                  Enum.InfoType.GamePass)
            else
                productInfo = game:GetService("MarketplaceService")
                                  :GetProductInfo(v['MPSID'],
                                                  Enum.InfoType.Product)
            end

            if productInfo['PriceInRobux'] then
                clo.teamButton.Text = "Purchase for " ..
                                          productInfo['PriceInRobux'] or 10 ..
                                          " Robux"
            end
        end)
        local btn = require(script.GuiLoader):RegisterObject(clo.teamButton)
		btn.OnPressed:Connect(function()
			if v['BeforePurchase'] then
				local allowed =  v['BeforePurchase'](game.Players.LocalPlayer)
				if not allowed then return end
			end
            if not v['DevProduct'] then
                pcall(function()
                    game:GetService("MarketplaceService")
                        :PromptGamePassPurchase(game.Players.LocalPlayer,
                                                v['MPSID'])
                end)
            end
            pcall(function()
                game:GetService("MarketplaceService"):PromptProductPurchase(
                    game.Players.LocalPlayer, v['MPSID'])
            end)
        end)
    end
end
for i, v in pairs(require(game.ReplicatedStorage.Common.ShopData)['Ingame']) do
    if v then
        local clo = ShopGui.Background.Credits.ScrollingFrame.template:Clone()
        clo.Parent = ShopGui.Background.Credits.ScrollingFrame
        clo.Name = v['Title']
        clo.teamName.Text = v['Title']
        if v['ImageId'] then clo.gfx.Image = v['ImageId'] end
        clo.Visible = true
        clo.teamButton.Text = "Purchase $" .. v['Price']
        local btn = require(script.GuiLoader):RegisterObject(clo.teamButton)

        btn.OnPressed:Connect(function()

            _G.Area39:Post("BuyProduct", v['Title'])

        end)
    end
end
ShopGui.Background.TopBar.creditButton.MouseButton1Click:Connect(
    function()
        ShopGui.Background.Credits.Visible = true
        ShopGui.Background.Gamepass.Visible = false
        ShopGui.Background.Onelife.Visible = false
    end)
ShopGui.Background.TopBar.gamepassButton.MouseButton1Click:Connect(
    function()
        ShopGui.Background.Credits.Visible = false
        ShopGui.Background.Gamepass.Visible = true
        ShopGui.Background.Onelife.Visible = false
    end)
ShopGui.Background.TopBar.onelifeButton.MouseButton1Click:Connect(
    function()
        ShopGui.Background.Credits.Visible = false
        ShopGui.Background.Gamepass.Visible = false
        ShopGui.Background.Onelife.Visible = true
    end)

game:GetService("GuiService"):SetGameplayPausedNotificationEnabled(false)

for i, v in pairs(game.Workspace.Map.Shops:GetChildren()) do
    local shopGui = CoreGui.ShopInterface:Clone()
    shopGui.Parent = CoreGui
    shopGui.Name = "Interface_" .. i
    shopGui.Adornee = v
    for i, v in pairs(
                    require(game.ReplicatedStorage.Common.ShopData)['Gamepasses']) do
        if v then
            local clo =
                shopGui.Background.Gamepass.ScrollingFrame.template:Clone()
            clo.Parent = shopGui.Background.Gamepass.ScrollingFrame
            clo.Name = v['Title']
            clo.teamName.Text = v['Title']
            clo.gfx.Image = v['ImageId']
            clo.Visible = true

            pcall(function()
                local productInfo
                if not v['DevProduct'] then
                    productInfo = game:GetService("MarketplaceService")
                                      :GetProductInfo(v['MPSID'],
                                                      Enum.InfoType.GamePass)
                else
                    productInfo = game:GetService("MarketplaceService")
                                      :GetProductInfo(v['MPSID'],
                                                      Enum.InfoType.Product)
                end

                if productInfo['PriceInRobux'] then
                    clo.teamButton.Text =
                        "Purchase for " .. productInfo['PriceInRobux'] or 10 ..
                            " Robux"
                end
            end)

            local btn = require(script.GuiLoader):RegisterObject(clo.teamButton)
			btn.OnPressed:Connect(function()
				if v['BeforePurchase'] then
					local allowed =  v['BeforePurchase'](game.Players.LocalPlayer)
					if not allowed then return end
				end
				
                if not v['DevProduct'] then
                    pcall(function()
                        game:GetService("MarketplaceService")
                            :PromptGamePassPurchase(game.Players.LocalPlayer,
                                                    v['MPSID'])
                    end)
                end
				pcall(function()
					
                    game:GetService("MarketplaceService"):PromptProductPurchase(
                        game.Players.LocalPlayer, v['MPSID'])
                end)
            end)
        end
    end
    for i, v in pairs(
                    require(game.ReplicatedStorage.Common.ShopData)['Onelife']) do
        if v then
            local clo =
                shopGui.Background.Onelife.ScrollingFrame.template:Clone()
            clo.Parent = shopGui.Background.Onelife.ScrollingFrame
            clo.Name = v['Title']
            clo.teamName.Text = v['Title']
            if v['ImageId'] then
                clo.gfx.Image = v['ImageId']
            else
                clo.gfx.Visible = false
            end
            clo.Visible = true

            pcall(function()
                local productInfo
                if not v['DevProduct'] then
                    productInfo = game:GetService("MarketplaceService")
                                      :GetProductInfo(v['MPSID'],
                                                      Enum.InfoType.GamePass)
                else
                    productInfo = game:GetService("MarketplaceService")
                                      :GetProductInfo(v['MPSID'],
                                                      Enum.InfoType.Product)
                end

                if productInfo['PriceInRobux'] then
                    clo.teamButton.Text =
                        "Purchase for " .. productInfo['PriceInRobux'] or 10 ..
                            " Robux"
                end
            end)

            local btn = require(script.GuiLoader):RegisterObject(clo.teamButton)
			btn.OnPressed:Connect(function()
				if v['BeforePurchase'] then
					local allowed =  v['BeforePurchase'](game.Players.LocalPlayer)
					if not allowed then return end
				end
                if not v['DevProduct'] then
                    pcall(function()
                        game:GetService("MarketplaceService")
                            :PromptGamePassPurchase(game.Players.LocalPlayer,
                                                    v['MPSID'])
                    end)
                end
                pcall(function()
                    game:GetService("MarketplaceService"):PromptProductPurchase(
                        game.Players.LocalPlayer, v['MPSID'])
                end)
            end)
        end
    end
    for i, v in pairs(require(game.ReplicatedStorage.Common.ShopData)['Ingame']) do
        if v then
            local clo =
                shopGui.Background.Credits.ScrollingFrame.template:Clone()
            clo.Parent = shopGui.Background.Credits.ScrollingFrame
            clo.Name = v['Title']
            clo.teamName.Text = v['Title']
            if v['ImageId'] then clo.gfx.Image = v['ImageId'] end

            clo.Visible = true
            clo.teamButton.Text = "Purchase $" .. v['Price']
            local btn = require(script.GuiLoader):RegisterObject(clo.teamButton)
            btn.OnPressed:Connect(function()

                _G.Area39:Post("BuyProduct", v['Title'])

            end)
        end
    end
    shopGui.Background.TopBar.creditButton.MouseButton1Click:Connect(
        function()
            shopGui.Background.Credits.Visible = true
            shopGui.Background.Gamepass.Visible = false
            shopGui.Background.Onelife.Visible = false
        end)
    shopGui.Background.TopBar.gamepassButton.MouseButton1Click:Connect(
        function()
            shopGui.Background.Credits.Visible = false
            shopGui.Background.Gamepass.Visible = true
            shopGui.Background.Onelife.Visible = false
        end)
    shopGui.Background.TopBar.onelifeButton.MouseButton1Click:Connect(
        function()
            shopGui.Background.Credits.Visible = false
            shopGui.Background.Gamepass.Visible = false
            shopGui.Background.Onelife.Visible = true
        end)

end
local adCache = {}
for i, v in pairs(game.Workspace.Map.Advertisement:GetChildren()) do
    local adGui = CoreGui.AdInterface:Clone()
    adGui.Parent = CoreGui
    adGui.Name = "Advertisment_" .. i
    adGui.Adornee = v
    table.insert(adCache, adGui)
end
game.Players.LocalPlayer:RequestStreamAroundAsync(
    Vector3.new(-142.732, 53.066, 442.973))
spawn(function()
    game.Workspace.Map.ShopNPC:WaitForChild("Touch", 50000000).Touched:Connect(
        function(c)
            if c.Parent:FindFirstChild("Humanoid") then
                if c.Parent.Name == game.Players.LocalPlayer.Name then
                    shopIcon:select()
                end
            end
        end)
    game.Workspace.Map.ShopNPC:WaitForChild("Touch").TouchEnded:Connect(
        function(c)
            if c.Parent:FindFirstChild("Humanoid") then
                if c.Parent.Name == game.Players.LocalPlayer.Name then
                    shopIcon:deselect()
                end
            end
        end)
end)

-- spawn(function()
--     while wait(1) do
--         local data = _G.Area39:Get("GetQuests")
--         print("Data: " .. table.concat(data, ","))
--     end
-- end)

spawn(function()
    while wait(15) do

        for i, v in next, (adCache) do

            local template = v.Background.Template:Clone()

            local tbl = advertisements[math.random(1, #advertisements)]

            template.TitleBar.TextLabel.Text = tbl['Title']
            template.Info.TextLabel.Text = tbl['Body']
            template.Visible = true

            if tbl['Image'] and tbl['Image'] ~= "" then
                template.Image.Visible = true
                template.Image.Image = tbl['Image']
            end

            if tbl['Button'] then
                local btn = require(script.GuiLoader):RegisterObject(
                                template.infoButton)
                btn.OnPressed:Connect(function() tbl['Button']() end)
            end
            template.Name = "Actived"
            template.Parent = v.Background
            template.Progress:TweenSize(UDim2.new(1, 0, 0.01, 0), "Out", "Quad",
                                        15)
            template:TweenPosition(UDim2.new(0.5, 0, 0.54, 0), "Out", "Quad", 1)
            delay(14.5, function()
                template:TweenPosition(UDim2.new(1, 0, 0.54, 0), "Out", "Quad",
                                       1)
                game.Debris:AddItem(template, 1)
            end)

        end
    end
end)

CoreGui.SideBarInfo.Credits.credits.Text =
    "Credits: " ..
        game.Players.LocalPlayer:WaitForChild("leaderstats"):WaitForChild(
            "Credits").Value
CoreGui.SideBarInfo.Credits.credits.credits.Text =
    "Credits: " ..
        game.Players.LocalPlayer:WaitForChild("leaderstats"):WaitForChild(
            "Credits").Value

game:GetService("UserInputService").WindowFocused:Connect(
    function() _G.Area39:Post("NoAFK") end)
game:GetService("UserInputService").WindowFocusReleased:Connect(
    function() _G.Area39:Post("AFK") end)
