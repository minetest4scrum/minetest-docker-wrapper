-- intllib support
local S
if (minetest.get_modpath("intllib")) then
	S = intllib.Getter()
else
  S = function ( s ) return s end
end

areas.hud = {}

minetest.register_globalstep(function(dtime)
	for _, player in pairs(minetest.get_connected_players()) do
		local name = player:get_player_name()
		local pos = vector.round(player:get_pos())
		local areaStrings = {}
		for id, area in pairs(areas:getAreasAtPos(pos)) do
			if not area.hidden then
				table.insert(areaStrings, (S("You are here: %s")):format(S(area.name)))
			end
		end
		local areaString = table.concat(areaStrings, "\n")
		local hud = areas.hud[name]
		if not hud then
			hud = {}
			areas.hud[name] = hud
			hud.areasId = player:hud_add({
				hud_elem_type = "text",
				name = "Areas",
				number = 0xFFFFFF,
				position = {x=1, y=0.25},
				offset = {x=-12, y=17},
				text = areaString,
				scale = {x=200, y=60},
				alignment = {x=-1, y=1},
			})
			hud.oldAreas = areaString
			return
		elseif hud.oldAreas ~= areaString then
			player:hud_change(hud.areasId, "text", areaString)
			hud.oldAreas = areaString
		end
	end
end)

minetest.register_on_leaveplayer(function(player)
	areas.hud[player:get_player_name()] = nil
end)

