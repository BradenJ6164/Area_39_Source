return function (context, targetPlayer, reason)
    if targetPlayer and reason then
        reason = game:GetService("Chat"):FilterStringAsync(reason,context.Executor,targetPlayer)
        targetPlayer:Kick("You've" .. ' been kicked from this server for "' .. reason .. '" by ' .. context.Executor.Name)
    else
        return "You must define a target and a reason for this kick."
    end
  end