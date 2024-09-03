-- intllib support
local S, F
if (minetest.get_modpath("intllib")) then
	S = intllib.Getter()
	F = function( s )
		return minetest.formspec_escape(S(s))
	end
else
  S = function ( s ) return s end
  F = function ( s ) return minetest.formspec_escape(s) end
end

local WATER_VISC = 1

minetest.register_node("tutorial_default:stone", {
	description = S("stone"),
	tiles = {"default_stone.png"},
	is_ground_content = true,
	groups = {cracky=3, stone=1},
	drop = 'tutorial_default:cobble',
	legacy_mineral = true,
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("tutorial_default:stone_with_coal", {
	description = S("coal ore"),
	tiles = {"default_stone.png^default_mineral_coal.png"},
	is_ground_content = true,
	groups = {cracky=3},
	drop = 'tutorial_default:coal_lump',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("tutorial_default:stone_with_iron", {
	description = S("iron ore"),
	tiles = {"default_stone.png^default_mineral_iron.png"},
	is_ground_content = true,
	groups = {cracky=2},
	drop = 'tutorial_default:iron_lump',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("tutorial_default:stone_with_gold", {
	description = S("gold ore"),
	tiles = {"default_stone.png^default_mineral_gold.png"},
	is_ground_content = true,
	groups = {cracky=2},
	drop = "tutorial_default:gold_lump",
	sounds = default.node_sound_stone_defaults(),
})
	
minetest.register_node("tutorial_default:stone_with_diamond", {
	description = S("diamond ore"),
	tiles = {"default_stone.png^default_mineral_diamond.png"},
	is_ground_content = true,
	groups = {cracky=1},
	drop = "tutorial_default:diamond",
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("tutorial_default:dirt_with_grass", {
	description = S("dirt with grass"),
	tiles = {"default_grass.png", "default_dirt.png", "default_dirt.png^default_grass_side.png"},
	is_ground_content = true,
	groups = {creative_breakable=1},
	drop = 'tutorial_default:dirt',
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.25},
	}),
})

minetest.register_node("tutorial_default:dirt", {
	description = S("dirt"),
	tiles = {"default_dirt.png"},
	is_ground_content = true,
	groups = {creative_breakable=1},
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("tutorial_default:sand", {
	description = S("sand"),
	tiles = {"default_sand.png"},
	is_ground_content = true,
	groups = {creative_breakable=1, falling_node=1},
	sounds = default.node_sound_sand_defaults(),
})

minetest.register_node("tutorial_default:tree", {
	description = S("tree trunk"),
	tiles = {"default_tree_top.png", "default_tree_top.png", "default_tree.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {creative_breakable=1},
	sounds = default.node_sound_wood_defaults(),
	on_place = minetest.rotate_node
})

minetest.register_node("tutorial_default:leaves", {
	description = S("leaves"),
	drawtype = "allfaces_optional",
	waving = 1,
	tiles = {"default_leaves.png"},
	paramtype = "light",
	is_ground_content = false,
	groups = {creative_breakable=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("tutorial_default:grass_5", {
	description = S("grass"),
	tiles = {"default_grass_5.png"},
	is_ground_content = true,
	groups = {attached_node=1,creative_breakable=1},
	sounds = default.node_sound_leaves_defaults(),
	wield_image = "default_grass_5.png",
	inventory_image = "default_grass_5.png",
	drawtype = "plantlike",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
})

minetest.register_node("tutorial_default:ladder", {
	description = S("ladder"),
	drawtype = "signlike",
	tiles = {"default_ladder.png"},
	inventory_image = "default_ladder.png",
	wield_image = "default_ladder.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	walkable = false,
	climbable = true,
	is_ground_content = false,
	selection_box = {
		type = "wallmounted",
	},
	groups = {attached_node=1,creative_breakable=1},
	legacy_wallmounted = true,
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("tutorial_default:wood", {
	description = S("wooden planks"),
	tiles = {"default_wood.png"},
	groups = {choppy=2,wood=1},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("tutorial_default:water_flowing", {
	description = S("flowing water"),
	inventory_image = minetest.inventorycube("default_water.png"),
	drawtype = "flowingliquid",
	tiles = {"default_water.png"},
	special_tiles = {
		{
			image="default_water_flowing_animated.png",
			backface_culling=false,
			animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=0.8}
		},
		{
			image="default_water_flowing_animated.png",
			backface_culling=true,
			animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=0.8}
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
	liquid_alternative_flowing = "tutorial_default:water_flowing",
	liquid_alternative_source = "tutorial_default:water_source",
	liquid_viscosity = WATER_VISC,
	post_effect_color = {a=64, r=100, g=100, b=200},
	groups = {water=3, liquid=3, puts_out_fire=1, not_in_creative_inventory=1, freezes=1, melt_around=1},
	sounds = default.node_sound_water_defaults(),
})

minetest.register_node("tutorial_default:water_source", {
	description = S("water source"),
	inventory_image = minetest.inventorycube("default_water.png"),
	drawtype = "liquid",
	tiles = {
		{name="default_water_source_animated.png", animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=2.0}}
	},
	special_tiles = {
		-- New-style water source material (mostly unused)
		{
			name="default_water_source_animated.png",
			animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=2.0},
			backface_culling = false,
		}
	},
	use_texture_alpha = "blend",
	paramtype = "light",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "tutorial_default:water_flowing",
	liquid_alternative_source = "tutorial_default:water_source",
	liquid_viscosity = WATER_VISC,
	post_effect_color = {a=64, r=100, g=100, b=200},
	groups = {water=3, liquid=3, puts_out_fire=1, freezes=1},
	sounds = default.node_sound_water_defaults(),
})

minetest.register_node("tutorial_default:torch", {
	description = S("torch"),
	drawtype = "torchlike",
	--tiles = {"default_torch_on_floor.png", "default_torch_on_ceiling.png", "default_torch.png"},
	tiles = {
		{name="default_torch_on_floor_animated.png", animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=3.0}},
		{name="default_torch_on_ceiling_animated.png", animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=3.0}},
		{name="default_torch_animated.png", animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=3.0}}
	},
	inventory_image = "default_torch_on_floor.png",
	wield_image = "default_torch_on_floor.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	is_ground_content = false,
	walkable = false,
	light_source = 13,
	selection_box = {
		type = "wallmounted",
		wall_top = {-0.1, 0.5-0.6, -0.1, 0.1, 0.5, 0.1},
		wall_bottom = {-0.1, -0.5, -0.1, 0.1, -0.5+0.6, 0.1},
		wall_side = {-0.5, -0.3, -0.1, -0.5+0.3, 0.3, 0.1},
	},
	groups = {attached_node=1,creative_breakable = 1},
	legacy_wallmounted = true,
	sounds = default.node_sound_defaults(),
})

function default.chest_formspec()
	return
	"size[8,10.6]"..
	default.gui_bg..
	default.gui_bg_img..
	default.gui_slots..
	"label[0,-0.2;"..minetest.formspec_escape(S("Chest inventory:")).."]"..
	"list[current_name;main;0,0.3;8,4;]"..
	"label[0,4.35;"..minetest.formspec_escape(S("Player inventory:")).."]"..
	"list[current_player;main;0,4.85;8,1;]"..
	"list[current_player;main;0,6.08;8,3;8]"..
	"listring[current_name;main]"..
	"listring[current_player;main]"..
	"label[0,9.1;"..default.gui_controls.."]"..
	default.get_hotbar_bg(0,4.85)
end

minetest.register_node("tutorial_default:chest", {
	description = S("storage chest"),
	tiles = {"default_chest_top.png", "default_chest_top.png", "default_chest_side.png",
		"default_chest_side.png", "default_chest_side.png", "default_chest_front.png"},
	paramtype2 = "facedir",
	groups = {creative_breakable=1},
	legacy_facedir_simple = true,
	is_ground_content = false,
	sounds = default.node_sound_wood_defaults(),
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", default.chest_formspec())
		meta:set_string("infotext", S("Chest (Rightclick to open)"))
		local inv = meta:get_inventory()
		inv:set_size("main", 8*4)
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty("main")
	end,
	on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff in chest at "..minetest.pos_to_string(pos))
	end,
    on_metadata_inventory_put = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff to chest at "..minetest.pos_to_string(pos))
	end,
    on_metadata_inventory_take = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
				" takes stuff from chest at "..minetest.pos_to_string(pos))
	end,
})

function default.furnace_active(pos, percent, item_percent)
    local formspec = 
	"size[8,9.8]"..
	default.gui_bg..
	default.gui_bg_img..
	default.gui_slots..
	"label[-0.1,-0.3;"..minetest.formspec_escape(S("This furnace is active and constantly burning its fuel.")).."]"..
	"label[2.25,0.1;"..minetest.formspec_escape(S("Source:")).."]"..
	"list[current_name;src;2.25,0.5;1,1;]"..
	"label[2.25,2.5;"..minetest.formspec_escape(S("Fuel:")).."]"..
	"list[current_name;fuel;2.25,2.9;1,1;]"..
	"label[2.25,1.3;"..minetest.formspec_escape(S("Flame:")).."]"..
	"image[2.25,1.7;1,1;default_furnace_fire_bg.png^[lowpart:"..
	(100-percent)..":default_furnace_fire_fg.png]"..
	"label[3.75,1.3;"..minetest.formspec_escape(S("Progress:")).."]"..
        "image[3.75,1.7;1,1;gui_furnace_arrow_bg.png^[lowpart:"..
        (item_percent*100)..":gui_furnace_arrow_fg.png^[transformR270]"..
	"label[5.75,0.70;"..minetest.formspec_escape(S("Output slots:")).."]"..
	"list[current_name;dst;5.75,1.16;2,2;]"..
	"label[0,3.75;"..minetest.formspec_escape(S("Player inventory:")).."]"..
	"list[current_player;main;0,4.25;8,1;]"..
	"list[current_player;main;0,5.5;8,3;8]"..
	"listring[current_name;dst]"..
	"listring[current_player;main]"..
	"listring[current_name;src]"..
	"listring[current_player;main]"..
	"label[0,8.5;"..default.gui_controls.."]"..
	default.get_hotbar_bg(0,4.25)
    return formspec
  end

function default.get_furnace_active_formspec(pos, percent)
	local meta = minetest.get_meta(pos)local inv = meta:get_inventory()
	local srclist = inv:get_list("src")
	local cooked = nil
	local aftercooked = nil
	if srclist then
		cooked, aftercooked = minetest.get_craft_result({method = "cooking", width = 1, items = srclist})
	end
	local item_percent = 0
	if cooked then
		item_percent = meta:get_float("src_time")/cooked.time
	end
       
        return default.furnace_active(pos, percent, item_percent)
end

default.furnace_inactive_formspec =
	"size[8,9.8]"..
	default.gui_bg..
	default.gui_bg_img..
	default.gui_slots..
	"label[-0.1,-0.3;"..minetest.formspec_escape(S("This furnace is inactive. Please read the sign above.")).."]"..
	"label[2.25,0.1;"..minetest.formspec_escape(S("Source:")).."]"..
	"list[current_name;src;2.25,0.5;1,1;]"..
	"label[2.25,2.5;"..minetest.formspec_escape(S("Fuel:")).."]"..
	"list[current_name;fuel;2.25,2.9;1,1;]"..
	"label[2.25,1.3;"..minetest.formspec_escape(S("Flame:")).."]"..
	"image[2.25,1.7;1,1;default_furnace_fire_bg.png]"..
	"label[3.75,1.3;"..minetest.formspec_escape(S("Progress:")).."]"..
	"image[3.75,1.7;1,1;gui_furnace_arrow_bg.png^[transformR270]"..
	"label[5.75,0.70;"..minetest.formspec_escape(S("Output slots:")).."]"..
	"list[current_name;dst;5.75,1.16;2,2;]"..
	"label[0,3.75;"..minetest.formspec_escape(S("Player inventory:")).."]"..
	"list[current_player;main;0,4.25;8,1;]"..
	"list[current_player;main;0,5.5;8,3;8]"..
	"listring[current_name;dst]"..
	"listring[current_player;main]"..
	"listring[current_name;src]"..
	"listring[current_player;main]"..
	"label[0,8.5;"..default.gui_controls.."]"..
	default.get_hotbar_bg(0,4.25)

minetest.register_node("tutorial_default:furnace", {
	description = S("furnace"),
	tiles = {"default_furnace_top.png", "default_furnace_bottom.png", "default_furnace_side.png",
		"default_furnace_side.png", "default_furnace_side.png", "default_furnace_front.png"},
	paramtype2 = "facedir",
	groups = {creative_breakable=1},
	legacy_facedir_simple = true,
	is_ground_content = false,
	sounds = default.node_sound_stone_defaults(),
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", default.furnace_inactive_formspec)
		meta:set_string("infotext", S("Inactive furnace (Rightclick to examine)"))
		local inv = meta:get_inventory()
		inv:set_size("fuel", 1)
		inv:set_size("src", 1)
		inv:set_size("dst", 4)
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		if not inv:is_empty("fuel") then
			return false
		elseif not inv:is_empty("dst") then
			return false
		elseif not inv:is_empty("src") then
			return false
		end
		return true
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		if minetest.is_protected(pos, player:get_player_name()) then
			return 0
		end
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		if listname == "fuel" then
			if minetest.get_craft_result({method="fuel",width=1,items={stack}}).time ~= 0 then
				if inv:is_empty("src") then
					meta:set_string("infotext",S("Empty furnace (Rightclick to examine)"))
				end
				return stack:get_count()
			else
				return 0
			end
		elseif listname == "src" then
			return stack:get_count()
		elseif listname == "dst" then
			return 0
		end
	end,
	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		if minetest.is_protected(pos, player:get_player_name()) then
			return 0
		end
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		local stack = inv:get_stack(from_list, from_index)
		if to_list == "fuel" then
			if minetest.get_craft_result({method="fuel",width=1,items={stack}}).time ~= 0 then
				if inv:is_empty("src") then
					meta:set_string("infotext",S("Empty furnace (Rightclick to examine)"))
				end
				return count
			else
				return 0
			end
		elseif to_list == "src" then
			return count
		elseif to_list == "dst" then
			return 0
		end
	end,
	allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		if minetest.is_protected(pos, player:get_player_name()) then
			return 0
		end
		return stack:get_count()
	end,
})

minetest.register_node("tutorial_default:furnace_active", {
	description = S("furnace"),
	tiles = {
		"default_furnace_top.png",
		"default_furnace_bottom.png",
		"default_furnace_side.png",
		"default_furnace_side.png",
		"default_furnace_side.png",
		{
			image = "default_furnace_front_active.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 1.5
			},
		}
	},
	paramtype2 = "facedir",
	light_source = 8,
	drop = "tutorial_default:furnace",
	groups = {creative_breakable=1,not_in_creative_inventory=1,hot=1},
	legacy_facedir_simple = true,
	is_ground_content = false,
	sounds = default.node_sound_stone_defaults(),
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", default.furnace_inactive_formspec)
		meta:set_string("infotext", S("Inactive furnace (Rightclick to examine)"));
		local inv = meta:get_inventory()
		inv:set_size("fuel", 1)
		inv:set_size("src", 1)
		inv:set_size("dst", 4)
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		if not inv:is_empty("fuel") then
			return false
		elseif not inv:is_empty("dst") then
			return false
		elseif not inv:is_empty("src") then
			return false
		end
		return true
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		if minetest.is_protected(pos, player:get_player_name()) then
			return 0
		end
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		if listname == "fuel" then
			if minetest.get_craft_result({method="fuel",width=1,items={stack}}).time ~= 0 then
				if inv:is_empty("src") then
					meta:set_string("infotext",S("Empty furnace (Rightclick to examine)"))
				end
				return stack:get_count()
			else
				return 0
			end
		elseif listname == "src" then
			return stack:get_count()
		elseif listname == "dst" then
			return 0
		end
	end,
	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		if minetest.is_protected(pos, player:get_player_name()) then
			return 0
		end
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		local stack = inv:get_stack(from_list, from_index)
		if to_list == "fuel" then
			if minetest.get_craft_result({method="fuel",width=1,items={stack}}).time ~= 0 then
				if inv:is_empty("src") then
					meta:set_string("infotext",S("Empty furnace (Rightclick to examine)"))
				end
				return count
			else
				return 0
			end
		elseif to_list == "src" then
			return count
		elseif to_list == "dst" then
			return 0
		end
	end,
	allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		if minetest.is_protected(pos, player:get_player_name()) then
			return 0
		end
		return stack:get_count()
	end,
})

local function swap_node(pos,name)
	local node = minetest.get_node(pos)
	if node.name == name then
		return
	end
	node.name = name
	minetest.swap_node(pos,node)
end

minetest.register_abm({
	nodenames = {"tutorial_default:chest"},
	interval = 5,
	chance = 1,
	action = function(pos,node,active_object_count, active_object_count_wider)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", default.chest_formspec())
		meta:set_string("infotext", S("Chest (Rightclick to open)"))
	end
})

minetest.register_abm({
	nodenames = {"tutorial_default:furnace","tutorial_default:furnace_active"},
	interval = 1.0,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local meta = minetest.get_meta(pos)
		for i, name in ipairs({
				"fuel_totaltime",
				"fuel_time",
				"src_totaltime",
				"src_time"
		}) do
			if meta:get_string(name) == "" then
				meta:set_float(name, 0.0)
			end
		end

		local inv = meta:get_inventory()

		local srclist = inv:get_list("src")
		local cooked = nil
		local aftercooked
		
		if srclist then
			cooked, aftercooked = minetest.get_craft_result({method = "cooking", width = 1, items = srclist})
		end
		
		local was_active = false
		
		if meta:get_float("fuel_time") < meta:get_float("fuel_totaltime") then
			was_active = true
			meta:set_float("fuel_time", meta:get_float("fuel_time") + 1)
			meta:set_float("src_time", meta:get_float("src_time") + 1)
			if cooked and cooked.item and meta:get_float("src_time") >= cooked.time then
				-- check if there's room for output in "dst" list
				if inv:room_for_item("dst",cooked.item) then
					-- Put result in "dst" list
					inv:add_item("dst", cooked.item)
					-- take stuff from "src" list
					inv:set_stack("src", 1, aftercooked.items[1])
				else
					--print("Could not insert '"..cooked.item:to_string().."'")
				end
				meta:set_string("src_time", 0)
			end
		end
		
		if meta:get_float("fuel_time") < meta:get_float("fuel_totaltime") then
			local percent = math.floor(meta:get_float("fuel_time") /
					meta:get_float("fuel_totaltime") * 100)
			meta:set_string("infotext",string.format(S("Active furnace (Flame used: %d%%) (Rightclick to examine)"), percent))
			swap_node(pos,"tutorial_default:furnace_active")
			meta:set_string("formspec",default.get_furnace_active_formspec(pos, percent))
			return
		end

		local fuel = nil
		local afterfuel
		local cooked = nil
		local fuellist = inv:get_list("fuel")
		local srclist = inv:get_list("src")
		
		if srclist then
			cooked = minetest.get_craft_result({method = "cooking", width = 1, items = srclist})
		end
		if fuellist then
			fuel, afterfuel = minetest.get_craft_result({method = "fuel", width = 1, items = fuellist})
		end

		if not fuel or fuel.time <= 0 then
			meta:set_string("infotext",S("Furnace without fuel (Rightclick to examine)"))
			swap_node(pos,"tutorial_default:furnace")
			meta:set_string("formspec", default.furnace_inactive_formspec)
			return
		end

		if cooked.item:is_empty() then
			if was_active then
				meta:set_string("infotext",S("Empty furnace (Rightclick to examine)"))
				swap_node(pos,"tutorial_default:furnace")
				meta:set_string("formspec", default.furnace_inactive_formspec)
			end
			return
		end

		meta:set_string("fuel_totaltime", fuel.time)
		meta:set_string("fuel_time", 0)
		
		inv:set_stack("fuel", 1, afterfuel.items[1])
	end,
})

minetest.register_node("tutorial_default:cobble", {
	description = S("cobblestone"),
	tiles = {"default_cobble.png"},
	is_ground_content = true,
	groups = {cracky=3, stone=2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("tutorial_default:apple", {
	description = S("apple"),
	drawtype = "plantlike",
	visual_scale = 1.0,
	tiles = {"default_apple.png"},
	inventory_image = "default_apple.png",
	paramtype = "light",
	sunlight_propagates = true,
	walkable = false,
	is_ground_content = true,
	selection_box = {
		type = "fixed",
		fixed = {-0.2, -0.5, -0.2, 0.2, 0, 0.2}
	},
	groups = {dig_immediate=3,},
	on_use = minetest.item_eat(1),
	sounds = default.node_sound_leaves_defaults(),
	after_place_node = function(pos, placer, itemstack)
		if placer:is_player() then
			minetest.set_node(pos, {name="tutorial_default:apple", param2=1})
		end
	end,
})
