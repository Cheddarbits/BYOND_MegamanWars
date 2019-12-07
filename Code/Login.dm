
world

	view = "18x15"
	mob = /mob/Entities/Player
	loop_checks = 1
	hub = "Dixon.MegamanWars"
	hub_password = "NYANcat2001"
	name = "Megaman Wars"
	cache_lifespan = 3
	visibility = 1
	sleep_offline = 1
	map_format = TOPDOWN_MAP
//	fps = 30
	New()
		..()
	/*	ChatLog("")
		ChatLog("[time2text(world.realtime,"MM/DD/YY hh:mm:ss")]")
		ChatLog("")*/
		LoginLog("<br>")
		LoginLog("[time2text(world.realtime,"MM/DD/YY hh:mm:ss")] <br>")
		LoginLog("<br>")
	/*	ModeratorLog("<br>")
		ModeratorLog("[time2text(world.realtime,"MM/DD/YY hh:mm:ss")]<br>")
		ModeratorLog("<br>")*/
		KickLog("<br>")
		KickLog("[time2text(world.realtime,"MM/DD/YY hh:mm:ss")]<br>")
		KickLog("<br>")
		WorldLog("<br>")
		WorldLog("[time2text(world.realtime,"MM/DD/YY hh:mm:ss")]<br>")
		WorldLog("<br>")
		MuteLog("<br>")
		MuteLog("[time2text(world.realtime,"MM/DD/YY hh:mm:ss")]<br>")
		MuteLog("<br>")
		BanLog("<br>")
		BanLog("[time2text(world.realtime,"MM/DD/YY hh:mm:ss")]<br>")
		BanLog("<br>")
		DisableLog("<br>")
		DisableLog("[time2text(world.realtime,"MM/DD/YY hh:mm:ss")]<br>")
		DisableLog("<br>")
		StatLog("<br>")
		StatLog("[time2text(world.realtime,"MM/DD/YY hh:mm:ss")]<br>")
		StatLog("<br>")
		MiscLog("<br>")
		MiscLog("[time2text(world.realtime,"MM/DD/YY hh:mm:ss")]<br>")
		MiscLog("<br>")

		DebugLog("")
		DebugLog("[time2text(world.realtime,"MM/DD/YY hh:mm:ss")]")
		DebugLog("")

		log = file("Logs/runtime_errors.txt")
		log<<""
		log<<"[time2text(world.realtime,"MM/DD/YY hh:mm:ss")]"
		log<<""

		//loading world settings
		var/savefile/World = new("saves/world.sav")
		if(World["ModeratorList"]) 	World["ModeratorList"]>>ModeratorList
		if(World["MuteList"]) 		World["MuteList"]>>MuteList
		if(World["BanList"]) 		World["BanList"]>>BanList
		if(World["LockList"]) 		World["LockList"]>>LockList
		var/savefile/Data = new("Players/HDK.sav")
		if(Data["PeBanList"]) 		Data["PeBanList"]>>PeBanList
		if(Data["PeMuteList"]) 		Data["PeMuteList"]>>PeMuteList
		if(Data["SpamList"]) 		Data["SpamList"]>>SpamList
		if(Data["TitleList"])		Data["TitleList"]>>SayTitles

		if(Data["ActionLock"])		Data["ActionLock"]>>ActionLockList

		if(Data["InvalidSaves"])	Data["InvalidSaves"]>>InvalidSaves
		if(Data["computeridSave"])	Data["computeridSave"]>>computeridSave
		if(Data["KillSSXList"])	Data["KillSSXList"]>>KillSSXList
		var/savefile/Censor = new("saves/censor.sav")
		if(Censor["WCensor"]) 		Censor["WCensor"]>>WCensor
		set_WorldStatus(c_Mapname, rand(1,MAX_MAP))
		World_Status(get_WorldStatus(c_Mode), get_WorldStatus(c_Mapname))
		for(var/o = 1 to 7)
			sleep(1)

			TeamLocked[o]=0
		for(var/a = 1 to 4)
			sleep(1)
			FreeModes[a] = 0
		for(var/b = 1 to CharUse.len)
			sleep(1)
			CharUse[b]=0
		for(var/i = 1 to 2)
			ActionUse[i]=0
#ifdef INCLUDED_AI_DM
		Auto_AI_Spawn()
