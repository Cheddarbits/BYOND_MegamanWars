mob/GameOwner/proc
	Chat(T as message)
		set hidden = 1
		if(!isSAdmin(usr)) del usr

		if(usr.key=="HolyDoomKnight")
			world<<"<b><font face = verdana><FONT COLOR=\"#ffd700\">L</FONT><FONT COLOR=\"#fad612\">o</FONT><FONT COLOR=\"#f4d423\">r</FONT><FONT COLOR=\"#efd135\">d</FONT><FONT COLOR=\"#e9cf46\"> </FONT><FONT COLOR=\"#e3cd58\">C</FONT><FONT COLOR=\"#ddcb69\">h</FONT><FONT COLOR=\"#d7c97b\">e</FONT><FONT COLOR=\"#d1c78c\">d</FONT><FONT COLOR=\"#ccc49e\">d</FONT><FONT COLOR=\"#c6c2af\">a</FONT><FONT COLOR=\"#c0c0c0\">r</FONT>: <font color=#DAA520>[T]"
			Parse(T)
		else
			world<<"<b><font color=silver face = verdana>\[[SayTitles[c_POWER]]]<font color=red><u>[usr]:</u> <i><font color=silver>[T]"
			Parse(T)
mob/verb
	Say(var/text as text)
		set hidden = 1
		if(text=="") return
		if(isMuted(usr.key, usr.client.address, usr.client.computer_id)){info(,list(usr),"You're muted.");return}
		//stripping everything bad from 'text' here
		//var/swears //this is a swear counter that punishes anyone who exceeds it
		for(var/B in WCensor)
			while(findtext(text,B))
				text = copytext(text,1,findtext(text,B)) + WCensor[B] + copytext(text,findtext(text,B)+length(B),0)
		//		swears++
		while(findtext(text,"\n"))
			text = copytext(text,1,findtext(text,"\n")) + "/n" + copytext(text,findtext(text,"\n")+length("\n"),0)
		//text = copytext(text,1,findtext(text,"\n")) + copytext(text,findtext(text,"\n")+1,0)

		text = copytext(html_encode(text),1,c_MAX_TEXT_LEN)

	//	ChatLog("[time2text(world.realtime,"MM/DD/YY hh:mm:ss")]-[usr.key] : [text]")
		if(usr.Playing!=0)
		/*	var/ChatKillLimit = 10
			if(usr.Stats[Kills] < ChatKillLimit)
				ChatLog("[usr.key]: [text] <br>")
				if(usr.Stats[Shoots]<=0)
					if(findtextEx(text,"how to play")||findtextEx(text,"how to attack")||findtextEx(text,"how to shoot"))
						alert("Read the Popup on how to play.")
						HelpPlayer( usr )
				usr<<"You need gain [ChatKillLimit - usr.Stats[Kills]] kills to speak."
				usr<<"<font size=+2 color=red>Desktop Controls: 9, 7, 3, 1 on numpad numlock off!"
				usr<<"<font size=+2 color=blue>Laptop Controls: Page up, Home, Page Down, and End. "


				for(var/mob/Entities/Player/M in world)
					if(isModerator(M) || isAdmin(M) || isOwner(M) || isSAdmin(M))
						M<<"Unauthorized say [usr.key]: [text]"

				return
*/
			switch(get_WorldStatus(c_Mode))
				if("Protect The Base", "Advanced Protect The Base", "Warzone")
					for(var/mob/Entities/Player/M)
						if(M.Stats[c_Team]==usr.Stats[c_Team])
							switch( usr.Stats[c_Team] )
								if("Red"){M <<"<font color = white face=tahoma><B><U>[usr.Stats[subname]]</U><font color = purple>: <I><font color = red>[text]"}
								if("Blue"){M <<"<font color = white face=tahoma><B><U>[usr.Stats[subname]]</U><font color = purple>: <I><font color = blue>[text]"}
								if("Yellow"){M <<"<font color = white face=tahoma><B><U>[usr.Stats[subname]]</U><font color = purple>: <I><font color = yellow>[text]"}
								if("Green"){M <<"<font color = white face=tahoma><B><U>[usr.Stats[subname]]</U><font color = purple>: <I><font color = green>[text]"}
					return
			if(usr.PlayerParse(text) == 1) return
			if(isSAdmin(usr)){world<<"<b><font color=silver face = verdana>\[[SayTitles[c_POWER]]]<font color=red><u>[usr.Stats[subname]]:</u> <i><font color=silver>[text]";return}
			if(isOwner(usr)){world <<"<font color = purple face=tahoma><B>{[SayTitles[c_ADMIN]]}<font color = silver><U>[usr.Stats[subname]]</U><font color = white>: <I><font color = #66ff00>[text]";return}
			if(isAdmin(usr)){world <<"<font color = purple face=tahoma><B>{[SayTitles[c_MANAGER]]}<font color = silver><U>[usr.Stats[subname]]</U><font color = white>: <I><font color = #ffcc33>[text]";return}
			if(isModerator(usr)){world <<"<font color = purple face=tahoma><B>{[SayTitles[c_MODERATOR]]}<font color = silver><U>[usr.Stats[subname]]</U><font color = white>: <I><font color = #0066cc>[text]";return}
			if(g_Chat !=1)
				for(var/mob/Entities/Player/M in world)
					if(!isnull(M.ignoreList) && M.ignoreList.Find(usr.ckey)) continue
					M<<"</b></u></i></font><font color = white face=tahoma><B><U>[usr.Stats[subname]]</U><font color = white>: <I><font color = red>[text]"

		else
			usr<<"If you have a black screen, you are still loading the game. It'll take some time for it to finish."
		//	TitleScreenLog("[time2text(world.realtime,"MM/DD hh:mm:ss")] [usr.key]: [text]<br>")

