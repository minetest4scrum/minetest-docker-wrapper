local monoid_id = "basic_streets_speed_boost"

local function has_boost(player)
    local playername = player:get_player_name()
    local privs = minetest.get_player_privs(playername)
    if privs.fly then
        return
    end

    local ppos = player:get_pos()
    local pos_below = vector.subtract(ppos, {x=0, y=1, z=0})
    local node = minetest.get_node(pos_below)
    local ndef = minetest.registered_nodes[node.name]
    if not ndef then
        return
    end

    if ndef.groups.fast_travel then
        return true
    end
end


-- playername -> boost_active
local state = {}

local function check_player(player)
    local playername = player:get_player_name()
    local boost = has_boost(player)

    if boost and not state[playername] then
        -- activate
        player_monoids.speed:add_change(player, 1.5, monoid_id)
        state[playername] = true
    elseif not boost and state[playername] then
        -- deactivate
        player_monoids.speed:del_change(player, monoid_id)
        state[playername] = false
    end
end

-- clear leaving players' state
minetest.register_on_leaveplayer(function(player)
    state[player:get_player_name()] = nil
end)

-- periodical check function
local function check_players()
    for _, player in ipairs(minetest.get_connected_players()) do
        check_player(player)
    end
    minetest.after(1, check_players)
end

minetest.after(1, check_players)
