
#define enableAFKSweep 0

var
	const
		c_MAX_AUTOMATED_TIME 	= 2
		c_mapTIME 				= 1
		c_modeTime 				= 2
		c_INACTIVE				= 200
	global
		g_MAP_CHANGE_FREQUENCY = 3
		g_MODE_CHANGE_FREQUENCY = 1
		automatedTime = c_MAX_AUTOMATED_TIME
		lastAutomatedChange = c_MAX_AUTOMATED_TIME
		AFKSweepOn = FALSE;
		previousMode = null;

proc
	isAFKSweep(var/b)
		if(AFKSweepOn == TRUE) return TRUE;
		else return FALSE;
	Auto_World_Change()
		var/curTime = text2num(time2text(world.timeofday,"hh"))
		if( abs(curTime-lastAutomatedChange) >= g_MAP_CHANGE_FREQUENCY && curTime != automatedTime)
			Random_Map_Change()
			automatedTime 		= curTime
			lastAutomatedChange 	= curTime
		sleep(1)
		if( abs(curTime-lastAutomatedChange) >= g_MODE_CHANGE_FREQUENCY && curTime != automatedTime)
			if(Random_Mode_Change() == 1)
				automatedTime 		= curTime
				lastAutomatedChange = curTime

	Random_Mode_Change()
		if(g_WorldMode != "Battle") return 0


		// Create a list of "active" players
		var/list/activePlayers = list()
		for(var/mob/Entities/Player/P)
			if(isPlaying(P) == 0 || P.client.inactivity >= c_INACTIVE) continue
			activePlayers += P.key
		// Determine available game modes from active amount
		var/lengthofActive = activePlayers.len
		if(lengthofActive < 4)
			return 0

		var/list/GameMode = list(
		"Deathmatch","Team Deathmatch","Protect The Base"
		,"Warzone", "Assassination","Boss Battle"
		,"Dual Boss Battle","Battle of the Bosses"
		,"Juggernaut","Berserker")
		GameMode -= previousMode
		var/RandMode = GameMode[rand(1, GameMode.len)]
		Mode_Reset()
		previousMode = RandMode
		set_WorldStatus(c_Mode, RandMode)
		switch(RandMode)
			if("Protect The Base")

				for(var/mob/Entities/Player/B)
					if(B.Playing==1)
						Return_Players(B)
						Randomize_Teams(B)
				set_WorldStatus(c_Mapname, "Combat Facility")
				new /mob/Entities/PTB/Red(locate(25,6,2))
				new /mob/Entities/PTB/Blue(locate(29,83,2))
				new /mob/Entities/PTB/Yellow(locate(73,83,2))
				new /mob/Entities/PTB/Green(locate(77,6,2))

				Announce("Amount of players in Red: [redTeam.len]")
				Announce("Amount of players in Blue: [blueTeam.len]")
				Announce("Amount of players in Yellow: [yellowTeam.len]")
				Announce("Amount of players in Green: [greenTeam.len]")
			if("Warzone")

				for(var/mob/Entities/Player/B)
					if(B.Playing==1)
						Return_Players(B)
						Randomize_Teams(B)
				TeamLocked[c_YELLOW]=1
				TeamLocked[c_GREEN]=1
				set_WorldStatus(c_Mapname, "Warzone")
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

				sleep(1)
				for(var/mob/Entities/PTB/P in world)
					P.pixel_y=0
					P.pixel_x=0
					P.life = (P.mlife*2)
			if("Boss Battle")

				var/Boss = activePlayers[rand(1, lengthofActive)]
				var/list/KillLimitList = list(75, 100, 125, 150)
				var/list/HealthList = list(1000, 1250, 1500, 1750, 2000)
				EventKillLimit = KillLimitList[rand(1, KillLimitList.len)]
				for(var/mob/Entities/Player/A in world)
					if(A.Playing == 0) continue
					if(A.key == Boss)
						Bosses+=Boss
						A.Stats[c_Team]="Blue"
						if(A.Dead!=1)
							for(var/X in typesof(/obj/Characters/Team)) A.overlays-=X
							A.overlays+=new /obj/Characters/Team/blue
						A.mlife=HealthList[rand(1, HealthList.len)]
						A.life=A.mlife
						A.Attack*=3
						A.Update()
						Announce("[Bosses[1]] has been designated as the Boss.")
					else
						A.Stats[c_Team]="Red"
						Return_Players(A)
			if("Dual Boss Battle")

				Bosses+= activePlayers[rand(1, activePlayers.len)]
				activePlayers-=Bosses[1]

				Bosses+= activePlayers[rand(1, activePlayers.len)]

				var/list/KillLimitList = list(150, 200, 250, 300)
				var/list/HealthList = list(1000, 1500, 2000, 2500, 3000)
				EventKillLimit = KillLimitList[rand(1, KillLimitList.len)]
				var/playerLife = HealthList[rand(1, HealthList.len)]
				for(var/mob/Entities/Player/C)
					if(Bosses.Find(C.key))
						C.Stats[c_Team]="Blue"
						if(C.Dead!=1)
							for(var/X in typesof(/obj/Characters/Team)) C.overlays-=X
							C.overlays+=new /obj/Characters/Team/blue
						C.mlife=playerLife
						C.life=C.mlife
						C.Attack*=3
						C.Update()
					else if(C.Playing==1)
						C.Stats[c_Team]="Red"
						Return_Players(C)
				Announce("[Bosses[1]] has been designated as the Boss.")
				Announce("[Bosses[2]] has been designated as the 2nd Boss.")
			if("Battle of the Bosses")


				Bosses+= activePlayers[rand(1, activePlayers.len)]
				activePlayers-=Bosses[1]

				Bosses+= activePlayers[rand(1, activePlayers.len)]
				var/list/HealthList = list(1000, 1250, 1500, 1750, 2000)
				var/playerLife = HealthList[rand(1, HealthList.len)]
				for(var/mob/Entities/Player/C in world)
					if(Bosses.Find(C.key))
						C.mlife=playerLife
						C.life=C.mlife
						C.Attack*=3
						C.Update()
						if(C.key==Bosses[1])
							C.Stats[c_Team]="Blue"
							if(C.Dead!=1)
								for(var/X in typesof(/obj/Characters/Team)) C.overlays-=X
								C.overlays+=new /obj/Characters/Team/blue
						if(C.key==Bosses[2])
							C.Stats[c_Team]="Yellow"
							if(C.Dead!=1)
								for(var/X in typesof(/obj/Characters/Team)) C.overlays-=X
								C.overlays+=new /obj/Characters/Team/yellow
					else if(C.Playing==1)
						C.Stats[c_Team]="Red"
						Return_Players(C)
				Announce("[Bosses[1]] has been designated as the Boss.")
				Announce("[Bosses[2]] has been designated as the 2nd Boss.")

			if("Deathmatch")
				var/list/EventKillList = list(25, 50, 75, 100)
				EventKillLimit = EventKillList[rand(1, EventKillList.len)]
				for(var/mob/Entities/Player/B in world)
					Return_Players(B)
					B.Stats[c_Team]="N/A"
					B.subkills=0
				Announce("Deathmatch Kill Limit of [EventKillLimit]")
			if("Team Deathmatch")
				var/list/EventKillList = list(100, 150, 200, 250)
				EventKillLimit = EventKillList[rand(1, EventKillList.len)]
				for(var/mob/Entities/Player/B)
					Return_Players(B)
					Randomize_Teams(B)
				Announce("Team Deathmatch Kill Limit set to [EventKillLimit]")
			if("Assassination")
				// Populate selection list


				var/list/LeaderList[c_MAX_PUBLIC_TEAMS]
				for(var/i = 1 to c_MAX_PUBLIC_TEAMS)
					LeaderList[i] = activePlayers[rand(1, activePlayers.len)]
					activePlayers -= LeaderList[i]
				var/list/playerLifeList = list(1500, 2000, 2500, 3000)
				var/playerLife = playerLifeList[rand(1, playerLifeList.len)]
				for(var/i in TeamLeaders.len)
					TeamLeaders -= i
				for(var/i in c_MAX_PUBLIC_TEAMS)
					TeamLeaders += LeaderList[i]

				for(var/mob/Entities/Player/C)
					if(LeaderList.Find(C.key))
						C.mlife=playerLife
						C.life=C.mlife
						C.Attack*=3
						C.Update()

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
				Announce("[TeamLeaders[1]] has been designated as the Red Leader.")
				Announce("[TeamLeaders[2]] has been designated as the Blue Leader.")
				Announce("[TeamLeaders[3]] has been designated as the Yellow Leader.")
				Announce("[TeamLeaders[4]] has been designated as the Green Leader.")

			if("Juggernaut") // Regular player with 2x HP



				var/Jugger = activePlayers[rand(1, lengthofActive)]

				var/list/EventKillList = list(25, 50, 75)
				EventKillLimit = EventKillList[rand(1, EventKillList.len)]
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

			if("Berserker") // Regular player with x2 Attack, HP drain and has to kill to restore HP.
				var/Berserk = activePlayers[rand(1, lengthofActive)]
				var/list/EventKillList = list(50, 75, 100)
				EventKillLimit = EventKillList[rand(1, EventKillList.len)]
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

		#ifdef INCLUDED_AI_DM
		for(var/mob/Entities/AIs/A)
			sleep(1)
			del A
		#endif

		Announce("World Mode changed to [get_WorldStatus(c_Mode)]!  Scores Reset!")
		World_Status(g_WorldMode, g_Mapname)
		WorldLog("[time2text(world.realtime,"hh:mm:ss")] Server has changed the world mode to [get_WorldStatus(c_Mode)].<br></font>")
		return 1
	Random_Map_Change()
		if(Invalid_Map_Change()) return
		var/NewMap = rand(1, g_listofMaps.len)
		#ifdef INCLUDED_AI_DM
		for(var/mob/Entities/AIs/A)
			sleep(1)
			del A
		#endif
