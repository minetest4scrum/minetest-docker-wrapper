-- Areas mod; original by ShadowNinja
-- Based on node_ownership
-- Stripped down for the Tutorial
-- License: LGPLv2+

areas = {}

areas.adminPrivs = {areas=true}
areas.startTime = os.clock()

areas.modpath = minetest.get_modpath("tutorial_areas")
dofile(areas.modpath.."/api.lua")
dofile(areas.modpath.."/internal.lua")
dofile(areas.modpath.."/hud.lua")

areas:load()

if minetest.settings:get_bool("log_mod") then
	local diffTime = os.clock() - areas.startTime
	minetest.log("action", "[tutorial_areas] Tutorial areas mod loaded in "..diffTime.."s.")
end

