return {
    ['Ingame'] = {
        {
            ['Price'] = 75,
            ['Title'] = "USP40",
            ['Tools'] = {"USP40"},
            ['ImageId'] = "rbxassetid://5668841750",
        },
        {
            ['Price'] = 250,
            ['Title'] = "SCAR-H",
            ['Tools'] = {"SCAR-H"},
            ['ImageId'] = "rbxassetid://5668781774",
        }
    },
    ['Onelife'] = {
		{
            ['DevProduct'] = true,
			['MPSID'] = 1154403905,
		
			['Title'] = "2 Minutes of Invisibility",
			['Description'] = "",
		},
		{
			['DevProduct'] = true,
			['MPSID'] = 1154403630,
			['ImageId'] = "rbxassetid://5545878352",
			['Title'] = "Class D Riot",
			['BeforePurchase'] = function(plr)
				
				if game.ReplicatedStorage.ClassDRiot.Value == true then
					return false -- deny sale
				else
					return true
				end
			end,
			['Description'] = "Be In control of the facility, anything you say goes, anything that happens you will know about it. Gain access to be a O5 Council and control the entire SCP Facility!",
		},
	},
    ['Gamepasses'] = {
        
        {
			['MPSID'] = 15319872,
            ['ImageId'] = "rbxassetid://5668763896",
            ['Title'] = "Class D Leader",
            ['Description'] = "Best Class D yes. ",
        },
        {
			['MPSID'] = 15319757,
            ['ImageId'] = "rbxassetid://5545797863",
            ['Title'] = "Rapid Response Team",
            ['Description'] = "Be the best of the best, when all else fails you are there to protect the foundation. By purchasing this game pass you unlock the Rapid Response Team, and all three variants that come with it.",
        },
        {
			['MPSID'] = 15319780,
            ['ImageId'] = "rbxassetid://5543049563",
            ['Title'] = "Internal Security Department",
            ['Description'] = "Nobody is a threat until it's too late, make sure its never too late. By purchasing this game pass you unlock the Internal Security Department, and all three variants that come with it.",
        },
        {
			['MPSID'] = 15319798,
            ['ImageId'] = "rbxassetid://5545731973",
            ['Title'] = "Intelligence Agency",
            ['Description'] = "By purchasing this game pass you unlock the Intelligence Agency and all three variants that come with it. Including the Elite Agent!",
        },
        {
			['MPSID'] = 15319812,
            ['ImageId'] = "rbxassetid://5543026795",
            ['Title'] = "Mobile Task Force",
            ['Description'] = "Recontain all SCP's that escape the facility. and Defend against the Chaos Insurgency. By purchasing this game pass you unlock Mobile Task Force, and all three variants that come with it! Including Task Force Alpha-1 Red Right Hand!",
        },
        {
			['MPSID'] = 15319820,
            ['ImageId'] = "rbxassetid://5546268580",
            ['Title'] = "Site Director",
            ['Description'] = "Be In control of the facility, anything you say goes, anything that happens you will know about it. Gain access to be a Site Director and control the entire SCP Facility!",
        },
        {
			['MPSID'] = 15319840,
            ['ImageId'] = "rbxassetid://5661018334",
            ['Title'] = "O5 Council",
            ['Description'] = "Be In control of the facility, anything you say goes, anything that happens you will know about it. Gain access to be a O5 Council and control the entire SCP Facility!",
        },
        {
			['MPSID'] = 15319862,
            ['ImageId'] = "rbxassetid://5648860004",
            ['Title'] = "Omni Keycard",
            ['Description'] = "Be In control of the facility, anything you say goes, anything that happens you will know about it. Gain access to be a O5 Council and control the entire SCP Facility!",
        },
        {
            ['DevProduct'] = true,
			['MPSID'] = 1154403815,
            ['ImageId'] = "rbxassetid://5648860004",
            ['Title'] = "[Server Life] Omni Keycard",
            ['Description'] = "Be In control of the facility, anything you say goes, anything that happens you will know about it. Gain access to be a O5 Council and control the entire SCP Facility!",
        },
        {
			['MPSID'] = 15319858,
            ['ImageId'] = "rbxassetid://5648859939",
            ['Title'] = "L5 Keycard",
            ['Description'] = "Be In control of the facility, anything you say goes, anything that happens you will know about it. Gain access to be a O5 Council and control the entire SCP Facility!",
        },
        {
			['MPSID'] = 15319848,
            ['ImageId'] = "rbxassetid://5648859864",
            ['Title'] = "L4 Keycard",
            ['Description'] = "Be In control of the facility, anything you say goes, anything that happens you will know about it. Gain access to be a O5 Council and control the entire SCP Facility!",
        },
        {
            ['DevProduct'] = true,
			['MPSID'] = 1154403777,
            ['ImageId'] = "rbxassetid://5648859864",
            ['Title'] = "[Server Life] L4 Keycard",
            ['Description'] = "Be In control of the facility, anything you say goes, anything that happens you will know about it. Gain access to be a O5 Council and control the entire SCP Facility!",
        },
       
    }

}