-- Remove /pulverize commmand because it could
-- put player in an unfinishable state.
-- (unless in Map Editing Mode)

local map_editing = minetest.settings:get_bool("tutorial_debug_map_editing")
if not map_editing then
	minetest.unregister_chatcommand("pulverize")
end
