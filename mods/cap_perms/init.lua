-- Author: Thorben Striegel

-- Funktion zum Entfernen des interact-Privilegs für alle Spieler
local function remove_interact_privilege()
    for _, player in ipairs(minetest.get_connected_players()) do
        local name = player:get_player_name()
        minetest.set_player_privs(name, {interact = nil})
    end
end

-- Funktion zum Hinzufügen des interact-Privilegs für alle Spieler
local function add_interact_privilege()
    for _, player in ipairs(minetest.get_connected_players()) do
        local name = player:get_player_name()
        minetest.set_player_privs(name, {interact = true})
    end
end

-- Registrierung der Chat-Befehle für den Mod
minetest.register_chatcommand("remove_interact", {
    description = "Entzieht allen Spielern das interact-Privileg",
    privs = {server = true}, -- Nur für Server-Admins zugänglich machen
    func = remove_interact_privilege
})

minetest.register_chatcommand("add_interact", {
    description = "Vergibt allen Spielern das interact-Privileg",
    privs = {server = true}, -- Nur für Server-Admins zugänglich machen
    func = add_interact_privilege
})