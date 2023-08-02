
return {
	Name = "permban";
	Aliases = {"pban"};
	Description = "Perm bans a player from all servers..";
	Group = "Admin";
	Args = {
		{
			Type = "player";
			Name = "target";
			Description = "The player to perm ban";
		},
		{
			Type = "string";
			Name = "Reason";
			Description = "The reason to perm ban the player."
		}
	};
}