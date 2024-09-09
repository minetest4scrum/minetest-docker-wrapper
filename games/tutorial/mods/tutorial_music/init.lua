
tutorial_music={}

--config
tutorial_music.pause_between_songs=7

--end config

tutorial_music.modpath=minetest.get_modpath("tutorial_music")
if not tutorial_music.modpath then
	error("mod folder has to be named 'tutorial_music'!")
end
--{name, length, gain~1}
tutorial_music.songs = {}
local sfile, sfileerr=io.open(tutorial_music.modpath.."/songs.txt")
if not sfile then error("Error opening songs.txt: "..sfileerr) end
for line in sfile:lines() do
	if line~="" and line[1]~="#" then
		local name, timeMinsStr, timeSecsStr, gainStr = string.match(line, "^(%S+)%s+(%d+):([%d%.]+)%s+([%d%.]+)$")
		local timeMins, timeSecs, gain = tonumber(timeMinsStr), tonumber(timeSecsStr), tonumber(gainStr)
		if name and timeMins and timeSecs and gain then
			tutorial_music.songs[#tutorial_music.songs+1]={name=name, length=timeMins*60+timeSecs, lengthhr=timeMinsStr..":"..timeSecsStr, gain=gain}
		else
			minetest.log("warning", "[tutorial_music] Misformatted song entry in songs.txt: "..line)
		end
	end
end
sfile:close()

if #tutorial_music.songs==0 then
	minetest.log("error", "[tutorial_music] no songs registered, not doing anything")
	return
end

tutorial_music.storage = minetest.get_mod_storage()

tutorial_music.handles={}

tutorial_music.playing=false
tutorial_music.id_playing=nil
tutorial_music.song_time_left=nil
tutorial_music.time_next=10 --sekunden
tutorial_music.id_last_played=nil

minetest.register_on_joinplayer(function(player)
	local meta = player:get_meta()
	local play_music = meta:get_string("play_music")
	local play = true
	if play_music == "" then
		meta:set_string("play_music", "1")
	elseif play_music == "0" then
		play = false
	end
	if play then
		tutorial_music.next_song()
	else
		tutorial_music.stop_song()
	end
end)

minetest.register_globalstep(function(dtime)
	if tutorial_music.playing then
		if tutorial_music.song_time_left<=0 then
			tutorial_music.stop_song()
			tutorial_music.time_next=tutorial_music.pause_between_songs
		else
			tutorial_music.song_time_left=tutorial_music.song_time_left-dtime
		end
	elseif tutorial_music.time_next then
		if tutorial_music.time_next<=0 then
			tutorial_music.next_song()
		else
			tutorial_music.time_next=tutorial_music.time_next-dtime
		end
	end
end)
tutorial_music.play_song=function(id)
	if tutorial_music.playing then
		tutorial_music.stop_song()
	end
	local song=tutorial_music.songs[id]
	if not song then return end
	for _,player in ipairs(minetest.get_connected_players()) do
		local pname=player:get_player_name()
		local pvolume=tonumber(tutorial_music.storage:get_string("vol_"..pname))
		if not pvolume then pvolume=1 end
		if pvolume>0 then
			local handle = minetest.sound_play(song.name, {to_player=pname, gain=song.gain*pvolume})
			if handle then
				tutorial_music.handles[pname]=handle
			end
		end
	end
	tutorial_music.playing=id
	--adding 2 seconds as security
	tutorial_music.song_time_left = song.length + 2
end
tutorial_music.stop_song=function()
	for pname, handle in pairs(tutorial_music.handles) do
		minetest.sound_stop(handle)
	end
	tutorial_music.id_last_played=tutorial_music.playing
	tutorial_music.playing=nil
	tutorial_music.handles={}
	tutorial_music.time_next=nil
end

tutorial_music.next_song=function()
	local next
	repeat
		next=math.random(1,#tutorial_music.songs)
	until #tutorial_music.songs==1 or next~=tutorial_music.id_last_played
	tutorial_music.play_song(next)
end

tutorial_music.song_human_readable=function(id)
	local song=tutorial_music.songs[id]
	return id..": "..song.name.." ["..song.lengthhr.."]"
end

minetest.register_privilege("mpd", "May control the music")

minetest.register_chatcommand("music_stop", {
	params = "",
	description = "Stop the song currently playing",
	privs = {mpd=true},
	func = function(name, param)
		local player = minetest.get_player_by_name(name)
		player:get_meta():set_string("play_music", "0")
		tutorial_music.stop_song()
	end,		
})
minetest.register_chatcommand("music_list", {
	params = "",
	description = "List all available songs and their IDs",
	privs = {mpd=true},
	func = function(name, param)
		for k,v in ipairs(tutorial_music.songs) do
			minetest.chat_send_player(name, tutorial_music.song_human_readable(k))
		end
	end,		
})
minetest.register_chatcommand("music_play", {
	params = "<id>",
	description = "Play the songs with the given ID (see IDs with /music_list)",
	privs = {mpd=true},
	func = function(name, param)
		id=tonumber(param)
		if id and id>0 and id<=#tutorial_music.songs then
			local player = minetest.get_player_by_name(name)
			player:get_meta():set_string("play_music", "1")
			tutorial_music.play_song(id)
			return true,"Playing: "..tutorial_music.song_human_readable(id)
		end
		return false, "Invalid song ID!"
	end,		
})
minetest.register_chatcommand("music_what", {
	params = "",
	description = "Display the currently played song.",
	privs = {mpd=true},
	func = function(name, param)
	if not tutorial_music.playing then return true,"Nothing playing, "..math.floor(tutorial_music.time_next or 0).." sec. left until next song." end
	return true,"Playing: "..tutorial_music.song_human_readable(tutorial_music.playing).."\nTime left: "..math.floor(tutorial_music.song_time_left or 0).." sec."
end,		
})
minetest.register_chatcommand("music_next", {
	params = "[seconds]",
	description = "Start the next song, either immediately (no parameters) or after n seconds.",
	privs = {mpd=true},
	func = function(name, param)
		local player = minetest.get_player_by_name(name)
		player:get_meta():set_string("play_music", "1")
		tutorial_music.stop_song()
		if param and tonumber(param) then
			tutorial_music.time_next=tonumber(param)
			return true,"Next song in "..param.." seconds!"
		else
			tutorial_music.next_song()
			return true,"Next song started!"
		end
	end,		
})
minetest.register_chatcommand("mvolume", {
	params = "[volume level (0-1)]",
	description = "Set your background music volume. Use /mvolume 0 to turn off background music for you. Without parameters, show your current setting.",
	privs = {},
	func = function(pname, param)
		if not param or param=="" then
			local pvolume=tonumber(tutorial_music.storage:get_string("vol_"..pname))
			if not pvolume then pvolume=1 end
			if pvolume>0 then
				return true, "Your music volume is set to "..pvolume.."."
			else
				if tutorial_music.handles[pname] then
					minetest.sound_stop(tutorial_music.handles[pname])
				end
				return true, "Background music is disabled for you. Use '/mvolume 1' to enable it again."
			end
		end
		local pvolume=tonumber(param)
		if not pvolume then
			return false, "Invalid usage: /mvol [volume level (0-1)]"
		end
		pvolume = math.min(pvolume, 1)
		pvolume = math.max(pvolume, 0)
		tutorial_music.storage:set_string("vol_"..pname, pvolume)
		if pvolume>0 then
			return true, "Music volume set to "..pvolume..". Change will take effect when the next song starts."
		else
			if tutorial_music.handles[pname] then
				minetest.sound_stop(tutorial_music.handles[pname])
			end
			return true, "Disabled background music for you. Use /mvol to enable it again."
		end
	end,		
})

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if(fields.togglemusic) then
		if tutorial_music.playing then
			tutorial_music.stop_song()
			player:get_meta():set_string("play_music", "0")
		else
			tutorial_music.next_song()
			player:get_meta():set_string("play_music", "1")
		end
	end
end)

