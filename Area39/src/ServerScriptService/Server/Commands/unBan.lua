
return {
	Name = "unban";
	Aliases = {"unban"};
	Description = "Un Bans a player from the current server.";
	Group = "Moderator";
	Args = {
		{
			Type = "string";
			Name = "target";
			Description = "The player to un ban";
		},
		
	};
}