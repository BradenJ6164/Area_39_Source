local module = {}

local IS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local running = false

function module:Register(char)
  char:WaitForChild("Humanoid")
  if not char:FindFirstChild("Humanoid") then return end
    local con = IS.InputBegan:Connect(function(iobj,s)
        if s then return end
        
        if iobj.KeyCode == Enum.KeyCode.LeftShift then
           
                local tw = TweenService:Create(char.Humanoid,TweenInfo.new(.25),{WalkSpeed = 28})
                tw:Play()
                running = true
              
        end
    end)
    local con1 = IS.InputEnded:Connect(function(iobj,s)
        if s then return end
        
        if iobj.KeyCode == Enum.KeyCode.LeftShift then
           
                running = false
                local tw = TweenService:Create(char.Humanoid,TweenInfo.new(.25),{WalkSpeed = 16})
                tw:Play()
              
               
           
        end
    end)
    
    local con3
    con3 = char.Humanoid.Jumping:Connect(function()
        
        delay(.8,function()
            char.Humanoid.JumpPower = 0
            wait(1)
            char.Humanoid.JumpPower = 50
        end)
    end)

    local con2
    con2 = char.Changed:Connect(function()
        if char.Parent == nil then
            con2:Disconnect()
            con3:Disconnect()
            con:Disconnect()
            con1:Disconnect()
            
        end
    end)
    char.Humanoid.WalkSpeed = 16
    


    
end

return module