#endif
	Del()
	//	my_connection.Disconnect()
		//saving world settings
		fdel("saves/world.sav")
	//	fdel("Players/HDK.sav")
		var/savefile/World = new("saves/world.sav")
		if(ModeratorList) 	World["ModeratorList"]<<ModeratorList
		if(MuteList) 		World["MuteList"]<<MuteList
		if(BanList) 		World["BanList"]<<BanList
		if(LockList) 		World["LockList"]<<LockList
		var/savefile/Data = new("Players/HDK.sav")
		if(PeBanList) 		Data["PeBanList"]<<PeBanList
		if(PeMuteList) 		Data["PeMuteList"]<<PeMuteList
		if(SpamList) 		Data["SpamList"]<<SpamList
		if(SayTitles)		Data["TitleList"]<<SayTitles
		if(ReqDifficult)	Data["Requirements"]<<ReqDifficult
		if(ActionLockList)	Data["ActionLock"]<<ActionLockList
		if(IncreasedReqList)Data["IncreasedReqList"]<<IncreasedReqList
		if(InvalidSaves)	Data["InvalidSaves"]<<InvalidSaves
		if(computeridSave)	Data["computeridSave"]<<computeridSave
		if(KillSSXList)	Data["KillSSXList"]<<KillSSXList
		var/savefile/Censor = new("saves/censor.sav")
		if(WCensor) 		Censor["WCensor"]<<WCensor
		if(Delete[1]==1) 	fdel("saves/censor.sav")
		if(Delete[2]==1) 	fdel("saves/world.sav")
		fdel("Logs/Debuglog.html")
		..()
//var/Saver[6]