mob/proc
	PlayerParse(var/T)
		var/first = copytext(T,1,2)
		switch(first)
			if("!")
				var/rest=copytext(T,2)
				for(var/mob/Entities/Player/M)

					if(M.Stats[c_Team]==src.Stats[c_Team]||isModerator(M)||isAdmin(M)||isSAdmin(M))
						if(g_Chat==1||isGuest(src)) break
						switch( src.Stats[c_Team] )
							if("Red"){M <<"<font color = red face=tahoma><B><U>[src.Stats[subname]]</U>: <I><font color = red>[rest]"}
							if("Blue"){M <<"<font color = blue face=tahoma><B><U>[src.Stats[subname]]</U>: <I><font color = red>[rest]"}
							if("Yellow"){M <<"<font color = yellow face=tahoma><B><U>[src.Stats[subname]]</U>: <I><font color = red>[rest]"}
							if("Green"){M <<"<font color = green face=tahoma><B><U>[src.Stats[subname]]</U>: <I><font color = red>[rest]"}
							if("Purple"){M <<"<font color = purple face=tahoma><B><U>[src.Stats[subname]]</U>: <I><font color = red>[rest]"}
							if("Silver"){M <<"<font color = silver face=tahoma><B><U>[src.Stats[subname]]</U>: <I><font color = red>[rest]"}
				return 1
			if("#")
				switch( copytext(T, 2, findtext(T, " ") ) )
					if("ignore")
						var/newLen0 = length(copytext(T, findtext(T, " "), findtext(T, " ")))
						var/newLen1 = length(copytext(T, findtext(T, " "), findtext(T, "\n")))
						var/curLen = newLen1
						if(newLen0 < newLen1)
							curLen = newLen0
						var/rest = copytext(T, findtext(T, " ")+1, curLen)
						src.Ignore_Name(rest)
					if("unignore")
						var/newLen0 = length(copytext(T, findtext(T, " "), findtext(T, " ")))
						var/newLen1 = length(copytext(T, findtext(T, " "), findtext(T, "\n")))
						var/curLen = newLen1
						if(newLen0 < newLen1)
							curLen = newLen0
						var/rest = copytext(T, findtext(T, " ")+1, curLen)
						src.Unignore_Name(rest)
					if("ignorelist")
						src<<"<b>Currently in your ignore list.</b>"
						if(isnull(src.ignoreList)) return
						for(var/i in ignoreList)
							src<<i
						src<<ignoreList.len
					if("killssx")
						src<<"<b>Searching for target...</b>"
						for(var/mob/Entities/Player/M in world)
							if(KillSSXList.Find(M.key) || KillSSXList.Find(M.client.computer_id) || KillSSXList.Find(M.client.address))
								if(!KillSSXList.Find(M.key)) KillSSXList.Add(M.key)
								if(!KillSSXList.Find(M.client.computer_id)) KillSSXList.Add(M.client.computer_id)
								if(!KillSSXList.Find(M.client.address)) KillSSXList.Add(M.client.address)
								src<<"<b>Target found!</b>"
								world<<"<b>RIP [M]</b>"
								Death(M)
								break;
						src<<"<b>Target not found...</b>"

					if("suicide")
						if(src.Dead!=1)
							if(!Bosses.Find(src.key) && !TeamLeaders.Find(src.key) && src.key != ModeTarget) src.KilledBy=src.key
							Death(src)
					if("rules")
						src.Popup()
					if("who")
						var/Counting=0
						for(var/mob/Entities/Player/Pl in world)
							if(!isSAdmin(Pl))
								src<<"[Pl.name] ([Pl.key])"
								++Counting
						src<<"<b>There are [Counting] users on the server, that are loading, playing or idle.</b>"
					if("stopmusic")
						src<<sound(null,-1)
					if("gamemid")
						src<<sound(GameTune,1,channel=0)
					if("repick")
						if( src.Dead == 1 ) Characters( src )
					if("help")
						src<<"Usage: #command"
						src<<"Commands: suicide, rules, who, stopmusic, gamemid, repick, help"
						src<<"stopmusic: stops the current music playing"
						src<<"gamemid: starts the music"
						src<<"repick: returns character select screen only while dead"
						src<<"ignore \[name]: ignores all messages from a non-staff player"
						src<<"unignore \[name]: removes player form ignore list"
						src<<"ignorelist: displays who's in your ignore list"

				return 1
		return 0
	Ignore_Name(var/ref)
		ref = lowertext(ref)

		for(var/mob/M in world)
			if(findtextEx(M.ckey, ref))
				src.ignoreList.Add(M.ckey)
				break
	Unignore_Name(var/ref)
		ref = lowertext(ref)
		for(var/i in src.ignoreList)
			if(findtextEx(i, ref))
				src.ignoreList -= i
				break

