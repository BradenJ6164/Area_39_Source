local cache = {}
return function(scp)
    scp.MouseClick.MouseClick:Connect(function(plr)
        scp.Bowl.Grab:Play()
        if not cache[plr] then cache[plr] = 0 end
        cache[plr] = cache[plr] + 1
        if cache[plr] > 2 then
            plr.Character.Humanoid:TakeDamage(5000000000000000000)
            cache[plr]=0
        end
    end)
end