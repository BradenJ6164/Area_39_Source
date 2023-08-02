
return {
	Name = "ban";
	Aliases = {"ban"};
	Description = "Bans a player from the current server.";
	Group = "Moderator";
	Args = {
		{
			Type = "player";
			Name = "victim";
			Description = "The player to ban";
		},
		{
			Type = "string";
			Name = "Reason";
			Description = "The reason to ban the player."
		}
	};
}