return function (context, targetPlayer, reason)
    if targetPlayer and reason then
        reason = game:GetService("Chat"):FilterStringAsync(reason,context.Executor,targetPlayer)
        if targetPlayer:GetRankInGroup(_G.GroupId) >= context.Executor:GetRankInGroup(_G.GroupId) then return "You can't ban this player." end
        _G.BannedPlayers[targetPlayer.UserId] = "You've" .. ' been banned from this server for "' .. reason .. '" by ' .. context.Executor.Name
        targetPlayer:Kick("You've" .. ' been banned from this server for "' .. reason .. '" by ' .. context.Executor.Name)
    else
        return "You must define a target and a reason for this ban."
    end
  end