

mob/proc
	AFK_Sweep_Toggle()
		if(isAFKSweep())
			AFKSweepOn = FALSE;
			MiscLog("[time2text(world.realtime,"hh:mm:ss")] [src.key] has turned off AFK Sweep.")
			info(,list(src),"AFK Sweep disabled")
		else
			AFKSweepOn = TRUE;
			MiscLog("[time2text(world.realtime,"hh:mm:ss")] [src.key] has turned on AFK Sweep.")
			info(,list(src),"AFK Sweep enabled")
	World_Mode()
		// Create a list of "active" players
		var/list/activePlayers = list()
		for(var/mob/Entities/Player/P)
			if(isPlaying(P) == 0 || P.client.inactivity >= c_INACTIVE) continue
			activePlayers += P.key
		// Determine available game modes from active amount
		var/lengthofActive = activePlayers.len
		if(lengthofActive < 4)
			info(,list(src),"Not enough active players")

		var/list/InvalidMode = list(
		"Protect The Base","Advanced Protect The Base","Boss Battle","Dual Boss Battle","Battle of the Bosses","Assassination",
		"Duel Mode","Neutral Flag","Capture The Flag","Juggernaut","Berserker", "Tournament", "Survival")
		if(InvalidMode.Find("[get_WorldStatus(c_Mode)]"))
			if(!isSAdmin(usr)) return
		var/list/GameMode = list(
		"Battle","Deathmatch","Team Deathmatch","Protect The Base"/*,"Advanced Protect The Base"*/,"Warzone","Neutral Flag",
		"Capture The Flag","Assassination","Boss Battle","Dual Boss Battle","Battle of the Bosses","Juggernaut","Berserker",
		"Survival",
		/*"Duel Mode",*/ /*"Tournament"*/)
		if(isSAdmin(usr))
			GameMode+="Double Kill"
		GameMode+="Cancel"
		switch(input("Select a Mode","Game Mode",get_WorldStatus(c_Mode)) in GameMode)
			if("Battle")
				Mode_Reset()
				set_WorldStatus(c_Mode,"Battle")
			if("Protect The Base")

				Mode_Reset()
				set_WorldStatus(c_Mode,"Protect The Base")
				for(var/mob/Entities/Player/B)
					if(B.Playing==1)
						Return_Players(B)
						Randomize_Teams(B)
				set_WorldStatus(c_Mapname, COMBAT_FACILITY);
				new /mob/Entities/PTB/Red(locate(25,6,2))
				new /mob/Entities/PTB/Blue(locate(29,83,2))
				new /mob/Entities/PTB/Yellow(locate(73,83,2))
				new /mob/Entities/PTB/Green(locate(77,6,2))
				Announce("World Mode changed to [get_WorldStatus(c_Mode)]!  Scores Reset!")
				Announce("Amount of players in Red: [redTeam.len]")
				Announce("Amount of players in Blue: [blueTeam.len]")
				Announce("Amount of players in Yellow: [yellowTeam.len]")
				Announce("Amount of players in Green: [greenTeam.len]")
			// Basically, it's one base standing wins
		#if APTB
			if("Advanced Protect The Base")
				Mode_Reset()
				WorldMode="Advanced Protect The Base"
				for(var/mob/Entities/Player/B)
					if(B.Playing==1)
						Return_Players(B)
						Randomize_Teams(B)
				Reset_Scores()
				Map = COMBAT_FACILITY
				new /mob/Entities/PTB/Red(locate(25,6,2))
				new /mob/Entities/PTB/Blue(locate(29,83,2))
				new /mob/Entities/PTB/Yellow(locate(73,83,2))
				new /mob/Entities/PTB/Green(locate(77,6,2))}
				Mapname = "Combat Facility"
				Announce("World Mode changed to [WorldMode]!  Scores Reset!")
				Announce("Amount of players in Red: [TeamCounter[c_RED]]")
				Announce("Amount of players in Blue: [TeamCounter[c_BLUE]]")
				Announce("Amount of players in Yellow: [TeamCounter[c_YELLOW]]")
				Announce("Amount of players in Green: [TeamCounter[c_GREEN]]")
		#endif
			if("Warzone")

				Mode_Reset()
				set_WorldStatus(c_Mode,"Warzone")
				for(var/mob/Entities/Player/B)
					if(B.Playing==1)
						Return_Players(B)
						Randomize_Teams(B)

				TeamLocked[c_YELLOW]=1
				TeamLocked[c_GREEN]=1
				set_WorldStatus(c_Mapname, WARZONE);
				// Spawn bases
				spawn(1) new /mob/Entities/PTB/Red(locate(47,22,10))
				spawn(1) new /mob/Entities/PTB/Blue(locate(53,22,10))
				spawn(1) new /mob/Entities/PTB/mini/Red(locate(26,33,10))
				spawn(1) new /mob/Entities/PTB/mini/Blue(locate(75,33,10))
				// Spawn bombers
				spawn(1) new /mob/Entities/AIs/Ships(locate(/turf/Warzone/Ship_Spawns/one))
				spawn(1) new /mob/Entities/AIs/Ships(locate(/turf/Warzone/Ship_Spawns/two))
				spawn(1) new /mob/Entities/AIs/Ships(locate(/turf/Warzone/Ship_Spawns/three))
				spawn(1) new /mob/Entities/AIs/Ships(locate(/turf/Warzone/Ship_Spawns/four))
				spawn(1) new /mob/Entities/AIs/Ships(locate(/turf/Warzone/Ship_Spawns/five))
				spawn(1) new /mob/Entities/AIs/Ships(locate(/turf/Warzone/Ship_Spawns/six))
				spawn(1) new /mob/Entities/AIs/Ships(locate(/turf/Warzone/Ship_Spawns/seven))
				spawn(1) new /mob/Entities/AIs/Ships(locate(/turf/Warzone/Ship_Spawns/eight))
				Announce("World Mode changed to [get_WorldStatus(c_Mode)]!  Scores Reset!")
				sleep(1)
				for(var/mob/Entities/PTB/P in world)
					P.pixel_y=0
					P.pixel_x=0
					P.life = (P.mlife*2)
			if("Boss Battle")
				Mode_Reset()
				var/list/Boss_List = list()
				for(var/mob/Entities/Player/P)
					if(P.Playing != 1 || P.client.inactivity >= c_INACTIVE) continue
					Boss_List+="[P.key]"
					Boss_List["[P.key]"] = P.key
				var/boss_player = input("Who shall be boss?")in Boss_List+"<Cancel>"
				if(boss_player == "<Cancel>") return
				EventKillLimit = input("Input a kill limit for boss","Limiter",100)
				EventKillLimit=round(EventKillLimit)
				if(EventKillLimit < 100) EventKillLimit=75
				if(EventKillLimit > 1000) EventKillLimit=1000
				for(var/mob/Entities/Player/A in world)
					if(A.Playing == 0) continue
					if(A.key == Boss_List[boss_player])
						Bosses+=boss_player
						A.Stats[c_Team]="Blue"
						if(A.Dead!=1)
							for(var/X in typesof(/obj/Characters/Team)) A.overlays-=X
							A.overlays+=new /obj/Characters/Team/blue
						A.mlife=input("Input an HP amount for the boss","HP",1000)
						A.mlife=round(A.mlife)
						if(A.mlife<1000) A.mlife=1000
						if(A.mlife>10000) A.mlife=10000
						A.life=A.mlife
						A.Attack*=3
						A.Update()
						Announce("[boss_player] has been designated as the Boss.")
					else
						A.Stats[c_Team]="Red"
						Return_Players(A)
				set_WorldStatus(c_Mode,"Boss Battle")
				Announce("World Mode changed to [get_WorldStatus(c_Mode)]!  Scores Reset!")
			if("Dual Boss Battle")
				Mode_Reset()
				var/list/Selection_List = list()
				for(var/mob/Entities/Player/P)
					if(P.Playing != 1 || P.client.inactivity >= c_INACTIVE) continue
					Selection_List+="[P.key]"
					Selection_List["[P.key]"] = P.key
				var/list/Players[2]
				Players[1] = input("Who is Player 1?") in Selection_List + "<Cancel>"
				if(Players[1]=="<Cancel>") return
				Selection_List-=Players[1]

				Players[2] = input("Who is Player 2?") in Selection_List + "<Cancel>"
				if(Players[2]=="<Cancel>") return
				Selection_List-=Players[2]

				EventKillLimit = input("Input a kill limit for boss","Limiter",200)
				EventKillLimit=round(EventKillLimit)
				if(EventKillLimit < 200) EventKillLimit=150
				if(EventKillLimit > 2000) EventKillLimit=2000
				var/playerlife=input("Input an HP amount for the boss","HP",1000)
				for(var/mob/Entities/Player/C)
					if(Players.Find(C.key))
						Bosses+=C.key
						C.Stats[c_Team]="Blue"
						if(C.Dead!=1)
							for(var/X in typesof(/obj/Characters/Team)) C.overlays-=X
							C.overlays+=new /obj/Characters/Team/blue
						C.mlife=round(playerlife)
						if(C.mlife<1000) C.mlife=1000
						if(C.mlife>10000) C.mlife=10000
						C.life=C.mlife
						C.Attack*=3
						C.Update()
					else if(C.Playing==1)
						C.Stats[c_Team]="Red"
						Return_Players(C)
				Announce("[Players[1]] has been designated as the Boss.")
				Announce("[Players[2]] has been designated as the 2nd Boss.")
				set_WorldStatus(c_Mode,"Dual Boss Battle")
				Announce("World Mode changed to [get_WorldStatus(c_Mode)]! Scores Reset!")
			if("Battle of the Bosses")
				Mode_Reset()
				var/list/Selection_List = list()
				for(var/mob/Entities/Player/P)
					if(P.Playing != 1 || P.client.inactivity >= c_INACTIVE) continue
					Selection_List+="[P.key]"
					Selection_List["[P.key]"] = P.key

				var/list/Players[2]
				Players[1] = input("Who is Player 1?") in Selection_List + "<Cancel>"
				if(Players[1]=="<Cancel>") return
				Selection_List-=Players[1]

				Players[2] = input("Who is Player 2?") in Selection_List + "<Cancel>"
				if(Players[2]=="<Cancel>") return
				Selection_List-=Players[2]
				var/playerlife=input("Input an HP amount for the boss","HP",1500)
				for(var/mob/Entities/Player/C in world)
					if(Players.Find(C.key))
						C.mlife=round(playerlife)
						if(C.mlife<1500) C.mlife=1500
						if(C.mlife>15000) C.mlife=15000
						C.life=C.mlife
						C.Attack*=3
						C.Update()
						Bosses+=C.key
						if(C.key==Players[1])
							C.Stats[c_Team]="Blue"
							if(C.Dead!=1)
								for(var/X in typesof(/obj/Characters/Team)) C.overlays-=X
								C.overlays+=new /obj/Characters/Team/blue
						if(C.key==Players[2])
							C.Stats[c_Team]="Yellow"
							if(C.Dead!=1)
								for(var/X in typesof(/obj/Characters/Team)) C.overlays-=X
								C.overlays+=new /obj/Characters/Team/yellow
					else if(C.Playing==1)
						C.Stats[c_Team]="Red"
						Return_Players(C)
				Announce("[Players[1]] has been designated as the Boss.")
				Announce("[Players[2]] has been designated as the 2nd Boss.")
				set_WorldStatus(c_Mode,"Battle of the Bosses")
				Announce("World Mode changed to [get_WorldStatus(c_Mode)]! Scores Reset!")
		#if DUEL_MODE
			if("Duel Mode")
				var/list/TeamSelect = list("One vs One","Free For All","Team Match")
				var/TeEnergydeSelect = input("Which type of match?","Match Type","Free For All") in TeamSelect+"<Cancel>"
				if(TeEnergydeSelect == "<Cancel>") return
				var/NewMap=input("What map shall this take place on?","Map",Mapname)in g_listofMaps + "<Cancel>"
				switch(NewMap)
					if("Underground Laboratory")
						eMap=UNDERGROUND_LABS
						eMapname=NewMap
					if("Combat Facility")
						eMap=COMBAT_FACILITY
						eMapname=NewMap
					if("Twin Towers")
						eMap=TWIN_TOWERS
						eMapname=NewMap
					if("Lava Caves")
						eMap=LAVA_CAVES
						eMapname=NewMap
					if("Frozen Tundra")
						eMap=FROZEN_TUNDRA
						eMapname=NewMap
					if("Neo Arcadia")
						eMap=NEO_ARCADIA
						eMapname=NewMap
					if("Desert Temple")
						eMap=DESERT_TEMPLE
						eMapname=NewMap
					if("Sleeping Forest")
						eMap=SLEEPING_FOREST
						eMapname=NewMap
					if("Warzone")
						eMap=WARZONE
						eMapname=NewMap
					if("Ground Zero")
						eMap=GROUND_ZERO
						eMapname=NewMap
					if("<Cancel>")
						return
				if(TeEnergydeSelect == "One vs One")
					var/list/SelectionList = list()
					for(var/mob/Entities/Player/P in world)
						if(P.client.inactivity > c_INACTIVE || P.Playing != 1) continue
						SelectionList+="[P.key]"
						SelectionList["[P.key]"] = P.key

					var/list/Players = list()
					Players[1] = input("Who is Player 1?") in SelectionList + "<Cancel>"
					if(Players[1]=="<Cancel>") return
					SelectionList-=Players[1]

					Players[2] = input("Who is Player 2?") in SelectionList + "<Cancel>"
					if(Players[2]=="<Cancel>") return
					SelectionList-=Players[2]

					var/playerlife=input("Input an HP amount for the players","HP",112)
					for(var/mob/Entities/Player/C in world)
						if(Players.Find(C.key))
							if(C.Dead!=1)
								Death(C)
							C.mlife=round(playerlife)
							if(C.mlife<28) C.mlife=28
							if(C.mlife>112) C.mlife=112
							C.Stats[c_Team]="N/A"
							C<<"<b>You have been selected to fight in a [TeEnergydeSelect] Duel Mode on [eMapname].\n\
							The match will initiate when everyone spawns."
					eTeam1+="[P1]"
					eTeam2+="[P2]"
				if(TeEnergydeSelect == "Free For All")
					var/list/ModeSelect2 = list("3","4","5","6")
					var/FFAMatch = input("How many participants?")in ModeSelect2+"<Cancel>"
					if(ModeSelect2 == "<Cancel>") return
					if(FFAMatch=="3")
						var/list/SelectionList = list()
						for(var/mob/Entities/Player/P in world)
							if(P.client.inactivity > c_INACTIVE || P.Playing != 1) continue
							SelectionList+="[P.key]"
							SelectionList["[P.key]"] = P.key

						var/list/Players = list()
						Players[1] = input("Who is Player 1?") in SelectionList + "<Cancel>"
						if(Players[1]=="<Cancel>") return
						SelectionList-=Players[1]

						Players[2] = input("Who is Player 2?") in SelectionList + "<Cancel>"
						if(Players[2]=="<Cancel>") return
						SelectionList-=Players[2]

						Players[3] = input("Who is Player 3?") in SelectionList + "<Cancel>"
						if(Players[3]=="<Cancel>") return
						SelectionList-=Players[3]

						var/playerlife=input("Input an HP amount for the players","HP",112)
						for(var/mob/Entities/Player/C in world)
							if(Players.Find(C.key))
								if(C.Dead!=1)
									Death(C)
								C.mlife=round(playerlife)
								if(C.mlife<28) C.mlife=28
								if(C.mlife>112) C.mlife=112
								C.Stats[c_Team]="N/A"
								C<<"<b>You have been selected to fight in a [TeEnergydeSelect] Duel Mode on [eMapname].\n\
								The match will initiate when everyone spawns."
						eTeam3.Add("[P1]","[P2]","[P3]")
					if(FFAMatch=="4")
						var/list/SelectionList = list()
						for(var/mob/Entities/Player/P in world)
							if(P.client.inactivity > c_INACTIVE || P.Playing != 1) continue
							SelectionList+="[P.key]"
							SelectionList["[P.key]"] = P.key

						var/list/Players = list()
						Players[1] = input("Who is Player 1?") in SelectionList + "<Cancel>"
						if(Players[1]=="<Cancel>") return
						SelectionList-=Players[1]

						Players[2] = input("Who is Player 2?") in SelectionList + "<Cancel>"
						if(Players[2]=="<Cancel>") return
						SelectionList-=Players[2]

						Players[3] = input("Who is Player 3?") in SelectionList + "<Cancel>"
						if(Players[3]=="<Cancel>") return
						SelectionList-=Players[3]

						Players[4] = input("Who is Player 4?") in SelectionList + "<Cancel>"
						if(Players[4]=="<Cancel>") return
						SelectionList-=Players[4]

						var/playerlife=input("Input an HP amount for the players","HP",112)
						for(var/mob/Entities/Player/C in world)
							if(Players.Find(C.key))
								if(C.Dead!=1)
									Death(C)
								C.mlife=round(playerlife)
								if(C.mlife<28) C.mlife=28
								if(C.mlife>112) C.mlife=112
								C.life=C.mlife
								C.Update()
								C.Stats[c_Team]="N/A"
								C<<"<b>You have been selected to fight in a [TeEnergydeSelect] Duel Mode on [eMapname].\n\
								The match will initiate when everyone spawns."
						eTeam3.Add("[P1]","[P2]","[P3]")
					if(FFAMatch=="5")
						var/list/SelectionList = list()
						for(var/mob/Entities/Player/P in world)
							if(P.client.inactivity > c_INACTIVE || P.Playing != 1) continue
							SelectionList+="[P.key]"
							SelectionList["[P.key]"] = P.key

						var/list/Players = list()
						Players[1] = input("Who is Player 1?") in SelectionList + "<Cancel>"
						if(Players[1]=="<Cancel>") return
						SelectionList-=Players[1]

						Players[2] = input("Who is Player 2?") in SelectionList + "<Cancel>"
						if(Players[2]=="<Cancel>") return
						SelectionList-=Players[2]

						Players[3] = input("Who is Player 3?") in SelectionList + "<Cancel>"
						if(Players[3]=="<Cancel>") return
						SelectionList-=Players[3]

						Players[4] = input("Who is Player 4?") in SelectionList + "<Cancel>"
						if(Players[4]=="<Cancel>") return
						SelectionList-=Players[4]

						Players[5] = input("Who is Player 4?") in SelectionList + "<Cancel>"
						if(Players[5]=="<Cancel>") return
						SelectionList-=Players[5]
						var/playerlife=input("Input an HP amount for the players","HP",112)
						for(var/mob/Entities/Player/C in world)
							if(Players.Find(C.key))
								if(C.Dead!=1)
									Death(C)
								C.mlife=round(playerlife)
								if(C.mlife<28) C.mlife=28
								if(C.mlife>112) C.mlife=112
								C.Stats[c_Team]="N/A"
								C<<"<b>You have been selected to fight in a [TeEnergydeSelect] Duel Mode on [eMapname].\n\
								The match will initiate when everyone spawns."

						eTeam3.Add("[P1]","[P2]","[P3]","[P4]","[P5]")

					if(FFAMatch=="6")

						var/list/SelectionList = list()
						for(var/mob/Entities/Player/P in world)
							if(P.client.inactivity > c_INACTIVE || P.Playing != 1) continue
							SelectionList+="[P.key]"
							SelectionList["[P.key]"] = P.key

						var/list/Players = list()
						Players[1] = input("Who is Player 1?") in SelectionList + "<Cancel>"
						if(Players[1]=="<Cancel>") return
						SelectionList-=Players[1]

						Players[2] = input("Who is Player 2?") in SelectionList + "<Cancel>"
						if(Players[2]=="<Cancel>") return
						SelectionList-=Players[2]

						Players[3] = input("Who is Player 3?") in SelectionList + "<Cancel>"
						if(Players[3]=="<Cancel>") return
						SelectionList-=Players[3]

						Players[4] = input("Who is Player 4?") in SelectionList + "<Cancel>"
						if(Players[4]=="<Cancel>") return
						SelectionList-=Players[4]

						Players[5] = input("Who is Player 5?") in SelectionList + "<Cancel>"
						if(Players[5]=="<Cancel>") return
						SelectionList-=Players[5]

						Players[6] = input("Who is Player 6?") in SelectionList + "<Cancel>"
						if(Players[6]=="<Cancel>") return
						SelectionList-=Players[6]

						var/playerlife=input("Input an HP amount for the players","HP",112)
						for(var/mob/Entities/Player/C in world)
							if(Players.Find(C.key))
								if(C.Dead!=1)
									Death(C)
								C.mlife=round(playerlife)
								if(C.mlife<28) C.mlife=28
								if(C.mlife>112) C.mlife=112
								C.Stats[c_Team]="N/A"
								C<<"<b>You have been selected to fight in a [TeEnergydeSelect] Duel Mode on [eMapname].\n\
								The match will initiate when everyone spawns."
						eTeam3.Add("[P1]","[P2]","[P3]","[P4]","[P5]","[P6]")
				if(TeEnergydeSelect == "Team Match")
					var/list/ModeSelect1 = list("2v2","3v3","4v4")
					var/TeamMatch = input("What kind of Team Match?")in ModeSelect1+"<Cancel>"
					if(ModeSelect1 == "<Cancel>") return
					if(TeamMatch == "2v2")
						var/list/SelectionList = list()
						for(var/mob/Entities/Player/P in world)
							if(P.client.inactivity > c_INACTIVE || P.Playing != 1) continue
							SelectionList+="[P.key]"
							SelectionList["[P.key]"] = P.key

						var/list/Players = list()
						Players[1] = input("Who is Player 1?") in SelectionList + "<Cancel>"
						if(Players[1]=="<Cancel>") return
						SelectionList-=Players[1]

						Players[2] = input("Who is Player 2?") in SelectionList + "<Cancel>"
						if(Players[2]=="<Cancel>") return
						SelectionList-=Players[2]

						Players[3] = input("Who is Player 3?") in SelectionList + "<Cancel>"
						if(Players[3]=="<Cancel>") return
						SelectionList-=Players[3]

						Players[4] = input("Who is Player 4?") in SelectionList + "<Cancel>"
						if(Players[4]=="<Cancel>") return
						SelectionList-=Players[4]


						var/playerlife=input("Input an HP amount for the players","HP",112)
						for(var/mob/Entities/Player/C in world)
							if(Players.Find(C.key))
								if(C.Dead!=1)
									Death(C)
								C.mlife=round(playerlife)
								if(C.mlife<28) C.mlife=28
								if(C.mlife>112) C.mlife=112
								if(C.key==P1||C.key==P2)
									C.Stats[c_Team]="Red"
								if(C.key==P3||C.key==P4)
									C.Stats[c_Team]="Blue"
								C<<"<b>You have been selected to fight in a [TeEnergydeSelect] Duel Mode on [eMapname].\n\
								The match will initiate when everyone spawns."
						eTeam1.Add("[P1]","[P2]")
						eTeam2.Add("[P3]","[P4]")
					if(TeamMatch == "3v3")

						var/list/SelectionList = list()
						for(var/mob/Entities/Player/P in world)
							if(P.client.inactivity > c_INACTIVE || P.Playing != 1) continue
							SelectionList+="[P.key]"
							SelectionList["[P.key]"] = P.key

						var/list/Players = list()
						Players[1] = input("Who is Player 1?") in SelectionList + "<Cancel>"
						if(Players[1]=="<Cancel>") return
						SelectionList-=Players[1]

						Players[2] = input("Who is Player 2?") in SelectionList + "<Cancel>"
						if(Players[2]=="<Cancel>") return
						SelectionList-=Players[2]

						Players[3] = input("Who is Player 3?") in SelectionList + "<Cancel>"
						if(Players[3]=="<Cancel>") return
						SelectionList-=Players[3]

						Players[4] = input("Who is Player 4?") in SelectionList + "<Cancel>"
						if(Players[4]=="<Cancel>") return
						SelectionList-=Players[4]

						Players[5] = input("Who is Player 5?") in SelectionList + "<Cancel>"
						if(Players[5]=="<Cancel>") return
						SelectionList-=Players[5]

						Players[6] = input("Who is Player 6?") in SelectionList + "<Cancel>"
						if(Players[6]=="<Cancel>") return
						SelectionList-=Players[6]

						var/playerlife=input("Input an HP amount for the players","HP",112)
						for(var/mob/Entities/Player/C in world)
							if(Players.Find(C.key))
								if(C.Dead!=1)
									Death(C)
								C.mlife=round(playerlife)
								if(C.mlife<28) C.mlife=28
								if(C.mlife>112) C.mlife=112
								if(C.key==P1||C.key==P2||C.key==P3)
									C.Stats[c_Team]="Red"
								if(C.key==P4||C.key==P5||C.key==P6)
									C.Stats[c_Team]="Blue"
								C<<"<b>You have been selected to fight in a [TeEnergydeSelect] Duel Mode on [eMapname].\n\
								The match will initiate when everyone spawns."

						eTeam1.Add("[P1]","[P2]","[P3]")
						eTeam2.Add("[P4]","[P5]","[P6]")
					if(TeamMatch == "4v4")
						var/list/SelectionList = list()
						for(var/mob/Entities/Player/P in world)
							if(P.client.inactivity > c_INACTIVE || P.Playing != 1) continue
							SelectionList+="[P.key]"
							SelectionList["[P.key]"] = P.key

						var/list/Players = list()
						Players[1] = input("Who is Player 1?") in SelectionList + "<Cancel>"
						if(Players[1]=="<Cancel>") return
						SelectionList-=Players[1]

						Players[2] = input("Who is Player 2?") in SelectionList + "<Cancel>"
						if(Players[2]=="<Cancel>") return
						SelectionList-=Players[2]

						Players[3] = input("Who is Player 3?") in SelectionList + "<Cancel>"
						if(Players[3]=="<Cancel>") return
						SelectionList-=Players[3]

						Players[4] = input("Who is Player 4?") in SelectionList + "<Cancel>"
						if(Players[4]=="<Cancel>") return
						SelectionList-=Players[4]

						Players[5] = input("Who is Player 5?") in SelectionList + "<Cancel>"
						if(Players[5]=="<Cancel>") return
						SelectionList-=Players[5]

						Players[6] = input("Who is Player 6?") in SelectionList + "<Cancel>"
						if(Players[6]=="<Cancel>") return
						SelectionList-=Players[6]

						Players[7] = input("Who is Player 7?") in SelectionList + "<Cancel>"
						if(Players[7]=="<Cancel>") return
						SelectionList-=Players[7]

						Players[8] = input("Who is Player 8?") in SelectionList + "<Cancel>"
						if(Players[8]=="<Cancel>") return
						SelectionList-=Players[8]

						var/playerlife=input("Input an HP amount for the players","HP",112)
						if(playerlife<28) playerlife=28
						if(playerlife>112) playerlife=112
						for(var/mob/Entities/Player/C in world)
							if(Players.Find(C.key))
								if(C.Dead!=1)
									Death(C)
								C.mlife=round(playerlife)
								if(C.key==P1||C.key==P2||C.key==P3||C.key==P4)
									C.Stats[c_Team]="Red"
								if(C.key==P5||C.key==P6||C.key==P7||C.key==P8)
									C.Stats[c_Team]="Blue"
								C<<"<b>You have been selected to fight in a [TeEnergydeSelect] Duel Mode on [eMapname].\n\
								The match will initiate when everyone spawns."

						eTeam1.Add("[P1]","[P2]","[P3]","[P4]")
						eTeam2.Add("[P5]","[P6]","[P7]","[P8]")
				WorldMode="Duel Mode"
				Announce("World Mode changed to [WorldMode]!")
		#endif
			if("Deathmatch")
				Mode_Reset()
				EventKillLimit = input("Input a number for Death match kill limit","Limiter",50)
				EventKillLimit=round(EventKillLimit)
				if(EventKillLimit>250) EventKillLimit=250
				if(EventKillLimit<10) EventKillLimit=10
				for(var/mob/Entities/Player/B in world)
					Return_Players(B)
					B.Stats[c_Team]="N/A"
					B.subkills=0
				set_WorldStatus(c_Mode,"Deathmatch")
				Announce("World Mode changed to [get_WorldStatus(c_Mode)]!  Scores Reset!")
				Announce("Deathmatch Kill Limit of [EventKillLimit]")
			if("Team Deathmatch")
				Mode_Reset()

				EventKillLimit = input("Input a number for Team Deathmatch kill limit","Limiter",75)
				EventKillLimit=round(EventKillLimit)
				if(EventKillLimit>500) EventKillLimit=500
				if(EventKillLimit<100) EventKillLimit=75
				set_WorldStatus(c_Mode,"Team Deathmatch")
				for(var/mob/Entities/Player/B)
					Return_Players(B)
					Randomize_Teams(B)
				Announce("World Mode changed to [get_WorldStatus(c_Mode)]!  Scores Reset!")
				Announce("Team Deathmatch Kill Limit set to [EventKillLimit]")
			if("Assassination")
				// Populate selection list
				var/list/SelectionList = list()

				for(var/mob/Entities/Player/M in world)
					if(M.client.inactivity > c_INACTIVE || M.Playing != 1) continue
					SelectionList+="[M.key]"
					SelectionList["[M.key]"] = M.key
				if(SelectionList.len < 4)
					usr<<"Not enough active Players."
					return

				Mode_Reset()

				var/list/LeaderList[4]
				// Select leader 1
				LeaderList[1] = input("Please designate a key.")in SelectionList+"<Cancel>"
				if(LeaderList[1]=="<Cancel>") return
				SelectionList-=LeaderList[1]

				// Select leader 2
				LeaderList[2] = input("Please designate a key.")in SelectionList+"<Cancel>"
				if(LeaderList[2]=="<Cancel>") return
				SelectionList-=LeaderList[2]

				// Select leader 3
				LeaderList[3] = input("Please designate a key.")in SelectionList+"<Cancel>"
				if(LeaderList[3]=="<Cancel>") return
				SelectionList-=LeaderList[3]

				// Select leader 4
				LeaderList[4] = input("Please designate a key.")in SelectionList+"<Cancel>"
				if(LeaderList[4]=="<Cancel>") return
				SelectionList-=LeaderList[4]

				var/playerlife=input("Input an amount for the VIP's HP.","HP",1500)
				for(var/mob/Entities/Player/C)
					if(LeaderList.Find(C.key))
						C.mlife=round(playerlife)
						if(C.mlife<1500) C.mlife=1500
						if(C.mlife>15000) C.mlife=15000
						C.life=C.mlife
						C.Attack*=3
						C.Update()
						del TeamLeaders
						for(var/i in LeaderList)
							TeamLeaders += LeaderList[i]
						if(C.key==LeaderList[1])
							C.Stats[c_Team]="Red"
							if(C.Dead!=1)
								for(var/X in typesof(/obj/Characters/Team)) C.overlays-=X
								C.overlays+=new /obj/Characters/Team/red
						else if(C.key==LeaderList[2])
							C.Stats[c_Team]="Blue"
							if(C.Dead!=1)
								for(var/X in typesof(/obj/Characters/Team)) C.overlays-=X
								C.overlays+=new /obj/Characters/Team/blue
						else if(C.key==LeaderList[3])
							C.Stats[c_Team]="Yellow"
							if(C.Dead!=1)
								for(var/X in typesof(/obj/Characters/Team)) C.overlays-=X
								C.overlays+=new /obj/Characters/Team/yellow
						else if(C.key==LeaderList[4])
							C.Stats[c_Team]="Green"
							if(C.Dead!=1)
								for(var/X in typesof(/obj/Characters/Team)) C.overlays-=X
								C.overlays+=new /obj/Characters/Team/green
					else
						if(C.Playing==1)
							Randomize_Teams(C)
							Return_Players(C)
				activeTeams.Add("Red", "Blue", "Green", "Yellow")
				set_WorldStatus(c_Mode,"Assassination")
				Announce("World Mode changed to [get_WorldStatus(c_Mode)]!")
				Announce("[LeaderList[1]] has been designated as the Red Leader.")
				Announce("[LeaderList[2]] has been designated as the Blue Leader.")
				Announce("[LeaderList[3]] has been designated as the Yellow Leader.")
				Announce("[LeaderList[4]] has been designated as the Green Leader.")
			if("Neutral Flag")
				Mode_Reset()
				EventKillLimit = input("Input a number for Score Limit","Limiter",15)
				EventKillLimit=round(EventKillLimit)
				if(EventKillLimit>25) EventKillLimit=25
				if(EventKillLimit<5) EventKillLimit=5
				for(var/mob/Entities/Player/B in world)
					Return_Players(B)
					B.Stats[c_Team]="N/A"
					B.subkills=0
				set_WorldStatus(c_Mode,"Neutral Flag")
				Announce("World Mode changed to [get_WorldStatus(c_Mode)]!  Scores Reset!")
				Announce("Reach [EventKillLimit] points to win!")
				ActionUse[INV]=1
				Announce("Invisible Use Auto-Disabled")
				Flag_Respawn()

			if("Capture The Flag")
				Mode_Reset()

				TeamLocked[c_YELLOW]=1
				TeamLocked[c_GREEN]=1
				EventKillLimit = input("Input a number for Score Limit","Score Limit",20)
				EventKillLimit=round(EventKillLimit)
				if(EventKillLimit>30) EventKillLimit=30
				if(EventKillLimit<15) EventKillLimit=15
				set_WorldStatus(c_Mode,"Capture The Flag")
				for(var/mob/Entities/Player/B in world)
					if(B.Playing==1)
						Return_Players(B)
						Randomize_Teams(B)
				set_WorldStatus(c_Mapname, "Warzone")
				new /obj/Flags/Red(locate(47,22,10))
				new /obj/Flags/Blue(locate(53,22,10))
				Announce("World Mode changed to [get_WorldStatus(c_Mode)]!  Scores Reset!")
				ActionUse[INV]=1
				Announce("Invisible Use Auto-Disabled")
			#if TOURNAMENT
			if("Tournament")
				var/list/Participants = list()
				for(var/mob/Entities/Player/P in world)
					if(P.client.inacitivity > 400 || P.Playing != 1) continue
					switch(alert(M, "Do you wish to enter the tournament?", "Invite", "Yes", "No"))
						if("Yes")
							Participants+="[P.key]"
							Participants["[P.key]"] = P.key
						if("No")
							continue
			#endif
			if("Juggernaut") // Regular player with 2x HP
				switch(input("Start Juggernaut?", "Confirmation", "No")in list("Yes", "No"))
					if("No") return

				Mode_Reset()
				var/list/Selection = list()
				for(var/mob/Entities/Player/P in world)
					if(P.Playing != 1 || P.client.inactivity > c_INACTIVE) continue
					Selection+=P.key
				var/Jugger = Selection[rand(1, Selection.len)]
				EventKillLimit = input("Input a kill limit for Juggernaut.","Limiter",50)
				EventKillLimit=round(EventKillLimit)
				if(EventKillLimit < 50) EventKillLimit=50
				if(EventKillLimit > 100) EventKillLimit=100
				for(var/mob/Entities/Player/A in world)
					if(A.Playing == 1)
						A.Stats[c_Team] = "N/A"
						Return_Players(A)
						if(A.key == Jugger)
							ModeTarget=Jugger
							A.Stats[c_Team]="Blue"
							if(A.Dead!=1)
								for(var/X in typesof(/obj/Characters/Team)) A.overlays-=X
								A.overlays+=new /obj/Characters/Team/blue
							A.mlife=(A.mlife*2)
							A.life=A.mlife
							A.Update()
							Announce("[A.key] has been designated as the Juggernaut.")

				set_WorldStatus(c_Mode,"Juggernaut")
				Announce("World Mode changed to [get_WorldStatus(c_Mode)]!  Scores Reset!")
			if("Berserker") // Regular player with x2 Attack, HP drain and has to kill to restore HP.
				switch(input("Start Berserker?", "Confirmation", "No")in list("Yes", "No"))
					if("No") return

				Mode_Reset()
				var/list/Selection = list()
				for(var/mob/Entities/Player/P in world)
					if(P.Playing != 1 || P.client.inactivity > c_INACTIVE) continue
					Selection+=P.key
				var/Berserk = Selection[rand(1, Selection.len)]

				EventKillLimit = input("Input a kill limit for Berserker.","Limiter",75)
				EventKillLimit=round(EventKillLimit)
				if(EventKillLimit < 75) EventKillLimit=75
				if(EventKillLimit > 150) EventKillLimit=150
				for(var/mob/Entities/Player/A in world)
					if(A.Playing == 1)
						A.Stats[c_Team] = "N/A"
						Return_Players(A)
						if(A.key == Berserk)

							ModeTarget=Berserk
							A.Stats[c_Team]="Blue"
							if(A.Dead!=1)
								for(var/X in typesof(/obj/Characters/Team)) A.overlays-=X
								A.overlays+=new /obj/Characters/Team/blue
							A.life=A.mlife
							A.Attack=(A.Attack*2)
							A.Update()
							Announce("[A.key] has been designated as the Berserker.")
				set_WorldStatus(c_Mode,"Berserker")
				Announce("World Mode changed to [get_WorldStatus(c_Mode)]!  Scores Reset!")
			if("Survival") // Regular player with x2 Attack, HP drain and has to kill to restore HP.
				Mode_Reset()
				for(var/i = playerList.len, i > 0, --i)
					playerList-=playerList[i]
				for(var/i = playerEvent.len, i > 0, --i)
					playerEvent-=playerEvent[i]
				for(var/mob/Entities/Player/P in world)
					NULL_C(P)
					if(P.Playing != 1 || P.client.inactivity >= c_INACTIVE) continue
					playerList+=P.key
					playerEvent += P.key
				var/Lives = input("How many lives shall the players have?", "Lives", 5) as num
				if(Lives == -1) return
				if(Lives < 1) Lives = 1
				if(Lives > 100) Lives = 100
				var/NewMap=input("Choose a map","Map",g_listofMaps[1])in g_listofMaps + "<Cancel>"

				if(NewMap != "<Cancel>")
					set_WorldStatus(c_vMapname, NewMap)
					for(var/mob/Entities/Player/A in world)
						if(isnull(A)) continue
						Return_Players(A)
						for(var/X in typesof(/obj/Characters/Team)) A.overlays-=X
						A.Stats[c_Team] = "N/A"
						A.playerLives = Lives
					for(var/i = 1 to 7)
						TeamLocked[i]=1
					set_WorldStatus(c_Mode, "Survival")
					Announce("World Mode changed to [get_WorldStatus(c_Mode)]!  Scores Reset!")

			if("Double Kill")
				Mode_Reset()

				EventKillLimit = input("Input a number for Double Kill kill limit","Limiter",25)
				EventKillLimit=round(EventKillLimit)
				if(EventKillLimit>100) EventKillLimit=100
				if(EventKillLimit<10) EventKillLimit=10
				for(var/mob/Entities/Player/B in world)
					Return_Players(B)
					B.Stats[c_Team]="N/A"
					B.subkills=0
				KillMultiplier = 2
				set_WorldStatus(c_Mode, "Double Kill")
				Announce("World Mode changed to [get_WorldStatus(c_Mode)]!  Scores Reset!")
				Announce("Double Kill kill Limit of [EventKillLimit]")

		World_Status(get_WorldStatus(c_Mode), get_WorldStatus(c_Mapname))
		WorldLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has changed the world mode to [get_WorldStatus(c_Mode)].<br></font>")
	World_Damage()
		switch(get_WorldStatus(c_Mode))
			if("Protect The Base","Advanced Protect The Base")
				return
		switch(input("Select a Setting" , "Damage Setting", DamageSetting) in list ("High","Medium","Low","Insane","Cancel"))
			if("High")
				Multiplier=3
				DamageSetting="High"
			if("Medium")
				Multiplier=2
				DamageSetting="Medium"
			if("Low")
				Multiplier=1
				DamageSetting="Low"
			if("Insane")
				Multiplier=28
				DamageSetting="Insane"
				if(ActionUse[AOE]==0) ActionUse[AOE]=1
				Announce("Area Effect Use disabled.")
		Announce("Damage Setting has been changed to [DamageSetting]!")
		WorldLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has changed the world damage to [DamageSetting].<br></font>")
	World_Map()

		if(Invalid_Map_Change() == 1) return
		var/NewMap=input("Choose a map","Map", get_WorldStatus(c_Mapname))in g_listofMaps + "<Cancel>"

		//	Return_Players(A)
		#ifdef INCLUDED_AI_DM
		for(var/mob/Entities/AIs/A)
			sleep(1)
			del A
		#endif
		if(NewMap != "<Cancel>")
			set_WorldStatus(c_Mapname, NewMap)
			World_Status(get_WorldStatus(c_Mode), get_WorldStatus(c_Mapname))
			Announce("Map has been changed to <font color=green><u>[NewMap]!")
			WorldLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has changed the world map to [NewMap].<br></font>")
			for(var/obj/Drops/O in world)
				spawn(1) del O
			for(var/mob/Entities/Player/A)
				if(A.key=="HolyDoomKnight") continue
				if(A.playerLives > 0) continue
				if(A.Dead == 0 && A.Playing == 1)
					Map_Location(A)
	World_Door()
		var/S = input(src,"Enter the door number.","Open/Close Door") as null|num
		for(var/obj/Switches/Door/D)
			spawn(1)
			if(D.DoorNumber==S)
				if(D.icon_state=="closed"){D.density=0;flick("opening",D);D.icon_state="open";return}
				if(D.icon_state=="open"){D.density=1;flick("closing",D);D.icon_state="closed";return}
	World_Mute()
		switch(g_Chat)
			if(1)
				g_Chat=0
				Announce("World has been unmuted!")
				MiscLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has unmuted the World.<br></font>")
				return
			if(0)
				g_Chat=1
				Announce("World has been muted!")
				MiscLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has muted the World.<br></font>")
				return
	World_Restart()
		if(rebooting)
			info(,world,"Reboot cancelled.")
			rebooting = 0
			return
		var/countdown = input("How long until a reboot? (In Seconds, enter -1 to cancel, 0 to reboot now)")as num
		if(countdown>6048000) countdown=6048000
		var
			list/reboot_total_time = list("hours"=0,"minutes"=0,"seconds"=0)
			count_duplicate
		if(countdown == -1) return
		if(countdown != -1 && countdown <= 0) countdown = 1
		if(alert(src,"Reboot the world?","World reboot","Yes","No") == "Yes")
			count_duplicate = countdown
			while(count_duplicate >= 60)
				++reboot_total_time["minutes"]
				if(reboot_total_time["minutes"] >= 60)
					++reboot_total_time["hours"]
					reboot_total_time["minutes"] = 0
				count_duplicate -= 60
			if(count_duplicate) reboot_total_time["seconds"]+= count_duplicate
			info(,world,"World is rebooting in [reboot_total_time["hours"]] hour\s, [reboot_total_time["minutes"]] minute\s, and [reboot_total_time["seconds"]] second\s.")
			MiscLog("[time2text(world.realtime,"hh:mm:ss")] [src.key] is rebooting the server.<br></font>")
			rebooting = 1
			while(rebooting && countdown)
				sleep(10)
				--countdown
				if(countdown == 10) info(,world,"World is rebooting in 10 seconds.")
				if(countdown <= 1) world.Reboot()
			rebooting = 0
	World_Close()
		if(shutting_down)
			info(,world,"Shutdown cancelled.")
			shutting_down = 0
			shutdown_time = 0
			return
		var/countdown = input("How long until the shutdown?")as num
		if(countdown>6048000) countdown=6048000
		var
			count_dupe
			list/reboot_total_time = list("hours"=0,"minutes"=0,"seconds"=0)
		if(alert(src,"Are you SURE that you want to do this?","World shutdown","Yes","No")=="Yes")
			count_dupe = countdown
			while(count_dupe >= 60)
				++reboot_total_time["minutes"]
				if(reboot_total_time["minutes"] >= 60)
					++reboot_total_time["hours"]
					reboot_total_time["minutes"] = 0
				count_dupe -= 60
			if(count_dupe) reboot_total_time["seconds"] += count_dupe
			info(,world,"World is shutting down in [reboot_total_time["hours"]] hour\s, [reboot_total_time["minutes"]] minute\s, and [reboot_total_time["seconds"]] second\s.")
			shutting_down = 1
			MiscLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has shutdown the server.<br></font>")
			while(shutting_down && countdown)
				sleep(10)
				countdown--
				if(countdown == 10) info(,world,"World is shutting down in 10 seconds.")
				if(countdown <= 1)
					shutting_down = 0
					world.Del()
				shutdown_time = countdown
			shutting_down = 0

	World_Delete()
		var/list/DeleteList=list("Censor","Chart","World")
		var/Deleting = input("What are you gonna delete?","Deletion")in DeleteList + "<Cancel>"
		if(Deleting == "<Cancel>") return
		switch(Deleting)

			if("Censor")
				var/Check=input("Are you sure you wish to delete [Deleting]?","Prompt","No")in list("Yes","No")
				if(Check=="Yes")
					Delete[1]=1
					return
				else
					Delete[1]=0
					return
			if("Chart")
				var/Check=input("Are you sure you wish to delete [Deleting]?","Prompt","No")in list("Yes","No")
				if(Check=="Yes")
					if(fexists("saves/chart.sav")) fdel("saves/chart.sav")
					usr<<"Chart deleted"
			if("World")
				var/Check=input("Are you sure you wish to delete [Deleting]?","Prompt","No")in list("Yes","No")
				if(Check=="Yes")
					Delete[2]=1
					return
				else
					Delete[2]=0
					return
