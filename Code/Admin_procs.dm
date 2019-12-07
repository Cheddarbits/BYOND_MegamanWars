
var
	const
		c_Mode 		= 1
		c_Mapname 	= 2
		c_Map 		= 3
		c_vMapname 	= 4
		c_vMap 		= 5
	global
		g_Map 			= UNDERGROUND_LABS
		g_Mapname		= "Underground Laboratory"
		g_vMap 			= g_Map
		g_vMapname 		= g_Mapname
		g_WorldMode 	= "Battle"

proc
//	ChatLog(T) 		text2file(T, "Logs/Chatlog.html");
	LoginLog(T) 	text2file(T, "Logs/LoginLog.html")
//	ModeratorLog(T) text2file(T, "ModeratorLog.htm")
	DebugLog(T)
		T += "<br>"
		text2file(T, "Logs/Debuglog.html")

	KickLog(T) 		text2file(T, "HTML/KickLog.html")
	WorldLog(T) 	text2file(T, "HTML/WorldLog.html")
	MuteLog(T) 		text2file(T, "HTML/MuteLog.html")
	BanLog(T) 		text2file(T, "HTML/BanLog.html")
	DisableLog(T) 	text2file(T, "HTML/DisableLog.html")
	StatLog(T) 		text2file(T, "HTML/StatLog.html")
	MiscLog(T) 		text2file(T, "HTML/MiscLog.html")
	World_Status(var/worldMode, var/mapName)
		world.status = "<b>World Mode: <font color=green><i>[worldMode] </i></font>World Map: <font color=green><u>[mapName]\
		</font></b></u>"// <font color=green><u>[PlayersOnline] Players/[USERMAX] Slots</font></b></u>"
	get_WorldStatus(var/i)
		switch(i)
			if(c_Mode) 		return g_WorldMode
			if(c_Mapname) 	return g_Mapname
			if(c_Map)		return g_Map
			if(c_vMapname) 	return g_vMapname
			if(c_vMap)		return g_vMap
	set_WorldStatus(var/i, var/value)
		switch(i)
			if(c_Mode)
				g_WorldMode = value;
			if(c_Mapname)
				g_Mapname = value
				switch(value)
					if("Underground Laboratory") 	g_Map = UNDERGROUND_LABS
					if("Combat Facility") 			g_Map = COMBAT_FACILITY
					#ifdef TWINTOWERS_MAP
					if("Twin Towers") 				g_Map = TWIN_TOWERS
					#endif
					if("Lava Caves") 				g_Map = LAVA_CAVES
					if("Frozen Tundra") 			g_Map = FROZEN_TUNDRA
					if("Neo Arcadia") 				g_Map = NEO_ARCADIA
					if("Desert Temple") 			g_Map = DESERT_TEMPLE
					if("Sleeping Forest") 			g_Map = SLEEPING_FOREST
					if("Warzone") 					g_Map = WARZONE
					if("Ground Zero") 				g_Map = GROUND_ZERO
					if("Abandoned Warehouse") 		g_Map = ABANDONED_WAREHOUSE
#ifdef ASTRO_GRID_MAP
					if("Astro Grid") 				g_Map = ASTRO_GRID
#endif
					if("Battlefield") 				g_Map = BATTLEFIELD

			if(c_Map)
				g_Map = value
				switch(value)
					if(UNDERGROUND_LABS) 	g_Mapname = "Underground Laboratory"
					if(COMBAT_FACILITY){	g_Mapname = "Combat Facility"}
					#ifdef TWINTOWERS_MAP
					if(TWIN_TOWERS){		g_Mapname = "Twin Towers"}
					#endif
					if(LAVA_CAVES){			g_Mapname = "Lava Caves"}
					if(FROZEN_TUNDRA){		g_Mapname = "Frozen Tundra"}
					if(NEO_ARCADIA){		g_Mapname = "Neo Arcadia"}
					if(DESERT_TEMPLE){		g_Mapname = "Desert Temple"}
					if(SLEEPING_FOREST){	g_Mapname = "Sleeping Forest"}
					if(WARZONE){			g_Mapname = "Warzone"}
					if(GROUND_ZERO){		g_Mapname = "Ground Zero"}
					if(ABANDONED_WAREHOUSE) g_Mapname = "Abandoned Warehouse"
#ifdef ASTRO_GRID_MAP
					if(ASTRO_GRID) 			g_Mapname = "Astro Grid"
#endif
					if(BATTLEFIELD) 		g_Mapname = "Battlefield"
			if(c_vMapname)
				g_vMapname = value
				switch(value)
					if("Underground Laboratory") 	g_vMap = UNDERGROUND_LABS
					if("Combat Facility") 			g_vMap = COMBAT_FACILITY
					#ifdef TWINTOWERS_MAP
					if("Twin Towers") 				g_vMap = TWIN_TOWERS
					#endif
					if("Lava Caves") 				g_vMap = LAVA_CAVES
					if("Frozen Tundra") 			g_vMap = FROZEN_TUNDRA
					if("Neo Arcadia") 				g_vMap = NEO_ARCADIA
					if("Desert Temple") 			g_vMap = DESERT_TEMPLE
					if("Sleeping Forest") 			g_vMap = SLEEPING_FOREST
					if("Warzone") 					g_vMap = WARZONE
					if("Ground Zero") 				g_vMap = GROUND_ZERO
					if("Abandoned Warehouse") 		g_vMap = ABANDONED_WAREHOUSE
#ifdef ASTRO_GRID_MAP
					if("Astro Grid") 				g_vMap = ASTRO_GRID
#endif
					if("Battlefield") 				g_vMap = BATTLEFIELD

			if(c_vMap)
				g_vMap = value
				switch(value)
					if(UNDERGROUND_LABS) 	g_vMapname = "Underground Laboratory"
					if(COMBAT_FACILITY){	g_vMapname = "Combat Facility"}
					#ifdef TWINTOWERS_MAP
					if(TWIN_TOWERS){		g_vMapname = "Twin Towers"}
					#endif
					if(LAVA_CAVES){			g_vMapname = "Lava Caves"}
					if(FROZEN_TUNDRA){		g_vMapname = "Frozen Tundra"}
					if(NEO_ARCADIA){		g_vMapname = "Neo Arcadia"}
					if(DESERT_TEMPLE){		g_vMapname = "Desert Temple"}
					if(SLEEPING_FOREST){	g_vMapname = "Sleeping Forest"}
					if(WARZONE){			g_vMapname = "Warzone"}
					if(GROUND_ZERO){		g_vMapname = "Ground Zero"}
					if(ABANDONED_WAREHOUSE) g_vMapname = "Abandoned Warehouse"
#ifdef ASTRO_GRID_MAP
					if(ASTRO_GRID) 			g_vMapname = "Astro Grid"
#endif
					if(BATTLEFIELD) 		g_vMapname = "Battlefield"