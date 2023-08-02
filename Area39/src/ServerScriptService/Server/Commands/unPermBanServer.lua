-- perm ban
local DataStore = game:GetService("DataStoreService"):GetDataStore("BanData1")

return function (context, targetPlayer)
    if targetPlayer then
      
            DataStore:SetAsync(game.Players:GetUserIdFromNameAsync(targetPlayer),nil)
       
        
    else
        return "You must define a target and a reason for this ban."
    end
  end