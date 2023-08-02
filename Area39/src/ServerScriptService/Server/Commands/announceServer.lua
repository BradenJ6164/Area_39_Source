return function (context, message)
    if message then
       
        message = game.Chat:FilterStringForBroadcast(message,context.Executor)
        context:BroadcastEvent("announce","Message from " .. context.Executor.Name .. ": " .. message)

        --[[for i,v in pairs(game.Players:GetPlayers()) do
            message = game.Chat:FilterStringAsync(message,context.Executor,v)
            _G.Area39:SendTip(v,"Announcement from " .. context.Executor.Name,message)
        end]]
       
    else
        return "You must define a message to broadcast."
    end
  end