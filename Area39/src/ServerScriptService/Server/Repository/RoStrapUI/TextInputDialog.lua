-- 2-step Choice Dialog ReplicatedPseudoInstance
-- @source https://raw.githubusercontent.com/RoStrap/RoStrapUI/master/ChoiceDialog.lua
-- @rostrap ChoiceDialog
-- @documentation https://rostrap.github.io/Libraries/RoStrapUI/ChoiceDialog/
-- @author Validark

-- Note: You should only be using 1 at once, for a given player

local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Resources = require(ReplicatedStorage.Common:WaitForChild("Resources"))

local Color = Resources:LoadLibrary("Color")
local Debug = Resources:LoadLibrary("Debug")
local Tween = Resources:LoadLibrary("Tween")
local Typer = Resources:LoadLibrary("Typer")
local Enumeration = Resources:LoadLibrary("Enumeration")
local PseudoInstance = Resources:LoadLibrary("PseudoInstance")
local ReplicatedPseudoInstance = Resources:LoadLibrary("ReplicatedPseudoInstance")

local Radio = Resources:LoadLibrary("Radio")
local Shadow = Resources:LoadLibrary("Shadow")
local RadioGroup = Resources:LoadLibrary("RadioGroup")
local RippleButton = Resources:LoadLibrary("RippleButton")
local RoStrapPriorityUI = Resources:LoadLibrary("RoStrapPriorityUI")

local BUTTON_WIDTH_PADDING = 8

local Left = Enum.TextXAlignment.Left.Value
local SourceSansSemibold = Enum.Font.SourceSansSemibold.Value

local Flat = Enumeration.ButtonStyle.Flat.Value
local InBack = Enumeration.EasingFunction.InBack.Value
local OutBack = Enumeration.EasingFunction.OutBack.Value

local LocalPlayer, PlayerGui do
	if RunService:IsClient() then
		if RunService:IsServer() then
			PlayerGui = game:GetService("CoreGui")
		else
			repeat LocalPlayer = Players.LocalPlayer until LocalPlayer or not wait()
			repeat PlayerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui") until PlayerGui or not wait()
		end
	end
end

local Frame do
	Frame = Instance.new("Frame")
	Frame.BackgroundTransparency = 1
	Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
	Frame.AnchorPoint = Vector2.new(0.5, 0.5)
	Frame.Size = UDim2.new(1, 0, 1, 0)
	Frame.Name = "TextInputDialog"

	local UIScale = Instance.new("UIScale")
	UIScale.Scale = 0
	UIScale.Name = "UIScale"
	UIScale.Parent = Frame

	local Background = Instance.new("ImageLabel")
	Background.BackgroundTransparency = 1
	Background.ScaleType = Enum.ScaleType.Slice
	Background.SliceCenter = Rect.new(4, 4, 256 - 4, 256 - 4)
	Background.Image = "rbxassetid://1934624205"
	Background.Size = UDim2.new(0.5, 0, 0.4, 0)
	Background.Position = UDim2.new(0.5, 0, 0.5, 0)
	Background.AnchorPoint = Vector2.new(0.5, 0.5)
	Background.Name = "Background"
	Background.ZIndex = 2
	Background.Parent = Frame

	local Header = Instance.new("TextLabel")
	Header.Font = SourceSansSemibold
	Header.TextSize = 26
	Header.Size = UDim2.new(1, -24, 0, 64)
	Header.Position = UDim2.new(0, 24, 0, 1)
	Header.BackgroundTransparency = 1
	Header.TextXAlignment = Left
	Header.TextTransparency = 0.13
	Header.TextColor3 = Color.Black
	Header.Name = "Header"
	Header.ZIndex = 3
	Header.Parent = Background

	local Border = Instance.new("Frame")
	Border.BackgroundColor3 = Color.Black
	Border.BackgroundTransparency = 238 / 255
	Border.BorderSizePixel = 0
	Border.Position = UDim2.new(0, 0, 0, 64 - 2 + 1)
	Border.Size = UDim2.new(1, 0, 0, 1)
	Border.ZIndex = 3
	Border.Parent = Background
	
	

	local BottomBorder = Border:Clone()
	BottomBorder.Position = UDim2.new(0, 0, 1, -52 + 2 - 4 + 1)
	BottomBorder.Parent = Background

	local Shadow = PseudoInstance.new("Shadow")
	Shadow.Elevation = 8
	Shadow.Parent = Background
end

local function OnDismiss(self)
	if not self.Dismissed then
		self:Dismiss()
		self.OnConfirmed:Fire(LocalPlayer, false)
	end
end

local function OnConfirm(self)
	if not self.Dismissed then
		self:Dismiss()
		self.OnConfirmed:Fire(LocalPlayer, self.Object.Background.textbox.InputBox.Text)
	end
end

local function ConfirmEnable(ConfirmButton)
	ConfirmButton.Disabled = false
end

local function HideUIScale(self)
	self.UIScale.Parent = nil
end

local DialogsActive = 0

local function SubDialogsActive()
	DialogsActive = DialogsActive - 1
end

