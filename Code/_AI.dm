#ifndef INCLUDED_AI_DM
#define INCLUDED_AI_DM
#define AI_DEBUG 1
/*
AI Plans

Stage 1
- Simple AI Implementation with use of rand()
- Have the AI face the a majority of the time with wall Avoidance

Stage 2
- Improved AI functionality by utilizing prib
- Give Priority attacking, such as ignoring people it cannot harm
- Improve targeting to first player it comes in contact with until player is out of sight or dies

Stage 3
- Improve AI's attack priority as to what attack to use given the situation
- Give AI the ability to move around the environment

Stage 4
- Allow AIs to hurt each other with any move set.
- Give each AI it's own ID and something to refresh that ID to be free
- AI Entity Manager

AI Info
- Types of AI Algorithm
-- Territorial AI
--- AI has a territory that pursues anything within that area
-- Solo AI
--- Specified for one vs one only
-- Multi AI
--- Tasked with multiple opponents
- Type of AI Attack Algorithm
-- Constant Attack
--- Always attacking
-- Attack when a player is in view
--- Attacking only when a player is near
- Types of AI Difficulty
-- Easy AI
--- Purely random and not dedicated to defeating the player
--- Moves randomly away or towards the player
--- Shoots away or towards the player
-- Medium AI
--- More designated to attack the player
--- Faces the player often, rarely moves or attacks away from the player
--- More controlled shots rather then frequent
-- Hard AI
--- Always facing the first player it comes in contact with
--- More accurate in attacks, such as leading a shot or setting the player up
-- Impossible AI
--- Takes in account to all attacks and  in view
--- Dodges as well as counters all attacks if possible
--- Counters with the best possibile means
*/
var/const
	SpawnH = 1
	SpawnP = 0
	AI_SIGHT = 5
	AI_ATTACK_SIGHT = 7
var/AISpawn = SpawnH
var/AITeam = "N/A"
var/startSpawn = 0

var/const/c_MAX_AUTOMATED_AI_TIME_IN_MINUTES = 5
var/global
	g_AI_SPAWN_FREQUENCY_IN_MINUTES = 2
	automatedAITime = c_MAX_AUTOMATED_AI_TIME_IN_MINUTES
	lastAutomatedAIChange = c_MAX_AUTOMATED_AI_TIME_IN_MINUTES

proc/Auto_AI_Spawn()
	var/curTime = text2num(time2text(world.timeofday,"mm"))
	DebugLog("[time2text(world.realtime,"hh:mm:ss")] AI Time<br></font>")
	if( abs(curTime-lastAutomatedAIChange) >= g_AI_SPAWN_FREQUENCY_IN_MINUTES && curTime != automatedAITime)
		automatedAITime 		= curTime
		lastAutomatedAIChange 	= curTime
		#if AI_DEBUG
		DebugLog("[curTime]")
		#endif
		Auto_Spawn_AIs()
	sleep(2500 * world.tick_lag)
	Auto_AI_Spawn()