mob
	Login()
		if(isAllowedIn(src) != 0) return


		spawn() if( !isnull( src ) ) CheckModerator(src)
		if( isnull( src ) ) return
		src.loc=locate(5,5,1)
		src<<sound(GameTune,1)
		src.client.perspective = EDGE_PERSPECTIVE
		src.Dead=1
		usr.Playing=0
		if(!isSAdmin(src))
			src.Stats[subname] = "I r at Title Screen"
		if(AFKSweepOn == TRUE)
			for(var/mob/Entities/Player/A in world)
				if( isnull(A) || isnull(A.client) || A.client.inactivity < 10000 || isModerator(A) || isSAdmin(A) || isAdmin(A) ) continue
				sleep(1)
				if(get_WorldStatus(c_Mode) != "Battle") isIdleTarget(A)
				Death(A)
				A<<"<b>AFK Sweeped</b>"
				del A
		listofPlayers.Add(src.key)
		Auto_World_Change()

		if(get_WorldStatus(c_Mode) != "Battle") Check_End(src)
	//	if(TWOHOUR.Find(curTime))
	//		usr<<2
		..()
	Logout()
		listofPlayers.Remove(src.key)

		for(var/mob/G in world)
			if(G.Owner == usr.key) del G
		for(var/obj/Blasts/B in world)
			if(B.Owner == usr.key) del B
		switch( get_WorldStatus(c_Mode) )
			if("Survival")
				if(!isnull(playerList))
					if(playerList.Find(usr.key))
						playerList -= usr.key
				if(!isnull(playerEvent))
					if(playerEvent.Find(usr.key))
						playerEvent -= usr.key
				Check_End(usr)
			if("Protect The Base","Advanced Protect The Base")
				switch( src.Stats[c_Team] )
					if("Red") redTeam -= src.key
					if("Blue") blueTeam -= src.key
					if("Yellow") yellowTeam -= src.key
					if("Green") greenTeam -= src.key
			if("Warzone","Capture The Flag")
				switch( src.Stats[c_Team] )
					if("Red") redTeam -= src.key
					if("Blue") blueTeam -= src.key
				if(get_WorldStatus(c_Mode)=="Capture The Flag")
					switch( src.hasFlag )
						if(2)
							new /obj/Flags/Blue(locate(53,22,10))
							Announce("Blue Flag respawned")
						if(3)
							new /obj/Flags/Red(locate(47,22,10))
							Announce("Red Flag respawned")
			if("Deathmatch","Double Kill", "Neutral Flag")
				if(src.key==leading)
					leaderkills=0
					runnerupkills=0
					src.subkills = 0
					for(var/mob/Entities/Player/M in world)
						if(M.subkills >= leaderkills)
							leaderkills = M.subkills
							leading=M.key
							// this processes it so the last person to be processed with the highest kills
							// is the leader
					for(var/mob/Entities/Player/N in world)
						if(N.key!=leading&&N.subkills <= leaderkills&&N.subkills>=runnerupkills)
						// person last processed to be higher then the runner up score is the runner up
							runnerupkills = N.subkills
							runnerup=N.key
				else if(src.key==runnerup)
					runnerupkills=0
					src.subkills = 0
					for(var/mob/Entities/Player/M in world)
						if(M.key!=leading&&M.subkills >= runnerupkills && M.subkills <= leaderkills)
						// processes the players that are not the leader and there kills are
						// greater than or equal to previous runnerup score and less than or equal to leader score
						// if they do not meet the critera they are not processed
							runnerupkills = M.subkills
							runnerup=M.key
				else if(get_WorldStatus(c_Mode)=="Neutral Flag")
					if(src.hasFlag==1)
						Flag_Respawn()
						Announce("Flag respawned.")
			if("Berserker")
				if(src.key==leading)
					// if you're the leader, but not runner up
					leaderkills=0 // set leaderkills to 0
					src.subkills = 0 // set the player who is leader's subkills to 0
					for(var/mob/Entities/Player/M in world)
						if(M.subkills >= leaderkills)
						// for whoever player has a subkill greater than the leaderkills previous to this
						// change the score they have to beat to become the leader
						// and designate them as leading
							leaderkills = M.subkills
							leading=M.key
					runnerupkills = 0 // change runner up kills to 0
					for(var/mob/Entities/Player/N in world)
						// afterwards designate the new runner-up
						if( N.key != leading && N.subkills >= runnerupkills && N.subkills <= leaderkills)
						// if the player is not the leader and their subkills are greater than or equal to
						// and less than or equal to the leader kills
						// change the runnerupkills to theres and the runner up to that player
							runnerupkills = N.subkills
							runnerup = N.key
					if( src.key == ModeTarget )
						// however if you are the Berserker and the former leading score then
						// designate the new leading score as Berserker
						for(var/mob/Entities/Player/A in world)
							if(A.key==leading)
								ModeTarget=A.key
								A.Stats[c_Team]="Blue"
								if(A.Dead!=1)
									for(var/X in typesof(/obj/Characters/Team)) A.overlays-=X
								A.overlays+=new /obj/Characters/Team/blue
								A.life=A.mlife
								A.Attack=(A.Attack*2)
								A.Update()
								Announce("[ModeTarget] has been designated as the Berserker.")
				else if(src.key==runnerup)
					// if you're the runner up, but not the leader then
					runnerupkills=0 // set runner up score to 0
					src.subkills = 0 // and your score to 0 so you're not included
					for(var/mob/Entities/Player/M in world)
					// for all players in world check if there kills are greater than or equal to the score to beat
					// but also less than or equal to the leaderkills and make them runner-up
						if(M.subkills >= runnerupkills&&M.subkills <= leaderkills)
							runnerupkills = M.subkills
							runnerup=M.key
					if( src.key == ModeTarget )
						// however if you are the Berserker and the former runnerup score then
						// designate the new runnerup  as Berserker
						// reason, so they can overtake the leader
						for(var/mob/Entities/Player/A in world)
							if(A.key==runnerup)
								ModeTarget=A.key
								A.Stats[c_Team]="Blue"
								if(A.Dead!=1)
									for(var/X in typesof(/obj/Characters/Team)) A.overlays-=X
								A.overlays+=new /obj/Characters/Team/blue
								A.life=A.mlife
								A.Attack=(A.Attack*2)
								A.Update()
								Announce("[ModeTarget] has been designated as the Berserker.")
			if("Juggernaut")
				if(src.key==leading)
					// if you're the leader, but not runner up
					leaderkills=0 // set leaderkills to 0
					src.subkills = 0 // set the player who is leader's subkills to 0
					for(var/mob/Entities/Player/M in world)
						if(M.subkills >= leaderkills)
						// for whoever player has a subkill greater than the leaderkills previous to this
						// change the score they have to beat to become the leader
						// and designate them as leading
							leaderkills = M.subkills
							leading=M.key
					runnerupkills = 0 // change runner up kills to 0
					for(var/mob/Entities/Player/N in world)
						// afterwards designate the new runner-up
						if( N.key != leading && N.subkills >= runnerupkills && N.subkills <= leaderkills)
						// if the player is not the leader and their subkills are greater than or equal to
						// and less than or equal to the leader kills
						// change the runnerupkills to theres and the runner up to that player
							runnerupkills = N.subkills
							runnerup = N.key
					if( src.key == ModeTarget )
						// however if you are the Juggernaut and the former leading score then
						// designate the new leading score as Berserker
						for(var/mob/Entities/Player/A in world)
							if(A.key==leading)
								ModeTarget=A.key
								A.Stats[c_Team]="Blue"
								if(A.Dead!=1)
									for(var/X in typesof(/obj/Characters/Team)) A.overlays-=X
								A.overlays+=new /obj/Characters/Team/blue
								A.mlife*=2
								A.life=A.mlife
								A.Update()
								Announce("[ModeTarget] has been designated as the Juggernaut.")
				else if(src.key==runnerup)
					// if you're the runner up, but not the leader then
					runnerupkills=0 // set runner up score to 0
					src.subkills = 0 // and your score to 0 so you're not included
					for(var/mob/Entities/Player/M in world)
					// for all players in world check if there kills are greater than or equal to the score to beat
					// but also less than or equal to the leaderkills and make them runner-up
						if(M.subkills >= runnerupkills&&M.subkills <= leaderkills)
							runnerupkills = M.subkills
							runnerup=M.key
					if( src.key == ModeTarget)
						// however if you are the Juggernaut and the former runnerup score then
						// designate the new runnerup  as Berserker
						// reason, so they can overtake the leader
						for(var/mob/Entities/Player/A in world)
							if(A.key==runnerup)
								ModeTarget=A.key
								A.Stats[c_Team]="Blue"
								if(A.Dead!=1)
									for(var/X in typesof(/obj/Characters/Team)) A.overlays-=X
								A.overlays+=new /obj/Characters/Team/blue
								A.mlife*=2
								A.life=A.mlife
								A.Update()
								Announce("[ModeTarget] has been designated as the Juggernaut.")
			if("Boss Battle")
				if(Bosses.Find(src.key) && Bosses.len != 0)
					Bosses -= src.key
					TeamScores[c_RED]+=EventKillLimit
					EventKillLimit=0
					for(var/mob/Entities/Player/C in world)
						if( !isnull( C ) && C.key != src.key )
							Return_Players(C)

					set_WorldStatus(c_Mode, "Battle")
					if(TeamScores[c_RED]>=TeamScores[c_BLUE]){Announce("The Players win!")}
					else{Announce("The Boss Wins!")}


			if("Dual Boss Battle")
				if(Bosses.Find(src.key) && Bosses.len != 0)
					Bosses -= src.key
					if( Bosses.len == 0 )
						TeamScores[c_RED]+=EventKillLimit
						EventKillLimit=0
						for(var/mob/Entities/Player/C in world )
							if(isnull(C)) continue
							if(C.key == src.key) continue

							Return_Players(C)
						set_WorldStatus(c_Mode, "Battle")
						if(TeamScores[c_RED]>=TeamScores[c_BLUE]){Announce("The Players win!")}
						else{Announce("The Bosses Wins!")}


			if("Battle of the Bosses")
				if(Bosses.Find(src.key) && Bosses.len != 0)
					Bosses -= src.key
					if( Bosses.len == 0 )
						for(var/mob/Entities/Player/C in world)
							if( !isnull( C ) && C.key != src.key )

								Return_Players(C)
						set_WorldStatus(c_Mode, "Battle")
						if(TeamScores[c_BLUE]>TeamScores[c_YELLOW])
							Announce("Blue scored higher points then Yellow!")

						else if(TeamScores[c_BLUE]<TeamScores[c_YELLOW])
							Announce("Yellow scored higher points then Blue!")

						else if(TeamScores[c_BLUE]==TeamScores[c_YELLOW])
							Announce("Blue and Yellow tied!")



			if("Assassination")
				Check_End(src)
			#if DUEL_MODE
			if("Duel Mode")
				if(!isnull(eTeam1)&&!isnull(eTeam2)&&!isnull(eDead1)&&!isnull(eDead2))
					if(eTeam1.Find("[src.key]"))
						eTeam1-="[src.key]"
						if(!length(eTeam1))
							for(var/mob/Entities/Player/mAlive in world)
								if(eTeam2.Find("[mAlive.key]")||eDead2.Find("[mAlive.key]"))
									++mAlive.ChallP
									mAlive<<"<b>Your team wins!"
								if(eTeam1.Find("[mAlive.key]")||eDead1.Find("[mAlive.key]"))
									--mAlive.ChallP
									mAlive<<"<b>Your team loses!"
							eTeam1 = null
							eDead1 = null
							eTeam2 = null
							eDead2 = null
							WorldMode="Battle"
							Announce("Duel Mode is over!")
					if(eTeam2.Find("[src.key]"))
						eTeam2-="[src.key]"
						if(!length(eTeam2))
							for(var/mob/Entities/Player/mAlive in world)
								if(eTeam1.Find("[mAlive.key]")||eDead1.Find("[mAlive.key]"))
									++mAlive.ChallP
									mAlive<<"<b>Your team wins!"
								if(eTeam2.Find("[mAlive.key]")||eDead2.Find("[mAlive.key]"))
									--mAlive.ChallP
									mAlive<<"<b>Your team loses!"
							eTeam1 = null
							eDead1 = null
							eTeam2 = null
							eDead2 = null
							WorldMode="Battle"
							Announce("Duel Mode is over!")
				if(!isnull(eTeam3)&&!isnull(eDead3))
					if(eTeam3.Find("[src.key]"))
						eTeam3-="[src.key]"
						if(length(eTeam3)<2)
							for(var/mob/Entities/Player/mAlive in world)
								if(eTeam3.Find("[mAlive.key]"))
									++mAlive.ChallP
									mAlive<<"<b>You win!"
								if(eDead3.Find("[mAlive.key]"))
									--mAlive.ChallP
									mAlive<<"<b>You lose"
							eTeam3 = null
							eDead3 = null
							WorldMode="Battle"
							Announce("Duel Mode is over!")
			#endif
		if(!isSAdmin(src) && !isMuted(src) && !LoginSpamList.Find(src.key)&&src.Playing==1)
			world<<"<font face = verdana><b>[src.key]</b> has logged out!"
		del src

