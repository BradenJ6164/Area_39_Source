
return {
	Name = "unfreeze";
	Aliases = {"unlock"};
	Description = "Unfreezes a player.";
	Group = "Moderator";
	Args = {
		{
			Type = "player";
			Name = "Target";
			Description = "The player to unfreeze.",
		}
	};
}