local sound = script.Parent.Head.CBout
local hum = script.Parent:FindFirstChild("Item")
local anim = hum:LoadAnimation(script.Parent["Transform"])

while true do
	wait(60)
	sound:Play()
	anim:Play()
	script.Parent.Eyeeffect.Effecterthing.Enabled = true
	script.Parent.Eye.Transparency = 0
	script.Parent.RightFoot.Flame2.Enabled = true
	script.Parent.LeftFoot.Flame1.Enabled = true
	script.Parent.UpperTorso.OminousPresence.Enabled = true
	script.Parent.Item.WalkSpeed = 45
	wait(30)
	script.Parent.Eyeeffect.Effecterthing.Enabled = false
	script.Parent.Eye.Transparency = 1
	script.Parent.RightFoot.Flame2.Enabled = false
	script.Parent.LeftFoot.Flame1.Enabled = false
	script.Parent.UpperTorso.OminousPresence.Enabled = false
	script.Parent.Item.WalkSpeed = 35
end


local death = script.Parent.Head.Death