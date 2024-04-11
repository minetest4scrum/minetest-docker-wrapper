-- LUALOCALS < ---------------------------------------------------------
local error, ipairs, math, minetest, nodecore, pairs, string, type,
      vector
    = error, ipairs, math, minetest, nodecore, pairs, string, type,
      vector
local math_abs, string_format, string_gsub, string_lower
    = math.abs, string.format, string.gsub, string.lower
-- LUALOCALS > ---------------------------------------------------------

local modname = minetest.get_current_modname()

local hash = minetest.hash_node_position

local function recipebase()
	local idx = {}
	local flat = {}
	for x = -1, 2 do
		for y = -1, 1 do
			for z = -1, 2 do
				local def = {x = x, y = y, z = z, match = "air"}

				idx[hash(def)] = def
				flat[#flat + 1] = def
			end
		end
	end
	return function(x, y, z, t)
		if not x then return flat end
		local found = idx[hash({x = x, y = y, z = z})]
		for k, v in pairs(t) do found[k] = v end
	end
end

local function setid(pos, basepos)
	return minetest.get_meta(pos):set_string(modname, minetest.pos_to_string(basepos, 0))
end
local function getid(pos)
	local id = minetest.get_meta(pos):get_string(modname)
	return id and id ~= "" and id
end

local digidcache = {}
local function node_on_dig(pos, ...)
	digidcache[hash(pos)] = getid(pos)
	return minetest.node_dig(pos, ...)
end
local function get_node_after_dig(cb)
	return function(pos)
		local id = digidcache[hash(pos)]
		if not id then return end
		for dy = -1, 1 do
			for dx = -1, 1 do
				for dz = -1, 1 do
					local p = {
						x = pos.x + dx,
						y = pos.y + dy,
						z = pos.z + dz
					}
					if getid(p) == id then
						minetest.remove_node(p)
						if cb then cb(p) end
					end
				end
			end
		end
	end
end

local function get_node_place(stairpart, nodename)
	return function(stack, placer, pointed)
		local pos = nodecore.buildable_to(pointed.under) and pointed.under
		or nodecore.buildable_to(pointed.above) and pointed.above
		if nodecore.protection_test(pos, placer) then return end

		local rela, relb
		local look = placer:get_look_dir()
		if look.z > math_abs(look.x) then
			rela = {x = 1, y = 0, z = 0}
			relb = {x = 0, y = 0, z = 1}
		elseif look.z < -math_abs(look.x) then
			rela = {x = -1, y = 0, z = 0}
			relb = {x = 0, y = 0, z = -1}
		elseif look.x > 0 then
			rela = {x = 0, y = 0, z = -1}
			relb = {x = 1, y = 0, z = 0}
		else
			rela = {x = 0, y = 0, z = 1}
			relb = {x = -1, y = 0, z = 0}
		end

		local poslist = {
			pos,
			vector.add(pos, rela),
			vector.add(pos, relb),
			vector.add(vector.add(pos, rela), relb)
		}
		if stairpart then
			local rely = pointed.under.y > pointed.above.y and -1 or 1
			local v = vector.add(vector.add(pos, rela), relb)
			v.y = v.y + rely
			poslist[#poslist + 1] = v
			v = vector.add(pos, relb)
			v.y = v.y + rely
			poslist[#poslist + 1] = v
		end

		for _, v in ipairs(poslist) do
			if (not nodecore.buildable_to(v)) or nodecore.obstructed(v)
			or (placer and placer:is_player() and minetest.is_protected(pos,
					placer:get_player_name())) then
				return stack
			end
		end

		for _, v in ipairs(poslist) do
			minetest.set_node(v, {name = nodename})
			setid(v, pos)
		end
		stack:set_count(stack:get_count() - 1)
		return stack
	end
end

local function imgdouble(thing, key)
	if type(thing) == "string" and (key == nil or key == "name"
		or type(key) == "number") then
		thing = "(" .. thing .. ")^[resize:16x16"
		thing = string_gsub(thing, ":", "\\:")
		thing = string_gsub(thing, "%^", "\\^")
		local txr = "[combine:32x32"
		for x = 0, 16, 16 do
			for y = 0, 16, 16 do
				txr = txr .. ":" .. x .. "," .. y .. "=" .. thing
			end
		end
		return txr
	end
	if type(thing) == "table" then
		local t = {}
		for k, v in pairs(thing) do t[k] = imgdouble(v, k) end
		return t
	end
	return thing
end

local function registercore(def, typedesc, stairpart)
	local typename = string_lower(typedesc)

	local basedef = minetest.registered_items[def.recipenode]
	if not basedef then return
		error(string_format("item %q not registered; missing dependency?",
				def.recipenode))
	end

	local stairname = modname .. ":" .. typename .. "_"
	.. string_gsub(def.recipenode, "%W", "_")
	local itemname = stairname .. "_inv"

	local stairdef = nodecore.underride({}, def)
	nodecore.underride(stairdef, {
			description = string_gsub(basedef.description,
				"Bricks", "Brick") .. " " .. typedesc,
			drop = itemname,
			groups = {stone_bricks = 0},
			on_dig = node_on_dig,
			after_dig_node = get_node_after_dig(),
			on_place = get_node_place(stairpart, stairname),
			silktouch = false
		})
	nodecore.underride(stairdef, basedef)
	stairdef.drop_in_place = nil
	minetest.register_node(":" .. stairname, stairdef)

	local itemdef = nodecore.underride({}, def)
	local nodebox = nodecore.fixedbox({-0.5, -0.5, -0.5, 0.5, 0, 0.5})
	if stairpart then
		nodebox.fixed[#nodebox.fixed + 1] = {-0.5, 0, 0, 0.5, 0.5, 0.5}
	end
	nodecore.underride(itemdef, {
			description = string_gsub(basedef.description,
				"Bricks", "Brick") .. " " .. typedesc,
			drawtype = "nodebox",
			node_box = nodebox,
			tiles = imgdouble(basedef.tiles),
			groups = {stone_bricks = 0},
			on_dig = node_on_dig,
			after_dig_node = get_node_after_dig(),
			on_place = get_node_place(stairpart, stairname),
			node_placement_prediction = stairname
		})
	nodecore.underride(itemdef, basedef)
	itemdef.drop_in_place = nil
	minetest.register_node(":" .. itemname, itemdef)

	local staircraftnodes = recipebase()
	staircraftnodes(0, 0, 0, {match = "nc_tree:eggcorn", replace = "air"})
	staircraftnodes(0, -1, 0, {match = def.recipenode, replace = stairname})
	staircraftnodes(1, -1, 0, {match = def.recipenode, replace = stairname})
	staircraftnodes(1, -1, 1, {match = def.recipenode, replace = stairname})
	staircraftnodes(0, -1, 1, {match = def.recipenode, replace = stairname})
	if stairpart then
		staircraftnodes(1, 0, 0, {match = def.recipenode, replace = stairname})
		staircraftnodes(1, 0, 1, {match = def.recipenode, replace = stairname})
	end
	nodecore.register_craft({
			label = "craft " .. string_lower(stairdef.description),
			indexkeys = {"nc_tree:eggcorn"},
			action = "pummel",
			toolgroups = {thumpy = 2},
			nodes = staircraftnodes(),
			after = function(_, data)
				local basepos = data.rel(0, -1, 0)
				setid(basepos, basepos)
				setid(data.rel(1, -1, 0), basepos)
				setid(data.rel(1, -1, 1), basepos)
				setid(data.rel(0, -1, 1), basepos)
				if stairpart then
					setid(data.rel(1, 0, 0), basepos)
					setid(data.rel(1, 0, 1), basepos)
				end
			end
		})

	nodecore.register_craft({
			label = "recycle " .. string_lower(stairdef.description),
			action = "pummel",
			toolgroups = {choppy = 3},
			nodes = {
				{match = stairname, replace = "air"}
			},
			items = {
				{name = def.recipenode, scatter = 5}
			},
			check = function(pos)
				local id = getid(pos)
				digidcache[hash(pos)] = id
				return id
			end,
			after = get_node_after_dig(function(p)
					return nodecore.item_eject(p, def.recipenode, 5)
				end)
		})

	minetest.register_abm({
			label = "fix misplaced " .. string_lower(stairdef.description),
			nodenames = {itemname},
			interval = 1,
			chance = 1,
			action = function(pos)
				minetest.remove_node(pos)
				nodecore.place_stack(pos, itemname)
			end
		})
end

local function register(def)
	registercore(def, "Stairs", true)
	registercore(def, "Slab", false)
end

register({recipenode = "nc_lode:block_annealed"})
register({recipenode = "nc_lode:block_tempered"})
register({recipenode = "nc_optics:glass_opaque"})
register({recipenode = "nc_stonework:bricks_adobe_bonded"})
register({recipenode = "nc_stonework:bricks_coalstone_bonded"})
register({recipenode = "nc_stonework:bricks_sandstone_bonded"})
register({recipenode = "nc_stonework:bricks_stone_bonded"})
register({recipenode = "nc_terrain:cobble"})
register({recipenode = "nc_woodwork:plank"})
