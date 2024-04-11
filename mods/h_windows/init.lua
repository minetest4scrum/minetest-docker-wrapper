h_windows = {}

local path = minetest.get_modpath(minetest.get_current_modname())
dofile(path .. "/functions.lua")

-- Lock for making windows locked --

minetest.register_craftitem("h_windows:lock", {
    description = "Windows Lock (Right click on window to lock it)",
    inventory_image = "h_windows_lock.png",
    stack_max = 1
})

minetest.register_craft({
    output = "h_windows:lock",
    recipe = {
        {"", "", ""},
        {"", "default:steel_ingot", ""},
        {"default:gold_ingot", "default:gold_ingot", "default:gold_ingot"}
    }
})

-- Register saw --

minetest.register_craftitem("h_windows:saw", {
    description = "Windows Saw",
    inventory_image = "h_windows_saw.png",
    stack_max = 1
})

minetest.register_craft({
    output = "h_windows:saw",
    recipe = {
        {"", "", ""},
        {"default:steel_ingot", "default:steel_ingot", "group:wood"},
        {"", "", ""}
    }
})

-- Register windows and their crafts --

-- Small White Window
h_windows.register_window("h_windows:window_white", {
    description = "White Window",
    sides_texture = "^[colorize:#FFFFFF",
    glass_texture = "h_windows_white.png",
    register_locked = true,
    groups = {oddly_breakable_by_hand = 3, cracky = 3}
})

minetest.register_craft({
    type = "shapeless",
    output = "h_windows:window_white 6",
    recipe = {
        "default:glass",
        "h_windows:saw"
    }
})

minetest.register_craft({
    type = "shapeless",
    output = "h_windows:window_white",
    recipe = {
        "h_windows:window_black",
        "dye:white"
    }
})

-- Small Black Window
h_windows.register_window("h_windows:window_black", {
    description = "Black Window",
    sides_texture = "^[colorize:#000000",
    glass_texture = "h_windows_black.png",
    register_locked = true,
    groups = {oddly_breakable_by_hand = 3, cracky = 3}
})

minetest.register_craft({
    type = "shapeless",
    output = "h_windows:window_black",
    recipe = {
        "h_windows:window_white",
        "dye:black"
    }
})


-- Medium White Window
h_windows.register_window("h_windows:medwindow_white", {
    description = "Medium White Window",
    sides_texture = "^[colorize:#FFFFFF",
    glass_texture = "h_windows_white.png",
    type = "medium",
    register_locked = true,
    inventory_image = "h_windows_white.png^h_windows_M.png",
    groups = {oddly_breakable_by_hand = 3, cracky = 3}
})

minetest.register_craft({
    output = "h_windows:medwindow_white 4",
    recipe = {
        {"default:glass", "default:glass", "h_windows:saw"},
        {"default:glass", "default:glass", ""},
        {"", "", ""}
    }
})

minetest.register_craft({
    type = "shapeless",
    output = "h_windows:medwindow_white",
    recipe = {
        "h_windows:medwindow_black",
        "dye:white"
    }
})

-- Medium Black Window
h_windows.register_window("h_windows:medwindow_black", {
    description = "Medium Black Window",
    sides_texture = "^[colorize:#FFFFFF",
    glass_texture = "h_windows_black.png",
    type = "medium",
    register_locked = true,
    inventory_image = "h_windows_black.png^h_windows_M.png",
    groups = {oddly_breakable_by_hand = 3, cracky = 3}
})

minetest.register_craft({
    type = "shapeless",
    output = "h_windows:medwindow_black",
    recipe = {
        "h_windows:medwindow_white",
        "dye:black"
    }
})

-- Big White Window
h_windows.register_bigwindow("h_windows:bigwindow_white", {
    description = "Big White Window",
    sides_texture = "^[colorize:#FFFFFF",
    glass_texture = "h_windows_white.png",
    inventory_image = "h_windows_white.png^h_windows_B.png",
    groups = {oddly_breakable_by_hand = 3, cracky = 3}
})

minetest.register_craft({
    output = "h_windows:bigwindow_white 2",
    recipe = {
        {"default:glass", "default:glass", "h_windows:saw"},
        {"default:glass", "default:glass", ""},
        {"default:glass", "default:glass", ""}
    }
})

minetest.register_craft({
    type = "shapeless",
    output = "h_windows:bigwindow_white",
    recipe = {
        "h_windows:bigwindow_black",
        "dye:white"
    }
})

-- Big Black Window
h_windows.register_bigwindow("h_windows:bigwindow_black", {
    description = "Big Black Window",
    sides_texture = "^[colorize:#000000",
    glass_texture = "h_windows_black.png",
    inventory_image = "h_windows_black.png^h_windows_B.png",
    groups = {oddly_breakable_by_hand = 3, cracky = 3}
})

minetest.register_craft({
    type = "shapeless",
    output = "h_windows:bigwindow_black",
    recipe = {
        "h_windows:bigwindow_white",
        "dye:black"
    }
})