local function AdjustButtonSize(Button)
	Button.Size = UDim2.new(0, Button.TextBounds.X + BUTTON_WIDTH_PADDING * 2, 0, 36)
end

return PseudoInstance:Register("TextInputDialog", {
	Storage = {};

	Internals = {"ConfirmButton", "DismissButton", "RadioGroup", "AssociatedRadioContainers", "Header", "UIScale", "Background";
		SHOULD_BLUR = false;
	};

	Events = {"OnConfirmed"};

	Methods = {
		Enter = function(self)
			self.UIScale.Parent = self.Object
			self.Object.Parent = self.SCREEN
			AdjustButtonSize(self.DismissButton)
			AdjustButtonSize(self.ConfirmButton)

			Tween(self.UIScale, "Scale", 1, OutBack, self.ENTER_TIME, true, HideUIScale, self)
		end;

		Dismiss = function(self)
			-- Destroys Dialog when done
			if not self.Dismissed then
				self.Dismissed = true
				Tween(self.UIScale, "Scale", 0, InBack, self.DISMISS_TIME, true, self.Janitor)
				self.UIScale.Parent = self.Object
				self:Unblur()
			end
		end;
	};

	Properties = {
		PrimaryColor3 = Typer.AssignSignature(2, Typer.Color3, function(self, PrimaryColor3)
			self.ConfirmButton.PrimaryColor3 = PrimaryColor3
			self.DismissButton.PrimaryColor3 = PrimaryColor3

			for Item, ItemContainer in next, self.AssociatedRadioContainers do
				Item.PrimaryColor3 = PrimaryColor3
				ItemContainer.PrimaryColor3 = PrimaryColor3
			end

			self:rawset("PrimaryColor3", PrimaryColor3)
		end);

		
		HeaderText = Typer.AssignSignature(2, Typer.String, function(self, Text)
			self.Header.Text = Text
			self:rawset("HeaderText", self.Header.Text)
		end);

		DismissText = Typer.AssignSignature(2, Typer.String, function(self, Text)
			local DismissButton = self.DismissButton
			DismissButton.Text = Text
			self:rawset("DismissText", DismissButton.Text)
		end);

		ConfirmText = Typer.AssignSignature(2, Typer.String, function(self, Text)
			local ConfirmButton = self.ConfirmButton
			ConfirmButton.Text = Text
			self:rawset("ConfirmText", ConfirmButton.Text)
		end);
		InputText = Typer.AssignSignature(2,Typer.String, function(self, Text) 
		
		end),
	};

	Init = function(self, ...)
		self:rawset("Object", Frame:Clone())
		self.UIScale = self.Object.UIScale
		self.Background = self.Object.Background
		self.Header = self.Background.Header
		self.AssociatedRadioContainers = {}

		local ConfirmButton = PseudoInstance.new("RippleButton")
		ConfirmButton.AnchorPoint = Vector2.new(1, 1)
		ConfirmButton.Position = UDim2.new(1, -8, 1, -8)
		ConfirmButton.BorderRadius = 4
		ConfirmButton.ZIndex = 10
		ConfirmButton.TextSize = 16
		ConfirmButton.TextTransparency = 0.13
		ConfirmButton.Style = Flat
		ConfirmButton.Parent = self.Background
		
		local TextBox = script.textbox:Clone()
		TextBox.Size = UDim2.new(.8,0,0.4,0)
		TextBox.Position = UDim2.new(0.5, 0, 0.5, 0)
		TextBox.ZIndex = 3
		TextBox.Parent = self.Background
		TextBox.InputBox.Changed:Connect(function()
			if TextBox:FindFirstChild("InputBox") then
				self.InputText = TextBox.InputBox.Text
				if #TextBox.InputBox.Text > 1 then
					ConfirmEnable(self.ConfirmButton)
				end
			end
		end)
		TextBox.InputBox.FocusLost:Connect(function(enter)
			if enter then
				if not self.Dismissed then
					OnConfirm(self)
				end
			end
		end)
		
		local DismissButton = ConfirmButton:Clone()
		DismissButton.Position = UDim2.new(0, -8, 1, 0)
		DismissButton.Parent = ConfirmButton.Object

		self.Janitor:Add(DismissButton:GetPropertyChangedSignal("TextBounds"):Connect(AdjustButtonSize, DismissButton), "Disconnect")
		self.Janitor:Add(ConfirmButton:GetPropertyChangedSignal("TextBounds"):Connect(AdjustButtonSize, ConfirmButton), "Disconnect")

		ConfirmButton.Disabled = true

		self.ConfirmButton = ConfirmButton
		self.DismissButton = DismissButton
		self.Janitor:Add(ConfirmButton.OnPressed:Connect(OnConfirm, self), "Disconnect")
		self.Janitor:Add(DismissButton.OnPressed:Connect(OnDismiss, self), "Disconnect")

		self.Janitor:Add(self.Object, "Destroy")
		self.Janitor:Add(self.UIScale, "Destroy")
		self.Janitor:Add(SubDialogsActive, true)

		self.PrimaryColor3 = Color3.fromRGB(98, 0, 238)
		self:superinit(...)
	end;
}, RoStrapPriorityUI)
