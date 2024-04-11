function h_windows.register_window(name, def)
    local nb_fixed = {{-0.5, -0.5, -0.1, 0.5, 0.5, 0.1}}
    local nb_fixed_open = {{-0.5, 0.5, -0.5, 0.5, 0.3, 0.5}}
    if def.type == "medium" then
        nb_fixed = {{-1.5, 1.5, -0.1, 0.5, -0.5, 0.1}}
        nb_fixed_open = {{-1.5, 1.5, -1.5, 0.5, 1.3, 0.5}}
    end

    local inv_img = def.inventory_image
    if not def.inventory_image then
        inv_img = def.glass_texture
    end

    minetest.register_node(name, {
        description = def.description,
        tiles = {
            def.sides_texture,
            def.sides_texture,
            def.sides_texture,
            def.sides_texture,
            def.glass_texture
        },
        wield_image = def.glass_texture,
        inventory_image = inv_img,
        paramtype = "light",
        paramtype2 = "facedir",
        sunlight_propagates = true,
        drawtype = "nodebox",
        node_box = {
            type = "fixed",
            fixed = nb_fixed
        },
        groups = table.copy(def.groups),
        on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
            minetest.swap_node(pos, {name = name .. "_open", param2 = node.param2})
        end
    })

    if def.register_locked == true then
        h_windows.register_locked_window(name, nb_fixed, nb_fixed_open, def)
    end

    def.groups.not_in_creative_inventory = 1 -- Add a group for open window
    
    minetest.register_node(name .. "_open", {
        description = def.description .. " Open",
        tiles = {
            def.glass_texture,
            def.glass_texture,
            def.sides_texture,
            def.sides_texture,
        },
        wield_image = def.glass_texture,
        inventory_image = inv_img,
        paramtype = "light",
        paramtype2 = "facedir",
        sunlight_propagates = true,
        drawtype = "nodebox",
        node_box = {
            type = "fixed",
            fixed = nb_fixed_open
        },
        groups = def.groups,
        drop = name,
        on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
            minetest.swap_node(pos, {name = name, param2 = node.param2})
        end
    })
end

function h_windows.register_locked_window(name, nb_fixed, nb_fixed_open, def)
    local inv_img = "h_windows_lock.png^" .. def.glass_texture
    if def.inventory_image then
        inv_img = "h_windows_lock.png^" .. def.inventory_image
    end

    minetest.register_node(name .. "_locked", {
        description = def.description .. " Locked",
        tiles = {
            def.sides_texture,
            def.sides_texture,
            def.sides_texture,
            def.sides_texture,
            def.glass_texture
        },
        wield_image = def.glass_texture,
        inventory_image = inv_img,
        paramtype = "light",
        paramtype2 = "facedir",
        sunlight_propagates = true,
        drawtype = "nodebox",
        node_box = {
            type = "fixed",
            fixed = nb_fixed
        },
        groups = table.copy(def.groups),
        on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
            local meta = minetest.get_meta(pos)
            if meta:get_string("owner") == clicker:get_player_name() then
                minetest.swap_node(pos, {name = name .. "_locked_open", param2 = node.param2})
            end
        end,
        after_place_node = function(pos, placer, itemstack, pointed_thing)
            local meta = minetest.get_meta(pos)
            meta:set_string("owner", placer:get_player_name())
            meta:set_string("infotext", def.description .. " (Locked by " .. meta:get_string("owner") .. ")")
        end
    })

    def.groups.not_in_creative_inventory = 1

    minetest.register_node(name .. "_locked_open", {
        description = def.description .. " Locked Open",
        tiles = {
            def.glass_texture,
            def.glass_texture,
            def.sides_texture,
            def.sides_texture,
        },
        wield_image = def.glass_texture,
        inventory_image = inv_img,
        paramtype = "light",
        paramtype2 = "facedir",
        sunlight_propagates = true,
        drawtype = "nodebox",
        node_box = {
            type = "fixed",
            fixed = nb_fixed_open
        },
        groups = def.groups,
        drop = name .. "_locked",
        on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
            local meta = minetest.get_meta(pos)
            if meta:get_string("owner") == clicker:get_player_name() then
                minetest.swap_node(pos, {name = name .. "_locked", param2 = node.param2})
            end
        end,
        after_place_node = function(pos, placer, itemstack, pointed_thing)
            local meta = minetest.get_meta(pos)
            meta:set_string("owner", placer:get_player_name())
            meta:set_string("infotext", def.description .. " (Locked by " .. meta:get_string("owner") .. ")")
        end
    })

    -- Register craft for the locked window
    minetest.register_craft({
        type = "shapeless",
        output = name .. "_locked",
        recipe = {
            name,
            "h_windows:lock"
        }
    })
end


function h_windows.register_bigwindow(name, def)
    local inv_img = def.inventory_image
    if not def.inventory_image then
        inv_img = def.glass_texture
    end

    minetest.register_node(name, {
        description = def.description,
        tiles = {
            def.sides_texture,
            def.sides_texture,
            def.sides_texture,
            def.sides_texture,
            def.glass_texture
        },
        wield_image = def.glass_texture,
        inventory_image = inv_img,
        paramtype = "light",
        paramtype2 = "facedir",
        sunlight_propagates = true,
        drawtype = "nodebox",
        node_box = {
            type = "fixed",
            fixed = {
                {-1.5, 2.5, -0.1, 0.5, -0.5, 0.1}
            }
        },
        groups = def.groups
    })
end