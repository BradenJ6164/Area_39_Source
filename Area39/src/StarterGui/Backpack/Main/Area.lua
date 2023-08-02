local Area = {}

function Area:IsInArea2D(ingressPosition, areaAbsolutePosition, areaAbsoluteSize)
	if ingressPosition.X >= areaAbsolutePosition.X and ingressPosition.X <= areaAbsolutePosition.X + areaAbsoluteSize.X and ingressPosition.Y >= areaAbsolutePosition.Y and ingressPosition.Y <= areaAbsolutePosition.Y + areaAbsoluteSize.Y then
		return true
	else
		return false
	end
end

return Area