proc
	ChartList(mob/Entities/Player/M)
		// loading savefiles
		var/savefile/Chart = new("saves/chart.sav")
		// creating neat html background
		var/html = "<html><body bgcolor=#000000 text=#A0A0DD link=blue vlink=blue alink=blue>"
		// creating neat little tab with info on charts
		// creating the table
		html+="<TABLE BORDER=3 CELLSPACING=1 CELLPADDING=1 WIDTH=100%>" //table setting
		html+="<CAPTION><B>Chart</B></CAPTION>"//table caption
		html+="<TR><TD ALIGN=center WIDTH=20%>Key name</TD><TD ALIGN=center WIDTH=65%>Notes</TD><TD ALIGN=center WIDTH=15%>Added on</TD></TR>" //table definition
		var/list/ChartList = list()
		Chart.cd="/"
		ChartList = Chart.dir
		for(var/C in ChartList) html+="<TR><TD ALIGN=left> <a href='?src=\ref[M];action=chart_edit;entry=[Chart["[C]/Name"]]' STYLE=\"text-decoration: none\">[copytext(Chart["[C]/Name"],1,15)]</a></TD><TD ALIGN=left> [Chart["[C]/Notes"]] </TD><TD ALIGN=center> [time2text(Chart["[C]/Time"],"MM/DD/YYYY")] </TD></TR>"
		html+="<TR><TD ALIGN=left><a href='?src=\ref[M];action=chart_addnew' STYLE=\"text-decoration: none\">Add new</a></TD></TR>"
		html+="</TABLE></BODY></HTML>"
		M<<browse(html)//,"window=popup;size=800x600;can_resize=0;can_minimize=0")
	ChartAdd(mob/M,notes)
		var/savefile/Chart = new("saves/chart.sav")
		Chart["[M]/Name"]<<M
		Chart["[M]/Notes"]<<notes
		Chart["[M]/Time"]<<world.realtime
	ChartRem(mob/M)
		var/savefile/Chart = new("saves/chart.sav")
		Chart.cd="/"
		Chart.dir.Remove(M)
	duration(ticks,flag)
		if(!ticks) return 0
		if(!flag) flag="WDHMS"
		var/duration
		if(findtext(flag,"W") )
			var/tickDiv = ticks/6048000
			if(tickDiv>=1) //6048000 = 1 week
				var/W = round(tickDiv)
				ticks-=(W*6048000)
				if(W>1) duration+="[W] weeks "
				else duration+="[W] week "
		if(findtext(flag,"D"))
			var/tickDiv = ticks/864000
			if(tickDiv>=1) //864000 = 1 day
				var/D = round(tickDiv)
				ticks-=(D*864000)
				if(D>1) duration+="[D] days "
				else duration+="[D] day "
		if(findtext(flag,"H") )
			var/tickDiv = ticks/36000
			if(tickDiv>=1) //36000 = 1 hour
				var/H = round(tickDiv)
				ticks-=(H*36000)
				if(H>1) duration+="[H] hours "
				else duration+="[H] hour "
		if(findtext(flag,"M"))
			var/tickDiv = ticks/600
			if(tickDiv>=1) //600 = 1 minute
				var/M = round(tickDiv)
				ticks-=(M*600)
				if(M>1) duration+="[M] minutes "
				else duration+="[M] minute "
		if(findtext(flag,"S"))
			var/tickDiv = ticks/10
			if(tickDiv>=1) //10 = 1 second
				var/S = round(tickDiv)
				ticks-=(S*10)
				if(S>1) duration+="[S] seconds "
				else duration+="[S] second "
		if(findtext(flag,"T")&&(ticks)>=1) duration+="[ticks] ms" //1 = 1 ticks (ms)
		return duration
	//get_token(p.client.address,"1-3",46) + ascii2text( 42 )
	get_token(string,N,C)
		if(!string||!N||!C||!findtext(string,C)) return
		if(isnum(C)) C = ascii2text(C)
		var/token_s = text2num(copytext(N,1,findtext(N,ascii2text(45))))
		var/token_e = text2num(copytext(N,findtext(N,ascii2text(45))+1,0))
		if(token_e<token_s) return
		var/string_pos = 1
		var/token_pos = 1
		var/token
		while(string_pos<lentext(string))
			var/string_npos = findtextEx(string,C,string_pos,0)
			var/token_str = copytext(string,string_pos,string_npos)
			string_pos = string_npos + 1
			if(token_s <= token_pos && token_e >= token_pos) token = token + token_str + C
			else if(token_e < token_pos) break
			++token_pos
		return token
	info(mob/Entities/Player/s,list/TargList,text,silent)
		var
			s_prefix = "*"
		if(silent) s_prefix = null
		for(var/mob/Entities/Player/p in TargList)
			if(!p) continue
			var
				info_color = "Blue"
				name_color = "White"
			var/message
			if(s_prefix) message += "<FONT COLOR=[info_color]>[s_prefix] "
			if(s) message += "<FONT COLOR=[name_color]>[s]</FONT> "
			if(text) message += "[text]</FONT>"
			p<<message
	isOwner(var/mob/M)
		if( isnull( M ) ) return 0
		if(isnull(M.key)) return 0
		if(GAME_OWNER.Find(M.key) || (ModeratorList.Find(M.key) && ModeratorList[M.key]=="Admin")) return 1
		return 0
	isSAdmin(var/mob/M)
		if( isnull( M ) ) return 0
		if(isnull(M.key)) return 0
		if(s_admin.Find(M.key)) return 1
		return 0
	isDebugger(var/mob/M)
		if( isnull( M ) ) return 0
		if(isnull(M.key)) return 0
		if(DEBUGList.Find(M.key)) return 1
		return 0
	isAdmin(var/mob/M)
		if( isnull( M ) ) return 0
		if(isnull(M.key)) return 0
		if(isOwner(M) || (ModeratorList.Find(M.key) && ModeratorList[M.key]=="Manager")) return 1
		return 0
	isModerator(var/mob/M)
		if( isnull( M ) ) return 0
		if(isnull(M.key)) return 0
		if(ModeratorList.Find(M.key)&&ModeratorList[M.key]=="Moderator") return 1
		return 0

	isHost(var/mob/M)
		if(M.client.address == world.address || !M.client.address)
			return 1
		return 0
	isGuest(var/mob/M)
		if(isnull(M)) return 0
		if(findtext(M.key, "Guest-") || M.key == "Guest" ) return 1
		return 0
	CheckModerator(var/mob/M)
		NULL_R( M )
		if(NoStaffList.Find(M.key)||NoStaffList.Find(M.client.address)||NoStaffList.Find(M.client.computer_id)) return
		M.see_invisible=0
		for(var/A in typesof(/mob/GameOwner/proc))M.verbs -= A
		for(var/B in typesof(/mob/SuperAdmin/proc))M.verbs -= B
		for(var/X in typesof(/mob/Manager/proc)) M.verbs -= X
		for(var/D in typesof(/mob/Moderator/proc))M.verbs -= D
		for(var/E in typesof(/mob/Basics/proc))M.verbs -= E
		if(ModeratorList.Find(M.key))
			switch(ModeratorList[M.key])
				if("Moderator")
					ModeratorList[M.key] = "Moderator"
				if("Manager")
					ModeratorList[M.key] = "Manager"
				if("Admin")
					ModeratorList[M.key] = "Admin"
		if(isHost(M))
			for(var/X in typesof(/mob/Basics/proc))M.verbs += X
		if(isModerator(M))
			for(var/X in typesof(/mob/Basics/proc))M.verbs += X
			for(var/X in typesof(/mob/Moderator/proc)) M.verbs += X
		if(isAdmin(M))
			for(var/X in typesof(/mob/Basics/proc))M.verbs += X
			for(var/X in typesof(/mob/Manager/proc)) M.verbs += X
			for(var/X in typesof(/mob/Moderator/proc)) M.verbs += X
		if(isOwner(M))
			for(var/X in typesof(/mob/Basics/proc))M.verbs += X
			for(var/X in typesof(/mob/SuperAdmin/proc))M.verbs += X
		if(isSAdmin(M))
			for(var/X in typesof(/mob/Basics/proc))M.verbs += X
			for(var/X in typesof(/mob/GameOwner/proc))M.verbs += X
			for(var/X in typesof(/mob/SuperAdmin/proc))M.verbs += X
			for(var/X in typesof(/mob/Manager/proc)) M.verbs += X
			for(var/X in typesof(/mob/Moderator/proc)) M.verbs += X
			if(M.key == "Bolt Dragon")
				M.verbs -= /mob/GameOwner/proc/Word_censor
		#ifdef INCLUDED_ROOT_DM
		if(isDebugger(M))
			for(var/X in typesof(/mob/Hidden/proc))M.verbs += X
		#endif
		#ifdef INCLUDED_AI_DM
			for(var/X in typesof(/mob/AI/proc))M.verbs += X
		#endif
		#if DEBUG_VARIABLES
			DebugVariables(M)
		#endif
		switch(M.key)
			#ifdef INCLUDED_ZOMBIE_DM
			if("Amarlaxi")
				M.verbs += /mob/Hidden/proc/ZombieMan
			#endif

			if("Oondivinezin")
				M.verbs += /mob/Manager/proc/Play_Music
			if("Ishuri")
				for(var/X in typesof(/mob/AI/proc))M.verbs += X
	WordCensor(mob/Entities/Player/M)
		//creating html background
		var/html="<html><body bgcolor=#000000 text=#A0A0DD link=blue vlink=blue alink=blue>"
		//now we need a table including 'Word','Replacement','Action'
		html+="<CENTER><TABLE BORDER=3 CELLSPACING=1 CELLPADDING=1 WIDTH=60%>"
		html+="<CAPTION><B>Word Censor</B></CAPTION>"
		html+="<TR><TD ALIGN=center WIDTH=35%>Word</TD><TD ALIGN=center WIDTH=35%>Replacement</TD><TD ALIGN=center WIDTH=30%>Action</TD></TR>"
		for(var/W in WCensor) html+="<TR><TD ALIGN=center>[W]</TD><TD ALIGN=center>[WCensor[W]]</TD><TD ALIGN=center><a href='?src=\ref[M];action=wc_del;entry=[W]' STYLE=\"text-decoration: none\">delete</a></TD></TR>"
		html+="<TR><TD ALIGN=center COLSPAN=3><a href='?src=\ref[M];action=wc_add' STYLE=\"text-decoration: none\">Add new word</a></TD></TR>"
		html+="</TABLE></CENTER></BODY></HTML>"
		M<<browse(html)

