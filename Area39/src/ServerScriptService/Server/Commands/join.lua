
return {
	Name = "join";
	Aliases = {"joinserver"};
	Description = "Joins a server by JobId (server id).";
	Group = "Moderator";
	Args = {
		{
			Type = "string";
			Name = "Server Id";
			Description = "The server Id to join.",
		}
	};
}