local maxDist = 1100
local range = 71

local tick = 1

local players = game:GetService("Players")

local ignoreListAdditions = {game.Workspace.AmbienceUpdaters,game.Workspace.ActionBricks,game.Workspace.Interactables}

function isPartInView(head,part)
	local relative = (part.Position-head.Position)
	local forward = head.CFrame.LookVector
	local side = relative.Unit
	local theta = math.deg(math.acos(forward:Dot(side)))
	if (relative.Magnitude < maxDist and theta <= range) then
		return true
	else
		return false
	end
end

function getLightsInRadius(pos,radius)
    local returning = {}
    for i,v in pairs(game.Workspace.LightData:GetChildren()) do
        if (v.Value - pos).Magnitude <= radius then
            table.insert(returning,v.Object.Value)
        end
    end
    return returning
end


function findFirstDescendants(object, name)
    for i, v in pairs(object:GetDescendants()) do
        if v.Name == name then return v end
    end
end

function getPlayersLooking(scp)
    local returning = {}
    for i,v in pairs(players:GetPlayers()) do
        local _,er = pcall(function()
            if isPartInView(v.Character.Head,scp.PrimaryPart) then
                local ray = Ray.new(scp.PrimaryPart.Position,v.Character.Head.Position-scp.PrimaryPart.Position)
                local ignores = {scp,v.Character}
                for i,x in pairs(ignoreListAdditions) do
                    table.insert(ignores,x)
                end
                local hit = workspace:FindPartOnRayWithIgnoreList(ray,ignores)
                if not hit then
                    table.insert(returning,v) 
                end
            end
        end)
        if er then warn(er) end
    end
  
    return returning
end




return function(scp)
    if scp.PrimaryPart then
        spawn(function()
            while wait(tick) do
                local returnings = getPlayersLooking(scp)
                for i,v in pairs(returnings) do
                    for i=1,100 do
                        wait()
                        if not isPartInView(v.Character.Head,scp.PrimaryPart) then
                            if (v.Character.PrimaryPart.Position-scp.PrimaryPart.Position).Magnitude < 10 then
                                scp:SetPrimaryPartCFrame(CFrame.new((v.Character.PrimaryPart.CFrame*CFrame.new(0,0,-1)).Position,v.Character.PrimaryPart.Position))
                                
                                if findFirstDescendants(scp,"Move") then
                                    findFirstDescendants(scp,"Move"):Play()
                                end
                                if findFirstDescendants(scp,"RunToKill") then
                                    findFirstDescendants(scp,"RunToKill"):Play()
                                end
                                if findFirstDescendants(scp,"Kill") then
                                    findFirstDescendants(scp,"Kill"):Play()
                                end
                                v.Character.Humanoid:TakeDamage(500)
                                spawn(function()
                                    local lights = getLightsInRadius(scp.PrimaryPart.Position,22)
                                    for _,x in pairs(lights) do
                                        x.Enabled = false
                                    end
                                    delay(.75,function()
                                        for _,x in pairs(lights) do
                                            x.Enabled = true
                                        end
                                    end)
        
                                end)
                               wait(.2)
                            else
                                spawn(function()
                                    local lights = getLightsInRadius(scp.PrimaryPart.Position,22)
                                    for _,x in pairs(lights) do
                                        x.Enabled = false
                                    end
                                    delay(.75,function()
                                        for _,x in pairs(lights) do
                                            x.Enabled = true
                                        end
                                    end)
        
                                end)
                                local constructedCFrame = CFrame.new(scp.PrimaryPart.Position,v.Character.PrimaryPart.Position)
                                constructedCFrame = constructedCFrame * CFrame.new(0,0,-10)
                                scp:SetPrimaryPartCFrame(constructedCFrame)
                                if findFirstDescendants(scp,"Move") then
                                    findFirstDescendants(scp,"Move"):Play()
                                end
                                break
                            end
                            break
                        end
                    end
                    
                end
            end
        end)
    end
end