-- Spawns a new thread without waiting one step
-- See https://github.com/roblox-ts/roblox-ts/issues/668 for reason why we create a new BindableEvent each time

local function FastSpawn(callback, ...)
	local spawnBindable = Instance.new("BindableEvent")
	local args = { ... }
	local length = select("#", ...)
	spawnBindable.Event:Connect(function()
		callback(unpack(args, 1, length))
	end)
	spawnBindable:Fire()
	spawnBindable:Destroy()
end

return FastSpawn
