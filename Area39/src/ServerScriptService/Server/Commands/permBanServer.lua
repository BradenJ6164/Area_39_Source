-- perm ban
local DataStore = game:GetService("DataStoreService"):GetDataStore("BanData1")

return function (context, targetPlayer, reason)
    if targetPlayer and reason then
        reason = game:GetService("Chat"):FilterStringAsync(reason,context.Executor,targetPlayer)
        if targetPlayer:GetRankInGroup(_G.GroupId) >= context.Executor:GetRankInGroup(_G.GroupId) then return "You can't ban this player." end
        DataStore:SetAsync(targetPlayer.UserId,reason)
        targetPlayer:Kick("You've" .. ' been perm banned from SCP Roleplay for "' .. reason .. '" by ' .. context.Executor.Name)
       
       
       
      
        
    else
        return "You must define a target and a reason for this ban."
    end
  end