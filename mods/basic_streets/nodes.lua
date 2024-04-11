
local has_dye_mod = minetest.get_modpath("dye")
local has_unifieddyes_mod = minetest.get_modpath("unifieddyes")
local has_default_mod = minetest.get_modpath("default")
local has_moreblocks_mod = minetest.get_modpath("moreblocks")
local has_building_blocks_mod = minetest.get_modpath("building_blocks")

local sounds
if has_default_mod then
	-- use default sounds if possible
	sounds = default.node_sound_stone_defaults()
end

-- street nodes
local nodes = {
	["street_straight"] = {
		description = "Tar with straight street markings",
		overlay = "basic_streets_solid_center_line_wide.png",
	},
	["street_corner"] = {
		description = "Tar with corner street markings",
		overlay = "basic_streets_solid_center_line_wide_corner.png",
	},
	["street_crossing"] = {
		description = "Tar with crossing street markings",
		overlay = "basic_streets_solid_center_line_wide_crossing.png",
	},
	["street_tjunction"] = {
		description = "Tar with straight t-junction markings",
		overlay = "basic_streets_solid_center_line_wide_tjunction.png",
	}
}

for name, def in pairs(nodes) do
	-- node registration
	local nodedef = {
		description = def.description,
		tiles = {{ name = "basic_streets_tar.png", color = "white" }},
		overlay_tiles = {{ name = def.overlay }},
		paramtype2 = "colorwallmounted",
		groups = {
            crumbly=1,
            tar_block = 1,
            fast_travel = 1
        },
		sounds = sounds
	}

	if has_unifieddyes_mod then
		nodedef.palette = "unifieddyes_palette_colorwallmounted.png"
		nodedef.groups.ud_param2_colorable = 1
		nodedef.on_construct = unifieddyes.on_construct
		nodedef.on_dig = unifieddyes.on_dig
	end

	minetest.register_node("basic_streets:" .. name, nodedef)

	if has_moreblocks_mod then
		-- register all stairsplus variants
		stairsplus:register_all("basic_streets", name, "basic_streets:" .. name, {
			description = def.description,
			tiles = { "basic_streets_tar.png^" .. def.overlay },
			groups = {crumbly=1},
			sounds = def.sounds,
		})
	end

end

-- base tar-node if the "building_blocks" mod is available
local base_tar_nodename = "building_blocks:Tar"

if not has_building_blocks_mod then
	-- register basic tar as replacement for the one in the "building_blocks" mod
	base_tar_nodename = "basic_streets:tar"
	minetest.register_node(base_tar_nodename, {
		description = "Tar",
		tiles = {"basic_streets_tar.png"},
		groups = {
            crumbly = 1,
            tar_block = 1,
            fast_travel = 1
        },
		sounds = sounds
	})

	if has_moreblocks_mod then
		-- register all base tar slopes/stairs
		stairsplus:register_all("basic_streets", "tar", base_tar_nodename, {
			description = "Tar",
			tiles = {"basic_streets_tar.png"},
			groups = {
                crumbly = 1,
                tar_block = 1,
                fast_travel = 1
            },
			sounds = sounds
		})
	end

	if has_default_mod then
		-- plain simple recipe if just the default mod is present
		minetest.register_craft({
			output = base_tar_nodename,
			recipe = {
				{"default:coal_lump", "default:gravel"},
				{"default:gravel", "default:coal_lump"}
			}
		})
	end
else
    -- override groups from existing tar-block
    minetest.override_item(base_tar_nodename, {
        groups = {
            crumbly = 1,
            tar_block = 1,
            fast_travel = 1
        }
    })
end

if has_dye_mod then
	-- register recipes if the "dye" mod is available

	minetest.register_craft({
		output = "basic_streets:street_straight",
		recipe = {
			{base_tar_nodename, "dye:white", base_tar_nodename},
			{base_tar_nodename, "dye:white", base_tar_nodename},
			{base_tar_nodename, "dye:white", base_tar_nodename}
		}
	})

	minetest.register_craft({
		output = "basic_streets:street_corner",
		recipe = {
			{base_tar_nodename, base_tar_nodename, base_tar_nodename},
			{base_tar_nodename, "dye:white", "dye:white"},
			{base_tar_nodename, "dye:white", base_tar_nodename}
		}
	})

	minetest.register_craft({
		output = "basic_streets:street_crossing",
		recipe = {
			{base_tar_nodename, "dye:white", base_tar_nodename},
			{"dye:white", "dye:white", "dye:white"},
			{base_tar_nodename, "dye:white", base_tar_nodename}
		}
	})

	minetest.register_craft({
		output = "basic_streets:street_tjunction",
		recipe = {
			{base_tar_nodename, "dye:white", base_tar_nodename},
			{base_tar_nodename, "dye:white", "dye:white"},
			{base_tar_nodename, "dye:white", base_tar_nodename}
		}
	})

end