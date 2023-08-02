-- // DrBaja/Braden_J

local module = {}
    
function module.new(options,size)
    local self = {}
    self.Options = options

    local frame = Instance.new("Frame")
    frame.Name = "Carousel_Container"
    frame.Size = size
    frame.BackgroundTransparency = 1

    local template = Instance.new("TextLabel")
    template.BackgroundTransparency = 1
    template.Size = UDim2.new(1,0,0.1,0)
    template.AnchorPoint = Vector2.new(0,0.5)
    template.TextColor3 = Color3.new(255/255,255/255,255/255)
    template.Font = Enum.Font.SourceSansBold
    template.Parent = frame
    template.TextSize = "20"
    template.Name = "template"
    template.Visible = false

    for i=1,#self.Options do
        local option = options[i]
        local opt = template:Clone()
        opt.Parent = frame
        opt.Name = option
        opt.Text = option
        opt.Position = UDim2.new(0,0,i*0.1,0)
        opt.Visible = true
    end
    
    self.Template = template

    self.Object = frame

    setmetatable(self,{__index = module})
    return self
end

function module:Render()
    local newTemplate = self.Template:Clone()
    newTemplate.Parent = self.Object
    newTemplate.Text = self.Options[math.random(1,#self.Options)]
    newTemplate.Name = newTemplate.Text
    newTemplate.Position = UDim2.new(0,0,0,0)
    newTemplate.Visible = true
    for i,v in pairs(self.Object:GetChildren()) do
        if v:IsA("TextLabel") and v.Name ~= "template" then
            if v.Position.Y.Scale < 1 then
                v:TweenPosition(UDim2.new(0,0,v.Position.Y.Scale+0.1,0),"Out","Quad",0.1)
            else
                v:Destroy()
            end
        end
    end
end

function module:Destroy()
    self.Object:Destroy()
    self = nil
end

return module