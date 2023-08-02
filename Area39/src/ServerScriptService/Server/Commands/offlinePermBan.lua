
return {
	Name = "offlinepermban";
	Aliases = {"opban"};
	Description = "Perm bans a player from all servers by a userID or name.";
	Group = "Admin";
	Args = {
		{
			Type = "string";
			Name = "target";
			Description = "The name/userid to perm ban";
		},
		{
			Type = "string";
			Name = "Reason";
			Description = "The reason to perm ban the player."
		}
	};
}