/*
	World_Teams()
		if(!isSAdmin(usr)&&WorldMode!="Battle") return
		var/list/TeamsList=list("Red [TeamLocked[c_RED]]","Blue [TeamLocked[c_BLUE]]","Yellow [TeamLocked[c_YELLOW]]","Green [TeamLocked[c_GREEN]]","Purple [TeamLocked[c_SILVER]]","Silver [TeamLocked[c_PURPLE]]","Neutral [TeamLocked[c_NEUTRAL]]")
		var/TeamLocking = input("Which team do you wish to lock?","Team Lock")in TeamsList + "<Cancel>"
		if(TeamLocking == "<Cancel>") return
		if(TeamLocking == "Red [TeamLocked[c_RED]]")
			if(TeamLocked[c_RED]==0)
				TeamLocked[c_RED]=1
				Announce("Red Team Disabled")
				for(var/mob/Entities/Player/B)
					if(B.Stats[c_Team]=="Red") Randomize_Teams(B)
				DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled Red Team.<br></font>")
			else
				TeamLocked[c_RED]=0
				Announce("Red Team Enabled")
				DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled Red Team.<br></font>")
		if(TeamLocking == "Blue [TeamLocked[c_BLUE]]")
			if(TeamLocked[c_BLUE]==0)
				TeamLocked[c_BLUE]=1
				Announce("Blue Team Disabled")
				for(var/mob/Entities/Player/B)
					if(B.Stats[c_Team]=="Blue") Randomize_Teams(B)
				DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled Blue Team.<br></font>")
			else
				TeamLocked[c_BLUE]=0
				Announce("Blue Team Enabled")
				DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled Blue Team.<br></font>")
		if(TeamLocking == "Yellow [TeamLocked[c_YELLOW]]")
			if(TeamLocked[c_YELLOW]==0)
				TeamLocked[c_YELLOW]=1
				Announce("Yellow Team Disabled")
				for(var/mob/Entities/Player/B)
					if(B.Stats[c_Team]=="Yellow") Randomize_Teams(B)
				DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled Yellow Team.<br></font>")
			else
				TeamLocked[c_YELLOW]=0
				Announce("Yellow Team Enabled")
				DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled Yellow Team.<br></font>")
		if(TeamLocking == "Green [TeamLocked[c_GREEN]]")
			if(TeamLocked[c_GREEN]==0)
				TeamLocked[c_GREEN]=1
				Announce("Green Team Disabled")
				for(var/mob/Entities/Player/B)
					if(B.Stats[c_Team]=="Green") Randomize_Teams(B)
				DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled Green Team.<br></font>")
			else
				TeamLocked[c_GREEN]=0
				Announce("Green Team Enabled")
				DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled Green Team.<br></font>")
		if(TeamLocking == "Purple [TeamLocked[c_SILVER]]")
			if(TeamLocked[c_PURPLE]==0)
				TeamLocked[c_PURPLE]=1
				Announce("Purple Team Disabled")
				for(var/mob/Entities/Player/B)
					if(B.Stats[c_Team]=="Purple") Randomize_Teams(B)
				DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled Purple Team.<br></font>")
			else
				TeamLocked[c_PURPLE]=0
				Announce("Purple Team Enabled")
				DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled Purple Team.<br></font>")
		if(TeamLocking == "Silver [TeamLocked[c_PURPLE]]")
			if(TeamLocked[c_SILVER]==0)
				TeamLocked[c_SILVER]=1
				Announce("Silver Team Disabled")
				for(var/mob/Entities/Player/B)
					if(B.Stats[c_Team]=="Silver") Randomize_Teams(B)
				DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled Silver Team.<br></font>")
			else
				TeamLocked[c_SILVER]=0
				Announce("Silver Team Enabled")
				DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled Silver Team.<br></font>")
		if(TeamLocking == "Neutral [TeamLocked[c_NEUTRAL]]")
			if(TeamLocked[c_NEUTRAL]==0)
				TeamLocked[c_NEUTRAL]=1
				Announce("Neutral Team Disabled")
				for(var/mob/Entities/Player/B)
					if(B.Stats[c_Team]=="N/A") Randomize_Teams(B)
				DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled Neutral Team.<br></font>")
			else
				TeamLocked[c_NEUTRAL]=0
				Announce("Neutral Team Enabled")
				DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled Neutral Team.<br></font>")
*/
/*
	World_Actions()
		var/list/Disable=list("Area Effects [ActionUse[AOE]]","Melee [ActionUse[MEL]]","Invisible [ActionUse[INV]]","Guns [ActionUse[GUN]]","Dash [ActionUse[DSH]]","Guard [ActionUse[GRD]]","Heal [ActionUse[HEL]]")
		if(!isModerator(src)&&!isAdmin(src)&&!isSAdmin(src)){info(,list(src),"You cannot do this.");return}
		var/Disabled = input("Note: 1 means disabled, 0 means enabled","Enable/Disable which character(s)?")in Disable + "<Cancel>"
		if(Disabled=="Area Effects [ActionUse[AOE]]")
			if(ActionUse[AOE]==0)
				ActionUse[AOE]=1
				Announce("Area Effect Use disabled.")
				DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled Area Effect Use.<br></font>")
			else
				if(DamageSetting!="Insane")
					ActionUse[AOE]=0
					Announce("Area Effect Use enabled.")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled Area Effect Use.<br></font>")
		if(Disabled=="Melee [ActionUse[MEL]]")
			if(ActionUse[MEL]==0)
				ActionUse[MEL]=1
				Announce("Melee use disabled.")
				DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled Melee Use.<br></font>")
			else
				ActionUse[MEL]=0
				Announce("Melee use enabled.")
				DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled Melee Use.<br></font>")
		if(Disabled=="Invisible [ActionUse[INV]]")
			if(WorldMode!="Neutral Flag"&&WorldMode!="Capture The Flag")
				if(ActionUse[INV]==0)
					ActionUse[INV]=1
					Announce("Invisible Use disabled.")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled Invisible Use.<br></font>")
				else
					ActionUse[INV]=0
					Announce("Invisible Use enabled.")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled Invisible Use.<br></font>")
			else usr<<"<b>This is auto-disabled for this mode."
		if(Disabled=="Guns [ActionUse[GUN]]")
			if(ActionUse[GUN]==0)
				ActionUse[GUN]=1
				Announce("Gun Use disabled.")
				DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled Gun Use.<br></font>")
			else
				ActionUse[GUN]=0
				Announce("Gun Use enabled.")
				DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled Gun Use.<br></font>")
		if(Disabled=="Dash [ActionUse[DSH]]")
			if(ActionUse[DSH]==0)
				ActionUse[DSH]=1
				Announce("Dash Use disabled.")
				DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled Dash Use.<br></font>")
			else
				ActionUse[DSH]=0
				Announce("Dash Use enabled.")
				DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled Dash Use.<br></font>")
		if(Disabled=="Guard [ActionUse[GRD]]")
			if(ActionUse[GRD]==0)
				ActionUse[GRD]=1
				Announce("Guard Use disabled.")
				DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled Guard Use.<br></font>")
			else
				ActionUse[GRD]=0
				Announce("Guard Use enabled.")
				DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled Guard Use.<br></font>")
		if(Disabled=="Heal [ActionUse[HEL]]")
			if(ActionUse[HEL]==0)
				ActionUse[HEL]=1
				Announce("Heal Use disabled.")
				DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled Heal Use.<br></font>")
			else
				ActionUse[HEL]=0
				Announce("Heal Use enabled.")
				DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled Heal Use.<br></font>")
			*/
	World_Characters()
		var/list/Disable=list("Area Effects [CharUse[c_AOE]]","Team-Based [CharUse[c_TEAMBASED]]","Invisible [CharUse[c_INVISIBLE]]","Classic [CharUse[c_MEGAMAN]]","X [CharUse[c_X]]","Zero [CharUse[c_ZERO]]", "Specific")
		if(!isModerator(src)&&!isAdmin(src)&&!isSAdmin(src)){info(,list(src),"You cannot do this.");return}
		var/Disabled
		if(!isOwner(src)) Disabled = input("Note: 1 means disabled, 0 means enabled","Enable/Disable which character(s)?")in Disable + "<Cancel>"
		else Disabled = input("Note: 1 means disabled, 0 means enabled","Enable/Disable which character(s)?")in Disable + "Customs [CharUse[c_CUSTOM]]" + "Starters Only [CharUse[c_STARTERS]]" + "<Cancel>"

		if(Disabled=="Area Effects [CharUse[c_AOE]]")
			if(CharUse[c_AOE]==0&&CharUse[c_STARTERS]==0)
				CharUse[c_AOE]=1
				for(var/mob/Entities/Player/M)
					if(M.Disabled[2]==1) Death(M)
				Announce("Area Effect Characters disabled.")
				DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled Area Effect Characters.<br></font>")
			else if(CharUse[c_AOE]==1&&CharUse[c_STARTERS]==0)
				CharUse[c_AOE]=0
				Announce("Area Effect Characters enabled.")
				DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled Area Effect Characters.<br></font>")
			else usr<<"<b>Cannot be done while Starters Only enabled."
		if(Disabled=="Team-Based [CharUse[c_TEAMBASED]]")
			if(CharUse[c_TEAMBASED]==0&&CharUse[c_STARTERS]==0)
				CharUse[c_TEAMBASED]=1
				for(var/mob/Entities/Player/M)
					if(M.Disabled[3]==1) Death(M)
				Announce("Team Based Characters disabled.")
				DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled Team-Based Characters.<br></font>")
			else if(CharUse[c_TEAMBASED]==1&&CharUse[c_STARTERS]==0)
				CharUse[c_TEAMBASED]=0
				Announce("Team Based Characters enabled.")
				DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled Team-Based Characters.<br></font>")
			else usr<<"<b>Cannot be done while Starters Only enabled."
		if(Disabled=="Invisible [CharUse[c_INVISIBLE]]")
			if(CharUse[c_INVISIBLE]==0&&CharUse[c_STARTERS]==0)
				CharUse[c_INVISIBLE]=1
				for(var/mob/Entities/Player/M)
					if(M.Disabled[1]==1) Death(M)
				Announce("Invisible Characters disabled.")
				DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled Invisible Characters.<br></font>")
			else if(CharUse[c_INVISIBLE]==1&&CharUse[c_STARTERS]==0)
				CharUse[c_INVISIBLE]=0
				Announce("Invisible Characters enabled.")
				DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled Invisible Characters.<br></font>")
			else usr<<"<b>Cannot be done while Starters Only enabled."
		if(Disabled=="Classic [CharUse[c_MEGAMAN]]")
			if(CharUse[c_MEGAMAN]==0&&CharUse[c_STARTERS]==0)
				CharUse[c_MEGAMAN]=1
				for(var/mob/Entities/Player/M)
					if(M.Disabled[c_MEGAMAN]==1) Death(M)
				Announce("Classic Series disabled.")
				DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled Classc Characters.<br></font>")
			else if(CharUse[c_MEGAMAN]==1&&CharUse[c_STARTERS]==0)
				CharUse[c_MEGAMAN]=0
				Announce("Classic Series enabled.")
				DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled Classc Characters.<br></font>")
			else usr<<"<b>Cannot be done while Starters Only enabled."
		if(Disabled=="X [CharUse[c_X]]")
			if(CharUse[c_X]==0&&CharUse[c_STARTERS]==0)
				CharUse[c_X]=1
				for(var/mob/Entities/Player/M)
					if(M.Disabled[c_X]==1) Death(M)
				Announce("X Series disabled.")
				DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled X Characters.<br></font>")
			else if(CharUse[c_X]==1&&CharUse[c_STARTERS]==0)
				CharUse[c_X]=0
				Announce("X Series enabled.")
				DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled X Characters.<br></font>")
			else usr<<"<b>Cannot be done while Starters Only enabled."
		if(Disabled=="Zero [CharUse[c_ZERO]]")
			if(CharUse[c_ZERO]==0&&CharUse[c_STARTERS]==0)
				CharUse[c_ZERO]=1
				for(var/mob/Entities/Player/M)
					if(M.Disabled[c_ZERO]==1) Death(M)
				Announce("Zero Series disabled.")
				DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled Zero Characters.<br></font>")
			else if(CharUse[c_ZERO]==1&&CharUse[c_STARTERS]==0)
				CharUse[c_ZERO]=0
				Announce("Zero Series enabled.")
				DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled Zero Characters.<br></font>")
			else usr<<"<b>Cannot be done while Starters Only enabled."
		if(Disabled=="Customs [CharUse[c_CUSTOM]]")
			if(CharUse[c_CUSTOM]==0&&CharUse[c_STARTERS]==0)
				CharUse[c_CUSTOM]=1
				for(var/mob/Entities/Player/M)
					if(M.Disabled[c_CUSTOM]==1) Death(M)
				Announce("Customs disabled.")
				DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled Custom Characters.<br></font>")

			else if(CharUse[c_CUSTOM]==1&&CharUse[c_STARTERS]==0)
				CharUse[c_CUSTOM]=0
				Announce("Customs enabled.")
				DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled Custom Characters.<br></font>")

			else usr<<"<b>Cannot be done while Starters Only enabled."
		if(Disabled=="Starters Only [CharUse[c_STARTERS]]")
			if(CharUse[c_STARTERS]==0)
				CharUse[c_STARTERS]=1
				for(var/mob/Entities/Player/M in world)
					spawn()
					for(var/i = 1 to 7)
						sleep(1)
						if(M.Disabled[i] == 1)
							Death(M)
				for(var/o = 1 to 7)
					sleep(1)
					CharUse[o]=1
				Announce("Starters Only Enabled")
				DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled Starter Only Mode.<br></font>")
			else
				CharUse[c_STARTERS]=0
				for(var/o = 1 to 7)
					sleep(1)
					CharUse[o]=0
				Announce("Starters Only disabled.")
				DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled Starter Only Mode.<br></font>")
		if(Disabled=="Specific")
			switch(input("Enabling or disabling?" ,"Enable/Disable characters") in list("Enable", "Disable", "<Cancel>"))
				if("Enable")
					var/enableChar = input("Enable which characters?", "Enable Characters") in listofDisabled + "<Cancel>"
					if(enableChar != "<Cancel>")
						listofCharacters += enableChar
						listofDisabled -= enableChar
						Announce("[enableChar] enabled")
						DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled [enableChar].<br></font>")
				if("Disable")
					var/disableChar = input("Disable which characters?", "Disable Characters") in listofCharacters + "<Cancel>"
					if(disableChar != "<Cancel>")
						listofDisabled += disableChar
						listofCharacters -= disableChar
						for(var/mob/Entities/Player/M in world)
							if(M.Class == disableChar)
								Death(M)
						Announce("[disableChar] disabled")
						DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled [disableChar].<br></font>")
				if("<Cancel>") return

		/*
			var/list/SDisable=list(
			"X [SCharDisabled[c_MMX]]",					"MMXZero [SCharDisabled[c_MMXZero]]",				"Axl [SCharDisabled[c_Axl]]",
			"Double [SCharDisabled[c_Double]]",				"Dynamo [SCharDisabled[c_Dynamo]]",				"Gate [SCharDisabled[c_Gate]]",
			"Sigma [SCharDisabled[c_Sigma]]",					"Vile [SCharDisabled[c_Vile]]", 					"Magma Dragoon [SCharDisabled[c_Magma]]",
			"Duo [SCharDisabled[c_Duo]]", 					"Grenademan [SCharDisabled[c_Grenademan]]", 			"Cutman [SCharDisabled[c_Cutman]]",
			"Shadowman [SCharDisabled[c_Shadowman]]", 			"Met [SCharDisabled[c_Met]]", 					"Tenguman [SCharDisabled[c_Tenguman]]",
			"Zanzibar [SCharDisabled[c_Zanzibar]]", 				"Commander X [SCharDisabled[c_CX]]", 			"Commander Zero [SCharDisabled[c_CZ]]",
			"Elpizo [SCharDisabled[c_Elpizo]]", 				"Harpuia [SCharDisabled[c_Harpuia]]", 				"Fefnir [SCharDisabled[c_Fefnir]]",
			"Phantom [SCharDisabled[c_Phantom]]", 				"Leviathen [SCharDisabled[c_Leviathen]]", 			"Omega [SCharDisabled[c_Omega]]",
			"Blizzard Wolfang [SCharDisabled[c_Wolfang]]",		"Infinity Mijinion [SCharDisabled[c_Mijinion]]", 	"Colonel [SCharDisabled[c_Colonel]]",
			"Purestrain Zero [SCharDisabled[c_PZero]]",		"Heatnix [SCharDisabled[c_Heatnix]]", 				"Nightmare Zero [SCharDisabled[c_NZero]]",
			"Shadow Armor X [SCharDisabled[c_SAX]]",		"Shield Shelldon [SCharDisabled[c_Shelldon]]", 		"Command Mission X [SCharDisabled[c_CMX]]",
			"Anubis [SCharDisabled[c_Anubis]]",				"Chilldre [SCharDisabled[c_Chilldre]]", 			"Kraft [SCharDisabled[c_Kraft]]",
			"Shadowman EXE [SCharDisabled[c_ShadowmanEXE]]",		"Weil [SCharDisabled[c_Weil]]", 				"Xeron [SCharDisabled[c_Xeron]]",
			"Medic [SCharDisabled[c_Medic]]", 				"Darkguise [SCharDisabled[c_Darkguise]]",			"Foxtar [SCharDisabled[c_Foxtar]]",
			"Swordman [SCharDisabled[c_Swordman]]", 			"Knightman [SCharDisabled[c_Knightman]]",			"Clownman [SCharDisabled[c_Clownman]]",
			"Burnerman [SCharDisabled[c_Burnerman]]", 			"Beat [SCharDisabled[c_Beat]]",					"Athena [SCharDisabled[c_Athena]]",
			"Sniper Joe X [SCharDisabled[c_SJX]]", 		"Model S [SCharDisabled[c_ModelS]]",				"Legendary Warrior X [SCharDisabled[c_LWX]]",
			"Plague [SCharDisabled[c_Plague]]", 				"Green Biker Dude [SCharDisabled[c_GBD]]",		"Purestrain X [SCharDisabled[c_PSX]]",
			"Valnaire [SCharDisabled[c_Valnaire]]", 			"Falcon Armor X [SCharDisabled[c_FAX]]",		"Model C [SCharDisabled[c_ModelC]]",
			"MG400 [SCharDisabled[c_MG400]]", 				"King [SCharDisabled[c_King]]", 				"DrWily [SCharDisabled[60]]",
			"XeronII [SCharDisabled[c_XeronII]]", 				"Eddie [SCharDisabled[c_Eddie]]", 				"Panther Fauclaw [SCharDisabled[c_Fauclaw]]",
			"Woodman [SCharDisabled[c_Woodman]]",				"GAX [SCharDisabled[c_GAX]]",				"Magicman [SCharDisabled[c_Magicman]]",
			"Hanu Machine [SCharDisabled[c_Hanu]]",		"Air Pantheon [SCharDisabled[c_Pantheon]]",		"Model BD [SCharDisabled[c_ModelBD]]",
			"Model Gate [SCharDisabled[c_ModelGate]]")

			var/SDisabled = input("Note: 1 means disabled, 0 means enabled","Enable/Disable which character?")in SDisable  + "<Cancel>"
			if(SDisabled == "X [SCharDisabled[c_MMX]]")
				if(SCharDisabled[c_MMX]==0)
					SCharDisabled[c_MMX]=1
					for(var/mob/Entities/Player/M in world)
						if(M.Class == "X") Death(M)
					Announce("X disabled")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled X.<br></font>")
				else
					SCharDisabled[c_MMX]=0
					Announce("X enabled.")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled X.<br></font>")

			if(SDisabled == "MMXZero [SCharDisabled[c_MMXZero]]")
				if(SCharDisabled[c_MMXZero]==0)
					SCharDisabled[c_MMXZero]=1
					for(var/mob/Entities/Player/M in world)
						if(M.Class == "MMXZero") Death(M)
					Announce("MMXZero disabled")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled MMXZero.<br></font>")
				else
					SCharDisabled[c_MMXZero]=0
					Announce("MMXZero enabled.")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled MMXZero.<br></font>")
			if(SDisabled == "Axl [SCharDisabled[c_Axl]]")
				if(SCharDisabled[c_Axl]==0)
					SCharDisabled[c_Axl]=1
					for(var/mob/Entities/Player/M in world)
						if(M.Class == "Axl") Death(M)
					Announce("Axl disabled")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled Axl.<br></font>")
				else
					SCharDisabled[c_Axl]=0
					Announce("Axl enabled.")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled Axl.<br></font>")
			if(SDisabled == "Double [SCharDisabled[c_Double]]")
				if(SCharDisabled[c_Double]==0)
					SCharDisabled[c_Double]=1
					for(var/mob/Entities/Player/M in world)
						if(M.Class == "Double") Death(M)
					Announce("Double disabled")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled Double.<br></font>")
				else
					SCharDisabled[c_Double]=0
					Announce("Double enabled.")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled Double.<br></font>")
			if(SDisabled == "Dynamo [SCharDisabled[c_Dynamo]]")
				if(SCharDisabled[c_Dynamo]==0)
					SCharDisabled[c_Dynamo]=1
					for(var/mob/Entities/Player/M in world)
						if(M.Class == "Dynamo") Death(M)
					Announce("Dynamo disabled")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled Dynamo.<br></font>")
				else
					SCharDisabled[c_Dynamo]=0
					Announce("Dynamo enabled.")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled Dynamo.<br></font>")
			if(SDisabled == "Gate [SCharDisabled[c_Gate]]")
				if(SCharDisabled[c_Gate]==0)
					SCharDisabled[c_Gate]=1
					for(var/mob/Entities/Player/M in world)
						if(M.Class == "Gate") Death(M)
					Announce("Gate disabled")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled Gate.<br></font>")
				else
					SCharDisabled[c_Gate]=0
					Announce("Gate enabled.")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled Gate.<br></font>")
			if(SDisabled == "Sigma [SCharDisabled[c_Sigma]]")
				if(SCharDisabled[c_Sigma]==0)
					SCharDisabled[c_Sigma]=1
					for(var/mob/Entities/Player/M in world)
						if(M.Class == "Sigma") Death(M)
					Announce("Sigma disabled")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled Sigma.<br></font>")
				else
					SCharDisabled[c_Sigma]=0
					Announce("Sigma enabled.")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled Sigma.<br></font>")
			if(SDisabled == "Vile [SCharDisabled[c_Vile]]")
				if(SCharDisabled[c_Vile]==0)
					SCharDisabled[c_Vile]=1
					for(var/mob/Entities/Player/M in world)
						if(M.Class == "Vile") Death(M)
					Announce("Vile disabled")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled Vile.<br></font>")
				else
					SCharDisabled[c_Vile]=0
					Announce("Vile enabled.")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled Vile.<br></font>")
			if(SDisabled == "Magma Dragoon [SCharDisabled[c_Magma]]")
				if(SCharDisabled[c_Magma]==0)
					SCharDisabled[c_Magma]=1
					for(var/mob/Entities/Player/M in world)
						if(M.Class == "Magma") Death(M)
					Announce("Magma Dragoon disabled")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled Magma Dragoon.<br></font>")
				else
					SCharDisabled[c_Magma]=0
					Announce("Magma Dragoon enabled.")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled Magma Dragoon.<br></font>")
			if(SDisabled == "Duo [SCharDisabled[c_Duo]]")
				if(SCharDisabled[c_Duo]==0)
					SCharDisabled[c_Duo]=1
					for(var/mob/Entities/Player/M in world)
						if(M.Class == "Duo") Death(M)
					Announce("Duo disabled")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled Duo.<br></font>")
				else
					SCharDisabled[c_Duo]=0
					Announce("Duo enabled.")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled Duo.<br></font>")
			if(SDisabled == "Grenademan [SCharDisabled[c_Grenademan]]")
				if(SCharDisabled[c_Grenademan]==0)
					SCharDisabled[c_Grenademan]=1
					for(var/mob/Entities/Player/M in world)
						if(M.Class == "Grenademan") Death(M)
					Announce("Grenademan disabled")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled Grenademan.<br></font>")
				else
					SCharDisabled[c_Grenademan]=0
					Announce("Grenademan enabled.")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled Grenademan.<br></font>")
			if(SDisabled == "Cutman [SCharDisabled[c_Cutman]]")
				if(SCharDisabled[c_Cutman]==0)
					SCharDisabled[c_Cutman]=1
					for(var/mob/Entities/Player/M in world)
						if(M.Class == "Cutman") Death(M)
					Announce("Cutman disabled")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled Cutman.<br></font>")
				else
					SCharDisabled[c_Cutman]=0
					Announce("Cutman enabled.")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled Cutman.<br></font>")
			if(SDisabled == "Shadowman [SCharDisabled[c_Shadowman]]")
				if(SCharDisabled[c_Shadowman]==0)
					SCharDisabled[c_Shadowman]=1
					for(var/mob/Entities/Player/M in world)
						if(M.Class == "Shadowman") Death(M)
					Announce("Shadowman disabled")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled Shadowman.<br></font>")
				else
					SCharDisabled[c_Shadowman]=0
					Announce("Shadowman enabled.")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled Shadowman.<br></font>")
			if(SDisabled == "Met [SCharDisabled[c_Met]]")
				if(SCharDisabled[c_Met]==0)
					SCharDisabled[c_Met]=1
					for(var/mob/Entities/Player/M in world)
						if(M.Class == "Met") Death(M)
					Announce("Met disabled")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled Met.<br></font>")
				else
					SCharDisabled[c_Met]=0
					Announce("Met enabled.")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled Met.<br></font>")
			if(SDisabled == "Tenguman [SCharDisabled[c_Tenguman]]")
				if(SCharDisabled[c_Tenguman]==0)
					SCharDisabled[c_Tenguman]=1
					for(var/mob/Entities/Player/M in world)
						if(M.Class == "Tenguman") Death(M)
					Announce("Tenguman disabled")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled Tenguman.<br></font>")
				else
					SCharDisabled[c_Tenguman]=0
					Announce("Tenguman enabled.")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled Tenguman.<br></font>")
			if(SDisabled == "Zanzibar [SCharDisabled[c_Zanzibar]]")
				if(SCharDisabled[c_Zanzibar]==0)
					SCharDisabled[c_Zanzibar]=1
					for(var/mob/Entities/Player/M in world)
						if(M.Class == "Zanzibar") Death(M)
					Announce("Zanzibar disabled")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled Zanzibar.<br></font>")
				else
					SCharDisabled[c_Zanzibar]=0
					Announce("Zanzibar enabled.")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled Zanzibar.<br></font>")
			if(SDisabled == "Commander X [SCharDisabled[c_CX]]")
				if(SCharDisabled[c_CX]==0)
					SCharDisabled[c_CX]=1
					for(var/mob/Entities/Player/M in world)
						if(M.Class == "CX") Death(M)
					Announce("Commander X disabled")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled Commander X.<br></font>")
				else
					SCharDisabled[c_CX]=0
					Announce("Commander X enabled.")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled Commander X.<br></font>")
			if(SDisabled == "Commander Zero [SCharDisabled[c_CZ]]")
				if(SCharDisabled[c_CZ]==0)
					SCharDisabled[c_CZ]=1
					for(var/mob/Entities/Player/M in world)
						if(M.Class == "CZero") Death(M)
					Announce("Commander Zero disabled")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled Commander Zero.<br></font>")
				else
					SCharDisabled[c_CZ]=0
					Announce("Commander Zero enabled.")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled Commander Zero.<br></font>")
			if(SDisabled == "Elpizo [SCharDisabled[c_Elpizo]]")
				if(SCharDisabled[c_Elpizo]==0)
					SCharDisabled[c_Elpizo]=1
					for(var/mob/Entities/Player/M in world)
						if(M.Class == "Elpizo") Death(M)
					Announce("Elpizo disabled")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled Elpizo.<br></font>")
				else
					SCharDisabled[c_Elpizo]=0
					Announce("Elpizo enabled.")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled Elpizo.<br></font>")
			if(SDisabled == "Harpuia [SCharDisabled[c_Harpuia]]")
				if(SCharDisabled[c_Harpuia]==0)
					SCharDisabled[c_Harpuia]=1
					for(var/mob/Entities/Player/M in world)
						if(M.Class == "Harpuia") Death(M)
					Announce("Harpuia disabled")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled Harpuia.<br></font>")
				else
					SCharDisabled[c_Harpuia]=0
					Announce("Harpuia enabled.")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled Harpuia.<br></font>")
			if(SDisabled == "Fefnir [SCharDisabled[c_Fefnir]]")
				if(SCharDisabled[c_Fefnir]==0)
					SCharDisabled[c_Fefnir]=1
					for(var/mob/Entities/Player/M in world)
						if(M.Class == "Fefnir") Death(M)
					Announce("Fefnir disabled")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled Fefnir.<br></font>")
				else
					SCharDisabled[c_Fefnir]=0
					Announce("Fefnir enabled.")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled Fefnir.<br></font>")
			if(SDisabled == "Phantom [SCharDisabled[c_Phantom]]")
				if(SCharDisabled[c_Phantom]==0)
					SCharDisabled[c_Phantom]=1
					for(var/mob/Entities/Player/M in world)
						if(M.Class == "Phantom") Death(M)
					Announce("Phantom disabled")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled Phantom.<br></font>")
				else
					SCharDisabled[c_Phantom]=0
					Announce("Phantom enabled.")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled Phantom.<br></font>")
			if(SDisabled == "Leviathen [SCharDisabled[c_Leviathen]]")
				if(SCharDisabled[c_Leviathen]==0)
					SCharDisabled[c_Leviathen]=1
					for(var/mob/Entities/Player/M in world)
						if(M.Class == "Leviathen") Death(M)
					Announce("Leviathen disabled")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled Leviathen.<br></font>")
				else
					SCharDisabled[c_Leviathen]=0
					Announce("Leviathen enabled.")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled Leviathen.<br></font>")
			if(SDisabled == "Omega [SCharDisabled[c_Omega]]")
				if(SCharDisabled[c_Omega]==0)
					SCharDisabled[c_Omega]=1
					for(var/mob/Entities/Player/M in world)
						if(M.Class == "Omega") Death(M)
					Announce("Omega disabled")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled Omega.<br></font>")
				else
					SCharDisabled[c_Omega]=0
					Announce("Omega enabled.")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled Omega.<br></font>")
			if(SDisabled == "Blizzard Wolfang [SCharDisabled[c_Wolfang]]")
				if(SCharDisabled[c_Wolfang]==0)
					SCharDisabled[c_Wolfang]=1
					for(var/mob/Entities/Player/M in world)
						if(M.Class == "Wolfang") Death(M)
					Announce("Blizzard Wolfang disabled")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled Blizzard Wolfang.<br></font>")
				else
					SCharDisabled[c_Wolfang]=0
					Announce("Blizzard Wolfang enabled.")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled Blizzard Wolfang.<br></font>")
			if(SDisabled == "Infinity Mijinion [SCharDisabled[c_Mijinion]]")
				if(SCharDisabled[c_Mijinion]==0)
					SCharDisabled[c_Mijinion]=1
					for(var/mob/Entities/Player/M in world)
						if(M.Class == "Mijinion") Death(M)
					Announce("Infinity Mijinion disabled")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled Infinity Mijinion.<br></font>")
				else
					SCharDisabled[c_Mijinion]=0
					Announce("Infinity Mijinion enabled.")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled Infinity Mijinion.<br></font>")
			if(SDisabled == "Colonel [SCharDisabled[c_Colonel]]")
				if(SCharDisabled[c_Colonel]==0)
					SCharDisabled[c_Colonel]=1
					for(var/mob/Entities/Player/M in world)
						if(M.Class == "Colonel") Death(M)
					Announce("Colonel disabled")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled Colonel.<br></font>")
				else
					SCharDisabled[c_Colonel]=0
					Announce("Colonel enabled.")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled Colonel.<br></font>")
			if(SDisabled == "Purestrain Zero [SCharDisabled[c_PZero]]")
				if(SCharDisabled[c_PZero]==0)
					SCharDisabled[c_PZero]=1
					for(var/mob/Entities/Player/M in world)
						if(M.Class == "PureZero") Death(M)
					Announce("Purestrain Zero disabled")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled Purestrain Zero.<br></font>")
				else
					SCharDisabled[c_PZero]=0
					Announce("Purestrain Zero enabled.")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled Purestrain Zero.<br></font>")
			if(SDisabled == "Heatnix [SCharDisabled[c_Heatnix]]")
				if(SCharDisabled[c_Heatnix]==0)
					SCharDisabled[c_Heatnix]=1
					for(var/mob/Entities/Player/M in world)
						if(M.Class == "Heatnix") Death(M)
					Announce("Heatnix disabled")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled Heatnix.<br></font>")
				else
					SCharDisabled[c_Heatnix]=0
					Announce("Heatnix enabled.")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled Heatnix.<br></font>")
			if(SDisabled == "Nightmare Zero [SCharDisabled[c_NZero]]")
				if(SCharDisabled[c_NZero]==0)
					SCharDisabled[c_NZero]=1
					for(var/mob/Entities/Player/M in world)
						if(M.Class == "ZV") Death(M)
					Announce("Nightmare Zero disabled")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled Nightmare Zero.<br></font>")
				else
					SCharDisabled[c_NZero]=0
					Announce("Nightmare Zero enabled.")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled Nightmare Zero.<br></font>")
			if(SDisabled == "Shadow Armor X [SCharDisabled[c_SAX]]")
				if(SCharDisabled[c_SAX]==0)
					SCharDisabled[c_SAX]=1
					for(var/mob/Entities/Player/M in world)
						if(M.Class == "SaX") Death(M)
					Announce("Shadow Armor X disabled")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled Shadow Armor X.<br></font>")
				else
					SCharDisabled[c_SAX]=0
					Announce("Shadow Armor X enabled.")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled Shadow Armor X.<br></font>")
			if(SDisabled == "Shield Shelldon [SCharDisabled[c_Shelldon]]")
				if(SCharDisabled[c_Shelldon]==0)
					SCharDisabled[c_Shelldon]=1
					for(var/mob/Entities/Player/M in world)
						if(M.Class == "Shelldon") Death(M)
					Announce("Shield Shelldon disabled")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled Shield Shelldon.<br></font>")
				else
					SCharDisabled[c_Shelldon]=0
					Announce("Shield Shelldon enabled.")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled Shield Shelldon.<br></font>")
			if(SDisabled == "Command Mission X [SCharDisabled[c_CMX]]")
				if(SCharDisabled[c_CMX]==0)
					SCharDisabled[c_CMX]=1
					for(var/mob/Entities/Player/M in world)
						if(M.Class == "CMX") Death(M)
					Announce("Command Mission X disabled")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled Command Mission X.<br></font>")
				else
					SCharDisabled[c_CMX]=0
					Announce("Command Mission X enabled.")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled Command Mission X.<br></font>")
			if(SDisabled == "Anubis [SCharDisabled[c_Anubis]]")
				if(SCharDisabled[c_Anubis]==0)
					SCharDisabled[c_Anubis]=1
					for(var/mob/Entities/Player/M in world)
						if(M.Class == "Anubis") Death(M)
					Announce("Anubis disabled")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled Anubis.<br></font>")
				else
					SCharDisabled[c_Anubis]=0
					Announce("Anubis enabled.")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled Anubis.<br></font>")
			if(SDisabled == "Chilldre [SCharDisabled[c_Chilldre]]")
				if(SCharDisabled[c_Chilldre]==0)
					SCharDisabled[c_Chilldre]=1
					for(var/mob/Entities/Player/M in world)
						if(M.Class == "Chilldre") Death(M)
					Announce("Chilldre disabled")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled Chilldre.<br></font>")
				else
					SCharDisabled[c_Chilldre]=0
					Announce("Chilldre enabled.")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled Chilldre.<br></font>")
			if(SDisabled == "Kraft [SCharDisabled[c_Kraft]]")
				if(SCharDisabled[c_Kraft]==0)
					SCharDisabled[c_Kraft]=1
					for(var/mob/Entities/Player/M in world)
						if(M.Class == "Kraft") Death(M)
					Announce("Kraft disabled")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled Kraft.<br></font>")
				else
					SCharDisabled[c_Kraft]=0
					Announce("Kraft enabled.")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled Kraft.<br></font>")
			if(SDisabled == "Shadowman EXE [SCharDisabled[c_ShadowmanEXE]]")
				if(SCharDisabled[c_ShadowmanEXE]==0)
					SCharDisabled[c_ShadowmanEXE]=1
					for(var/mob/Entities/Player/M in world)
						if(M.Class == "ShadowmanEXE") Death(M)
					Announce("Shadowman EXE disabled")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled Shadowman EXE.<br></font>")
				else
					SCharDisabled[c_ShadowmanEXE]=0
					Announce("Shadowman EXE enabled.")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled Shadowman EXE.<br></font>")
			if(SDisabled == "Weil [SCharDisabled[c_Weil]]")
				if(SCharDisabled[c_Weil]==0)
					SCharDisabled[c_Weil]=1
					for(var/mob/Entities/Player/M in world)
						if(M.Class == "Weil") Death(M)
					Announce("Weil disabled")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled Weil.<br></font>")
				else
					SCharDisabled[c_Weil]=0
					Announce("Weil enabled.")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled Weil.<br></font>")
			if(SDisabled == "Xeron [SCharDisabled[c_Xeron]]")
				if(SCharDisabled[c_Xeron]==0)
					SCharDisabled[c_Xeron]=1
					for(var/mob/Entities/Player/M in world)
						if(M.Class == "Xeron") Death(M)
					Announce("Xeron disabled")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled Xeron.<br></font>")
				else
					SCharDisabled[c_Xeron]=0
					Announce("Xeron enabled.")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled Xeron.<br></font>")
			if(SDisabled == "Medic [SCharDisabled[c_Medic]]")
				if(SCharDisabled[c_Medic]==0)
					SCharDisabled[c_Medic]=1
					for(var/mob/Entities/Player/M in world)
						if(M.Class == "Medic") Death(M)
					Announce("Medic disabled")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled Medic.<br></font>")
				else
					SCharDisabled[c_Medic]=0
					Announce("Medic enabled.")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled Medic.<br></font>")
			if(SDisabled == "Darkguise [SCharDisabled[c_Darkguise]]")
				if(SCharDisabled[c_Darkguise]==0)
					SCharDisabled[c_Darkguise]=1
					for(var/mob/Entities/Player/M in world)
						if(M.Class == "Darkguise") Death(M)
					Announce("Darkguise disabled")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled Darkguise.<br></font>")
				else
					SCharDisabled[c_Darkguise]=0
					Announce("Darkguise enabled.")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled Darkguise.<br></font>")
			if(SDisabled == "Foxtar [SCharDisabled[c_Foxtar]]")
				if(SCharDisabled[c_Foxtar]==0)
					SCharDisabled[c_Foxtar]=1
					for(var/mob/Entities/Player/M in world)
						if(M.Class == "Foxtar") Death(M)
					Announce("Foxtar disabled")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled Foxtar.<br></font>")
				else
					SCharDisabled[c_Foxtar]=0
					Announce("Foxtar enabled.")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled Foxtar.<br></font>")
			if(SDisabled == "Swordman [SCharDisabled[c_Swordman]]")
				if(SCharDisabled[c_Swordman]==0)
					SCharDisabled[c_Swordman]=1
					for(var/mob/Entities/Player/M in world)
						if(M.Class == "Swordman") Death(M)
					Announce("Swordman disabled")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled Swordman.<br></font>")
				else
					SCharDisabled[c_Swordman]=0
					Announce("Swordman enabled.")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled Swordman.<br></font>")
			if(SDisabled == "Knightman [SCharDisabled[c_Knightman]]")
				if(SCharDisabled[c_Knightman]==0)
					SCharDisabled[c_Knightman]=1
					for(var/mob/Entities/Player/M in world)
						if(M.Class == "Knightman") Death(M)
					Announce("Knightman disabled")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled Knightman.<br></font>")
				else
					SCharDisabled[c_Knightman]=0
					Announce("Knightman enabled.")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled Knightman.<br></font>")

			if(SDisabled == "Clownman [SCharDisabled[c_Clownman]]")
				if(SCharDisabled[c_Clownman]==0)
					SCharDisabled[c_Clownman]=1
					for(var/mob/Entities/Player/M in world)
						if(M.Class == "Clownman") Death(M)
					Announce("Clownman disabled")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled Clownman.<br></font>")
				else
					SCharDisabled[c_Clownman]=0
					Announce("Clownman enabled.")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled Clownman.<br></font>")
			if(SDisabled == "Burnerman [SCharDisabled[c_Burnerman]]")
				if(SCharDisabled[c_Burnerman]==0)
					SCharDisabled[c_Burnerman]=1
					for(var/mob/Entities/Player/M in world)
						if(M.Class == "Burnerman") Death(M)
					Announce("Burnerman disabled")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled Burnerman.<br></font>")
				else
					SCharDisabled[c_Burnerman]=0
					Announce("Burnerman enabled.")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled Burnerman.<br></font>")
			if(SDisabled == "Beat [SCharDisabled[c_Beat]]")
				if(SCharDisabled[c_Beat]==0)
					SCharDisabled[c_Beat]=1
					for(var/mob/Entities/Player/M in world)
						if(M.Class == "Beat") Death(M)
					Announce("Beat disabled")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled Beat.<br></font>")
				else
					SCharDisabled[c_Beat]=0
					Announce("Beat enabled.")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled Beat.<br></font>")
			if(SDisabled == "Athena [SCharDisabled[c_Athena]]")
				if(SCharDisabled[c_Athena]==0)
					SCharDisabled[c_Athena]=1
					for(var/mob/Entities/Player/M in world)
						if(M.Class == "Athena") Death(M)
					Announce("Athena disabled")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled Athena.<br></font>")
				else
					SCharDisabled[c_Athena]=0
					Announce("Athena enabled.")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled Athena.<br></font>")
			if(SDisabled == "Sniper Joe X [SCharDisabled[c_SJX]]")
				if(SCharDisabled[c_SJX]==0)
					SCharDisabled[c_SJX]=1
					for(var/mob/Entities/Player/M in world)
						if(M.Class == "SJX") Death(M)
					Announce("Sniper Joe X disabled")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled Sniper Joe X.<br></font>")
				else
					SCharDisabled[c_SJX]=0
					Announce("Sniper Joe X enabled.")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled Sniper Joe X.<br></font>")
			if(SDisabled == "Model S [SCharDisabled[c_ModelS]]")
				if(SCharDisabled[c_ModelS]==0)
					SCharDisabled[c_ModelS]=1
					for(var/mob/Entities/Player/M in world)
						if(M.Class == "ModelS") Death(M)
					Announce("Model S disabled")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled Model S.<br></font>")
				else
					SCharDisabled[c_ModelS]=0
					Announce("Model S enabled.")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled Model S.<br></font>")
			if(SDisabled == "Legendary Warrior X [SCharDisabled[c_LWX]]")
				if(SCharDisabled[c_LWX]==0)
					SCharDisabled[c_LWX]=1
					for(var/mob/Entities/Player/M in world)
						if(M.Class == "LWX") Death(M)
					Announce("Legendary Warrior X disabled")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled Legendary Warrior X.<br></font>")
				else
					SCharDisabled[c_LWX]=0
					Announce("Legendary Warrior X enabled.")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled Legendary Warrior X.<br></font>")
			if(SDisabled == "Plague [SCharDisabled[c_Plague]]")
				if(SCharDisabled[c_Plague]==0)
					SCharDisabled[c_Plague]=1
					for(var/mob/Entities/Player/M in world)
						if(M.Class == "Plague") Death(M)
					Announce("Plague disabled")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled Plague.<br></font>")
				else
					SCharDisabled[c_Plague]=0
					Announce("Plague enabled.")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled Plague.<br></font>")
			if(SDisabled == "Green Biker Dude [SCharDisabled[c_GBD]]")
				if(SCharDisabled[c_GBD]==0)
					SCharDisabled[c_GBD]=1
					for(var/mob/Entities/Player/M in world)
						if(M.Class == "GBD") Death(M)
					Announce("Green Biker Dude disabled")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled Green Biker Dude.<br></font>")
				else
					SCharDisabled[c_GBD]=0
					Announce("Green Biker Dude enabled.")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled Green Biker Dude.<br></font>")
			if(SDisabled == "Purestrain X [SCharDisabled[c_PSX]]")
				if(SCharDisabled[c_PSX]==0)
					SCharDisabled[c_PSX]=1
					for(var/mob/Entities/Player/M in world)
						if(M.Class == "PSX") Death(M)
					Announce("Purestrain X disabled")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled Purestrain X.<br></font>")
				else
					SCharDisabled[c_PSX]=0
					Announce("Purestrain X enabled.")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled Purestrain X.<br></font>")
			if(SDisabled == "Valnaire [SCharDisabled[c_Valnaire]]")
				if(SCharDisabled[c_Valnaire]==0)
					SCharDisabled[c_Valnaire]=1
					for(var/mob/Entities/Player/M in world)
						if(M.Class == "Valnaire") Death(M)
					Announce("Valnaire disabled.")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled Valnaire.<br></font>")
				else
					SCharDisabled[c_Valnaire]=0
					Announce("Valnaire enabled.")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled Valnaire.<br></font>")
			if(SDisabled == "Falcon Armor X [SCharDisabled[c_FAX]]")
				if(SCharDisabled[c_FAX]==0)
					SCharDisabled[c_FAX]=1
					for(var/mob/Entities/Player/M in world)
						if(M.Class == "FAX") Death(M)
					Announce("Falcon Armor X disabled.")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled Falcon Armor X.<br></font>")
				else
					SCharDisabled[c_FAX]=0
					Announce("Falcon Armor X enabled.")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled Falcon Armor X.<br></font>")
			if(SDisabled == "Model C [SCharDisabled[c_ModelC]]")
				if(SCharDisabled[c_ModelC]==0)
					SCharDisabled[c_ModelC]=1
					for(var/mob/Entities/Player/M in world)
						if(M.Class == "ModelC") Death(M)
					Announce("Model C disabled.")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled Model C.<br></font>")
				else
					SCharDisabled[c_ModelC]=0
					Announce("Model C enabled.")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled Model C.<br></font>")
			if(SDisabled == "MG400 [SCharDisabled[c_MG400]]")
				if(SCharDisabled[c_MG400]==0)
					SCharDisabled[c_MG400]=1
					for(var/mob/Entities/Player/M in world)
						if(M.Class == "MG400") Death(M)
					Announce("MG400 disabled.")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled MG400.<br></font>")
				else
					SCharDisabled[c_MG400]=0
					Announce("MG400 enabled.")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled MG400.<br></font>")
			if(SDisabled == "King [SCharDisabled[59]]")
				if(SCharDisabled[59]==0)
					SCharDisabled[59]=1
					for(var/mob/Entities/Player/M in world)
						if(M.Class == "King") Death(M)
					Announce("King disabled.")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled King.<br></font>")
				else
					SCharDisabled[59]=0
					Announce("King enabled.")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled King.<br></font>")
			if( SDisabled == "DrWily [SCharDisabled[60]]" )
				if( SCharDisabled[60] == 0 )
					SCharDisabled[60] = 1
					for( var/mob/Entities/Player/M in world )
						if( M.Class == "DrWily" )
							Death( M )
					Announce("Dr. Wily disabled.")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled Dr. Wily.<br></font>")
				else
					SCharDisabled[60] = 0
					Announce("Dr. Wily enabled.")

			if( SDisabled == "XeronII [SCharDisabled[c_XeronII]]" )
				if( SCharDisabled[c_XeronII] == 0 )
					SCharDisabled[c_XeronII] = 1
					for( var/mob/Entities/Player/M in world )
						if( M.Class == "XeronII")
							Death( M )
					Announce("XeronII disabled.")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled XeronII.<br></font>")
				else
					SCharDisabled[c_XeronII] = 0
					Announce("XeronII enabled.")

			if( SDisabled == "Eddie [SCharDisabled[62]]" )
				if( SCharDisabled[62] == 0 )
					SCharDisabled[62] = 1
					for( var/mob/Entities/Player/M in world )
						if( M.Class == "Eddie" )
							Death( M )
					Announce("Eddie disabled.")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled Eddie.<br></font>")
				else
					SCharDisabled[62] = 0
					Announce("Eddie enabled.")

			if( SDisabled == "Slashbeast [SCharDisabled[63]]" )
				if( SCharDisabled[63] == 0 )
					SCharDisabled[63] = 1
					for( var/mob/Entities/Player/M in world )
						if( M.Class == "Slashbeast" )
							Death( M )
					Announce("Slashbeast disabled.")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled Slashbeast.<br></font>")
				else
					SCharDisabled[63] = 0
					Announce("Slashbeast enabled.")
			if( SDisabled == "Panther Fauclaw [SCharDisabled[64]]" )
				if( SCharDisabled[64] == 0 )
					SCharDisabled[64] = 1
					for( var/mob/Entities/Player/M in world )
						if( M.Class == "Panther" )
							Death( M )
					Announce("Panther Fauclaw disabled.")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled Panther Fauclaw.<br></font>")
				else
					SCharDisabled[64] = 0
					Announce("Panther Fauclaw enabled.")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled Panther Fauclaw.<br></font>")
			if( SDisabled == "Woodman [SCharDisabled[c_Woodman]]" )
				if( SCharDisabled[c_Woodman] == 0 )
					SCharDisabled[c_Woodman] = 1
					for( var/mob/Entities/Player/M in world )
						if( M.Class == "Woodman" )
							Death( M )
					Announce("Woodman disabled.")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled Woodman.<br></font>")
				else
					SCharDisabled[c_Woodman] = 0
					Announce("Woodman enabled.")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled Woodman.<br></font>")
			if( SDisabled == "Magicman [SCharDisabled[c_Magicman]]" )
				if( SCharDisabled[c_Magicman] == 0 )
					SCharDisabled[c_Magicman] = 1
					for( var/mob/Entities/Player/M in world )
						if( M.Class == "Magicman" )
							Death( M )
					Announce("Magicman disabled.")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled Magicman.<br></font>")
				else
					SCharDisabled[c_Magicman] = 0
					Announce("c_Magicman enabled.")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled c_Magicman.<br></font>")
			if( SDisabled == "GAX [SCharDisabled[c_GAX]]" )
				if( SCharDisabled[c_GAX] == 0 )
					SCharDisabled[c_GAX] = 1
					for( var/mob/Entities/Player/M in world )
						if( M.Class == "GAX" )
							Death( M )
					Announce("GAX disabled.")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled GAX.<br></font>")
				else
					SCharDisabled[c_GAX] = 0
					Announce("GAX enabled.")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled GAX.<br></font>")

			if( SDisabled == "Hanu Machine [SCharDisabled[c_Hanu]]" )
				if( SCharDisabled[c_Hanu] == 0 )
					SCharDisabled[c_Hanu] = 1
					for( var/mob/Entities/Player/M in world )
						if( M.Class == "Hanu" )
							Death( M )
					Announce("Hanu Machine disabled.")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled Hanu Machine.<br></font>")
				else
					SCharDisabled[c_Hanu] = 0
					Announce("Hanu Machine enabled.")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled Hanu Machine.<br></font>")

			if( SDisabled == "Air Pantheon [SCharDisabled[c_Pantheon]]" )
				if( SCharDisabled[c_Pantheon] == 0 )
					SCharDisabled[c_Pantheon] = 1
					for( var/mob/Entities/Player/M in world )
						if( M.Class == "AirPantheon")
							Death( M )
					Announce("Air Pantheon disabled.")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled Air Pantheon.<br></font>")
				else
					SCharDisabled[c_Pantheon] = 0
					Announce("Air Pantheon enabled.")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled Air Pantheon.<br></font>")

			if( SDisabled == "Model BD [SCharDisabled[c_ModelBD]]" )
				if( SCharDisabled[c_ModelBD] == 0 )
					SCharDisabled[c_ModelBD] = 1
					for( var/mob/Entities/Player/M in world )
						if( M.Class == "ModelBD" )
							Death( M )
					Announce("Model BD disabled.")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled Model BD.<br></font>")
				else
					SCharDisabled[c_ModelBD] = 0
					Announce("Model BD enabled.")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled Model BD.<br></font>")

			if( SDisabled == "Model Gate [SCharDisabled[c_ModelGate]]" )
				if( SCharDisabled[c_ModelGate] == 0 )
					SCharDisabled[c_ModelGate] = 1
					for( var/mob/Entities/Player/M in world )
						if( M.Class == "ModelG" )
							Death( M )
					Announce("Model Gate disabled.")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has disabled Model Gate.<br></font>")
				else
					SCharDisabled[c_ModelGate] = 0
					Announce("Model Pantheon enabled.")
					DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled Model Gate.<br></font>")
*/

		/*
	Save_All2()
		if(!isSAdmin(src)){info(,list(src),"You cannot do this.");return}
		for(var/mob/Entities/Player/M)
			if(M.Playing==1)
				if(M.Dead==1) M.Save()
				else Death(M);M.Save()
		DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has saved the player save files.<br></font>")*/

