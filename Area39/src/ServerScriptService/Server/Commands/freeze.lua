
return {
	Name = "freeze";
	Aliases = {"lock"};
	Description = "Freezes a player.";
	Group = "Moderator";
	Args = {
		{
			Type = "player";
			Name = "Target";
			Description = "The player to freeze.",
		}
	};
}