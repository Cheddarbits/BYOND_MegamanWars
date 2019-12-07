/*
proc_CHECKEND
*/

proc
	Invalid_Map_Change()
		var/list/InvalidMap_Change = list(
		"Protect The Base","Advanced Protect The Base","Boss Battle","Dual Boss Battle","Battle of the Bosses","Assassination",
		"Duel Mode","Neutral Flag","Capture The Flag","Juggernaut","Berserker","Warzone")
		if(InvalidMap_Change.Find("[get_WorldStatus(c_Mode)]")) return 1
		return 0;
	Invalid_Team_Change()
		var/list/InvalidTeam_Change = list(
		"Deathmatch", "Team Deathmatch", "Double Kill","Warzone","Assassination","Protect The Base","Advanced Protect The Base",
		"Juggernaut","Berserker","Boss Battle","Dual Boss Battle","Battle of the Bosses","Capture The Flag")
		if(InvalidTeam_Change.Find("[get_WorldStatus(c_Mode)]")) return 1
		return 0;
	Repopulate_Teams()
		if(!activeTeams.Find("Red"))
			activeTeams += "Red"
		if(!activeTeams.Find("Blue"))
			activeTeams += "Blue"
		if(!activeTeams.Find("Green"))
			activeTeams += "Green"
		if(!activeTeams.Find("Yellow"))
			activeTeams += "Yellow"
	Mode_Reset()
		Repopulate_Teams()
		for(var/i = 1 to c_MAX_PUBLIC_TEAMS)
			TeamScores[i] = 0
			TeamLocked[i]=0
		for(var/mob/Entities/PTB/T in world)
			del T
		for(var/obj/Flags/F in world)
			del F
		for(var/mob/Entities/Player/B in world)
			if(B.Playing == 0) continue
			B.life=28
			B.mlife=28
			B.subkills=0

		EventKillLimit = 0
		leaderkills=0

		leading=null
		runnerup=null
		runnerupkills=0
#if DUEL_MODE
		eTeam1 = null
		eDead1 = null
		eTeam2 = null
		eDead2 = null
		eTeam3 = null
		eDead3 = null