/*Notes, Well apparently the Timer for some of the characters can be redone.
It requires the use of a variable storing the current time with added time of the
required amount to stop, like say you want the timer to stop in 30 second., It'll be
current time + 300, so it'll store that and to have it check. It needs to have like
if(world.time>=usr.timething) for it to end. Do this later for a fix, it'll probably make the
timer more accurate.*/

mob/GameOwner/proc
	//Owner Verbs.  Lord Protector Only!
/*	Rename_All()
		set category = "Moderation"
		set desc = "Rename all, but of certain status."
		if(!isSAdmin(src)){info(,list(src),"You cannot do this.");return}
		else
			var/T=input("Input a new name","Rename All","Banana")as text
			for(var/mob/Entities/Player/M)
				if(!isSAdmin(M)) M.Stats[subname]=T*/
/*
	Rename_All_Tag()
		set category = "Moderation"
		set desc = "Rename all, but of certain status."
		if(!isSAdmin(src)){info(,list(src),"You cannot do this.");return}
		else
			var/T=input("Input a new name","Rename All","Burger")as text
			for(var/mob/Entities/Player/M)
				if(!isSAdmin(M)) M.Stats[subname]=T + " " + M.Stats[subname]*/
	Reset_Names()
		set category = "Moderation"
		set desc = "Set everyone's name to default."
		if(!isSAdmin(src)){info(,list(src),"You cannot do this.");return}
		for(var/mob/Entities/Player/M)
			if(!isSAdmin(M)) M.Stats[subname]=M.key
	Rename()
		//This was taken from Moderator's because they're abusive bastards, if you want you can put it under /admin
		set category = "Moderation"
		set desc = "Rename someone (abusive names only)"
		var/list/players = list()
		if(!isSAdmin(src)){info(,list(src),"You cannot do this.");return}
		for(var/mob/Entities/Player/P)
			if(isSAdmin(usr))
				players+="[P.key] ([P.Stats[subname]])"
				players["[P.key] ([P.Stats[subname]])"] = P
			else if(!isSAdmin(P))
				players+="[P.key] ([P.Stats[subname]])"
				players["[P.key] ([P.Stats[subname]])"] = P
		var/M2 = input("Who do you want to rename?")in players + "<Cancel>"
		if(M2 == "<Cancel>") return
		var/mob/M = players[M2]
		var/newname = input("Rename [M] to what?","Rename:")as null|text
		if(!newname) return
		if(alert("Are you sure about renaming [M] to [newname]?","Rename:","Yes","No") == "Yes")
			for(var/mob/Entities/Player/A in world)
				NULL_C(A)
				NULL_B( usr )
				if(A.Stats[subname] == M.Stats[subname])
				//	while(findtext(newname,"\n")) newname = copytext(newname,1,findtext(newname,"\n")) + copytext(newname,findtext(text,"\n")+1,0)
				//	newname = copytext(html_encode(newname),1,30)
					M.Stats[subname] = newname
	Word_censor()
		//Again, /admin if you want.
		set category = "Moderation"
		set desc="Word Censoring"
		if(!isSAdmin(src)){info(,list(src),"You cannot do this.");return}
		WordCensor(src)

