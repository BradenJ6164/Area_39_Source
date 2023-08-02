local syncTime = _G.Area39:GetService("TimeSync")
syncTime.init()

local RunService = game:GetService("RunService")
local DataService = _G.Area39:GetService("DataStore2")

local function toHMS(s)
    return _G.Area39:GetService("TimeFormat"):Convert(s, "Default", true)
end
local currentDay

local currentQuests = {
}
local hourOffset = -2

local offset = (60*60*hourOffset)

local quests = {
    ['Class D'] = {
        "Kill 25 Enemies",
        "Escape the facility twice",
    },
    ['Chaos Insurgency'] = {
        "Kill 25 Enemies",
        "Overtake the Control Room",
    },
    ['Mobile Task Force'] = {
        "Guard for 5 Minutes",
    },
    ['Rapid Response Team'] = {
        "Guard for 5 Minutes",
    }
}

local questRequirements = {
    ["Kill 25 Enemies"] = {
        ['Kills'] = 25,
    },
    ["Escape the facility twice"] = {
        ['Escapes'] = 2,
    },
    ["Overtake the Control Room"] = {
        ['ControlRoomOvertakes'] = 1,
    },
    ["Guard for 5 Minutes"] = {
        ['TimeGuarding'] = 300,
    },
}

function getAvailableItems(team,day,numberOfQuests)
    if not numberOfQuests then numberOfQuests = 2 end
    if not quests[team] then return end
    if #quests[team] <= 0 then return {} end
    local rng = Random.new(day)
    local questItems = {}

    local function shallowCopy(original) -- function to copy the table so we can remove values from it.
	    local copy = {}
	    for key, value in pairs(original) do
	        copy[key] = value
	    end
	    return copy
	end

    local function Generate() -- Generate funciton
		local questItem = quests[team][rng:NextInteger(1,#quests[team])] -- Gets a random item in the table. This will generate the same sequence of items if the seed is the same.
		local itemtablecopy = shallowCopy(quests[team]) -- Copy the table 
		
		local duplicate = table.find(questItems, questItem) --Finds a duplicate
		
		if duplicate then -- If there is a duplicate and it's not nil...
			
			for number, v in pairs(itemtablecopy) do 
				for i = 1, #questItems do
					if v == questItems[i] then
			        	table.remove(itemtablecopy, number) -- if an item in the copied table is the same as a value inside of our shop items already, then it removes it
			        end
				end
			end

			
			questItem = itemtablecopy[rng:NextInteger(1,#itemtablecopy)] -- keep randomnly generating an item from the items that we have left
			
		end

		table.insert(questItems, questItem) -- Inserts the item inside of the table
	end
	
	repeat
        Generate()
        wait()
	until #questItems >= numberOfQuests -- keep generating items until we get to the # of items we want.

    return questItems
end

if RunService:IsServer() then
    spawn(function()
        while true do
            local day = math.floor((syncTime.time() + offset) / (60 * 60 * 24)) -- flooring is EXTREMELY important here, because that means the number won't change unless it becomes an integer higher. This is the seed we're going to supply to our getAvailableItems function. This would output something like 18431. By dividing this by 24 hours and adding our offset, we know that if the number changes, THEN a day has passed since the epoch +  our own offset.
            local t = (math.floor(syncTime.time())) + offset -- Sets the time to your offset time (ex. 8 pm PST)
            local daypass = t % 86400 -- Using % gives us the remainder, which in our case is how far into a day we are
            local timeleft = 86400 - daypass -- Now we can easily calculate how much time is left by subtracting a day (86,400 seconds) by daypass
            local timeleftstring = toHMS(timeleft) -- This will format the time to HH:MM:SS (ex. 05:42:03)
                
            
            
            --Obviously, you'd use "timeleftstring" to display a timer or something
        
            if day ~= currentDay then -- If the day variable isn't equal to currentDay (so when the day variable changes...)
                currentDay = day -- update the currentDay variable
                for i,v in pairs(game.Teams:GetTeams()) do
                    currentQuests[v.Name] = getAvailableItems(v.Name, 2)
                    if not currentQuests[v.Name] then currentQuests[v.Name] = {} end
                    print("The quests for " .. v.Name ..  " for today are these: ".. table.concat(currentQuests[v.Name], ", ")) -- prints out the items you get
                end
            
                
                --Your code to update your shop would go here!
                --print("Updated shop items.")		
            end
            wait(1)
        end
    end)
end

local function plrAdd(plr)
    local plrStore = DataService("PlayerQuestData", plr)
    plr:WaitForChild("Stats")
    for i,v in pairs(plr.Stats:GetChildren()) do
        v.Changed:Connect(function()
            
            local currentQuests = game.ReplicatedStorage.Remotes.Get.Bind:Invoke(plr,"GetQuests")
           
            if currentQuests and #currentQuests > 1 then
                
                local data = plrStore:Get({})
                if data then
                    
                    for i,quest in pairs(currentQuests) do
                        local duplicate = false
                        if not data then
                            data = {}
                        end
                        for i,x in pairs(data or {}) do
                            print(x)
                            if tostring(i) == tostring(quest) then
                                local compar = math.abs(x-syncTime.time())
                                if compar <= 86400 then
                                    duplicate = true
                                end
                            end
                        end
                        print(duplicate
                        )
                        if not duplicate then
                           
                            if questRequirements[quest] then
                               
                                if questRequirements[quest][v.Name] then
                                   
                                    if v.Value >= questRequirements[quest][v.Name] then -- Quest Complete
                                      
                                        data = plrStore:Get()
                                        data[v.Name] = syncTime.time()
                                        plrStore:Set(data)
                                       
                                        _G.Area39:SendSnackBar(plr,"You completed '" .. quest .. "' quest.")
                                        v.Value = 0
                                    end
                                end
                            end
                        end
                    end
                end
            else
                v.Value = 0
            end
        end)
    end
end
for i,v in pairs(game.Players:GetPlayers()) do
    plrAdd(v)
end
game.Players.PlayerAdded:Connect(plrAdd)

return currentQuests
