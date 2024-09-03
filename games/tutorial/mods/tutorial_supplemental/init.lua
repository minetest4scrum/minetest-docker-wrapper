-- intllib support
local S
if (minetest.get_modpath("intllib")) then
	S = intllib.Getter()
else
  S = function ( s ) return s end
end

minetest.register_node("tutorial_supplemental:sticky", {
	description = S("sticky stone brick"),
	tiles = {"default_stone_brick.png^supplemental_splat.png",
		"default_stone_brick.png", "default_stone_brick.png", "default_stone_brick.png",
		"default_stone_brick.png", "default_stone_brick.png"},
	groups = {creative_breakable=1, disable_jump=1},
	sounds = default.node_sound_stone_defaults()
})

minetest.register_node("tutorial_supplemental:bouncy", {
	description = S("bouncy block"),
	tiles = {"supplemental_bouncy.png"},
	groups = {creative_breakable=1, bouncy=70, fall_damage_add_percent=-100},
	sounds = default.node_sound_stone_defaults()
})



minetest.register_node("tutorial_supplemental:conglomerate", {
	description = S("conglomerate"),
	tiles = {"supplemental_conglomerate.png" },
	groups = {cracky=3},
	drop = { items = {
			{ items={"tutorial_supplemental:rock"} },
			{ items={"tutorial_supplemental:rock"}, rarity = 5 },
			{ items={"tutorial_supplemental:rock"}, rarity = 5 },
			{ items={"tutorial_supplemental:rock"}, rarity = 5 },
			{ items={"tutorial_supplemental:rock"}, rarity = 5 },
		}
	},
	sounds = default.node_sound_stone_defaults()
})

minetest.register_node("tutorial_supplemental:frame",{
	description = S("picture frame"),
	drawtype = "signlike",
	selection_box = { type = "wallmounted" },
	walkable = false,
	tiles = {"supplemental_frame.png"},
	inventory_image = "supplemental_frame.png",
	wield_image = "supplemental_frame.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	groups = { creative_breakable=1, attached_node=1 },
	legacy_wallmounted = true,
	sounds = default.node_sound_defaults(),
})

minetest.register_node("tutorial_supplemental:spikes", {
	description = S("short spikes"),
	tiles = {"supplemental_spikes_small.png"},
	inventory_image = "supplemental_spikes_small.png",
	wield_image = "supplemental_spikes_small.png",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	groups = { attached_node = 1, creative_breakable = 1 },
	damage_per_second = 1,
	collision_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0.1, 0.5}
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, 0.1, 0.5}
	}
})

minetest.register_node("tutorial_supplemental:spikes_large", {
	description = S("long spikes"),
	tiles = {"supplemental_spikes_large.png"},
	inventory_image = "supplemental_spikes_large.png",
	wield_image = "supplemental_spikes_large.png",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	groups = { attached_node = 1, creative_breakable = 1 },
	damage_per_second = 2
})

-- TODO: Remove the loudspeaker node when there is a more user-friendly means
-- to control the music.
local set_loudspeaker_infotext = function(pos)
	local meta = minetest.get_meta(pos)
	meta:set_string("infotext", S("loudspeaker (rightclick to toggle music)"))
end

minetest.register_node("tutorial_supplemental:loudspeaker", {
	description = S("loudspeaker"),
	tiles = {"supplemental_loudspeaker.png"},
	groups = { creative_breakable = 1 },
	sounds = default.node_sound_wood_defaults(),
	on_construct = set_loudspeaker_infotext,
	on_rightclick = function(pos, node, clicker)
		if tutorial_music.playing then
			tutorial_music.stop_song()
			clicker:get_meta():set_string("play_music", "0")
		else
			tutorial_music.next_song()
			clicker:get_meta():set_string("play_music", "1")
		end
	end,

})

minetest.register_abm({
	nodenames = { "tutorial_supplemental:loudspeaker" },
	interval = 5,
	chance = 1,
	action = set_loudspeaker_infotext,
})

minetest.register_craftitem("tutorial_supplemental:rock", {
	description = S("piece of rock"),
	inventory_image = "supplemental_rock.png",
})

minetest.register_craftitem("tutorial_supplemental:wheat", {
	description = S("wheat"),
	inventory_image = "supplemental_wheat.png",
})

minetest.register_craftitem("tutorial_supplemental:flour", {
	description = S("flour"),
	inventory_image = "supplemental_flour.png",
})
-- Crafting example #2
minetest.register_craft({
	type = "shapeless",
	output = "tutorial_supplemental:flour",
	recipe = {"tutorial_supplemental:wheat", "tutorial_supplemental:wheat", "tutorial_supplemental:wheat", "tutorial_supplemental:wheat"}
})

