return function (context, targetPlayer)
    if targetPlayer then
        if _G.BannedPlayers[game.Players:GetUserIdFromNameAsync(targetPlayer)] then
            _G.BannedPlayers[game.Players:GetUserIdFromNameAsync(targetPlayer)] = nil
        elseif _G.BannedPlayers[targetPlayer] then

            _G.BannedPlayers[targetPlayer] = nil
        else
            return "Player is not banned."
        end
    else
        return "You must define a target this unban."
    end
  end