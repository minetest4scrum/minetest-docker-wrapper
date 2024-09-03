-- intllib support
local S
if (minetest.get_modpath("intllib")) then
	S = intllib.Getter()
else
  S = function ( s ) return s end
end

minetest.register_node("tutorial_darkage:basalt_cobble", {
	description = S("basalt cobble"),
	tiles = {"darkage_basalt_cobble.png"},
	groups = {creative_breakable=1},
	sounds = default.node_sound_stone_defaults()
})

minetest.register_node("tutorial_darkage:basalt_brick", {
	description = S("basalt brick"),
	tiles = {"darkage_basalt_brick.png"},
	groups = {creative_breakable=1},
	sounds = default.node_sound_stone_defaults()
})

minetest.register_node("tutorial_darkage:stone_brick", {
	description = S("stone brick"),
	tiles = {"darkage_stone_brick.png"},
	groups = {creative_breakable=1},
	sounds = default.node_sound_stone_defaults()
})

-- Other Blocks
minetest.register_node("tutorial_darkage:straw", {
	description = S("straw"),
	tiles = {"darkage_straw.png"},
	groups = {creative_breakable=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("tutorial_darkage:lamp", {
	description = S("lamp"),
	tiles = {"darkage_lamp.png"},
	paramtype = "light",
	light_source = minetest.LIGHT_MAX,
	groups = {creative_breakable=1},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("tutorial_darkage:marble_tile", {
	description = S("marble tile"),
	tiles = {"darkage_marble_tile.png"},
	groups = {creative_breakable=1},
	sounds = default.node_sound_stone_defaults()
})

-- Glass / Glow Glass
minetest.register_node("tutorial_darkage:glass", {
	description = S("medieval glass"),
	drawtype = "glasslike",
	tiles = {"darkage_glass.png"},
	paramtype = "light",
	sunlight_propagates = true,
	groups = {creative_breakable=1},
	sounds = default.node_sound_glass_defaults(),
})

-- Wood based deco items
minetest.register_node("tutorial_darkage:wood_bars", {
	description = S("wooden bars"),
	drawtype = "glasslike",
	tiles = {"darkage_wood_bars.png"},
	inventory_image = "darkage_wood_bars.png",
	wield_image = "darkage_wood_bars.png",
	paramtype = "light",
	sunlight_propagates = true,
	groups = {creative_breakable=1},
	sounds = default.node_sound_wood_defaults()
})

minetest.register_node("tutorial_darkage:wood_grille", {
	description = S("wooden grille"),
	drawtype = "glasslike",
	tiles = {"darkage_wood_grille.png"},
	inventory_image = "darkage_wood_grille.png",
	wield_image = "darkage_wood_grille.png",
	paramtype = "light",
	sunlight_propagates = true,
	groups = {creative_breakable=1},
	sounds = default.node_sound_wood_defaults()
})

minetest.register_node("tutorial_darkage:wood_frame", {
	description = S("wooden frame"),
	drawtype = "glasslike",
	tiles = {"darkage_wood_frame.png"},
	inventory_image = "darkage_wood_frame.png",
	wield_image = "darkage_wood_frame.png",
	paramtype = "light",
	sunlight_propagates = true,
	groups = {creative_breakable=1},
	sounds = default.node_sound_wood_defaults()
})

minetest.register_node("tutorial_darkage:iron_bars", {
	description = S("iron bars"),
	drawtype = "glasslike",
	tiles = {"darkage_iron_bars.png"},
	inventory_image = "darkage_iron_bars.png",
	wield_image = "darkage_iron_bars.png",
	paramtype = "light",
	sunlight_propagates = true,
	groups = {creative_breakable=1},
	sounds = default.node_sound_metal_defaults()
})

minetest.register_node("tutorial_darkage:iron_grille", {
	description = S("iron grille"),
	drawtype = "glasslike",
	tiles = {"darkage_iron_grille.png"},
	inventory_image = "darkage_iron_grille.png",
	sunlight_propagates = true,
	paramtype = "light",
	groups = {creative_breakable=1},
	sounds = default.node_sound_metal_defaults()
})

minetest.register_alias("darkage:basalt_cobble", "tutorial_darkage:basalt_cobble")
minetest.register_alias("darkage:basalt_brick", "tutorial_darkage:basalt_brick")
minetest.register_alias("darkage:stone_brick", "tutorial_darkage:stone_brick")
minetest.register_alias("darkage:straw", "tutorial_darkage:straw")
minetest.register_alias("darkage:lamp", "tutorial_darkage:lamp")
minetest.register_alias("darkage:marble_tile", "tutorial_darkage:marble_tile")
minetest.register_alias("darkage:glass", "tutorial_darkage:glass")
minetest.register_alias("darkage:wood_bars", "tutorial_darkage:wood_bars")
minetest.register_alias("darkage:wood_grille", "tutorial_darkage:wood_grille")
minetest.register_alias("darkage:wood_frame", "tutorial_darkage:wood_frame")
minetest.register_alias("darkage:iron_bars", "tutorial_darkage:iron_bars")
minetest.register_alias("darkage:iron_grille", "tutorial_darkage:iron_grille")
