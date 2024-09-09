-- intllib support
local S
if (minetest.get_modpath("intllib")) then
	S = intllib.Getter()
else
  S = function ( s ) return s end
end

minetest.register_node("tutorial_castle:light",{
	drawtype = "glasslike",
	description = S("light block"),
	sunlight_propagates = true,
	light_source = 14,
	tiles = {"castle_street_light.png"},
	groups = {creative_breakable=1},
	paramtype = "light",
	sounds = default.node_sound_glass_defaults()
})
