return function (context, serverId)
    local service = game:GetService("TeleportService")
    service:TeleportToPlaceInstance(game.PlaceId,serverId,context.Executor)
end