proc
	AI_Goto_Map(var/mob/Entities/AIs/M)
		if(isnull(M))
			DebugLog("No AI to send to map.");
			return 0
		M.pixel_y = -16
		DebugLog("Sending [M] to map. [M.loc] [get_WorldStatus(c_Map)]")
		switch(get_WorldStatus(c_Map))
			if(UNDERGROUND_LABS)
				switch(M.Class)
					if("ModelGate", "ModelBD")
						M.pixel_y = -8
				switch(rand(1,5))
					if(1) M.loc=locate(/turf/SpawnPoints/UndergroundLab/Spawn00)
					if(2) M.loc=locate(/turf/SpawnPoints/UndergroundLab/Spawn01)
					if(3) M.loc=locate(/turf/SpawnPoints/UndergroundLab/Spawn02)
					if(4) M.loc=locate(/turf/SpawnPoints/UndergroundLab/Spawn03)
					if(5) M.loc=locate(/turf/SpawnPoints/UndergroundLab/Spawn04)
			if(COMBAT_FACILITY)
				switch(M.Class)
					if("ModelGate", "ModelBD")
						M.pixel_y = -8

				switch(rand(1,5))
					if(1) M.loc=locate(50,41,2)
					if(2) M.loc=locate(14,15,2)
					if(3) M.loc=locate(14,84,2)
					if(4) M.loc=locate(87,84,2)
					if(5) M.loc=locate(87,15,2)
			#ifdef TWINTOWERS_MAP
			if(TWIN_TOWERS)
				switch(M.Class)
					if("ModelGate", "ModelBD")
						M.pixel_y = -8
				switch(rand(1,4))
					if(1) M.loc=locate(/turf/SpawnPoints/TwinTowers/Spawn00)
					if(2) M.loc=locate(/turf/SpawnPoints/TwinTowers/Spawn01)
					if(3) M.loc=locate(/turf/SpawnPoints/TwinTowers/Spawn02)
					if(4) M.loc=locate(/turf/SpawnPoints/TwinTowers/Spawn03)
			#endif
			if(LAVA_CAVES)
				switch(M.Class)
					if("ModelGate", "ModelBD")
						M.pixel_y = -12
				switch(rand(1,4))
					if(1) M.loc=locate(15,85,5)
					if(2) M.loc=locate(86,17,5)
					if(3) M.loc=locate(15,17,5)
					if(4) M.loc=locate(86,85,5)
			if(FROZEN_TUNDRA)
				switch(M.Class)
					if("ModelGate", "ModelBD")
						M.pixel_y = -8
				switch(rand(1,4))
					if(1) M.loc=locate(/turf/SpawnPoints/FrozenTundra/Spawn00)
					if(2) M.loc=locate(/turf/SpawnPoints/FrozenTundra/Spawn01)
					if(3) M.loc=locate(/turf/SpawnPoints/FrozenTundra/Spawn02)
					if(4) M.loc=locate(/turf/SpawnPoints/FrozenTundra/Spawn03)
					/*
					if(1) M.loc=locate(10,24,6)
					if(2) M.loc=locate(10,12,6)
					if(3) M.loc=locate(91,24,6)
					if(4) M.loc=locate(91,12,6)
					*/
			if(NEO_ARCADIA)
				switch(M.Class)
					if("ModelGate", "ModelBD")
						M.pixel_y = -16
				switch(rand(1,4))
					if(1) M.loc=locate(48,95,7)
					if(2) M.loc=locate(48,46,7)
					if(3) M.loc=locate(7,32,7)
					if(4) M.loc=locate(94,32,7)
			if(DESERT_TEMPLE)
				M.pixel_y=-3

				switch(rand(1,6))
					if(1) M.loc=locate(3,9,8)
					if(2) M.loc=locate(98,7,8)
					if(3) M.loc=locate(54,27,8)
					if(4) M.loc=locate(42,53,8)
					if(5) M.loc=locate(42,79,8)
					if(6) M.loc=locate(8,78,8)
			if(SLEEPING_FOREST)
				M.pixel_y=-4

				switch(rand(1,4))
					if(1) M.loc=locate(4,13,9)
					if(2) M.loc=locate(45,27,9)
					if(3) M.loc=locate(75,32,9)
					if(4) M.loc=locate(97,21,9)
			if(WARZONE)
				M.pixel_y=-4

				switch(rand(1,6))
					if(1)
						M.loc=locate(2,34,10)
					if(2)
						M.loc=locate(4,15,10)
					if(3)
						M.loc=locate(41,11,10)
					if(4)
						M.loc=locate(99,34,10)
					if(5)
						M.loc=locate(97,15,10)
					if(6)
						M.loc=locate(59,11,10)
			if(GROUND_ZERO)
				M.pixel_y=-14

				switch(rand(1,6))
					if(1) M.loc=locate(2,22,11)
					if(2) M.loc=locate(16,72,11)
					if(3) M.loc=locate(32,72,11)
					if(4) M.loc=locate(70,72,11)
					if(5) M.loc=locate(86,72,11)
					if(6) M.loc=locate(99,22,11)
			if(ABANDONED_WAREHOUSE)
				M.pixel_y=-4
			//	switch( WorldMode )
				switch(rand(1,6))
					if(1) M.loc=locate(2,16,12)
					if(2) M.loc=locate(98,11,12)
					if(3) M.loc=locate(88,45,12)
					if(4) M.loc=locate(6,47,12)
					if(5) M.loc=locate(3,79,12)
					if(6) M.loc=locate(98,84,12)
