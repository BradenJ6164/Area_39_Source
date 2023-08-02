
return {
	Name = "announce";
	Aliases = {"m"};
	Description = "Announces a message.";
	Group = "Moderator";
	Args = {
		{
			Type = "string";
			Name = "Message";
			Description = "The message to broadcast.",
		}
	};
}