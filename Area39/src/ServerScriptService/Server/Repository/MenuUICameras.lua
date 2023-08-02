--  DrBaja/Braden_J

local TS = game:GetService("TweenService")
local plr = game.Players.LocalPlayer

local tim = tick()



local cam = workspace.CurrentCamera
local scenes = game.Workspace:WaitForChild("MenuScenes")


wait(0.1)
local numOfScenes = #scenes:GetChildren()/2

local tweens = {}

local module = {}
module.Enabled = false



function module:Enable()
	plr:RequestStreamAroundAsync(Vector3.new(-162.62, 75.46, 397.813))
	cam.CameraType = Enum.CameraType.Scriptable
	cam.Focus = scenes:WaitForChild("Scene").CFrame
	cam.CFrame = scenes:WaitForChild("Scene").CFrame
	game.Lighting.Menu.Enabled = true
	module.Enabled = true
	-- spawn(function()
		
		
	-- 	game.Lighting.Menu.Enabled = true
	-- 	module.Enabled = true
	-- 	cam.CameraType = Enum.CameraType.Scriptable
		
	-- 	spawn(function()
	-- 		while module.Enabled do
				
	-- 			local ranScene = (math.random(1,numOfScenes))
	-- 			if scenes:FindFirstChild("Scene_" .. ranScene .. "_1") then
				
				
	-- 			local tim = 6
				
	-- 			if math.random(1,2) == 1 then
	-- 				cam.CFrame = scenes:FindFirstChild("Scene_" .. ranScene .. "_1").CFrame
	-- 				cam.Focus = scenes:FindFirstChild("Scene_" .. ranScene .. "_1").CFrame
					
	-- 				local endCFrame = scenes:FindFirstChild("Scene_" .. ranScene .. "_2").CFrame
	-- 				local endFocus = scenes:FindFirstChild("Scene_" .. ranScene .. "_2").CFrame
	-- 				local tw = TS:Create(cam,TweenInfo.new(tim,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut),{CFrame = endCFrame,Focus = endFocus})
	-- 				tw:Play()
	-- 				table.insert(tweens,tw)
	-- 				wait(tim)
					
	-- 			else
	-- 				cam.CFrame = scenes:FindFirstChild("Scene_" .. ranScene .. "_2").CFrame
	-- 				cam.Focus = scenes:FindFirstChild("Scene_" .. ranScene .. "_2").CFrame
					
	-- 				local endCFrame = scenes:FindFirstChild("Scene_" .. ranScene .. "_1").CFrame
	-- 				local endFocus = scenes:FindFirstChild("Scene_" .. ranScene .. "_1").CFrame
	-- 				local tw = TS:Create(cam,TweenInfo.new(tim,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut),{CFrame = endCFrame,Focus = endFocus})
	-- 				tw:Play()
	-- 				table.insert(tweens,tw)
	-- 				wait(tim)
	-- 			end
	-- 			end
	-- 			wait()
	-- 		end
	-- 	end)
	-- end)
end

function module:Disable()
    module.Enabled = false
    game.Lighting.Menu.Enabled = false
    cam.CameraType = Enum.CameraType.Custom
    for i,v in pairs(tweens) do
        if v then
            v:Pause()
        end
    end
    tweens = {}
end

return module
