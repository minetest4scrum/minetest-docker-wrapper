--
-- Crafting (tool repair)
--
minetest.register_craft({
	type = "toolrepair",
	additional_wear = -0.02,
})

--
-- Cooking recipes
--

minetest.register_craft({
	type = "cooking",
	output = "tutorial_default:steel_ingot",
	recipe = "tutorial_default:iron_lump",
})

minetest.register_craft({
	type = "cooking",
	output = "tutorial_default:gold_ingot",
	recipe = "tutorial_default:gold_lump",
})

--
-- Fuels
--

minetest.register_craft({
	type = "fuel",
	recipe = "group:tree",
	burntime = 30,
})

minetest.register_craft({
	type = "fuel",
	recipe = "tutorial_default:junglegrass",
	burntime = 2,
})

minetest.register_craft({
	type = "fuel",
	recipe = "group:leaves",
	burntime = 1,
})

minetest.register_craft({
	type = "fuel",
	recipe = "tutorial_default:cactus",
	burntime = 15,
})

minetest.register_craft({
	type = "fuel",
	recipe = "tutorial_default:bookshelf",
	burntime = 30,
})

minetest.register_craft({
	type = "fuel",
	recipe = "tutorial_default:fence_wood",
	burntime = 15,
})

minetest.register_craft({
	type = "fuel",
	recipe = "tutorial_default:ladder",
	burntime = 5,
})

minetest.register_craft({
	type = "fuel",
	recipe = "group:wood",
	burntime = 7,
})

minetest.register_craft({
	type = "fuel",
	recipe = "tutorial_default:lava_source",
	burntime = 60,
})

minetest.register_craft({
	type = "fuel",
	recipe = "tutorial_default:torch",
	burntime = 4,
})

minetest.register_craft({
	type = "fuel",
	recipe = "tutorial_default:apple",
	burntime = 3,
})

minetest.register_craft({
	type = "fuel",
	recipe = "tutorial_default:coal_lump",
	burntime = 40,
})

minetest.register_craft({
	type = "fuel",
	recipe = "tutorial_default:coalblock",
	burntime = 370,
})
