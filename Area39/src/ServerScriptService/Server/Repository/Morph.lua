local module = {}

local function applyWeld(model,part)
	
	if model:FindFirstChild("Middle") then
		
		if string.find(model.Name,"Head") then

			for i,v in pairs(part.Parent:GetChildren()) do
				if v:IsA("Accessory") then v:Destroy() end
			end
			
		end
		
		--print(model.Name .. " welding to " .. part.Name .. " on " .. part.Parent.Name)
        local g = model:Clone()
        g.Name = g.Name .. "Morph"
		g.Parent = workspace
		wait()
		g.Parent = part.Parent
		
		for i,v in pairs(g:GetChildren()) do
			if v:IsA("Part") or v:IsA("CornerWedgePart") or v:IsA("WedgePart") or v:IsA("MeshPart") or v:IsA("UnionOperation") then
				local w = Instance.new("Weld")
				w.Part0 = g.Middle
				w.Part1 = v
				
				local CJ = CFrame.new(g.Middle.Position)
				local C0 = g.Middle.CFrame:inverse()*CJ
				local C1 = v.CFrame:inverse()*CJ
				
				w.C0 = C0
				w.C1 = C1
				w.Name = part.Name
				w.Parent = g.Middle
			end
				local Y = Instance.new("Weld")
				Y.Name = part.Name .. "Root"
				Y.Part0 = part
				Y.Part1 = g.Middle
				Y.C0 = CFrame.new(0,0,0)
				Y.Parent = part
		end
		
		for i,v in pairs(g:GetChildren()) do
			if v:IsA("Part") or v:IsA("CornerWedgePart") or v:IsA("WedgePart") or v:IsA("MeshPart") or v:IsA("UnionOperation") then
				v.Anchored = false
				v.CanCollide = false
			end
		end
	end
end


function module:MorphPlayer(plr,model)
	
    for i,v in pairs(model:GetChildren()) do
        if string.find(v.Name,"Hair") then
           
        else
            for i,x in pairs(plr.Character:GetChildren()) do
                if x:IsA("Accessory")  then
                    if x.Handle:FindFirstChild("HatAttachment") or x.Handle:FindFirstChild("NeckAttachment") or x.Handle:FindFirstChild("BodyBackAttachment") then
                        x:Destroy()
                    end
                end
            end
        end
        if plr.Character:FindFirstChild(v.Name) then
            applyWeld(v,plr.Character:FindFirstChild(v.Name))
        end


       
    end
end

function module:ClothePlayer(plr,model)
    for i,v in pairs(model:GetChildren()) do
        if v:IsA("Shirt") then
            if plr.Character:FindFirstChildWhichIsA("Shirt") then
                plr.Character:FindFirstChildWhichIsA("Shirt"):Destroy()
            end
            v:Clone().Parent = plr.Character
        end
        if v:IsA("Pants") then
            if plr.Character:FindFirstChildWhichIsA("Pants") then
                plr.Character:FindFirstChildWhichIsA("Pants"):Destroy()
            end
            v:Clone().Parent = plr.Character

        end
    end 
end

return module