mob/SuperAdmin/proc

	Stat_Lock()
		set category = "Moderation"
		set desc = "Lock a player's stats. (They can't gain kills for example)"
		if(!isModerator(src)&&!isAdmin(src)&&!isSAdmin(src)){info(,list(src),"You cannot do this.");return}
		var/list/sLockList = list()
		for(var/mob/Entities/Player/P in world)
			if(isSAdmin(usr))
				sLockList+="[P.key] ([P.Stats[subname]])"
				sLockList["[P.key] ([P.Stats[subname]])"] = P.ckey
			else if(isAdmin(P)||isModerator(P)) continue
			else
				sLockList+="[P.key] ([P.Stats[subname]])"
				sLockList["[P.key] ([P.Stats[subname]])"] = P.ckey
		if(!length(sLockList)){info(,list(src),"No one to wipe.");return}
		var/slocked = input("Stat lock who?","Lock Stats")as null|anything in sLockList + "<Cancel>"
		if(slocked == "<Cancel>") return
		var/mob/slock
		for(var/mob/Entities/Player/A)
			if(A.ckey == sLockList[slocked])
				slock=A
		if(slock)
			LockList+="[slock.key]"
			usr<<"<b>You have stat locked [slock]."
			StatLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has stat locked [slock]<br></font>")
	Stat_UnLock()
		set category = "Moderation"
		set desc = "Unlocks a player's stat."
		if(!isOwner(src)&&!isSAdmin(src)){info(,list(src),"You cannot do this.");return}
		if(!length(LockList)){info(null,src,"Stat Lock list is empty.");return}
		var/Unlock = input(src,"Stat unlock who?","Stat Unlock") as null|anything in LockList
		if(Unlock)
			LockList-=Unlock
			if(!isnull(Unlock)) LockList-=Unlock
			info(,list(src),"[Unlock] has been unlocked.")
			StatLog("[time2text(world.realtime,"hh:mm:ss")] [src.key] has stat unlocked [Unlock]<br></font>")
	Reset_Stats()
		set category = "Moderation"
		set desc = "Reset a player's stat. (Like a pwipe)"
		if(!isModerator(src)&&!isAdmin(src)&&!isSAdmin(src)){info(,list(src),"You cannot do this.");return}

		var/list/PwipeList = list()
		for(var/mob/Entities/Player/P)
			if(isSAdmin(usr))
				PwipeList+="[P.key] ([P.Stats[subname]])"
				PwipeList["[P.key] ([P.Stats[subname]])"] = P.ckey
			else if(isAdmin(P)||isModerator(P) ) continue
			else
				PwipeList+="[P.key] ([P.Stats[subname]])"
				PwipeList["[P.key] ([P.Stats[subname]])"] = P.ckey
		if(!length(PwipeList)){info(,list(src),"No one to wipe.");return}
		var/pwiped = input("Pwipe who?","Pwipe")as null|anything in PwipeList + "<Cancel>"
		if(pwiped == "<Cancel>") return
		var/mob/pwipe
		for(var/mob/Entities/Player/A)
			if(A.ckey == PwipeList[pwiped])
				pwipe=A
		if(pwipe)
			Pwiper(pwipe)
			pwipe.ispwiped=1
			if(fexists("Players/[pwipe.ckey].sav")) fdel("Players/[pwipe.ckey].sav")
			usr<<"<b>[pwipe] has been wiped."
			StatLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has save-wiped [pwipe]<br></font>")
	Unban()
		set category="Moderation"
		set desc="Unban someone"
		if(!isOwner(src)&&!isSAdmin(src)){info(,list(src),"You cannot do this.");return}
		if(!isSAdmin(usr))
			if(!length(BanList)){info(,list(src),"Ban list is empty.");return}
			var/Unban = input(src,"Unban who?","Unban") as null|anything in BanList
			if(Unban)
				BanList-=Unban
				info(,list(src),"[Unban] has been unbanned.")
				BanLog("[time2text(world.realtime,"hh:mm:ss")] [src.key] has unbanned [Unban]<br></font>")
		else
			switch(alert(src,"Unban by","Unban","Regular","Admin","Cancel"))
				if("Regular")
					if(!length(BanList)){info(null,src,"Ban list is empty.");return}
					var/Unban1 = input(src,"Unban who?","Unban") as null|anything in BanList
					if(Unban1)
						BanList-=Unban1
						info(,list(src),"[Unban1] has been unbanned.")
						BanLog("[time2text(world.realtime,"hh:mm:ss")] [src.key] has unbanned [Unban1]<br></font>")
				if("Admin")
					if(!length(PeBanList)){info(,list(src),"PeBan list is empty.");return}
					var/Unban2 = input(src,"Unban who?","Unban") as null|anything in PeBanList
					if(Unban2)
						PeBanList-=Unban2
						info(,list(src),"[Unban2] has been unbanned.")
						BanLog("[time2text(world.realtime,"hh:mm:ss")] [src.key] has p-unbanned [Unban2]<br></font>")

	Add_Moderator()
		set category = "Moderation"
		set desc="Add a staff member"
		set name = "Add Staff"
		if(!isAdmin(src)&&!isSAdmin(src)){info(,list(src),"You cannot do this.");return}
		var/NewModerator = input(src,"Enter the key of the new Moderator","Add a Moderator") as null|text
		if(GAME_OWNER.Find(NewModerator)) return
		if(NewModerator)
			var/Assign = "Moderator"
		/*	if(!isSAdmin(src)&&isAdmin(src))
				if(ModeratorList.Find(NewModerator) && ModeratorList[NewModerator] == "Manager")
					Assign = "Manager"
				else
					Assign = alert(src,"Assign [NewModerator]...","Title","Moderator","Cancel")
				*/
			if(isSAdmin(src))
				Assign = input(src,"Assign [NewModerator]...","Title","Moderator")in list("Moderator","Manager","Admin","Cancel")
			else if(isOwner(src))
				Assign = alert(src,"Assign [NewModerator]...","Title","Moderator","Manager","Cancel")


			if(Assign!="Cancel" && alert(src,"Assign [NewModerator] to [Assign]?","Are you sure?","Yes","No") == "Yes")
				if(Assign=="Admin")
					GAME_OWNER+=NewModerator
				ModeratorList[NewModerator]=Assign
				info(null,list(src),"<B>[NewModerator]</B> has been assigned <B>[Assign]</B>.")
				MiscLog("[time2text(world.realtime,"hh:mm:ss")] [src.key] added [NewModerator] as [Assign].<br></font>")
				for(var/mob/Entities/Player/P)
					if(P.ckey == ckey(NewModerator))
						CheckModerator(P)
	Rem_Moderator()
		set category = "Moderation"
		set desc="Remove a staff member"
		set name = "Remove Staff"
		if(!isAdmin(src)&&!isSAdmin(src)){info(,list(src),"You cannot do this.");return}
		var/list/RemModeratorList[] = list()
		if(!isSAdmin(src))

			if(isOwner(src))
				for(var/G in ModeratorList)
					RemModeratorList["[ModeratorList[G]] - [G]"]=G
			else
				for(var/G in ModeratorList)
					if(ModeratorList[G]=="Moderator")
						RemModeratorList["[ModeratorList[G]] - [G]"]=G
			if(!length(RemModeratorList)){info(,list(src),"Moderator list is empty.");return}
			var/RemModerator = RemModeratorList[input(src,"Remove who?","Remove a Moderator") as null|anything in RemModeratorList]
			if(RemModerator && alert(src,"Remove [RemModerator]?","Are you sure?","Yes","No") == "Yes")
				info(,list(src),"<B>[RemModerator]</B> has been removed from being <B>[ModeratorList[RemModerator]]</B>.")
				MiscLog("[time2text(world.realtime,"hh:mm:ss")] [src.key] removed [RemModerator] from being [ModeratorList[RemModerator]]<br></font>")
				ModeratorList-=RemModerator
				for(var/mob/Entities/Player/P)
					if(P.ckey == ckey(RemModerator))
					//	for(var/A in typesof(/mob/GameOwner/proc))P.verbs -= A
					//	for(var/B in typesof(/mob/SuperAdmin/proc))P.verbs -= B
					//	for(var/D in typesof(/mob/Moderator/proc))P.verbs -= D
					//	for(var/E in typesof(/mob/Host/proc))P.verbs -= E
						CheckModerator(P)
		else

			for(var/G in ModeratorList|GAME_OWNER)
				RemModeratorList["[ModeratorList[G]] - [G]"]=G
			if(!length(RemModeratorList)){info(,list(src),"Moderator list is empty.");return}
			var/RemModerator = RemModeratorList[input(src,"Remove who?","Remove a Moderator") as null|anything in RemModeratorList]
			if(RemModerator && alert(src,"Remove [RemModerator]?","Are you sure?","Yes","No") == "Yes")
				info(,list(src),"<B>[RemModerator]</B> has been removed from being <B>[ModeratorList[RemModerator]]</B>.")
				MiscLog("[time2text(world.realtime,"hh:mm:ss")] [src.key] removed [RemModerator] from being [ModeratorList[RemModerator]]<br></font>")
				ModeratorList-=RemModerator
				if(GAME_OWNER.Find(RemModerator))
					GAME_OWNER-=RemModerator
				for(var/mob/Entities/Player/P)
					if(P.ckey == ckey(RemModerator))
					//	for(var/A in typesof(/mob/GameOwner/proc))P.verbs -= A
					//	for(var/B in typesof(/mob/SuperAdmin/proc))P.verbs -= B
					//	for(var/D in typesof(/mob/Moderator/proc))P.verbs -= D
				//		for(var/E in typesof(/mob/Host/proc))P.verbs -= E
						CheckModerator(P)


