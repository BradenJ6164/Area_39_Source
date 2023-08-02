local ItemClass = {}

function ItemClass.new(Tool)
	if not Tool or not Tool:IsA("Tool") then
		return
	end
	local Object = {
		Tool = Tool,
		Frame = script.ItemTemplate:Clone(),
		Equipped = false,
		Connections = {}
	}
	Object.Frame.Content.TextLabel.Text = Tool.Name
	setmetatable(Object, ItemClass)
	ItemClass.__index = ItemClass
	return Object
end

function ItemClass:Initialise()
	table.insert(self.Connections, self.Tool.Equipped:Connect(function()
		self:Equip()
	end))
	table.insert(self.Connections, self.Tool.Unequipped:Connect(function()
		self:Unequip()
	end))
end

function ItemClass:MoveTo(Frame)
	if not Frame or not Frame:IsA("GuiObject") then
		return
	end
	self.Frame.Parent = Frame
end

function ItemClass:Equip(Player)
	if self.Equipped then
		return
	end
	if Player then
		if Player:IsA("Player") then
			Player.Character.Humanoid:EquipTool(self.Tool)
		else
			error("Player reference not given")
		end
	end
	self.Equipped = true
	self.Frame.Content.bar:TweenSize(UDim2.new(1,0,0,2),"Out","Quad",0.1,true)
	game:GetService("TweenService"):Create(self.Frame.Content.ImageLabel, TweenInfo.new(0.1, Enum.EasingStyle.Sine), {BackgroundColor3 = Color3.fromRGB(15, 90, 180)}):Play()
end

function ItemClass:Unequip(Player)
	if not self.Equipped then
		return
	end
	if Player then
		if Player:IsA("Player") then
			Player.Character.Humanoid:UnequipTools()
		else
			error("Player reference was not given")
		end
	end
	self.Equipped = false
	self.Frame.Content.bar:TweenSize(UDim2.new(0,0,0,2),"Out","Quad",0.1,true)
	game:GetService("TweenService"):Create(self.Frame.Content.ImageLabel, TweenInfo.new(0.1, Enum.EasingStyle.Sine), {BackgroundColor3 = Color3.fromRGB(24, 119, 232)}):Play()
end

function ItemClass:ToggleEquip(Player, Toggle)
	if Toggle then
		self:Equip(Player)
	else
		self:Unequip(Player)
	end
end

function ItemClass:Cleanup()
	self.Frame:Destroy()
	for _, Connection in pairs(self.Connections) do
		Connection:Disconnect()
	end
	self = nil
end

return ItemClass