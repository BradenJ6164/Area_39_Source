for i,v in pairs(script.Parent:GetChildren()) do
	if v:IsA("ImageButton") then
		v.MouseButton1Click:Connect(function()
			script.Parent.SelectedColor.Value = BrickColor.new(v.ImageColor3)
		end)
	end
end