#ifdef ASTRO_GRID_MAP
			if(ASTRO_GRID)
				switch(M.Class)
					if("ModelGate", "ModelBD")
						M.pixel_y = -8
				switch(rand(1,8))
					if(1) M.loc=locate(/turf/Theme/MaB/Astroman/spawns/one)
					if(2) M.loc=locate(/turf/Theme/MaB/Astroman/spawns/two)
					if(3) M.loc=locate(/turf/Theme/MaB/Astroman/spawns/three)
					if(4) M.loc=locate(/turf/Theme/MaB/Astroman/spawns/four)
					if(5) M.loc=locate(/turf/Theme/MaB/Astroman/spawns/five)
					if(6) M.loc=locate(/turf/Theme/MaB/Astroman/spawns/six)
					if(7) M.loc=locate(/turf/Theme/MaB/Astroman/spawns/seven)
					if(8) M.loc=locate(/turf/Theme/MaB/Astroman/spawns/eight)
#endif
			if(BATTLEFIELD)
				M.pixel_y = -4
				switch(rand(1,4))
					if(1) M.loc=locate(/turf/SpawnPoints/Battlefield/Spawn00)
					if(2) M.loc=locate(/turf/SpawnPoints/Battlefield/Spawn01)
					if(3) M.loc=locate(/turf/SpawnPoints/Battlefield/Spawn00)
					if(4) M.loc=locate(/turf/SpawnPoints/Battlefield/Spawn00)
		return 1
	Auto_Spawn_AIs()
		var/continueLoop = 1
	#if AI_DEBUG
		for(var/mob/M in world)
			if(isDebugger(M))
				M<<"Starting to spawn AIs"
	#endif

	#if AI_DEBUG
		for(var/mob/M in world)
			if(isDebugger(M))
				M<<"We have [listofPlayers.len] players."
	#endif
		if(world.cpu>3)
		#if AI_DEBUG
			for(var/mob/M in world)
				if(isDebugger(M))
					M<<"World CPU [world.cpu] > then allowed amount. Ending AI Spawning"
		#endif
			continueLoop = 0

		if(continueLoop)
#ifdef INCLUDED_CUTMAN_DM
			spawn() new /mob/Entities/AIs/EasyAI/_Cutman
	#endif
			spawn() new /mob/Entities/AIs/EasyAI/_Protoman
			spawn() new /mob/Entities/AIs/EasyAI/_Grenademan
			spawn() new /mob/Entities/AIs/EasyAI/_GBD
			spawn() new /mob/Entities/AIs/EasyAI/_DrWily
			spawn() new /mob/Entities/AIs/EasyAI/_Knightman
			spawn() new /mob/Entities/AIs/EasyAI/_Megaman
			spawn() new /mob/Entities/AIs/EasyAI/_Bass
			spawn() new /mob/Entities/AIs/EasyAI/_Met
			spawn() new /mob/Entities/AIs/EasyAI/_Duo
			spawn() new /mob/Entities/AIs/EasyAI/_Omega
			spawn()
			for(var/mob/Entities/AIs/M in world)

				if(isnull(M))
					DebugLog("NULL AI, unable to spawn")
					break
				DebugLog("AI [M], [AI_Goto_Map(M)] spawned")