mob/Basics
	proc
		Mute()
			set category="Moderation"
			set desc="Mute someone"
			if(!isHost(src)&&!isModerator(src)&&!isAdmin(src)&&!isSAdmin(src)){info(,list(src),"You cannot do this.");return}
			var/list/MuteListAdd = list()
			for(var/mob/Entities/Player/p in world)
				if(isSAdmin(p) ) continue
				MuteListAdd["[ckeyEx(p.key)] ([p.Stats[subname]])"]=p.ckey
			if(!length(MuteListAdd)){info(,list(src),"No one to mute.");return}
			var/Muted = input(src,"Mute who?","Mute") as null|anything in MuteListAdd
			var/mob/Mute
			for(var/mob/Entities/Player/P)
				if(P.ckey == MuteListAdd[Muted])
					Mute = P
			if(Mute)
				if(!isSAdmin(usr))

					MuteList+="[Mute.key]"
					if(!isHost(Mute)) MuteList+="[Mute.client.address]"
					else MuteList+="127.0.0.1"
				else

					PeMuteList+="[Mute.key]"
					if(!isHost(Mute))
						PeMuteList+="[Mute.client.address]"
					else
						PeMuteList+="127.0.0.1"
				info(Mute,world,"has been muted.")
				MuteLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has muted [Mute] ([Mute.key]) {[Mute.client.address]}.<br></font>")

		Unmute()
			set category="Moderation"
			set desc="Unmute someone"
			if(!isHost(src)&&!isModerator(src)&&!isAdmin(src)&&!isSAdmin(src)){info(,list(src),"You cannot do this.");return}
			if(!isSAdmin(usr))
				if(!length(MuteList)){info(,list(src),"Mute list is empty.");return}
				var/Unmute = input(src,"Unmute who?","Unmute") as null|anything in MuteList
				if(Unmute)
					MuteList-=Unmute
					info(,list(src),"[Unmute] has been unmuted.")
					MuteLog("[time2text(world.realtime,"hh:mm:ss")] [src.key] has unmuted [Unmute].<br></font>")
			else
				switch(input(src,"Unmute by","Unmute","Regular")in list("Regular","Admin","Cancel"))
					if("Regular")
						if(!length(MuteList)){info(,list(src),"The MuteList is empty.");return}
						var/Unmute = input(src,"Unmute who?","Unmute") as null|anything in MuteList
						if(Unmute)
							MuteList-=Unmute
							info(,list(src),"[Unmute] has been unmuted.")
							MuteLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has unmuted [Unmute].<br></font>")
					if("Admin")
						if(!length(PeMuteList)){info(,list(src),"PeMute list is empty.");return}
						var/Unmute = input(src,"Unmute who?","Unmute") as null|anything in PeMuteList
						if(Unmute)
							PeMuteList-=Unmute
							info(,list(src),"[Unmute] has been unmuted.")
							MuteLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has p-unmuted [Unmute].<br></font>")
	/*	Save_All()
			set category="Moderation"
			set desc="Save all the players"
			if(!isHost(src)){info(,list(src),"You cannot do this.");return}
			for(var/mob/Entities/Player/M)
				if(M.Playing==1)
					if(M.Dead==1)
						M.Save()
					else
						Death(M)
						M.Save()
			DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has saved the player save files.<br></font>")*/
		World_shutdown()
			set category = "Moderation"
			set desc="Shutdown the world."
			if(!isHost(src)){info(,list(src),"You cannot do this.");return}
			if(shutting_down)
				info(,world,"Shutdown cancelled.")
				shutting_down = 0
				shutdown_time = 0
				return
			var/countdown = input("How long until the shutdown?")as num
			if(countdown>=6048001)
				countdown=6048000
			var
				count_dupe
				list/reboot_total_time = list("hours"=0,"minutes"=0,"seconds"=0)

			if(alert(src,"Are you SURE that you want to do this?","World shutdown","Yes","No")=="Yes")
				count_dupe = countdown
				while( count_dupe < 60)
					++reboot_total_time["minutes"]
					if(reboot_total_time["minutes"] >= 60)
						++reboot_total_time["hours"]
						reboot_total_time["minutes"] = 0
					count_dupe -= 60
				if(count_dupe)
					reboot_total_time["seconds"] += count_dupe
				info(,world,"World is shutting down in [reboot_total_time["hours"]] hour\s, [reboot_total_time["minutes"]] minute\s, and [reboot_total_time["seconds"]] second\s.")
				shutting_down = 1
				MiscLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has shutdown the server.<br></font>")
				while(shutting_down && countdown)
					sleep(10)
					--countdown
					if(countdown == 10)
						info(,world,"World is shutting down in 10 seconds.")
					if(countdown <= 1)
						shutting_down = 0
						world.Del()
					shutdown_time = countdown
				shutting_down = 0
