-- // DrBaja/Braden_J
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")

local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:wait()
local Hum = Player.Character:WaitForChild("Humanoid")
local Mouse = Player:GetMouse()
local UI = script.Parent
local Inventory = UI:WaitForChild("Inventory")
local SlotBar = UI:WaitForChild("SlotBar")
local ToggleInventoryUI = UI:WaitForChild("ToggleInventory")
local Backpack = Player:WaitForChild("Backpack")
local Settings = require(script:WaitForChild("Settings"))
local InventoryOpen = false
local Items = {}
local SlotFrames = {}
local Connections = {SlotNumberActivation = nil, ToolAncestryChanges = {}}

StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)

local function SetupDefaultUI()
	for Index = 1, Settings.HotbarMaxSlots do
		local Slot = script.Slot:Clone()
		Slot.LayoutOrder = Index
		SlotFrames[Index] = Slot
		Slot.Parent = SlotBar
	end
end

local function GetAvailableSlotFrame()
	for _, SlotFrame in pairs(SlotFrames) do
		if not SlotFrame:FindFirstChild("ItemTemplate") then
			return SlotFrame
		end
	end
	return nil
end

local function SearchForItemWithTool(Tool)
	for _, Item in pairs(Items) do
		if Item.Tool == Tool then
			return Item
		end
	end
	return nil
end

local function SearchForItemWithFrame(Frame)
	for _, Item in pairs(Items) do
		if Item.Frame == Frame then
			return Item
		end
	end
	return nil
end

local function AddItem(Tool)
	local NewItem = require(script.Item).new(Tool)
	NewItem:Initialise()
	NewItem:MoveTo(GetAvailableSlotFrame() or Inventory.Items)
	table.insert(Items, NewItem)
end

local function RemoveItem(Tool)
	for _, Item in pairs(Items) do
		if Item.Tool == Tool then
			Item:Unequip(Player)
			Item:Cleanup()
			table.remove(Items, table.find(Items, Item))
			return
		end
	end
end

local function SetupItem(Tool)
	if SearchForItemWithTool(Tool) then
		return
	end
	AddItem(Tool)
	local Item = SearchForItemWithTool(Tool)
	local OriginalFrameParent, OriginalFramePosition, PreMouseMoveConnection, MouseMoveConnection, MovingSlotAnimatorGuid
	Item.Frame.InputBegan:Connect(function(Input)
		if Input.UserInputType ~= Enum.UserInputType.MouseButton1 then
			return
		end
		OriginalFrameParent = Item.Frame.Parent
		OriginalFramePosition = Item.Frame.Position
		local OriginalMousePosition = {X = Mouse.X, Y = Mouse.Y}
		PreMouseMoveConnection = Mouse.Move:Connect(function()
			if not InventoryOpen then
				return
			end
			local DifferenceX = Mouse.X - OriginalMousePosition.X
			local DifferenceY = Mouse.Y - OriginalMousePosition.Y
			if DifferenceX > Settings.NumAmount or DifferenceX < Settings.NumAmount * -1 or DifferenceY > Settings.NumAmount or DifferenceY < Settings.NumAmount * -1 then
				PreMouseMoveConnection:Disconnect()
				Item:Unequip(Player)
				MouseMoveConnection = Mouse.Move:Connect(function()
					Item.Frame.Position = UDim2.new(0, Mouse.X, 0, Mouse.Y)
				end)
				Item.Frame.Parent = script.Parent
				Item.Frame.Position = UDim2.new(0, Mouse.X, 0, Mouse.Y)
			end
		end)
	end)
	Item.Frame.InputEnded:Connect(function(Input)
		if Input.UserInputType ~= Enum.UserInputType.MouseButton1 then
			return
		end
		PreMouseMoveConnection:Disconnect()
		if MouseMoveConnection then
			MouseMoveConnection:Disconnect()
		end
		MovingSlotAnimatorGuid = nil
		Item.Frame.Position = OriginalFramePosition
		if require(script.Area):IsInArea2D(Input.Position, Inventory.Items.AbsolutePosition, Inventory.Items.AbsoluteSize) then
			Item:MoveTo(Inventory.Items)
			return
		end
		for _, Frame in pairs(script.Parent.SlotBar:GetChildren()) do
			if Frame:IsA("Frame") and require(script.Area):IsInArea2D(Input.Position, Frame.AbsolutePosition, Frame.AbsoluteSize) then
				if Frame == OriginalFrameParent then
					Item:ToggleEquip(Player, not Item.Equipped)
				else
					local ExistingItemTemplate = Frame:FindFirstChild("ItemTemplate")
					if ExistingItemTemplate then
						ExistingItemTemplate.Parent = OriginalFrameParent
					end
					Item:MoveTo(Frame)
					return
				end
			end
		end
		Item:MoveTo(OriginalFrameParent)
	end)
	local GUID = HttpService:GenerateGUID(false)
	Connections.ToolAncestryChanges[GUID] = Tool.AncestryChanged:Connect(function(_, Parent)
		if Parent ~= Player.Character and Parent ~= Backpack then
			RemoveItem(Tool)
			Connections.ToolAncestryChanges[GUID]:Disconnect()
			Connections.ToolAncestryChanges[GUID] = nil
		end
	end)
