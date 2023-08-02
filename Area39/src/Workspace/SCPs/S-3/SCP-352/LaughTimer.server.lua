local hum = script.Parent:FindFirstChild("Item")
local anim = hum:LoadAnimation(script.Parent["SitAnim"])
local anim2 = hum:LoadAnimation(script.Parent["GetUpAnim"])

while true do
	wait(180)
	anim:Play()
	script.Parent.Script.Disabled = true
	script.Parent.UpperTorso.Stun.Disabled = true
	script.Parent.RightFoot.bam.Disabled = true

	wait(60)
    anim:Stop()
    anim2:Play()
    wait(1.5)
    script.Parent.Script.Disabled = false
    script.Parent.UpperTorso.Stun.Disabled = false
    script.Parent.RightFoot.bam.Disabled = false
end


local death = script.Parent.Head.Death