/*
turf
	misc
		name = ""
		AISpawnPoint // LOL FOR NOW, should only be one instance
			density = 0
			New()
				..()
				g_SpawnAI+=2
				DebugLog("AI - Time to spawn AIs [g_SpawnAI]")
				sleep(g_SpawnAI)
				src.SpawnAIHere()
	proc
		SpawnAIHere()
			DebugLog("AI - Spawning AI Here.")
			Auto_Spawn_AIs()
			spawn()
			for(var/mob/Entities/AIs/M in world)

				if(isnull(M))
					DebugLog("NULL AI, unable to spawn")
					return
				DebugLog("AI [M], [AI_Goto_Map(M)] spawned")
			spawn(2500) src.SpawnAIHere()
*/
mob/AI/proc
	Kill_AIs()
		set category = "AI"
		for(var/mob/Entities/AIs/M in world)
			Death(M)
/*	Spawn_Them()
		set category = "AI"
		if(startSpawn == 0)
			startSpawn = 1
		else
			startSpawn = 0
		usr<<"Starting spawn [startSpawn]"
		return
	SpawnHere()
		set category = "AI"
		AISpawn = SpawnH
	SpawnPoints()
		set category = "AI"
		AISpawn = SpawnP
	Spawn_AIs()
		set category = "AI"
		AISpawn = SpawnP
		while(startSpawn == 1)
			sleep(250)
			if(world.cpu>3)
				break
#ifdef INCLUDED_CUTMAN_DM

			spawn() new /mob/Entities/AIs/EasyAI/_Cutman(locate(src.x,src.y+1,src.z))
#endif
			var/mob/Entities/AIs/EasyAI/AI = new /mob/Entities/AIs/EasyAI/_Protoman
			spawn() AI_Goto_Map(AI)
			spawn() AI_Goto_Map(new /mob/Entities/AIs/EasyAI/_Grenademan)
			spawn() AI_Goto_Map(new /mob/Entities/AIs/EasyAI/_GBD)
			spawn() AI_Goto_Map(new /mob/Entities/AIs/EasyAI/_DrWily)
			spawn() AI_Goto_Map(new /mob/Entities/AIs/EasyAI/_Knightman)
			spawn() AI_Goto_Map(new /mob/Entities/AIs/EasyAI/_Megaman)
			spawn() AI_Goto_Map(new /mob/Entities/AIs/EasyAI/_Bass)
			spawn() AI_Goto_Map(new /mob/Entities/AIs/EasyAI/_Met)
			spawn() AI_Goto_Map(new /mob/Entities/AIs/EasyAI/_Duo)
			spawn() AI_Goto_Map(new /mob/Entities/AIs/EasyAI/_Omega)
		*/
			/*spawn() new /mob/Entities/AIs/EasyAI/_Protoman(locate(src.x,src.y+1,src.z))
			spawn() new /mob/Entities/AIs/EasyAI/_Grenademan(locate(src.x,src.y+1,src.z))
			spawn() new /mob/Entities/AIs/EasyAI/_GBD(locate(src.x,src.y+1,src.z))
			spawn() new /mob/Entities/AIs/EasyAI/_DrWily(locate(src.x,src.y+1,src.z))
			spawn() new /mob/Entities/AIs/EasyAI/_Knightman(locate(src.x,src.y+1,src.z))
			spawn() new /mob/Entities/AIs/EasyAI/_Megaman(locate(src.x,src.y+1,src.z))
			spawn() new /mob/Entities/AIs/EasyAI/_Bass(locate(src.x,src.y+1,src.z))
			spawn() new /mob/Entities/AIs/EasyAI/_Met(locate(src.x,src.y+1,src.z))
			spawn() new /mob/Entities/AIs/EasyAI/_Duo(locate(src.x,src.y+1,src.z))
			spawn() new /mob/Entities/AIs/EasyAI/_Omega(locate(src.x,src.y+1,src.z))
			*/

	AICount()
		set category = "AI"
		var/Counter = 0;
		for(var/mob/Entities/AIs/M in world)
			++Counter
			usr<<"AI [M.Class] [M.x], [M.y], [M.z]"
		usr<<"Your location [usr.x] [usr.y] [usr.z]. There are [Counter] AIs in the world currently."
	Summon_All_AI()
		set category = "AI"
		for(var/mob/Entities/AIs/M in world)
			M.loc=usr.loc
	AI_Team()
		set category="AI"
		var/userteam=input("What team would you like to be on?","Teams",usr.Stats[c_Team])in list("Red","Blue","Yellow","Green","Silver","Purple","Neutral")
		AITeam=userteam

	Easy_X_AI()
		set category = "AI"
		new /mob/Entities/AIs/EasyAI/_X(locate(src.x,src.y+1,src.z))