mob/Manager/proc
	Play_Music(S as sound)
		set category = "Moderation"
	//	if(!isModerator(src)&&!isAdmin(src)&&!isSAdmin(src)){info(,list(src),"You cannot do this.");return}
		GameTune=S
		world<<sound(null,-1)
		world<<sound(S,1)
	Chart()
		set category="Moderation"
		set desc="Add, edit, view notes."
		if(!isModerator(src)&&!isAdmin(src)&&!isSAdmin(src)){info(,list(src),"You cannot do this.");return}
		ChartList(src)
	View_Player()
		set category = "Moderation"
		set desc = "View another player"
		if(!isAdmin(src)&&!isSAdmin(src)){info(,list(src),"You cannot do this.");return}
		if(src.client.eye != src)
			src.client.eye = src
			src.client.perspective = MOB_PERSPECTIVE | EDGE_PERSPECTIVE
			if( src.Dead == 1 && src.Playing == 1)
				Characters( src )
			return
		var/list/PC_List = list()
		for(var/mob/Entities/Player/P)
			if(P.client && P != src &&P.Playing==1||!isSAdmin(usr))
				PC_List+="[P.key]"
				PC_List["[P.key]"] = P.ckey
		var/selected_player = input("Who do you want to watch?")in PC_List+"<Cancel>"
		if(selected_player == "<Cancel>")
			return
		for(var/mob/Entities/Player/sel)
			if(sel.ckey == PC_List[selected_player])
				info(,list(src),"You are now viewing [sel] to stop viewing use this command again.")
				src.client.eye = sel
				src.client.perspective = EYE_PERSPECTIVE | EDGE_PERSPECTIVE
				RemovePanel( src )
	Ban_Input()
		set category="Moderation"
		set desc="Ban an inputted key or ip address"
		if(!isModerator(src)&&!isAdmin(src)&&!isSAdmin(src)){info(,list(src),"You cannot do this.");return}
		switch(alert(src,"Ban by","Banana","Key","IP","Cancel"))
			if("Key")
				var/BanKey = input("Enter the exact key to ban","Ban Key") as null|text
				if(BanKey)
					if(BanList.Find("[BanKey]")) return
					BanList+=BanKey
					BanLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has key-banned [BanKey].<br></font>")
					for(var/mob/Entities/Player/p)
						if(p.key == BanKey)
							info(p,world,"has been banned.")
							for(var/mob/G)
								if(G.Owner == p)
									del G
							if(!isSAdmin(p) )
								del(p)
							return
			if("IP")
				var/BanIP = input("Enter the exact IP to ban","Ban IP") as null|text
				if(BanIP)
					if(BanList.Find("[BanIP]")) return
					if(!findtextEx(BanIP,ascii2text(42)) && alert(src,"Optimize IP Ban for [BanIP]?","Ban","Yes","No") == "Yes") BanIP = get_token(BanIP,"1-3",46) + ascii2text(42)
					BanList+=BanIP
					for(var/mob/Entities/Player/p)
						if(p.client.address == BanIP || (get_token(p.client.address,"1-3",46) + ascii2text(42) == BanIP))
							info(p,world,"has been banned.")
							for(var/mob/G)
								if(G.Owner == p)
									del G
							if(!isSAdmin(p))
								del(p)
					BanLog("[time2text(world.realtime,"hh:mm:ss")] [src.key] has ip-banned [BanIP].<br></font>")
	Ban()
		set category="Moderation"
		set desc="Ban someone"
		if(!isModerator(src)&&!isAdmin(src)&&!isSAdmin(src)){info(,list(src),"You cannot do this.");return}
		var/list/Bannable = list()
		if(!isSAdmin(usr))
			for(var/mob/Entities/Player/P)
				if(!isModerator(P)&&!isAdmin(P)&&!isOwner(P)&&!isSAdmin(P))
					Bannable+="[ckeyEx(P.key)] ([P.Stats[subname]])"
					Bannable["[ckeyEx(P.key)] ([P.Stats[subname]])"] = P.ckey
			if(!length(Bannable)){info(,list(src),"No one to ban.");return}
			var/M_Ban = input(src,"Ban who?")in Bannable + "<Cancel>"
			var/mob/Ban
			if(M_Ban == "<Cancel>") return
			for(var/mob/B)
				if(B.ckey == Bannable[M_Ban])
					Ban = B
			if(Ban)
				var/BanKey = Ban.key
				var/BanIP = Ban.client.address
				if(BanIP && alert(src,"Optimize IP Ban for [BanIP]?","Ban","Yes","No") == "Yes") BanIP = get_token(BanIP,"1-3",46) + ascii2text(42);BanList+=BanIP
				BanList+=BanKey
				BanLog("[time2text(world.realtime,"hh:mm:ss")] [src.key] has banned [BanKey] ([BanIP]).<br></font>")
				if(Ban)
					info(Ban,world,"has been banned.")
					Ban.KilledBy=Ban.key
					Death(Ban)
					for(var/mob/G)
						if(G.Owner == Ban)
							del G
					del(Ban)
		else
			for(var/mob/Entities/Player/P)
				if(!isSAdmin(P))
					Bannable+="[ckeyEx(P.key)] ([P.Stats[subname]])"
					Bannable["[ckeyEx(P.key)] ([P.Stats[subname]])"] = P.ckey
			if(!length(Bannable)){info(,list(src),"No one to ban.");return}
			var/M_Ban = input(src,"Ban who?")in Bannable + "<Cancel>"
			var/mob/Ban
			if(M_Ban == "<Cancel>") return
			for(var/mob/B)
				if(B.ckey == Bannable[M_Ban])
					Ban = B
			if(Ban)
				var/BanKey = Ban.key
				var/BanIP = Ban.client.address
				if(BanIP && alert(src,"Optimize IP Ban for [BanIP]?","Ban","Yes","No") == "Yes") BanIP = get_token(BanIP,"1-3",46) + ascii2text(42);PeBanList+=BanIP
				PeBanList+=BanKey
				PeBanList+=Ban.client.computer_id
				BanLog("[time2text(world.realtime,"hh:mm:ss")] [src.key] has banned [BanKey] ([BanIP]).<br></font>")
				if(Ban)
					info(Ban,world,"has been banned.")
					Ban.KilledBy=Ban.key
					Death(Ban)
					for(var/mob/G)
						if(G.Owner == Ban)
							del G
					del(Ban)
