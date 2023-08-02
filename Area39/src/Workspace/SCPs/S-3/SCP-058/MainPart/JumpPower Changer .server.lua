debounce = true

function onTouched(hit)
	local h = hit.Parent:findFirstChild("Humanoid")
	if (h ~= nil and debounce == true) then
		debounce = false
		h.JumpPower = 0
		wait(1)
		debounce = true
	end
end

script.Parent.Touched:connect(onTouched)