-- // DrBaja/Braden_J

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local UserInput = game:GetService("UserInputService")

local Keybinds = _G.Area39:GetService("LiveKeybind")

local cuffs = {}

local module = {}
local mt_table = { __index = module}

local remote

if RunService:IsServer() then
	remote = Instance.new("RemoteEvent")
	remote.Parent = game.ReplicatedStorage.Remotes
	remote.Name = "Cuff"
	
	remote.OnServerEvent:Connect(function(plr,action,target)
		if plr.Character:FindFirstChild("Cuffs") then -- // Quick Sanity Check
			local localplr = plr
			local plr = Players:GetPlayerFromCharacter(target)
			if plr then
				if action == "Cuff" then
					if not cuffs[plr.UserId] then
						cuffs[plr.UserId] = module.new(localplr,localplr.Character,target)
					end
					if cuffs[plr.UserId] then
						cuffs[plr.UserId]:cuff()
					end
				elseif action == "UnCuff" then
					if cuffs[plr.UserId] then
						cuffs[plr.UserId]:uncuff()
					end
				elseif action == "KillCuff" then
					if cuffs[plr.UserId] then
						cuffs[plr.UserId]:killcuff()
						cuffs[plr.UserId] = nil
					end
				end
			end
		end
	end)
else
	local gui
	remote = game.ReplicatedStorage.Remotes:WaitForChild("Cuff")
	
	remote.OnClientEvent:Connect(function(action,val)
		if action == "Message" then
			gui.message.Visible = val
			local lastBackpack = true
			if val then
				if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
					game.Players.LocalPlayer.Character.Humanoid:UnequipTools()
				end
				--lastBackpack = game.StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.Backpack)	
				Players.LocalPlayer.PlayerGui.Backpack.Enabled = false
				game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, false)
				require(Players.LocalPlayer.PlayerScripts.PlayerModule.ControlModule):Disable()
			else
				--game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack, lastBackpack)
				Players.LocalPlayer.PlayerGui.Backpack.Enabled = true
				require(Players.LocalPlayer.PlayerScripts.PlayerModule.ControlModule):Enable()
			end
			
		end
	end)
	
	local CuffsEquipped = false
	local Player = Players.LocalPlayer
	local Mouse = Player:GetMouse()
	gui = script.CuffGui:Clone()
	gui.Parent = Player.PlayerGui
	Player.CharacterAdded:Connect(function(char)
		char.ChildAdded:Connect(function(child) -- Cuffs Equip
			if child:IsA("Tool") then
				if child.Name == "Cuffs" then
					CuffsEquipped = true
					Keybinds({[Enum.UserInputType.MouseButton1] = "Use",[Enum.KeyCode.E] = "Interaction"})
				end
			end
		end)
		char.ChildRemoved:Connect(function(child) -- Cuffs UnEquip
			if child:IsA("Tool") then
				if child.Name == "Cuffs" then
					CuffsEquipped = false
					gui.control.Visible = false
					Keybinds({[Enum.KeyCode.E] = "Interaction"})
				end
			end
		end)
	end)
	gui.control.cuff.MouseButton1Click:Connect(function()
		if CuffsEquipped then
			remote:FireServer("Cuff",gui.target.Value.Parent)
		end
	end)
	gui.control.release.MouseButton1Click:Connect(function()
		if CuffsEquipped then
			remote:FireServer("UnCuff",gui.target.Value.Parent)
		end
	end)
	gui.control.uncuff.MouseButton1Click:Connect(function()
		if CuffsEquipped then
			remote:FireServer("KillCuff",gui.target.Value.Parent)
		end
	end)
	UserInput.InputBegan:Connect(function(i,s)
		
		if s then return end
		if i.UserInputType == Enum.UserInputType.MouseButton1 then
			if Mouse.Target then
				local humanoid
				local function t(hum)
					if CuffsEquipped and Players:GetPlayerFromCharacter(hum.Parent) then
						humanoid = hum
						gui.control.title.Text = "Handcuff Options for " .. hum.Parent.Name
						gui.control.title.background.Text = "Handcuff Options for " .. hum.Parent.Name
				
						gui.control.Visible = true
						gui.target.Value = hum
					end
					
				end
				pcall(function() -- Due to the nature of this code we wrap with a pcall.
					if Mouse.Target.Parent:FindFirstChild("Humanoid") then
						t(Mouse.Target.Parent.Humanoid)
					elseif Mouse.Target.Parent.Parent:FindFirstChild("Humanoid") then
						t(Mouse.Target.Parent.Parent.Humanoid)
					elseif Mouse.Target.Parent.Parent.Parent:FindFirstChild("Humanoid") then
						t(Mouse.Target.Parent.Parent.Parent.Humanoid)
						
					end
				end)
				if not humanoid then
					gui.control.Visible = false
				end
			else
				gui.control.Visible = false
			end
		end
	end)
	