//================================================
// Shoot AIs
//================================================
	Easy_Protoman_AI()
		set category = "AI"
		new /mob/Entities/AIs/EasyAI/_Protoman(locate(src.x,src.y+1,src.z))
#ifdef INCLUDED_AI_MEDIUM_DM
	Medium_Protoman_AI()
		set category = "AI"
		new /mob/Entities/AIs/MediumAI/_Protoman(locate(src.x,src.y+1,src.z))
#endif
#ifdef INCLUDED_CUTMAN_DM
	Easy_Cutman_AI()
		set category = "AI"
		new /mob/Entities/AIs/EasyAI/_Cutman(locate(src.x,src.y+1,src.z))
#endif
	Easy_Grenademan_AI()
		set category = "AI"
		new /mob/Entities/AIs/EasyAI/_Grenademan(locate(src.x,src.y+1,src.z))
#ifdef INCLUDED_CZero_DM
	Easy_CZero_AI()
		set category = "AI"
		new /mob/Entities/AIs/EasyAI/_CZero(locate(src.x,src.y+1,src.z))
#endif
#ifdef INCLUDED_CX_DM
	Easy_CX_AI()
		set category = "AI"
		new /mob/Entities/AIs/EasyAI/_CX(locate(src.x,src.y+1,src.z))
#endif
	Easy_GBD_AI()
		set category = "AI"
		new /mob/Entities/AIs/EasyAI/_GBD(locate(src.x,src.y+1,src.z))
#ifdef INCLUDED_MAGMA_DM
	Easy_Magma_AI()
		set category = "AI"
		new /mob/Entities/AIs/EasyAI/_Magma(locate(src.x,src.y+1,src.z))
#endif
	Easy_DrWily_AI()
		set category = "AI"
		new /mob/Entities/AIs/EasyAI/_DrWily(locate(src.x,src.y+1,src.z))
	Easy_Knightman_AI()
		set category = "AI"
		new /mob/Entities/AIs/EasyAI/_Knightman(locate(src.x,src.y+1,src.z))

//================================================
// Shoot and Dash AIs
//================================================
	Easy_Megaman_AI()
		set category = "AI"
		new /mob/Entities/AIs/EasyAI/_Megaman(locate(src.x,src.y+1,src.z))
	Easy_Bass_AI()
		set category = "AI"
		new /mob/Entities/AIs/EasyAI/_Bass(locate(src.x,src.y+1,src.z))
//================================================
// Shoot and Guard AIs
//================================================
	Easy_Met_AI()
		set category = "AI"
		new /mob/Entities/AIs/EasyAI/_Met(locate(src.x,src.y+1,src.z))
//================================================
// AOE AIs
//================================================
	Easy_Duo_AI()
		set category = "AI"
		new /mob/Entities/AIs/EasyAI/_Duo(locate(src.x,src.y+1,src.z))
	Easy_Omega_AI()
		set category = "AI"
		new /mob/Entities/AIs/EasyAI/_Omega(locate(src.x,src.y+1,src.z))

	Easy_Randomness_AI()
		set category = "AI"
		new /mob/Entities/AIs/Randomness_AI(locate(src.x,src.y+1,src.z))


