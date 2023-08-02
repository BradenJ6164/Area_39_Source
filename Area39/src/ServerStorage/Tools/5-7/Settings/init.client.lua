repeat wait() until _G.Area39 ~= nil
local continue = false
repeat wait() 
	local continue = pcall(function() 
		_G.Area39:GetService("GunSystem")	
	end)	
until continue == true
local module = _G.Area39:GetService("GunSystem")
module(require(script.Parent),script.Parent.Parent)