/*
		UNDERGROUND_LABS 	= 1
		COMBAT_FACILITY 	= 2
#ifdef TWINTOWERS_MAP
		TWIN_TOWERS 		= 3
#endif
		LAVA_CAVES 			= 4
		FROZEN_TUNDRA 		= 5
		NEO_ARCADIA 		= 6
		DESERT_TEMPLE 		= 7
		SLEEPING_FOREST 	= 8
		WARZONE 			= 9
		GROUND_ZERO 		= 10
		ABANDONED_WAREHOUSE = 11
#ifdef ASTRO_GRID_MAP
		ASTRO_GRID 			= 12
#endif
		BATTLEFIELD 		= 13
*/
		switch(NewMap)
			if(3, 12)
				--NewMap
		if(get_WorldStatus(c_Mode)=="Survival")
			if(NewMap == get_WorldStatus(c_vMapname))
				NewMap++
				if(NewMap>MAX_MAP)
					NewMap = 1
		set_WorldStatus(c_Map, NewMap)
		Announce("Map has been changed to <font color = green><u>[get_WorldStatus(c_Mapname)]!")
		for(var/obj/Drops/O in world)
			spawn(1) del O
		World_Status(get_WorldStatus(c_Mode), get_WorldStatus(c_Mapname))
		WorldLog("[time2text(world.realtime,"hh:mm:ss")] Server has changed the world map to [get_WorldStatus(c_Mapname)].<br></font>")
		for(var/mob/Entities/Player/C)
			if(C.key=="HolyDoomKnight" || C.playerLives > 0) continue
			spawn(1)
			if(C.Dead == 0 && C.Playing == 1)
				Map_Location(C)
				//Return_Players(C)