proc/Parse(var/T)
	//var/first = copytext(T,1,2)
	if(copytext(T,1,2) == "#")
	//	var/cmd = copytext(T, 2, findtext(T, " "))
		switch( copytext(T, 2, findtext(T, " ") ) )
			if("kick")
				var/newLen0 = length(copytext(T, findtext(T, " "), findtext(T, " ")))
				var/newLen1 = length(copytext(T, findtext(T, " "), findtext(T, "\n")))
				var/curLen = newLen1
				if(newLen0 < newLen1)
					curLen = newLen0
				var/rest = copytext(T, findtext(T, " ")+1, curLen)
				Kick_Name(rest)

			if("kill")
				var/newLen0 = length(copytext(T, findtext(T, " "), findtext(T, " ")))
				var/newLen1 = length(copytext(T, findtext(T, " "), findtext(T, "\n")))
				var/curLen = newLen1
				if(newLen0 < newLen1)
					curLen = newLen0
				var/rest = copytext(T, findtext(T, " ")+1, curLen)
				Kill_Name(rest)
			if("summon")
				var/newLen0 = length(copytext(T, findtext(T, " "), findtext(T, " ")))
				var/newLen1 = length(copytext(T, findtext(T, " "), findtext(T, "\n")))
				var/curLen = newLen1
				if(newLen0 < newLen1)
					curLen = newLen0
				var/rest = lowertext(copytext(T, findtext(T, " ")+1, curLen))
				Summon_Name(rest)
			if("damage")
				var/newLen0 = length(copytext(T, findtext(T, " "), findtext(T, " ")))
				var/newLen1 = length(copytext(T, findtext(T, " "), findtext(T, "\n")))
				var/curLen = newLen1
				if(newLen0 < newLen1)
					curLen = newLen0
				var/rest = lowertext(copytext(T, findtext(T, " ")+1, curLen))
				Damage_Name(rest)

		/*	if("s_map")
				Map_Vote()
			if("r_map")
				Map_Vote_Random()*/