mob/Entities/AIs
	density = 1

	Randomness_AI
		New()
			..()
			src.name = "Randomness AI"
			src.icon = 'Random1.dmi'
			src.icon_state = "left"
			src.life = 28
			src.mlife = 28
			src.delay = 5
			src.Class = "Randomness"
			src.Attack = 28
			src.pixel_x = 0
			src.Guard = 3
			src.Attack = 5
			src.Flight = 1
			src.pixel_x = 0
			src.pixel_y = -16
			src.BulletIcon = null
			src.jumpHeight = 2.0
			src.MoveDelay = 2
			src.ReverseDMG = 1
			src.overlays = list()
			for(var/X in typesof(/obj/Characters/Randomness)) src.overlays+=X
			src.Randomness_AI()
#ifdef INCLUDED_AI_MEDIUM_DM
	MediumAI
		_Protoman
			New()
				..()
				src.name = "Protoman AI"
				src.icon = 'Protoman(2).dmi'
				src.icon_state = "left"
				src.life = 28
				src.mlife = 28
				src.delay = 5
				src.Class = "Protoman"
				src.Attack = 3
				src.pixel_x = -16
				src.BulletIcon = 'Protoshot.dmi'
				src.jumpHeight = 2.0
				src.MoveDelay = 1
				src.overlays = list()
				for(var/X in typesof(/obj/Characters/Protoman)) src.overlays+=X
				src.MEDIUM_Shoot_AI()
#endif
	EasyAI
		_X
			New()
				..()
				src.name = "X AI"
				src.icon = 'X(2).dmi'
				src.icon_state = "left"
				src.life = 28
				src.mlife = 28
				src.delay = 5
				src.Class = "X"
				src.Attack = 2
				src.pixel_x = -16
				src.BulletIcon = 'XShot.dmi'
				src.jumpHeight = 2.0
				src.MoveDelay = 2
				src.overlays = list()
				for(var/X in typesof(/obj/Characters/X)) src.overlays+=X
				src.X_AI()
		_Megaman
			New()
				..()
				src.name = "Megaman AI"
				src.icon = 'Megaman(2).dmi'
				src.icon_state = "left"
				src.life = 28
				src.mlife = 28
				src.delay = 4
				src.Class = "X"
				src.Attack = 1
				src.pixel_x = -16
				src.BulletIcon = 'Megashot.dmi'
				src.jumpHeight = 2.0
				src.MoveDelay = 2
				src.overlays = list()
				for(var/X in typesof(/obj/Characters/Megaman)) src.overlays+=X
				src.Easy_Shoot_Dash_AI()
		_Bass
			New()
				..()
				src.name = "Bass AI"
				src.icon = 'Bass(2).dmi'
				src.icon_state = "left"
				src.life = 28
				src.mlife = 28
				src.delay = 5
				src.Class = "Bass"
				src.Attack = 3
				src.pixel_x = -16
				src.BulletIcon = 'BassShot.dmi'
				src.jumpHeight = 2.0
				src.MoveDelay = 2
				src.overlays = list()
				for(var/X in typesof(/obj/Characters/Bass)) src.overlays+=X
				src.Easy_Shoot_Dash_AI()
		_Protoman
			New()
				..()
				src.name = "Protoman AI"
				src.icon = 'Protoman(2).dmi'
				src.icon_state = "left"
				src.life = 28
				src.mlife = 28
				src.delay = 5
				src.Class = "Protoman"
				src.Attack = 3
				src.pixel_x = -16
				src.BulletIcon = 'Protoshot.dmi'
				src.jumpHeight = 2.0
				src.MoveDelay = 1
				src.Shooting = 0
				src.overlays = list()
				for(var/X in typesof(/obj/Characters/Protoman)) src.overlays+=X
				src.Easy_Shoot_AI()
#ifdef INCLUDED_CUTMAN_DM
		_Cutman
			New()
				..()
				src.name = "Cutman AI"
				src.icon = 'Cutman(2).dmi'
				src.icon_state = "left"
				src.life = 28
				src.mlife = 28
				src.delay = 5
				src.Class = "Cutman"
				src.Attack = 3
				src.pixel_x = -16
				src.BulletIcon = 'CutShot.dmi'
				src.jumpHeight = 2.0
				src.MoveDelay = 2
				src.overlays = list()
				for(var/X in typesof(/obj/Characters/Cutman)) src.overlays+=X

				src.Easy_Shoot_AI()
