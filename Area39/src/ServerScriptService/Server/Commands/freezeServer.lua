return function (context, plr)
    if plr then
       
        plr.Character.HumanoidRootPart.Anchored = true
       
    else
        return "You must define a player to freeze."
    end
  end