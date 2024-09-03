--more_signs by addi
--Code and Textures are under the CC by-sa 3.0 licence 	
--see: http://creativecommons.org/licenses/by-sa/3.0/	
--modified and simplified for Tutorial

-- intllib support
local S
if (minetest.get_modpath("intllib")) then
	S = intllib.Getter()
else
  S = function ( s ) return s end
end
	
arrow_signs={}

 function arrow_signs:savetext(pos, formname, fields, sender)
		
		if not minetest.get_player_privs(sender:get_player_name())["interact"] then
			minetest.chat_send_player(sender:get_player_name(), "error: you don't have permission to edit the sign. you need the interact priv")
		return
		end
		local meta = minetest.get_meta(pos)
		fields.text = fields.text or ""
		print((sender:get_player_name() or "").." wrote \""..fields.text..
				"\" to sign at "..minetest.pos_to_string(pos))
		meta:set_string("text", fields.text)
		local text = arrow_signs:create_lines(fields.text)
		meta:set_string("infotext", text)
		local i=0
		for wort in text:gfind("\n") do
		i=i+1
        end
		if i > 4 then
		minetest.chat_send_player(sender:get_player_name(),"\tInformation: \nYou've written more than 5 lines. \n it may be that not all lines are displayed. \n Please remove the last entry")
		end
	return true
	end

function arrow_signs:create_lines(text)
	text = text:gsub("/", "\"\n\"")
	text = text:gsub("|", "\"\n\"")
	return text
end


local clone_registered = function(case,name)
    local params = {}
    local list
    if case == "item" then list = minetest.registered_items end
    if case == "node" then list = minetest.registered_nodes end
    if case == "craftitem" then list = minetest.registered_craftitems end
    if case == "tool" then list = minetest.registered_tools end
    if case == "entity" then list = minetest.registered_entities end
    if list then
        for k,v in pairs(list[name]) do
            params[k] = v
        end
    end
    return params
end

--Sign right
minetest.register_node("tutorial_arrow_signs:wall_right", {
	description = S("rightwards-pointing sign"),
	drawtype = "signlike",
	tiles = {"arrow_sign_right.png"},
	inventory_image = "arrow_sign_right.png",
	wield_image = "arrow_sign_right.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "wallmounted",
	},
	groups = {creative_breakable=1,attached_node=1,arrow_sign=1},
	legacy_wallmounted = true,
	sounds = default.node_sound_defaults(),
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", "field[text;;${text}]")
		meta:set_string("infotext", "\"\"")
	end,
	on_receive_fields = function(pos, formname, fields, sender)
		arrow_signs:savetext(pos, formname, fields, sender)
	end,
	on_punch = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", "")
	end,

})


-- sign left
minetest.register_node("tutorial_arrow_signs:wall_left", {
	description = S("leftwards-pointing sign"),
	drawtype = "signlike",
	tiles = {"arrow_sign_left.png"},
	inventory_image = "arrow_sign_left.png",
	wield_image = "arrow_sign_left.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "wallmounted",
	},
	groups = {creative_breakable=1,attached_node=1,arrow_sign=1},
	legacy_wallmounted = true,
	sounds = default.node_sound_defaults(),
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", "field[text;;${text}]")
		meta:set_string("infotext", "\"\"")
	end,
	on_receive_fields = function(pos, formname, fields, sender)
		arrow_signs:savetext(pos, formname, fields, sender)
	end,
	on_punch = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", "")
	end,
})


--Sign up
minetest.register_node("tutorial_arrow_signs:wall_up", {
	description = S("upwards-pointing sign"),
	drawtype = "signlike",
	tiles = {"arrow_sign_up.png"},
	inventory_image = "arrow_sign_up.png",
	wield_image = "arrow_sign_up.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "wallmounted",
	},
	groups = {creative_breakable=1,attached_node=1,arrow_sign=1},
	legacy_wallmounted = true,
	sounds = default.node_sound_defaults(),
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", "field[text;;${text}]")
		meta:set_string("infotext", "\"\"")
	end,
	on_receive_fields = function(pos, formname, fields, sender)
		arrow_signs:savetext(pos, formname, fields, sender)
	end,
	on_punch = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", "")
	end,
})


--Sign down
minetest.register_node("tutorial_arrow_signs:wall_down", {
	description = S("downwards-pointing sign"),
	drawtype = "signlike",
	tiles = {"arrow_sign_down.png"},
	inventory_image = "arrow_sign_down.png",
	wield_image = "arrow_sign_down.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	selection_box = {
		type = "wallmounted",
	},
	groups = {creative_breakable=1,attached_node=1,arrow_sign=1},
	legacy_wallmounted = true,
	sounds = default.node_sound_defaults(),
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", "field[text;;${text}]")
		meta:set_string("infotext", "\"\"")
	end,
	on_receive_fields = function(pos, formname, fields, sender)
		arrow_signs:savetext(pos, formname, fields, sender)
	end,
	on_punch = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", "")
	end,
})


minetest.register_abm( {
	nodenames = {"group:arrow_sign"},
	interval = 5,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_cound_wider)
		local meta = minetest.get_meta(pos)
		local original = meta:get_string("text")
		if(original ~= "") then
			meta:set_string("infotext", S(original))
		end
	end }
)

minetest.register_alias("arrow_signs:wall_right", "tutorial_arrow_signs:wall_right")
minetest.register_alias("arrow_signs:wall_left", "tutorial_arrow_signs:wall_left")
minetest.register_alias("arrow_signs:wall_up", "tutorial_arrow_signs:wall_up")
minetest.register_alias("arrow_signs:wall_down", "tutorial_arrow_signs:wall_down")
