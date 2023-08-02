local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

if RunService:IsServer() then return end
local TransitionGui = Instance.new("ScreenGui",game.Players.LocalPlayer.PlayerGui)
TransitionGui.Name = "PriorityTransitions"
TransitionGui.DisplayOrder = 999
TransitionGui.ResetOnSpawn = false

local transitionSettings = {
    ['Wipe'] = {
        ['Object'] = function()
            local frame = Instance.new("Frame")
            frame.Size = UDim2.new(1.5,0,1.2,0)
            frame.Position = UDim2.new(-1.5,0,-0.2,0)
            frame.BorderSizePixel = 0
            frame.BackgroundColor3 = Color3.new(255/255,255/255,255/255)
            frame.ZIndex = 100000
            return frame
        end,
        ['Animate'] = function(frame,tim)
            frame.Position = UDim2.new(-1,0,-0.2,0)
            frame:TweenPosition(UDim2.new(1.5,0,-0.2,0),"Out","Quad",tim)
        end,
    },
    ['Blackout'] = {
        ['Object'] = function()
            local frame = Instance.new("Frame")
            frame.Size = UDim2.new(1,0,1.2,0)
            frame.Position = UDim2.new(0,0,-0.2,0)
            frame.BorderSizePixel = 0
            frame.BackgroundTransparency = 1
            frame.BackgroundColor3 = Color3.new(0/255,0/255,0/255)
            frame.ZIndex = 100000
            return frame
        end,
        ['Animate'] = function(frame,tim)
            
            frame.Position = UDim2.new(0,0,-0.2,0)
            local tween = TweenService:Create(frame,TweenInfo.new(tim/2),{BackgroundTransparency=0})
            tween:Play()
            delay(tim/2,function()
                local tween2 = TweenService:Create(frame,TweenInfo.new(tim/2),{BackgroundTransparency=1})
                tween2:Play()
            end)
        end,
    }
}

local transition = {}

function transition.new(type)
    if not transitionSettings[type] then return end

    local self = {}
    self.Type = type
    self.Object = transitionSettings[type]['Object']()
    self.Object.Parent = TransitionGui

    setmetatable(self,{__index = transition})

    return self
end

function transition:Play(tim)
    transitionSettings[self.Type]['Animate'](self.Object,tim or 1)
end

function transition:Destroy(tim)
    if tim then
        delay(tim,function() 
            self.Object:Destroy()
            self = nil
        end)
    else
        self.Object:Destroy()
        self = nil
    end
    
end

return transition