#endif

		_Grenademan
			New()
				..()
				src.name = "Grenademan AI"
				src.icon = 'Gren.dmi'
				src.icon_state = "left"
				src.life = 28
				src.mlife = 28
				src.delay = 7
				src.Class = "Grenademan"
				src.Attack = 3
				src.pixel_x = 0
				src.pixel_y = -16
				src.BulletIcon = 'Grenbomb.dmi'
				src.jumpHeight = 2.0
				src.MoveDelay = 2
				src.overlays = list()
				for(var/X in typesof(/obj/Characters/Grenademan)) src.overlays+=X
				src.Easy_Shoot_AI()
#ifdef INCLUDED_CZero_DM
		_CZero
			New()
				..()
				src.name = "CZero AI"
				src.icon = 'CZero.dmi'
				src.icon_state = "left"
				src.life = 28
				src.mlife = 28
				src.delay = 5
				src.Class = "CZero"
				src.Attack = 4
				src.pixel_x = -16
				src.BulletIcon = 'XShot.dmi'
				src.jumpHeight = 2.5
				src.MoveDelay = 1
				src.overlays = list()
				for(var/X in typesof(/obj/Characters/CZero)) src.overlays+=X
				src.Easy_Shoot_AI()
#endif
#ifdef INCLUDED_CX_DM
		_CX
			New()
				..()
				src.name = "CX AI"
				src.icon = 'CX.dmi'
				src.icon_state = "left"
				src.life = 28
				src.mlife = 28
				src.delay = 4
				src.Class = "CX"
				src.Attack = 3
				src.pixel_x = -16
				src.BulletIcon = 'XShot.dmi'
				src.jumpHeight = 2.5
				src.MoveDelay = 0
				src.overlays = list()
				for(var/X in typesof(/obj/Characters/CX)) src.overlays+=X
				src.Easy_Shoot_AI()
#endif
		_GBD
			New()
				..()
				src.name = "GBD AI"
				src.icon = 'GBD.dmi'
				src.icon_state = "left"
				src.life = 28
				src.mlife = 28
				src.delay = 5
				src.Class = "GBD"
				src.Attack = 2
				src.pixel_x = 0
				src.BulletIcon = 'GBDShot.dmi'
				src.jumpHeight = 2.0
				src.MoveDelay = 1
				src.overlays = list()
				for(var/X in typesof(/obj/Characters/GBD)) src.overlays+=X
				src.Easy_Shoot_AI()
#ifdef INCLUDED_MAGMA_DM
		_Magma
			New()
				..()
				src.name = "Magma AI"
				src.icon = 'Magma Dragoon.dmi'
				src.icon_state = "left"
				src.life = 28
				src.mlife = 28
				src.delay = 4
				src.Class = "Magma"
				src.Attack = 3
				src.pixel_x = 0
				src.BulletIcon = 'MagmaShot.dmi'
				src.jumpHeight = 2.0
				src.MoveDelay = 2
				src.overlays = list()
				for(var/X in typesof(/obj/Characters/Magma)) src.overlays+=X
				src.Easy_Shoot_AI()