end

function registerCuffModel(character)
	local cuffs = script.Cuffs:Clone()
	cuffs.Parent = character
	
	local joint = Instance.new("Motor6D",character.RightHand)
	joint.Part0 = character.RightHand
	joint.Part1 = cuffs.Middle
	joint.Name = "Cuff"
	
	return
end

function module.new(fromplayer,fromcharacter,tocharacter)
	local self = {}
	self.fromplayer = fromplayer
	self.fromcharacter = fromcharacter
	self.tocharacter = tocharacter
	self.range = 6
	self.originalspeed = tocharacter.Humanoid.WalkSpeed
	
	self.connections = {}
	
	self.cuffanimation = self.tocharacter.Humanoid:LoadAnimation(script.cuffed)
	
	self.cuffed = false
	setmetatable(self,mt_table)
	return self
end
function module:cuff()
	self.cuffed = true
	self.cuffanimation:Play()
	if self.tocharacter then
		if not self.tocharacter:FindFirstChild("Cuffs") then
			registerCuffModel(self.tocharacter)
		end
		local cuffSound = script.Cuff:Clone()
		cuffSound.Parent = self.tocharacter.HumanoidRootPart
		cuffSound:Play()
		game.Debris:AddItem(cuffSound,cuffSound.TimeLength)
		local toplayer = Players:GetPlayerFromCharacter(self.tocharacter)
		if toplayer:IsA("Player") then
		remote:FireClient(toplayer,"Message",true)
		end
		local con2
		con2 = self.tocharacter.Humanoid.Died:Connect(function()
			self:uncuff()
			self:killcuff()
		end)
		table.insert(self.connections,con2)
		while self.cuffed do
			wait(0.15)
			self.tocharacter.Humanoid.WalkSpeed = self.fromcharacter.Humanoid.WalkSpeed
			if not self.fromcharacter or not self.tocharacter then
				module:uncuff()
				module:killcuff()
			end
			local ydist = (self.fromcharacter.HumanoidRootPart.Position.Y - self.tocharacter.HumanoidRootPart.Position.Y)
			local mag = (self.fromcharacter.HumanoidRootPart.Position - self.tocharacter.HumanoidRootPart.Position).Magnitude
			if ydist > 5 then
				self.tocharacter.Humanoid.Jump = true
			end
			
			local baseCframe = CFrame.new(self.tocharacter.HumanoidRootPart.Position,self.fromcharacter.HumanoidRootPart.Position)
			local distanceToCover = math.abs(mag - 3)
			local calculatedPosition = (baseCframe * CFrame.new(0,0,-distanceToCover)).Position
			
			if mag >= self.range and mag >= 3 then
				self.tocharacter.Humanoid:MoveTo(calculatedPosition)
			end
			if mag >= self.range * 10 then
				self.tocharacter.HumanoidRootPart.CFrame = CFrame.new(calculatedPosition)
			end
		end
	end
end
function module:uncuff()
	if self.tocharacter then
		local toplayer = Players:GetPlayerFromCharacter(self.tocharacter)
		if toplayer:IsA("Player") then
			remote:FireClient(toplayer,"Message",false)
		end
		
		self.cuffed = false
		self.tocharacter.Humanoid.WalkSpeed = self.originalspeed
	end
end
function module:killcuff()
	self:uncuff()
	self.cuffanimation:Stop()
	if self.tocharacter then
		self.tocharacter.Humanoid.WalkSpeed = self.originalspeed
		if self.tocharacter:FindFirstChild("Cuffs") then
			self.tocharacter.Cuffs:Destroy()
			self.tocharacter.RightHand.Cuff:Destroy()
		end
		local toplayer = Players:GetPlayerFromCharacter(self.tocharacter)
		remote:FireClient(toplayer,"Message",false)
		local cuffSound = script.UnCuff:Clone()
		cuffSound.Parent = self.tocharacter.HumanoidRootPart
		cuffSound:Play()
		game.Debris:AddItem(cuffSound,cuffSound.TimeLength)
	end
	for i,v in pairs(self.connections) do
		if v then
			v:Disconnect()
		end
	end
end

return module
