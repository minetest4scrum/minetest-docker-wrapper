-- Cottages, Tutorial Edition
-- Version: 2.0
-- Autor:   Sokomine
-- License: GPLv3
--
-- Modified:
-- 23.01.14 Added hammer and anvil as decoration and for repairing tools.
--          Added hatches (wood and steel).
--          Changed the texture of the fence/handrail.
-- 17.01.13 Added alternate receipe for fences in case of interference due to xfences
-- 14.01.13 Added alternate receipes for roof parts in case homedecor is not installed.
--          Added receipe for stove pipe, tub and barrel.
--          Added stairs/slabs for dirt road, loam and clay
--          Added fence_small, fence_corner and fence_end, which are useful as handrails and fences
--          If two or more window shutters are placed above each other, they will now all close/open simultaneously.
--          Added threshing floor.
--          Added hand-driven mill.

cottages = {}

-- uncomment parts you do not want

dofile(minetest.get_modpath("tutorial_cottages").."/nodes_furniture.lua");
dofile(minetest.get_modpath("tutorial_cottages").."/nodes_historic.lua");
dofile(minetest.get_modpath("tutorial_cottages").."/nodes_straw.lua");
dofile(minetest.get_modpath("tutorial_cottages").."/nodes_roof.lua");
