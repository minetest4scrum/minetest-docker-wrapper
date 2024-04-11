# House Windows API
This API allows to register your own windows


``h_windows.register_window(name, windows definition)`` - Function to register a small or a medium window


``h_windows.register_bigwindow(name, windows definition)`` - Function to register a big window

### Windows Definition
This also shows an example of creating a window
```lua
{
    description = "White Window", -- The description of the window (required)
    sides_texture = "sides_texture.png", -- The texture of the windows's sides (required)
    glass_texture = "glass_texture.png", -- The texture of the window's glass (required)
    register_locked = true, -- Doesn't work with big windows. If set to true then it registers a locked window (optional)
    type = "medium", -- If type is defined and exists then it will create a window of that type, else it will create a small window (optional)
    inventory_image = "window_invimg.png", -- Inventory image of the window (optional)
    groups = {oddly_breakable_by_hand = 3, cracky = 3} -- Groups of the window node (required)
}
```


There are 2 types of windows for ``h_windows.register_window`` function, they are medium and small.\
Note: if you want to register a small window then `type` is optional