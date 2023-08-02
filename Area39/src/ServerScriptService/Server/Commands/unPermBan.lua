
return {
	Name = "unpermban";
	Aliases = {"unpban"};
	Description = "Removes perm ban from a player.";
	Group = "Admin";
	Args = {
		{
			Type = "string";
			Name = "target";
			Description = "The player to remove perm ban from.";
		},
		
	};
}