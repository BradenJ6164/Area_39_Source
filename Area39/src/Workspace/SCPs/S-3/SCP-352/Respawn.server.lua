z = script.Parent

backup = z:clone()

while true do
	wait(5)
	if z.Item.Health == 0 then
		z:Remove()
		wait(4)
		backup.Parent = game.Workspace
		backup.Head:MakeJoints()
		backup.Torso:MakeJoints()
	end
	if z == nil then
		wait(4)
		backup.Parent = game.Workspace
		backup.Head:MakeJoints()
		backup.Torso:MakeJoints()
	end
end 