local ContentProvider = game:GetService("ContentProvider")
local MenuGui = game.Players.LocalPlayer.PlayerGui:WaitForChild("MenuGui")
local TweenService = game:GetService("TweenService")
return function()
    --local Carousel = CarouselService.new(
    --                     {
    --        "Recontaining SCP 049", "Calculating the Midpoint",
    --        "Recontaining SCP 457", "DMing DrBaja to Fix Bugs",
    --        "Building the Site", "Reporting to Ethics",
    --        "Asking BlueConX for Admin", "Free ranking O5-X",
    --        "Redacted are being Useless", "DMing ConfirmedArchivist for Robux",
    --        "Flinging Overseers Across the Map", "Feeding Class-D to 096",
    --        "Repelling the Insurgency"
    --    }, UDim2.new(1, 0, 1, 0))
    --Carousel.Object.Parent = MenuGui.Loading.loadingtext.background.container
    --local details = MenuGui.Loading.detailtext
    --details.Text = "Requiring Content Assets"
    --while ContentProvider.RequestQueueSize > 0 do
    --    wait(1)
    --    Carousel:Render()
    --end
    --details.Text = "Requiring Game Elements"
    --for i = 1, 1 do
    --    wait(1)
    --    Carousel:Render()
    --end
    --details.Text = "Checking Account Status"
    --for i = 1, 2 do
    --    wait(1)
    --    Carousel:Render()
    --end
    --details.Text = "Logging In"
    --for i = 1, 1 do
    --    wait(1)
    --    Carousel:Render()
    --end
	--Carousel:Destroy()
	local details = MenuGui.Loading.details
	details.Text = "Requiring Content"
	while ContentProvider.RequestQueueSize > 0 do
	    wait(1)
	end
	details.Text = "Getting Game Elements"
	wait(1)
	details.Text = "Checking Account Status"
	wait(1)
	details.Text = "Initializing"
	wait(1)
	details.Visible = false
	
	local tw = TweenService:Create(MenuGui.Loading.logo,TweenInfo.new(3,
		Enum.EasingStyle.Exponential,
		Enum.EasingDirection.InOut,
		0),{Rotation = 1440})
	tw:Play()
	TweenService:Create(MenuGui.Loading.logo,TweenInfo.new(0.8),{ImageTransparency = 0}):Play()
	wait(2.5)
	tw:Pause()
	MenuGui.Loading.logo.Rotation = 0
	
	script.bass:Play()
	TweenService:Create(MenuGui.Loading.Frame.studios,TweenInfo.new(.1),{Position = UDim2.new(0,0,0,0)}):Play()
	TweenService:Create(MenuGui.Loading.circle,TweenInfo.new(.5),{Size = UDim2.new(4,0,4,0)}):Play()
	TweenService:Create(MenuGui.Loading.logo,TweenInfo.new(1.8),{ImageTransparency = 1}):Play()
	TweenService:Create(MenuGui.Loading.Frame.studios,TweenInfo.new(1.8),{TextTransparency = 1}):Play()
	wait(2)

end