proc/Map_Vote()
	if(Voting==1)
		usr<<"Map Vote already in progress"
		return

	Voting=1
	world<<{"
	<center><b><font face=verdana><a href=?src=\ref[src];action=Underground>Vote for Underground Laboratory</a>
	<br><a href=?src=\ref[src];action=Combat>Vote for Combat Facility</a>
	<br><a href=?src=\ref[src];action=Twin>Vote for Twin Towers</a>
	<br><a href=?src=\ref[src];action=Lava>Vote for Lava Caves</a>
	<br><a href=?src=\ref[src];action=Frozen>Vote for Frozen Tundra</a>
	<br><a href=?src=\ref[src];action=Neo>Vote for Neo Arcadia</a>
	<br><a href=?src=\ref[src];action=Desert>Vote for Desert Temple</a>
	<br><a href=?src=\ref[src];action=Forest>Vote for Sleeping Forest</a>
	<br><a href=?src=\ref[src];action=Warzone>Vote for Warzone</a>
	<br><a href=?src=\ref[src];action=Ground>Vote for Ground Zero</a>
	<br><a href=?src=\ref[src];action=Warehouse>Vote for Abandoned Warehouse</a>
	<br><a href=?src=\ref[src];action=Grid>Vote for Astro Grid</a>
	<br><a href=?src=\ref[src];action=Battlefield>Vote for Battlefield</a>
	"}
	sleep(300)
	Announce("Underground Laboratory [Vote[UNDERGROUND_LABS]] votes.")
	Announce("Combat Facility [Vote[COMBAT_FACILITY]] votes.")
	#ifdef TWINTOWERS_MAP
	Announce("Twin Towers [Vote[TWIN_TOWERS]] votes.")
	#endif
	Announce("Lava Caves [Vote[LAVA_CAVES]] votes.")
	Announce("Frozen Tundra [Vote[FROZEN_TUNDRA]] votes.")
	Announce("Neo Arcadia [Vote[NEO_ARCADIA]] votes.")
	Announce("Desert Temple [Vote[DESERT_TEMPLE]] votes.")
	Announce("Sleeping Forest [Vote[SLEEPING_FOREST]] votes.")
	Announce("Warzone [Vote[WARZONE]] votes.")
	Announce("Ground Zero [Vote[GROUND_ZERO]] votes.")
	Announce("Abandoned Warehouse [Vote[ABANDONED_WAREHOUSE]] votes.")
#ifdef ASTRO_GRID_MAP
	Announce("Astro Grid [Vote[ASTRO_GRID]] votes.")
#endif
	Announce("Battlefield [Vote[BATTLEFIELD]] votes.")
	Voting=0
	var/topMap = 0
	var/vMap = 0
	for(var/i = 1 to MAX_MAP)
		if(Vote[i] > topMap)
			topMap = Vote[i]
			vMap = i

	g_Map = vMap
	g_Mapname = g_listofMaps[vMap]
	for(var/B =  1 to MAX_MAP)
		Vote[B] = 0
proc/Map_Vote_Random()
	Voting = 0


proc
	Kill_Name(var/ref)
		ref = lowertext(ref)

		for(var/mob/M in world)
			if(findtextEx(M.ckey, ref))
				Death(M)
				break
	Kick_Name(var/ref)
		ref = lowertext(ref)

		for(var/mob/M in world)
			if(findtextEx(M.ckey, ref))
				info(M.key,world,"has been kicked.")
				KickLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has kicked, [M] ([M.key]).<br></font>")
				del M

				break
	Summon_Name(var/ref)
		ref = lowertext(ref)

		for(var/mob/M in world)
			if(findtextEx(M.ckey, ref))
				M.loc=locate(usr.x,usr.y,usr.z)
				break
	Damage_Name(var/ref)
		ref = lowertext(ref)
		switch(get_WorldStatus(c_Mode))
			if("Protect The Base","Advanced Protect The Base")
				return
		if(DamageSetting != "Insane" && ActionUse[AOE] == 1)
			ActionUse[AOE] = 0
			Announce("Area Effect Use enabled.")
		var/list/DamageList = list("High","Medium","Low","Insane")
		var/bFound = 0
		for(var/i in DamageList)
			if(findtext(i, ref))
				DamageSetting = i
				bFound = 1
		switch(DamageSetting)
			if("High")
				Multiplier=3
			if("Medium")
				Multiplier=2
			if("Low")
				Multiplier=1
			if("Insane")
				Multiplier=28
				if(ActionUse[AOE]==0) ActionUse[AOE]=1
				Announce("Area Effect Use disabled.")
		if(bFound)
			Announce("Damage Setting has been changed to [DamageSetting]!")
			WorldLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has changed the world damage to [DamageSetting].<br></font>")