#endif
		for(var/i in TeamLeaders)
			TeamLeaders -= i
		for(var/i in Bosses)
			Bosses -= i
		ModeTarget = null
	// #proc_CHECKEND
	Check_End(var/mob/M)
		if(get_WorldStatus(c_Mode) == "Battle") return
		var/ModeEnd = 0
		switch( get_WorldStatus(c_Mode) )
			if("Survival")
				M.playerLives--
				for(var/mob/Entities/Player/P in world)
					if(P.playerLives < 1)
						if(playerEvent.Find(P.key))
							playerEvent -= P.key
							Announce("[P.key] has been eliminated from the match!")
					if(P.client.inactivity >= c_INACTIVE)
						P.playerLives = 0
						if(playerEvent.Find(P.key))
							playerEvent -= P.key
						Death(P)
				if(playerEvent.len == 1)
					var/Survivor = null
					for(var/mob/Entities/Player/P in world)
						if(isnull(P)) continue
						if(P.key == playerEvent[1])
							Survivor = P.key
							playerEvent-=P.key

							break
					Announce("[Survivor] is the last one standing!")
					for(var/mob/Entities/Player/C) Return_Players(C)
					ModeEnd = 1
			if("Boss Battle")
				if(Bosses.Find(M.key) && M.Dead == 1)
					Bosses -= M.key
					M.Stats[c_Team] = "Red"
					Announce("[M.key] has been killed by [M.KilledBy]")
					if(Bosses.len == 0)
						TeamScores[c_RED]+=EventKillLimit
						if(TeamScores[c_RED] >= TeamScores[c_BLUE])
							Announce("The Players win!")
						else
							Announce("The Boss Wins!")
						ModeEnd = 1
			if("Dual Boss Battle")
				if(Bosses.Find(M.key) && M.Dead == 1)
					Bosses -= M.key
					M.Stats[c_Team] = "Red"
					Announce("[M.key] has been killed by [M.KilledBy]")
					if(Bosses.len == 0)
						TeamScores[c_RED]+=EventKillLimit
						if(TeamScores[c_RED] >= TeamScores[c_BLUE])
							Announce("The Players win!")
						else
							Announce("The Bosses Win!")
						ModeEnd = 1
			if("Battle of the Bosses")
				if(Bosses.Find(M.key) && M.Dead == 1)
					Bosses -= M.key
					M.Stats[c_Team] = "Red"
					Announce("[M.key] has been killed by [M.KilledBy]")
					if(Bosses.len == 0)
						if(TeamScores[c_BLUE] > TeamScores[c_YELLOW])
							Announce("Blue scored higher points then Yellow!")
						else if(TeamScores[c_BLUE] < TeamScores[c_YELLOW])
							Announce("Yellow scored higher points then Blue!")
						else if(TeamScores[c_BLUE]==TeamScores[c_YELLOW])
							Announce("Blue and Yellow tied!")
						ModeEnd = 1

			if("Assassination")
				if(TeamLeaders.Find(M.key) && M.Dead == 1)
					TeamLeaders -= M.key
					switch(M.Stats[c_Team])
						if("Red")
							TeamLocked[c_RED]=1
						if("Blue")
							TeamLocked[c_BLUE]=1
						if("Yellow")
							TeamLocked[c_YELLOW]=1
						if("Green")
							TeamLocked[c_GREEN]=1
					if(activeTeams.len > 1)
						activeTeams -= M.Stats[c_Team]
					Announce("[M.Stats[c_Team]] Leader has been killed by [M.KilledBy]")
					for(var/mob/Entities/Player/F in world)
						if(F.client.inactivity >= c_INACTIVE) continue
						if(F.Playing==1&&F.Stats[c_Team]==M.Stats[c_Team])
							Return_Players(F)
							Randomize_Teams(F)
				if(activeTeams.len <= 1)
					DebugLog("Assassination - [activeTeams] [activeTeams[1]]")
					Announce("[activeTeams[1]] Wins!")
					activeTeams = 0

					ModeEnd = 1
			if("Deathmatch", "Double Kill" , "Neutral Flag", "Berserker", "Juggernaut")
				if(M.subkills >= EventKillLimit)
					Announce("[M.key] Wins!")
					for(var/mob/Entities/Player/B in world)

						Return_Players(B)
					KillMultiplier = 1
					ModeEnd = 1
					if(ActionUse[INV] == 1)
						ActionUse[INV] = 0
						Announce("Invisible Use enabled.")
				else
					if(M.subkills >= leaderkills)
						leaderkills = M.subkills
						leading = M.key
						for(var/mob/Entities/Player/P in world)
							if(P.key != leading && P.subkills >= runnerupkills)
								runnerupkills = P.subkills
								runnerup = P.key
					else if(M.subkills >= runnerupkills )
						runnerupkills = M.subkills
						runnerup = M.key
			if("Team Deathmatch")
				var/Result = 0;
				if(TeamScores[c_RED] >= EventKillLimit)
					Result = "Red"
				else if(TeamScores[c_BLUE] >= EventKillLimit)
					Result = "Blue"
				else if(TeamScores[c_YELLOW] >= EventKillLimit)
					Result = "Yellow"
				else if(TeamScores[c_GREEN] >= EventKillLimit)
					Result = "Green"
				Announce("[Result] Wins!")
				ModeEnd = 1
			if("Capture The Flag")
				var/Team = 0;
				if(TeamScores[c_RED] >= EventKillLimit)
					Team = "Red"
				else if(TeamScores[c_BLUE] >= EventKillLimit)
					Team = "Blue"
				Announce("[Team] Team Wins!")
				if(ActionUse[INV] == 1)
					ActionUse[INV] = 0
					Announce("Invisible Use enabled.")
		if(ModeEnd == 1)
			Mode_Reset()
			set_WorldStatus(c_Mode, "Battle")
	Return_Players(mob/C)
		if(!isnull( C ) && !isSAdmin( C ) && C.Dead!=1)
			C.KilledBy=C.key
			C.life=C.mlife
			if(C) C.Update()
			spawn(1) Death(C)
	Randomize_Teams(var/mob/M)
		if(get_WorldStatus(c_Mode)!="Battle")
			switch( get_WorldStatus(c_Mode) )
				if("Warzone","Capture The Flag")
					if(redTeam.len < blueTeam.len)
						M.Stats[c_Team] = "Red"
						redTeam += M.key
					else
						M.Stats[c_Team] = "Blue"
						blueTeam += M.key

				if("Team Deathmatch", "Protect The Base","Advanced Protect The Base")
					if( teamLength(c_RED) <= teamLength(c_BLUE) && teamLength(c_RED) <= yellowTeam.len && teamLength(c_RED) <= greenTeam.len )

						if(!blueTeam.Find(M.key) && !yellowTeam.Find(M.key) && !greenTeam.Find(M.key))
							M.Stats[c_Team] = "Red"
							redTeam += M.key
					else if( blueTeam.len <= redTeam.len && blueTeam.len <= yellowTeam.len && blueTeam.len <= greenTeam.len )
						if(!redTeam.Find(M.key) && !yellowTeam.Find(M.key) && !greenTeam.Find(M.key))
							M.Stats[c_Team] = "Blue"
							blueTeam += M.key
					else if( yellowTeam.len <= redTeam.len && yellowTeam.len <= blueTeam.len && yellowTeam.len <= greenTeam.len )
						if(!redTeam.Find(M.key) && !blueTeam.Find(M.key) && !greenTeam.Find(M.key))
							M.Stats[c_Team] = "Yellow"
							yellowTeam += M.key
					else
						if(!blueTeam.Find(M.key) && !yellowTeam.Find(M.key) && !redTeam.Find(M.key))
							M.Stats[c_Team] = "Green"
							greenTeam += M.key

				if("Assassination")
					var/list/pickList = list("Red", "Blue", "Yellow", "Green")
					if(TeamLocked[c_RED] == 1) pickList-="Red"
					if(TeamLocked[c_BLUE] == 1) pickList-="Blue"
					if(TeamLocked[c_YELLOW] == 1) pickList-="Yellow"
					if(TeamLocked[c_GREEN] == 1) pickList-="Green"
					var/randPick = rand(1, pickList.len)
					M.Stats[c_Team] = pickList[randPick]
					switch(M.Stats[c_Team])
						if("Red")
							redTeam += M.key
						if("Blue")
							blueTeam += M.key
						if("Yellow")
							yellowTeam += M.key
						if("Green")
							greenTeam += M.key