-- perm ban
local DataStore = game:GetService("DataStoreService"):GetDataStore("BanData")

return function (context, targetPlayer, reason)
    if targetPlayer and reason then
        reason = game:GetService("Chat"):FilterStringForBroadcast(reason,context.Executor)
        if tonumber(targetPlayer) then
        else
            targetPlayer = game.Players:GetUserIdFromNameAsync(targetPlayer)
        end

        local success, err = pcall(function()
            DataStore:SetAsync(targetPlayer,reason)
        end)
        if err then
            delay(30,function()
                local success, err = pcall(function()
                    DataStore:SetAsync(targetPlayer,reason)
                end)
            end)
        end
        
    else
        return "You must define a target and a reason for this ban."
    end
  end