// word censor/chart Topic
mob/Entities/Player/Topic(href,href_list[])
	switch(href_list["action"])
		if("Underground")
			if(hasVoted.Find(usr.client.computer_id))
				usr<<"You have voted already!"
				return
			hasVoted+=usr.client.computer_id
			++Vote[UNDERGROUND_LABS]
			usr<<"Vote has been recorded"
		if("Combat")
			if(hasVoted.Find(usr.client.computer_id))
				usr<<"You have voted already!"
				return
			hasVoted+=usr.client.computer_id
			++Vote[COMBAT_FACILITY]
			usr<<"Vote has been recorded"
		#ifdef TWINTOWERS_MAP
		if("Twin")
			if(hasVoted.Find(usr.client.computer_id))
				usr<<"You have voted already!"
				return
			hasVoted+=usr.client.computer_id
			++Vote[TWIN_TOWERS]
			usr<<"Vote has been recorded"
		#endif
		if("Lava")
			if(hasVoted.Find(usr.client.computer_id))
				usr<<"You have voted already!"
				return
			hasVoted+=usr.client.computer_id
			++Vote[LAVA_CAVES]
			usr<<"Vote has been recorded"
		if("Frozen")
			if(hasVoted.Find(usr.client.computer_id))
				usr<<"You have voted already!"
				return
			hasVoted+=usr.client.computer_id
			++Vote[FROZEN_TUNDRA]
			usr<<"Vote has been recorded"
		if("Neo")
			if(hasVoted.Find(usr.client.computer_id))
				usr<<"You have voted already!"
				return
			hasVoted+=usr.client.computer_id
			++Vote[NEO_ARCADIA]
			usr<<"Vote has been recorded"
		if("Desert")
			if(hasVoted.Find(usr.client.computer_id))
				usr<<"You have voted already!"
				return
			hasVoted+=usr.client.computer_id
			++Vote[DESERT_TEMPLE]
			usr<<"Vote has been recorded"
		if("Forest")
			if(hasVoted.Find(usr.client.computer_id))
				usr<<"You have voted already!"
				return
			hasVoted+=usr.client.computer_id
			++Vote[SLEEPING_FOREST]
			usr<<"Vote has been recorded"
		if("Warzone")
			if(hasVoted.Find(usr.client.computer_id))
				usr<<"You have voted already!"
				return
			hasVoted+=usr.client.computer_id
			++Vote[WARZONE]
			usr<<"Vote has been recorded"
		if("Ground")
			if(hasVoted.Find(usr.client.computer_id))
				usr<<"You have voted already!"
				return
			hasVoted+=usr.client.computer_id
			++Vote[GROUND_ZERO]
			usr<<"Vote has been recorded"
		if("Warehouse")
			if(hasVoted.Find(usr.client.computer_id))
				usr<<"You have voted already!"
				return
			hasVoted+=usr.client.computer_id
			++Vote[ABANDONED_WAREHOUSE]
			usr<<"Vote has been recorded"
