return {
	['Type'] = "Swing Door",
	
	['OpenOutState'] = script.Parent.Scripted.Hinge.CFrame*CFrame.new(0,7.5,0),
	['OpenInState'] = script.Parent.Scripted.Hinge.CFrame*CFrame.new(0,7.5,0),
	['CloseState'] = script.Parent.Scripted.Hinge.CFrame,
	
	['Tweener'] = script.Parent.Scripted.Hinge,
	
	['TweenTime'] = 1,
	['Clearance'] = 3,
	
	['AutoClose'] = true,
	['AutoCloseTime'] = 2.5,
	
}