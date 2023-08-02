return {
	['Type'] = "Swing Door",
	
	['OpenOutState'] = script.Parent.Scripted.Hinge.CFrame*CFrame.Angles(0,math.rad(-120),0),
	['OpenInState'] = script.Parent.Scripted.Hinge.CFrame*CFrame.Angles(0,math.rad(120),0),
	['CloseState'] = script.Parent.Scripted.Hinge.CFrame,
	
	['Tweener'] = script.Parent.Scripted.Hinge,
	
	['TweenTime'] = 0.5,
	['Clearance'] = 1,
	
	['AutoClose'] = true,
	['AutoCloseTime'] = 1.5,
	
}