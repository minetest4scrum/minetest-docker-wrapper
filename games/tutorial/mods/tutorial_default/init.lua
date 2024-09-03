-- See README.txt for licensing and other information.

-- The API documentation in here was moved into doc/lua_api.txt

-- intllib support
local S
if (minetest.get_modpath("intllib")) then
	S = intllib.Getter()
else
  S = function ( s ) return s end
end

-- Definitions made by this mod that other mods can use too
default = {}

-- GUI related stuff
default.gui_bg = "bgcolor[#080808BB;true]"
default.gui_bg_img = "background[5,5;1,1;gui_formbg.png;true]"
default.gui_slots = "listcolors[#00000069;#5A5A5A;#141318;#30434C;#FFF]"
default.gui_controls = minetest.formspec_escape(S("[Left click]: Take/drop stack\n[Right click]: Take half stack / drop 1 item\n[Middle click]: Take/drop 10 items\n[Esc] or [I]: Close"))

function default.get_hotbar_bg(x,y)
	local out = ""
	for i=0,7,1 do
		out = out .."image["..x+i..","..y..";1,1;gui_hb_bg.png]"
	end
	return out
end

local music = ""
if minetest.get_modpath("tutorial_music") then
	music = "button[-0.1,0.7;3,1;togglemusic;"..minetest.formspec_escape(S("Toggle music")).."]"
end

default.gui_suvival_form = "size[8,10]"..
			default.gui_bg..
			default.gui_bg_img..
			default.gui_slots..
			"button[-0.1,-0.3;3,1;teleport;"..minetest.formspec_escape(S("Teleport")).."]"..
			music ..
			"label[0,3.75;"..minetest.formspec_escape(S("Player inventory:")).."]"..
			"list[current_player;main;0,4.25;8,1;]"..
			"list[current_player;main;0,5.5;8,3;8]"..
			"label[0,8.5;"..default.gui_controls.."]"..
			"label[2.75,-0.1;"..minetest.formspec_escape(S("Crafting grid:")).."]"..
			"list[current_player;craft;2.75,0.5;3,3;]"..
			"label[6.75,0.9;"..minetest.formspec_escape(S("Output slot:")).."]"..
			"list[current_player;craftpreview;6.75,1.5;1,1;]"..
			"image[5.75,1.5;1,1;gui_furnace_arrow_bg.png^[transformR270]"..
			"listring[current_player;main]"..
			"listring[current_player;craft]"..
			default.get_hotbar_bg(0,4.25)

-- Load files
dofile(minetest.get_modpath("tutorial_default").."/functions.lua")
dofile(minetest.get_modpath("tutorial_default").."/nodes.lua")
dofile(minetest.get_modpath("tutorial_default").."/tools.lua")
dofile(minetest.get_modpath("tutorial_default").."/craftitems.lua")
dofile(minetest.get_modpath("tutorial_default").."/crafting.lua")
dofile(minetest.get_modpath("tutorial_default").."/mapgen.lua")
dofile(minetest.get_modpath("tutorial_default").."/player.lua")
dofile(minetest.get_modpath("tutorial_default").."/aliases.lua")
