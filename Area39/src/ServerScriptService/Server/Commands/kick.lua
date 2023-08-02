
return {
	Name = "kick";
	Aliases = {"kick"};
	Description = "Kicks a player from the current server.";
	Group = "Moderator";
	Args = {
		{
			Type = "player";
			Name = "victim";
			Description = "The player to kick";
		},
		{
			Type = "string";
			Name = "Reason";
			Description = "The reason to kick the player."
		}
	};
}