---------------------------------------------------------------------------------------
-- roof parts
---------------------------------------------------------------------------------------
-- a better roof than the normal stairs; can be replaced by stairs:stair_wood

-- intllib support
local S
if (minetest.get_modpath("intllib")) then
	S = intllib.Getter()
else
  S = function ( s ) return s end
end

-- create the three basic roof parts plus receipes for them;
cottages.register_roof = function( name, tiles, basic_material, homedecor_alternative, desc1, desc2, desc3 )

   minetest.register_node("tutorial_cottages:roof_"..name, {
		description = desc1,
		drawtype = "nodebox",
		--tiles = {"default_tree.png","default_wood.png","default_wood.png","default_wood.png","default_wood.png","default_tree.png"},
		tiles = tiles,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = true,
		groups = {creative_breakable=1},
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0, 0},
				{-0.5, 0, 0, 0.5, 0.5, 0.5},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0, 0},
				{-0.5, 0, 0, 0.5, 0.5, 0.5},
			},
		},
		sounds = default.node_sound_wood_defaults()
	})

   -- a better roof than the normal stairs; this one is for usage directly on top of walls (it has the form of a stair)
   minetest.register_node("tutorial_cottages:roof_connector_"..name, {
		description = desc2,
		drawtype = "nodebox",
                -- top, bottom, side1, side2, inner, outer
		--tiles = {"default_tree.png","default_wood.png","default_tree.png","default_tree.png","default_wood.png","default_tree.png"},
		--tiles = {"darkage_straw.png","default_wood.png","darkage_straw.png","darkage_straw.png","darkage_straw.png","darkage_straw.png"},
		tiles = tiles,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = true,
		groups = {creative_breakable=1},
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
				{-0.5, 0, 0, 0.5, 0.5, 0.5},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
				{-0.5, 0, 0, 0.5, 0.5, 0.5},
			},
		},
		sounds = default.node_sound_wood_defaults()
	})

   -- this one is the slab version of the above roof
   minetest.register_node("tutorial_cottages:roof_flat_"..name, {
		description = desc3,
		drawtype = "nodebox",
                -- top, bottom, side1, side2, inner, outer
		--tiles = {"default_tree.png","default_wood.png","default_tree.png","default_tree.png","default_wood.png","default_tree.png"},
                -- this one is from all sides - except from the underside - of the given material
		tiles = { tiles[1], tiles[2], tiles[1], tiles[1], tiles[1], tiles[1] };
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = true,
		groups = {creative_breakable=1},
		node_box = {
			type = "fixed",
			fixed = {	
				{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
			},
		},
		sounds = default.node_sound_wood_defaults()
	})

   minetest.register_alias("cottages:roof_"..name, "tutorial_cottages:roof_"..name)
   minetest.register_alias("cottages:roof_connector_"..name, "tutorial_cottages:roof_connector_"..name)
   minetest.register_alias("cottages:roof_flat_"..name, "tutorial_cottages:roof_flat_"..name)

end -- of cottages.register_roof( name, tiles, basic_material )




---------------------------------------------------------------------------------------
-- add the diffrent roof types
---------------------------------------------------------------------------------------
cottages.register_roof( 'black',
		{"cottages_homedecor_shingles_asphalt.png","default_wood.png","default_wood.png","default_wood.png","default_wood.png","cottages_homedecor_shingles_asphalt.png"},
		'homedecor:shingles_asphalt', 'tutorial_default:coal_lump', S("black roof"), S("black roof connector"), S("black flat roof"));
cottages.register_roof( 'red',
		{"cottages_homedecor_shingles_terracotta.png","default_wood.png","default_wood.png","default_wood.png","default_wood.png","cottages_homedecor_shingles_terracotta.png"},
		'homedecor:shingles_terracotta', 'tutorial_default:clay_brick', S("red roof"), S("red roof connector"), S("red flat roof"));
