Here is some useful info for developers.

### How the map is saved
The map is not stored in a traditional way, like in real Minetest world. Instead, the tutorial generates the world on-the-fly when the player creates a new world.

The tutorial castle is saved in the game itself in schematics and other binary metadata files in `mods/tutorial_mapgen/mapdata`. When you start a new world, Tutorial force-sets the mapgen to `singlenode`, loads the schematics and places them. After that, it generates the grassland surroundings.

## How to edit the map
### Summary

1. If Minetest is running, shut it down
2. Trust the code. In the settings menu or `minetest.conf`, add `tutorial_mapgen` to `secure.trusted_mods`
3. In `minetest.conf`, add `tutorial_debug_map_editing = true`
4. In `minetest.conf`, add `tutorial_debug_edit_item_spawners = true`
5. Start Minetest and create a new world and enter the world in singleplayer (there should be a confirmation message in chat)
6. Edit the map to your likings
7. Grant yourselves the `tutorialmap` privilege
8. Use `/tsave` command to save the map

Note: `tutorial_debug_map_editing=true` will automatically enable Creative Mode.

The changes will end up in `<world directory>/mapdata`. Copy this directory to `<game directory>/mods/tutorial_mapgen`, overwriting files, if neccessary.

If you want to edit item spawn positions, see the details below.

### Mod security
First, you need to list `tutorial_mapgen` as a trusted mod because the `/tsave` command needs write access.
You can review the relevant code in `mods/tutorial_mapgen/init.lua`.

Use the setting `secure.trusted_mods` to edit the list of trusted mods.

### Editing the map
You want to only edit the map data files. Here's how:

In `minetest.conf`, add the following settings:

```
tutorial_debug_map_editing = true
tutorial_debug_edit_item_spawners = true
```

This enables the `/treset` and `/tsave` commands to help editing the schematic. It also forces the Tutorial to only generate the raw castle, not the grasslands. Also, the item spawners become visible.

Create a new world with setting `tutorial_debug_map_editing` set to `true`. Now edit the map to your likings using your instant digging power and the creative inventory. You can of course WorldEdit to speed up the process.
If you're finished, grant yourself the `tutorialmap` privilege and use the `/tsave` command. This updates the map files in `<world directory>/mapdata`. Note that there are limits as for how big the tutorial castle can be.

Copy the contents of this directory to the `tutorial_mapgen` mod under `mapdata` and overwrite files as neccessary. Test your changes by creating a new world. If everything went fine, you can commit your changes now.

### About item spawners
To place items in the map, you must use the item spawners, these are simple nodes that spawn items. They have 2 states: active and inactive.

Inactive basically means "unconfigured". An inactive item spawner is made when you place one from the creative inventory. Place it somewhere where you want the item. If that place would be water, place it somewhere nearby. Rightclick the node and enter the itemstring and an optional offset. The item will spawn at the node position plus the offset. Click OK to make the item spawner active. You can't edit an item spawner once its configured, just remove it and place a new one.

In the finished map, all item spawners must be configured and active.

If you mess with item spawners, the setting `tutorial_debug_edit_item_spawners` MUST be `true` before you load the map.

### Testing and finalizing
To test your new map, remove the 2 `minetest.conf` settings and create a new world and check if everything works. If it does work, you can commit your changes now.

(Note: The `/tsave` command is not available if the `tutorial_mapgen` mod failed to request an "insecure" environment due to mod security issues.)