#endif
		_DrWily
			New()
				..()
				src.name = "DrWily AI"
				src.icon = 'Wily.dmi'
				src.icon_state = "left"
				src.life = 42
				src.mlife = 42
				src.delay = 30
				src.Class = "GBD"
				src.Attack = 7.5
				src.pixel_x = 0
				src.pixel_y = -16
				src.Flight = 1
				src.BulletIcon = 'WilyShot.dmi'
				src.jumpHeight = 2.0
				src.MoveDelay = 2
				src.overlays = list()
				for(var/X in typesof(/obj/Characters/DrWily)) src.overlays+=X
				src.Easy_Shoot_AI()
		_Knightman
			New()
				..()
				src.name = "Knightman AI"
				src.icon = 'Knightman.dmi'
				src.icon_state = "left"
				src.life = 28
				src.mlife = 28
				src.delay = 4
				src.Class = "Knightman"
				src.Attack = 3
				src.pixel_x = 0
				src.pixel_y = -16
				src.BulletIcon = 'KnightmanShots.dmi'
				src.jumpHeight = 2.0
				src.MoveDelay = 2
				src.overlays = list()
				for(var/X in typesof(/obj/Characters/Knightman)) src.overlays+=X
				src.Easy_Shoot_AI()

		_Met
			New()
				..()
				src.name = "Met AI"
				src.icon = /obj/Characters/Met
				src.icon_state = "left"
				src.life = 28
				src.mlife = 28
				src.delay = 6
				src.Class = "Met"
				src.Attack = 1
				src.pixel_x = 0
				src.BulletIcon = 'Megashot.dmi'
				src.jumpHeight = 2.0
				src.MoveDelay = 2
				src.overlays = list()
				src.Easy_Shoot_Guard_AI()
		_Duo
			New()
				..()
				src.name = "Duo AI"
				src.icon = 'Duo.dmi'
				src.icon_state = "left"
				src.life = 28
				src.mlife = 28
				src.delay = 5
				src.Class = "Duo"
				src.Attack = 2
				src.pixel_x = 0
				src.BulletIcon = null
				src.jumpHeight = 2.0
				src.MoveDelay = 2
				src.overlays = list()
				for(var/X in typesof(/obj/Characters/Duo)) usr.overlays+=X
				src.Easy_AOE_AI()
		_Omega
			New()
				..()
				src.name = "Omega AI"
				src.icon = /obj/Characters/Omega/c
				src.icon_state = "left"
				src.life = 28
				src.mlife = 28
				src.delay = 5
				src.Class = "Omega"
				src.Flight = 1
				src.Attack = 3
				src.pixel_x = 0
				src.BulletIcon = null
				src.jumpHeight = 2.0
				src.MoveDelay = 2
				src.overlays = list()
				for(var/X in typesof(/obj/Characters/Omega)) usr.overlays+=X
				src.Easy_Float_AOE_AI()


mob/proc
	Randomness_AI()
		if(AISpawn == SpawnP)
			src.GotoBattle()
		src.Stats[c_Team] = AITeam
		for(var/A in typesof(/obj/Characters/Team)) src.overlays-=A
		for(var/Z in typesof("/obj/Characters/Team/[lowertext(AITeam)]"))
			src.overlays+=Z
		while(src)
			sleep(rand(1,10))
			if(prob(50))
				src.icon_state="right"
			if(prob(50))
				src.icon_state="left"
			switch(rand(1,3))
				if(1)
					switch(rand(1,4))
						if(1)
							src.direction = EAST
							src.RightLoop()

						if(2)
							src.direction = WEST
							src.LeftLoop()
						if(3)
							src.direction = NORTH
							src.UpLoop()
						if(4)
							src.direction = SOUTH
							src.DownLoop()
				if(2)
					switch(rand(1,4))
						if(1)
							src.direction = EAST
							src.RightLoop()
							src.RightLoop()
						if(2)
							src.direction = WEST
							src.LeftLoop()
							src.LeftLoop()
						if(3)
							src.direction = NORTH
							src.UpLoop()
							src.UpLoop()
						if(4)
							src.direction = SOUTH
							src.DownLoop()
							src.DownLoop()
				if(3)
					switch(rand(1,4))
						if(1)
							src.direction = EAST
							src.RightLoop()
							src.RightLoop()
							src.RightLoop()
						if(2)
							src.direction = WEST
							src.LeftLoop()
							src.LeftLoop()
							src.LeftLoop()
						if(3)
							src.direction = NORTH
							src.UpLoop()
							src.UpLoop()
							src.UpLoop()
						if(4)
							src.direction = SOUTH
							src.DownLoop()
							src.DownLoop()
							src.DownLoop()
#endif