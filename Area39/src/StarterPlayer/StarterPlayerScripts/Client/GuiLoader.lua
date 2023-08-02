local PseudoInstance =  _G.Area39:GetService("PseudoInstance") -- Basically everything to be honest.
local ColorService =  _G.Area39:GetService("Color") -- Register Color Service
local PlayerGui = game.Players.LocalPlayer.PlayerGui

local Colors = {
	['Danger'] = {ColorService.Red[600],ColorService.White},
	['Success'] = {ColorService.Green[600],ColorService.White},
	['Primary'] = {ColorService.Grey[50],ColorService.Black},
	['Secondary'] = {ColorService.Blue[200],ColorService.White},
    ['Warning'] = {ColorService.Orange[800],ColorService.White},
    ['BlueConX'] = {Color3.new(26/255,121/255,234/255),ColorService.White}
}

local types = {

	["Button"] = function(obj)
		local btn = PseudoInstance.new("RippleButton") -- // New Ripple Button
		btn.AnchorPoint = obj.AnchorPoint
		btn.Name = obj.Name
		btn.ZIndex = obj.ZIndex
		btn.Size = obj.Size
		btn.Position = obj.Position
		btn.PrimaryColor3 = (Colors[obj.Type.Value][1] or ColorService.White) -- Prevent Errors if Type could not be found.
		btn.SecondaryColor3 = (Colors[obj.Type.Value][2] or ColorService.White) -- Prevent Errors if Type could not be found.
		btn.Tooltip = (obj:FindFirstChild("ToolTip").Value or "")
		btn.BorderRadius = 4
		btn.Style = (obj:FindFirstChild("Style").Value or "Contained")
		btn.Text = obj.Text
		btn.Parent = obj.Parent
		btn.LayoutOrder = obj.LayoutOrder
		if obj:FindFirstChild("NoShadow") then
			btn.Elevation = 0
		end
		if obj:FindFirstChild("UIAspectRatioConstraint") then
			obj.UIAspectRatioConstraint.Parent = btn.Object
		end
		if obj:FindFirstChild("Icon") then
			
			obj.Icon.ZIndex = btn.ZIndex + 1
			
			obj.Icon.Parent = btn.Object
		end
		if obj:FindFirstChild("BorderRadius") then
			btn.BorderRadius = obj.BorderRadius.Value
		end
		btn.OnPressed:Connect(function()
			PlayerGui.Click:Play()
		end)

		obj:Destroy()
		return btn
	end,
	['CheckBox'] = function(obj)
		local btn = PseudoInstance.new("Checkbox") -- // New Ripple Button
		btn.AnchorPoint = obj.AnchorPoint
		btn.Name = obj.Name
		btn.ZIndex = obj.ZIndex
		btn.Size = obj.Size
		btn.LayoutOrder = obj.LayoutOrder
		btn.Position = obj.Position
		btn.PrimaryColor3 = (Colors[obj.Type.Value][1] or ColorService.White) -- Prevent Errors if Type could not be found.
		btn.SecondaryColor3 = (Colors[obj.Type.Value][2] or ColorService.White) -- Prevent Errors if Type could not be found.
		btn.Parent = obj.Parent
		obj:Destroy()
		return btn
	end,
	
	
	
}


local module = {}

function module:RegisterObject(obj)
	if obj:FindFirstChild("CheckBox") then
		return types["CheckBox"](obj)
	else
		return types["Button"](obj)
	end
end


return module