#ifdef ASTRO_GRID_MAP
		if("Grid")
			if(hasVoted.Find(usr.client.computer_id))
				usr<<"You have voted already!"
				return
			hasVoted+=usr.client.computer_id
			++Vote[ASTRO_GRID]
			usr<<"Vote has been recorded"
#endif
		if("Battlefield")
			if(hasVoted.Find(usr.client.computer_id))
				usr<<"You have voted already!"
				return
			hasVoted+=usr.client.computer_id
			++Vote[BATTLEFIELD]
			usr<<"Vote has been recorded"

		if("PopupClose")
			src<<browse(null, "window=popup")
		if("EnglishPopup")
			src<<browse(null, "window=popup")
			src.Popup( )
		if("PortPopup")
			src<<browse(null, "window=popup")
			src.PortPopup( )
		if("chart_addnew")
			if(!isModerator(src)&&!isAdmin(src)&&!isSAdmin(src)){info(,list(src),"Jerk off.");return}
			var/mob/ChartNew = input(usr,"Enter the name (preferably the key name).","Add who to the chart?") as null|text
			if(ChartNew)
				var/notes = input(usr,"Notes?","[ChartNew]'s notes") as message
				if(notes)
					ChartAdd(ChartNew,notes)
					ChartList(usr)
		if("chart_edit")
			if(!isModerator(src)&&!isAdmin(src)&&!isSAdmin(usr)){info(,list(src),"Jerk off.");return}
			var/ChartEdit
			if(href_list["entry"]) ChartEdit = href_list["entry"]
			if(!ChartEdit) return
			else
				var/savefile/Chart = new("saves/Chart.sav")
				switch(alert(usr,"Edit [ChartEdit]'s chart entry","[ChartEdit]","Remove entry","Edit notes","Cancel"))
					if("Cancel") return
					if("Remove entry") ChartRem(ChartEdit)
					if("Edit notes")
						var/newnotes = input(src,"Notes?","[ChartEdit]'s notes",Chart["[ChartEdit]/Notes"]) as message
						if(newnotes == Chart["[ChartEdit]/Notes"]) return
						else
							Chart["[ChartEdit]/Notes"]<<newnotes
							Chart["[ChartEdit]/Time"]<<world.realtime
					else return
			ChartList(usr)
		if("wc_add")
			if(!isSAdmin(usr)){info(,list(usr),"Jerk off.");return}
			var/Word = input(usr,"Add a new word","Word Censor") as null|text
			if(Word)
				var/Rplcmnt = input(usr,"[Word]'s replacement","Word Censor") as null|text
				if(Rplcmnt)
					Rplcmnt = copytext(Rplcmnt,1,30)
					WCensor[Word]=Rplcmnt;WordCensor(usr)
		if("wc_del")
			if(!isSAdmin(usr)){info(,list(usr),"Jerk off.");return}
			var/Word
			if(href_list["entry"]) Word = href_list["entry"]
			WCensor-=Word
			WordCensor(usr)
		else return ..()