-- Items for crafting examples #1, #4 and #5
minetest.register_craftitem("tutorial_supplemental:paper_white", {
	description = S("white sheet of paper"),
	inventory_image = "default_paper.png",
	groups = { paper = 1 },
})
minetest.register_craftitem("tutorial_supplemental:paper_orange", {
	description = S("orange sheet of paper"),
	inventory_image = "supplemental_paper_orange.png",
	groups = { paper = 1 },
})
minetest.register_craftitem("tutorial_supplemental:paper_purple", {
	description = S("purple sheet of paper"),
	inventory_image = "supplemental_paper_purple.png",
	groups = { paper = 1 },
})
minetest.register_craftitem("tutorial_supplemental:paper_green", {
	description = S("green sheet of paper"),
	inventory_image = "supplemental_paper_green.png",
	groups = { paper = 1 },
})
-- Crafting example #4
minetest.register_craft({
	output = "tutorial_default:book",
	recipe = {
		{"group:paper"},
		{"group:paper"},
		{"group:paper"}
	}
})


-- 8 viscosity example liquids
for v=0,7 do
	minetest.register_node("tutorial_supplemental:liquid"..v, {
		description = string.format(S("flowing test liquid %i"), v),
		inventory_image = minetest.inventorycube("supplemental_testliquid"..v..".png"),
		drawtype = "flowingliquid",
		tiles = {"supplemental_testliquid"..v..".png"},
		special_tiles = {
			{
				name="supplemental_testliquid"..v..".png",
				backface_culling=false,
			},
			{
				name="supplemental_testliquid"..v..".png",
				backface_culling=true,
			},

		},
		use_texture_alpha = "blend",
		paramtype = "light",
		paramtype2 = "flowingliquid",
		walkable = false,
		pointable = false,
		diggable = false,
		buildable_to = true,
		drop = "",
		drowning = 1,
		liquidtype = "flowing",
		liquid_alternative_flowing = "tutorial_supplemental:liquid"..v,
		liquid_alternative_source = "tutorial_supplemental:liquidsource"..v,
		liquid_viscosity = v,
		groups = {not_in_creative_inventory = 1},
		sounds = default.node_sound_water_defaults(),
	})

	minetest.register_node("tutorial_supplemental:liquidsource"..v, {
		description = string.format(S("test liquid source %i"), v),
		inventory_image = minetest.inventorycube("supplemental_testliquid"..v..".png"),
		drawtype = "liquid",
		special_tiles = {
			{
				name="supplemental_testliquid"..v..".png",
				backface_culling=false,
			},
		},
		tiles = {"supplemental_testliquid"..v..".png",},
		use_texture_alpha = "blend",
		paramtype = "light",
		walkable = false,
		pointable = false,
		diggable = false,
		buildable_to = true,
		drop = "",
		drowning = 1,
		liquidtype = "source",
		liquid_alternative_flowing = "tutorial_supplemental:liquid"..v,
		liquid_alternative_source = "tutorial_supplemental:liquidsource"..v,
		liquid_viscosity = v,
		groups = {},
		sounds = default.node_sound_water_defaults(),
	})

	minetest.register_alias("supplemental:liquid"..v, "tutorial_supplemental:liquid"..v)
	minetest.register_alias("supplemental:liquidsource"..v, "tutorial_supplemental:liquidsource"..v)
end


minetest.register_alias("supplemental:sticky", "tutorial_supplemental:sticky")
minetest.register_alias("supplemental:bouncy", "tutorial_supplemental:bouncy")
minetest.register_alias("supplemental:conglomerate", "tutorial_supplemental:conglomerate")
minetest.register_alias("supplemental:frame", "tutorial_supplemental:frame")
minetest.register_alias("supplemental:spikes", "tutorial_supplemental:spikes")
minetest.register_alias("supplemental:spikes_large", "tutorial_supplemental:spikes_large")
minetest.register_alias("supplemental:loudspeaker", "tutorial_supplemental:loudspeaker")
minetest.register_alias("supplemental:rock", "tutorial_supplemental:rock")
minetest.register_alias("supplemental:wheat", "tutorial_supplemental:wheat")
minetest.register_alias("supplemental:flour", "tutorial_supplemental:flour")
minetest.register_alias("supplemental:paper_white", "tutorial_supplemental:paper_white")
minetest.register_alias("supplemental:paper_orange", "tutorial_supplemental:paper_orange")
minetest.register_alias("supplemental:paper_purple", "tutorial_supplemental:paper_purple")
minetest.register_alias("supplemental:paper_green", "tutorial_supplemental:paper_green")
minetest.register_alias("supplemental:book", "tutorial_supplemental:book")
