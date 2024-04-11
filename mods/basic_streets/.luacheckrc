allow_defined_top = true

read_globals = {
	-- Stdlib
	string = {fields = {"split"}},
	table = {fields = {"copy", "getn"}},

	-- Minetest
	"minetest",
	"vector", "ItemStack",
	"dump",

	-- optional deps
	"stairsplus", "default", "unifieddyes", "player_monoids"

}