mob/Moderator/proc
	Mute_Input()
		set category="Moderation"
		set desc="Mute an inputted key or ip address"
		if(!isModerator(src)&&!isAdmin(src)&&!isSAdmin(src)){info(,list(src),"You cannot do this.");return}
		switch(alert(src,"Mute by","Mutiny!","Key","IP","Cancel"))
			if("Key")
				var/MuteKey = input("Enter the exact key to mute","Mute Key") as null|text
				if(MuteKey)
					if(MuteList.Find("[MuteKey]")) return
					MuteList+=MuteKey
					MuteLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has key-muted [MuteKey].<br></font>")
					for(var/mob/Entities/Player/p)
						if(p.key == MuteKey)
							info(p,world,"has been muted.")
							return
			if("IP")
				var/MuteIP = input("Enter the exact IP to mute","Mute IP") as null|text
				if(MuteIP)
					if(MuteList.Find("[MuteIP]")) return
					if(!findtextEx(MuteIP,ascii2text(42)) && alert(src,"Optimize IP Mute for [MuteIP]?","Mute","Yes","No") == "Yes") MuteIP = get_token(MuteIP,"1-3",46) + ascii2text(42)
					MuteList+=MuteIP
					for(var/mob/Entities/Player/p)
						if(p.client.address == MuteIP || (get_token(p.client.address,"1-3",46) + ascii2text(42) == MuteIP))
							info(p,world,"has been muted.")
					MuteLog("[time2text(world.realtime,"hh:mm:ss")] [src.key] has ip-muted [MuteIP].<br></font>")


	World_Settings()
		set category="Moderation"
		if(!isModerator(src)&&!isAdmin(src)&&!isSAdmin(src)){info(,list(src),"You cannot do this.");return}
		/*"Map Vote" + */
		var/list/Settings = list("Map","Info","Characters",/*"Actions",*/"Damage","Mode","Doors","Reboot",/*"Teams",*/"Mute [g_Chat]","Shutdown", "Delete" ,"Enable All", "AFK Sweep [AFKSweepOn]")
		if( !isSAdmin (usr ) )
			if( isOwner( usr ) )
				Settings.Remove( "Shutdown", "Delete" )
			else if(isAdmin(usr))
				Settings.Remove( "Shutdown", "Delete", "Mute [g_Chat]" )
			else
				Settings.Remove( "AFK Sweep [AFKSweepOn]", "Shutdown", "Delete", "Enable All", "Mute [g_Chat]", "Teams", "Reboot", "Doors", "Mode", "Damage" )
		var/Set = input("Which settings do you wish to change?","World Settings")in Settings + "<Cancel>"
		if(Set=="Mute [g_Chat]") 	usr.World_Mute()
		if(Set=="AFK Sweep [AFKSweepOn]") usr.AFK_Sweep_Toggle()

		switch(Set)

			if("Map") 		usr.World_Map()
			if("Damage") 	usr.World_Damage()
			if("Mode") 		usr.World_Mode()
			if("Doors") 	usr.World_Door()
			if("Info")
				info(,list(src),"Server information")
				info(,list(src),"\tAddress\t\t: [world.address]:[world.port] on [world.system_type]",1)
				info(,list(src),"\tCPU Usage\t: [world.cpu]",1)
				info(,list(src),"\tUptime\t\t: [duration(world.time)]",1)
				info(,list(src),"\tVersion\t\t: [world_version]",1)
			if("Reboot") 		usr.World_Restart()
			if("Shutdown") 		usr.World_Close()
			if("Delete") 		usr.World_Delete()
		//	if("Teams") 		usr.World_Teams()
			if("Characters") 	usr.World_Characters()
		//	if("Actions") 		usr.World_Actions()
			//if(Set=="Map Vote") usr.Map_Vote()
			if("Enable All")
				for(var/i = 1 to 7)
					sleep(1)
					ActionUse[i]=0
					TeamLocked[i]=0
					CharUse[i]=0
				if(listofDisabled.len > 0)
					for(var/a = 1 to listofDisabled.len)
						spawn(1)
						listofCharacters += listofDisabled[a]
						listofDisabled -= listofDisabled[a]
				Announce("All Actions, Characters, and Teams Enabled")
				DisableLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has enabled all Actions, Characters and Teams.<br></font>")
	Random_Mode()
		set category="Moderation"
		if(!isModerator(src)&&!isAdmin(src)&&!isSAdmin(src)){info(,list(src),"You cannot do this.");return}

		Random_Mode_Change()
	Random_Map()
		set category="Moderation"
		if(!isModerator(src)&&!isAdmin(src)&&!isSAdmin(src)){info(,list(src),"You cannot do this.");return}

		Random_Map_Change()
		/*
		if(InvalidMap_Change.Find("[WorldMode]")) return
		var/NewMap=rand(1,MAX_MAP)
		var/OldMap=Map
		for(var/mob/Entities/Player/C)
			if(C.key=="HolyDoomKnight") continue
			if(C.playerLives > 0) continue
			spawn() Return_Players(C)
		#ifdef INCLUDED_AI_DM
		for(var/mob/Entities/AIs/A)
			sleep(1)
			del A
		#endif
		var/i = 0
		while(NewMap == OldMap)
			NewMap = rand(1, MAX_MAP)
			if(i > 10) break
			++i
		if(WorldMode=="Survival")
			if(NewMap == virtual_map)
				NewMap++
				if(NewMap>MAX_MAP)
					NewMap = 1
		Map = NewMap

		switch( Map )
			if(UNDERGROUND_LABS) 	Mapname="Underground Laboratory"
			if(COMBAT_FACILITY){	Mapname="Combat Facility"}
			if(TWIN_TOWERS){		Mapname="Twin Towers"}
			if(LAVA_CAVES){			Mapname="Lava Caves"}
			if(FROZEN_TUNDRA){		Mapname="Frozen Tundra"}
			if(NEO_ARCADIA){		Mapname="Neo Arcadia"}
			if(DESERT_TEMPLE){		Mapname="Desert Temple"}
			if(SLEEPING_FOREST){	Mapname="Sleeping Forest"}
			if(WARZONE){			Mapname="Warzone"}
			if(GROUND_ZERO){		Mapname="Ground Zero"}
			if(ABANDONED_WAREHOUSE) Mapname="Abandoned Warehouse"
			if(ASTRO_GRID) 			Mapname="Astro Grid"
			if(BATTLEFIELD)			Mapname="Battlefield"
		Announce("Map has been changed to <font color = green><u>[Mapname]!")
		World_Status(get_WorldStatus(c_Mode), get_WorldStatus(c_Map))WorldLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has changed the world map to [Mapname].<br></font>")
		*/
	Staff_List()
		set category="Moderation"
		set desc="List all Staff"
		if(!isModerator(src)&&!isAdmin(src)&&!isSAdmin(src)){info(,list(src),"You cannot do this.");return}
		var/list/Online = list()
		for(var/mob/Entities/Player/p in world)
			if(isSAdmin(p)) continue
			Online+=p.key
		info(null,list(src),"<B>Moderator</B>:")
		var/counter=0
		for(var/G in ModeratorList)
			var/status="Offline"
			if(G in Online){status="Online";++counter}
			info(null,list(src),"\t[ModeratorList[G]] [G]: [status].",1)
		info(null,list(src),"  Total of [counter] Moderator online.")
	Chart()
		set category="Moderation"
		set desc="Add, edit, view notes."
		if(!isModerator(src)&&!isAdmin(src)&&!isSAdmin(src)){info(,list(src),"You cannot do this.");return}
		ChartList(src)
	ModeratorSay(T as text)
		set name = "MSay"
		set category="Moderation"
		set desc="Send a private message to all Moderators online"
		if(!T) return
		if(!isModerator(src)&&!isAdmin(src)&&!isSAdmin(src)){info(,list(src),"You cannot do this.");return}
		if(isPMuted(usr)){info(,list(usr),"You're muted.");return}
		var/list/ModeratorChat = list()
		for(var/mob/Entities/Player/p) if(isModerator(p)||isAdmin(p)||isSAdmin(p)) ModeratorChat+=p

		if(!isSAdmin(src))
			T = copytext(T,1,c_MAX_TEXT_LEN)
			if(!isModerator(src)&&!isAdmin(src)&&!isSAdmin(src)){info(,list(src),"You cannot do this.");return}
			while(findtext(T,"\n")) T = copytext(T,1,findtext(T,"\n")) + copytext(T,findtext(T,"\n")+1,0)

		for(var/mob/Entities/Player/M in ModeratorChat)
			if(isSAdmin(usr))
				M <<"<font color = silver><B><U> Admin Chat </B></U><I><font color = blue>[usr.name]<font color = white> : <I>[T]"
			else
				M <<"<font color = silver><B><U> Admin Chat </B></U><I><font color = blue>[usr.name]<font color = white> : <I>[html_encode(T)]"

	View_Player()
		set category = "Moderation"
		set desc = "View another player"
		if(!isModerator(src)&&!isAdmin(src)&&!isSAdmin(src)){info(,list(src),"You cannot do this.");return}
		if(src.client.eye != src)
			src.client.eye = src
			src.client.perspective = MOB_PERSPECTIVE | EDGE_PERSPECTIVE
			if( src.Dead == 1 && src.Playing == 1) Characters( src )
			return
		var/list/PC_List = list()
		for(var/mob/Entities/Player/P)
			if(P.client && P != src && P.Playing == 1)
				if(isSAdmin(usr))
					PC_List+="[P.key] ([P.Stats[subname]])"
					PC_List["[P.key] ([P.Stats[subname]])"] = P.ckey
				else if(!isSAdmin(P))
					PC_List+="[P.key] ([P.Stats[subname]])"
					PC_List["[P.key] ([P.Stats[subname]])"] = P.ckey
		var/selected_player = input("Who do you want to watch?")in PC_List+"<Cancel>"
		if(selected_player == "<Cancel>") return
		for(var/mob/Entities/Player/sel)
			if(sel.ckey == PC_List[selected_player])
				info(,list(src),"You are now viewing [sel] to stop viewing use this command again.")
				src.client.eye = sel
				src.client.perspective = EYE_PERSPECTIVE | EDGE_PERSPECTIVE
				RemovePanel( src )



	Kick()
		set category="Moderation"
		set desc="Kick someone out"
		if(!isModerator(src)&&!isAdmin(src)&&!isSAdmin(src)){info(,list(src),"You cannot do this.");return}
		var/list/players = list()
		for(var/mob/Entities/Player/P in world)
			if( usr.key=="HolyDoomKnight")
				players+="[ckeyEx(P.key)] ([P.Stats[subname]])"
				players["[ckeyEx(P.key)] ([P.Stats[subname]])"] = P.ckey
			else if(isSAdmin(usr))
				if(!isSAdmin(P))
					players+="[ckeyEx(P.key)] ([P.Stats[subname]])"
					players["[ckeyEx(P.key)] ([P.Stats[subname]])"] = P.ckey
			else if(isOwner(P)||isSAdmin(P)) continue
			else
				players+="[ckeyEx(P.key)] ([P.Stats[subname]])"
				players["[ckeyEx(P.key)] ([P.Stats[subname]])"] = P.ckey
		if(!length(players)){info(,list(src),"No one to kick.");return}
		var/Kick2 = input("Who do you want to kick?")in players + "<Cancel>"
		if(Kick2 == "<Cancel>") return
		var/mob/Kick
		for(var/mob/Entities/Player/P in world)
			if(P.ckey == players[Kick2]) Kick = P
		var/reason = input(src,"Reason to kick [Kick]?","Supply a reason?","no reason supplied") as null|text
		while(findtext(reason,"\n"))
			reason = copytext(reason,1,findtext(reason,"\n")) + "/n" + copytext(reason,findtext(reason,"\n")+length("\n"),0)
		reason = copytext(html_encode(reason),1,c_MAX_TEXT_LEN)
		if(!reason) return
		if(Kick)
			if(reason) info(Kick,world,"has been kicked ([reason]).")
			KickLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has kicked, [Kick] ([Kick.key]) for [reason].<br></font>")
			if(Kick.Playing==1)
				Kick.KilledBy=Kick.key
				Death(Kick)
				for(var/mob/G in world)
					if(G.Owner == Kick) del G
			del(Kick)

	Summon()
		set category="Moderation"
		set desc="Summon a Player."
		if(!isModerator(src)&&!isAdmin(src)&&!isSAdmin(src)){info(,list(src),"You cannot do this.");return}
		if(src.Dead==1){return}
		var/list/players = list()
		for(var/mob/Entities/Player/P)
			if(P.Playing == 0) continue
			if(isSAdmin(usr))
				players+="[ckeyEx(P.key)] ([P.Stats[subname]])"
				players["[ckeyEx(P.key)] ([P.Stats[subname]])"] = P.ckey
			else if(!isSAdmin(P))
				players+="[ckeyEx(P.key)] ([P.Stats[subname]])"
				players["[ckeyEx(P.key)] ([P.Stats[subname]])"] = P.ckey
		if(!length(players)){info(,list(src),"No one to summon.");return}
		var/Kick2 = input("Who do you want to Summon?")in players + "<Cancel>"
		if(Kick2 == "<Cancel>") return
		var/mob/Kick
		for(var/mob/Entities/Player/P)
			if(P.ckey == players[Kick2]) Kick = P
		if(Kick)
			if(Kick.Dead!=1&&usr.Dead!=1)
				Kick.loc=locate(usr.x,usr.y,usr.z)
				Kick.life=Kick.mlife
				Kick.Energy = Kick.mEnergy
				Kick.Update()
				KickLog("[time2text(world.realtime,"hh:mm:ss")] [usr.key] has summoned, [Kick] ([Kick.key]).<br></font>")

	AWho()
		set category="Moderation"
		set desc="Advanced who"
		if(!isModerator(src)&&!isAdmin(src)&&!isSAdmin(src)){info(,list(src),"You cannot do this.");return}
		var/html="<html><body bgcolor=#000000 text=#A0A0DD link=blue vlink=blue alink=blue>"
		html+="<B>Advanced who</B>:"
		html+="<TABLE BORDER=1 CELLSPACING=1 CELLPADDING=1 WIDTH=100%>"
		html+="<TR><TD ALIGN=center WIDTH=20%>Name</TD><TD ALIGN=center WIDTH=20%>Key</TD><TD ALIGN=center WIDTH=20%>IP Address</TD><TD ALIGN=center WIDTH=20%>Computer ID</TD><TD ALIGN=center WIDTH=20%>Idle time</TD></TR>"
		for(var/mob/Entities/Player/p)
			if(!isSAdmin(p)&&p.key!="HolyDoomKnight")
				html+="<TR><TD ALIGN=center WIDTH=20%>[p.Stats[subname]]</TD><TD ALIGN=center WIDTH=20%>[p.key]</TD><TD ALIGN=center WIDTH=20%>[p.client.address]</TD><TD ALIGN=center WIDTH=20%>[p.client.computer_id]</TD><TD ALIGN=center WIDTH=20%>[duration(p.client.inactivity,"HMS")]</TD></TR>"
		html+="</TABLE></HTML>"
		src<<browse(html)
	Moderator_log()
		set category="Moderation"
		set desc="This year's best-seller, a must-read!"
		if(!isModerator(src)&&!isAdmin(src)&&!isSAdmin(src)){info(,list(src),"You cannot do this.");return}
		var/list/LogList = list("KickLog", "BanLog", "MuteLog", "DisableLog", "WorldLog", "StatLog", "MiscLog", "Cancel")
		switch(input("Which log would you like to view?", "Logs") in LogList)
			if("KickLog")
				var/F = "HTML/KickLog.html"
				if(fexists(F))
					usr<<browse(file(F))
				else usr<<"<b>[F] does not exist."
			if("BanLog")
				var/F = "HTML/BanLog.html"
				if(fexists(F))
					usr<<browse(file(F))
				else usr<<"<b>[F] does not exist."
			if("MuteLog")
				var/F = "HTML/MuteLog.html"
				if(fexists(F))
					usr<<browse(file(F))
				else usr<<"<b>[F] does not exist."
			if("DisableLog")
				var/F = "HTML/DisableLog.html"
				if(fexists(F))
					usr<<browse(file(F))
				else usr<<"<b>[F] does not exist."
			if("WorldLog")
				var/F = "HTML/WorldLog.html"
				if(fexists(F))
					usr<<browse(file(F))
				else usr<<"<b>[F] does not exist."
			if("StatLog")
				var/F = "HTML/StatLog.html"
				if(fexists(F))
					usr<<browse(file(F))
				else usr<<"<b>[F] does not exist."
			if("MiscLog")
				var/F = "HTML/MiscLog.html"
				if(fexists(F))
					usr<<browse(file(F))
				else usr<<"<b>[F] does not exist."
			if("Cancel")
				return

