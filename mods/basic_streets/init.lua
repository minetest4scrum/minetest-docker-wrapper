local MP = minetest.get_modpath("basic_streets")

dofile(MP.."/nodes.lua")

if minetest.get_modpath("player_monoids") then
	-- initialize player street physics
	dofile(MP.."/physics.lua")
end