end

local function ToggleInventory(ForceOption)
	if ForceOption == false or ForceOption == nil and InventoryOpen then
		ToggleInventoryUI.Frame.TextLabel.Text = "OPEN"
		InventoryOpen = false
		Inventory:TweenSize(UDim2.new(0, 395, 0, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, 0.2, true)
		return
	end
	ToggleInventoryUI.Frame.TextLabel.Text = "CLOSE"
	InventoryOpen = true
	Inventory:TweenSize(UDim2.new(0, 395, Settings.InventoryFullyExpandedSizeY, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, 0.2, true)
end

local function ToggleSlotNumberActivation(Toggle)
	if Toggle then
		Connections.SlotNumberActivation = UserInputService.InputBegan:Connect(function(Input, GameProcessedEvent)
			if GameProcessedEvent or not Settings.Numbers[Input.KeyCode] then
				return
			end
			for _, Frame in pairs(script.Parent.SlotBar:GetChildren()) do
				if Frame:IsA("Frame") and Frame.LayoutOrder == Settings.Numbers[Input.KeyCode] and Frame:FindFirstChild("ItemTemplate") then
					local Item = SearchForItemWithFrame(Frame.ItemTemplate)
					if not Item then
						return
					end
					Item:ToggleEquip(Player, not Item.Equipped)
				end
			end
		end)
		return
	end
	if Connections.SlotNumberActivation == nil or not Connections.SlotNumberActivation.Connected then
		return
	end
	Connections.SlotNumberActivation:Disconnect()
	Player.Character.Humanoid:UnequipTools()
end

local function RegisterBackpackEvents(Child)
	Backpack.ChildAdded:Connect(function(Child)
		if not Child:IsA("Tool") then
			return
		end
		SetupItem(Child)
	end)
end

Player.ChildAdded:Connect(function(Child)
	if not Child:IsA("Backpack") then
		return
	end
	Backpack = Child
	RegisterBackpackEvents(Child)
	for _, Item in pairs(Items) do
		RemoveItem(Item.Tool)
	end
	for _, Tool in pairs(Backpack:GetChildren()) do
		SetupItem(Tool)
	end
end)

Player.CharacterAdded:Connect(function()
	Player.Character.ChildAdded:Connect(function(Child)
		if not Child:IsA("Tool") or SearchForItemWithTool(Child) then
			return
		end
		wait()
		Child.Parent = Backpack
	end)
end)

UI:GetPropertyChangedSignal("Enabled"):Connect(function()
	if script.Parent.Enabled then
		ToggleSlotNumberActivation(true)
		return
	end
	ToggleSlotNumberActivation(false)
	ToggleInventory(false)
end)

UI.ToggleInventory.TextButton.MouseButton1Click:Connect(function()	
	ToggleInventory()
end)
UserInputService.InputBegan:Connect(function(i,s)
	if s then return end
	if i.KeyCode == Enum.KeyCode.Backquote then
		ToggleInventory()
	end
end)

Inventory:GetPropertyChangedSignal("Size"):Connect(function()
	if tonumber(string.format("%2.0f", Inventory.Size.Y.Scale)) == Settings.InventoryFullyExpandedSizeY then
		Inventory.UISizeConstraint.MinSize = Vector2.new(0, Settings.InventoryMinSizeConstraintY)
	elseif Inventory.Size.Y.Scale == 0 then
	else
		Inventory.UISizeConstraint.MinSize = Vector2.new(0, 0)
	end
end)

Inventory.Items.ChildAdded:Connect(function(Child)
	if not Child:IsA("Frame") then
		return
	end
	Inventory.Items.CanvasSize = UDim2.new(0, 0, 0, Inventory.Items.UIGridLayout.AbsoluteContentSize.Y + 10)
end)

Inventory.MouseWheelForward:Connect(function()
	TweenService:Create(Inventory.Items, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {CanvasPosition = Vector2.new(0, Inventory.Items.CanvasPosition.Y - 40)}):Play()
end)

Inventory.MouseWheelForward:Connect(function()
	TweenService:Create(Inventory.Items, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {CanvasPosition = Vector2.new(0, Inventory.Items.CanvasPosition.Y + 40)}):Play()
end)

SetupDefaultUI()
RegisterBackpackEvents(Backpack)

for _, Tool in pairs(Backpack:GetChildren()) do
	if not Tool:IsA("Tool") then
		return
	end
	SetupItem(Tool)
end

if script.Parent.Enabled then
	ToggleSlotNumberActivation(true)
end