
-- Returns a list of areas and number of areas that include the provided position
function areas:getAreasAtPos(pos)
	local a = {}
	local amount = 0
	local px, py, pz = pos.x, pos.y, pos.z
	for id, area in pairs(self.areas) do
		local ap1, ap2 = area.pos1, area.pos2
		if px >= ap1.x and px <= ap2.x and
		   py >= ap1.y and py <= ap2.y and
		   pz >= ap1.z and pz <= ap2.z then
			a[id] = area
			amount = amount + 1
		end
	end
	return a, amount
end

