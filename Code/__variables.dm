
#define APTB 0
#define DUEL_MODE 0
#define TOURNAMENT 0


#define DEBUG_VARIABLES 0
#define TRUE 1
#define FALSE 0

#define NULL_R(x) if( isnull( x ) ) return
#define NULL_B(x) if( isnull( x ) ) break
#define NULL_C(x) if( isnull( x ) ) continue

var
	//========================================================//
	// Admin Variables
	//========================================================//
	list // variables that are defined as lists
		GAME_OWNER = list("Lord Protector",/*"HolyDoomKnight",*/"Amarlaxi")	// If you're in this list you get administrative powers.
		s_admin = list("Lord Protector")//,"HolyDoomKnight")
		DEBUGList = list("HolyDoomKnight")//list("HolyDoomKnight","Holydoom","Doomlance" )
	//	ClientIP[] = list()				// Multiples connections
		WCensor[] = list()				// Word censor list
		ModeratorList[] = list()		// Moderators list
		MuteList = list()					// mute list
		BanList = list()					// Ban list
		PeBanList = list()
		PeMuteList = list()
		LockList = list()
		LoginSpamList = list()
		SpamList = list()
		InvalidSaves = list()
		NewPlayer = list()
		hasVoted = list()
		SayTitles = list("Moderator", "Manager", "Admin", "Power Ranger")
		ActionLockList = list()
		IncreasedReqList = list()
		NoCustomsList = list()
		NoStaffList = list()
		KillUsageCharsList = list("Plague", "SJX", "Valnaire", "XeronII", "FAX", "ZV", "LWX", "Athena", "ModelC") // Player has to kill a certain amount of times before using these guys again.
		KillSSXList = list("Super Saiyan X")

	//========================================================//
	// Game Variables
	//========================================================//
	const
		NOACTIONRNG 		= 1
		MAX_CHARS 			= 72

		MAX_STAT 			= 999999

		world_version 		= "5.47.2"
		SAVE_VERSION		= 25


		c_MAX_TEXT_LEN 	 	= 400
		MAX_MAP				= 13

		MAX_LIFE_TIME 		= 100
//Core game variables
//var/const/gravity = 2 // This single variable controls the gravity of the world.
				// The higher it is, the pull on gravity becomes weaker
				// The lower it is, the pull on gravity becomes stronger
//var/const/fall_type = 1 // This determines which falling mode you use.
				  // If this is 1, it will check for dense objects below you, and not even try to go down if there are any.
				  // If this is 0, it will just keep going down over dense objects (causing nothing except Bump() to occur).
		gravity				= 2
		fall_type			= 1
	global
		g_Chat 				= 0
		g_WorldView 		= "18x15"

	//========================================================//
	// Freemode Variables
	//========================================================//
	const
		c_MMMode 		= 1
		c_XMode 		= 2
		c_ZeroMode 		= 3
		c_CustomMode 	= 4
	//========================================================//
	// Staff Variables
	//========================================================//
	const
		c_MODERATOR 	= 1
		c_MANAGER 		= 2
		c_ADMIN 		= 3
		c_POWER 		= 4
	//========================================================//
	// Action Variables
	//========================================================//
	const
		AOE = 1
		INV = 2
	//========================================================//
	// Series Variables
	//========================================================//
	const
		c_INVISIBLE 	= 1
		c_AOE 			= 2
		c_TEAMBASED 	= 3
		c_MEGAMAN 		= 4
		c_X 			= 5
		c_ZERO 			= 6
		c_CUSTOM 		= 7
		c_STARTERS 		= 8
	//========================================================//
	// Team Variables
	//========================================================//
	const
		c_RED 				= 1
		c_BLUE 				= 2
		c_YELLOW 			= 3
		c_GREEN 			= 4
		c_SILVER 			= 5
		c_PURPLE 			= 6
		c_NEUTRAL 			= 7
		c_MAX_PUBLIC_TEAMS 	= 4
		c_TOTAL_TEAMS 		= 7
	TeamScores[c_MAX_PUBLIC_TEAMS]

	TeamLocked[c_TOTAL_TEAMS]
	list
		activeTeams = list()
		TeamLeaders = list()
		redTeam 	= list()
		blueTeam 	= list()
		yellowTeam 	= list()
		greenTeam 	= list()
	//========================================================//
	// Map Variables
	//========================================================//
	const
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
	global/list/g_listofMaps = list(
		"Underground Laboratory",
		"Combat Facility",
#ifdef TWINTOWERS_MAP
		"Twin Towers",
#endif
		"Lava Caves",
		"Frozen Tundra",
		"Neo Arcadia",
		"Desert Temple",
		"Sleeping Forest",
		"Warzone",
		"Ground Zero",
		"Abandoned Warehouse",
#ifdef ASTRO_GRID_MAP
		"Astro Grid",
#endif
		"Battlefield")
	//========================================================//
	// Character Variables
	//========================================================//
/*
	const
		c_MMX 			= 1
		c_MMXZero 		= 2
		c_Axl 			= 3
		c_Double		= 4
		c_Dynamo 		= 5
		c_Gate 			= 6
		c_Sigma 		= 7
		c_Vile 			= 8
		c_Magma 		= 9
		c_Duo 			= 10
		c_Grenademan 	= 11
		c_Cutman 		= 12
		c_Shadowman 	= 13
		c_Met 			= 14
		c_Tenguman 		= 15
		c_Zanzibar 		= 16
		c_CX 			= 17
		c_CZ 			= 18
		c_Elpizo 		= 19
		c_Harpuia 		= 20
		c_Fefnir 		= 21
		c_Phantom 		= 22
		c_Leviathen 	= 23
		c_Omega 		= 24
		c_Wolfang 		= 25
		c_Mijinion 		= 26
		c_Colonel 		= 27
		c_PZero 		= 28
		c_Heatnix 		= 29
		c_NZero 		= 30
		c_SAX 			= 31
		c_Shelldon 		= 32
		c_CMX 			= 33
		c_Anubis 		= 34
		c_Chilldre 		= 35
		c_Kraft 		= 36
		c_ShadowmanEXE 	= 37
		c_Weil 			= 38
		c_Xeron 		= 39
		c_Medic 		= 40
		c_Darkguise 	= 41
		c_Foxtar 		= 42
		c_Swordman 		= 43
		c_Knightman 	= 44
		c_Clownman 		= 45
		c_Burnerman 	= 46
		c_Beat 			= 47
		c_Athena 		= 48
		c_SJX 			= 49
		c_ModelS 		= 50
		c_LWX 			= 51
		c_Plague 		= 52
		c_GBD			= 53
		c_PSX 			= 54
		c_Valnaire 		= 55
		c_FAX 			= 56
		c_ModelC 		= 57
		c_MG400 		= 58
		c_King 			= 59
		c_DrWily 		= 60
		c_XeronII 		= 61
		c_Eddie 		= 62
		c_SlashBeast 	= 63
		c_Fauclaw 		= 64
		c_Woodman 		= 65
		c_GAX 			= 66
		c_Magicman 		= 67
		c_Hanu 			= 68
		c_Pantheon 		= 69
		c_ModelBD 		= 70
		c_ModelGate 	= 71
		c_Hades 		= 72
*/



var/tmp // Variables that are temp only, meaning you can't save
	DamageSetting="Medium"
	Multiplier=2
	Conveyers = 4
	g_SpawnAI = 4

	list/playerList = list()
	list/playerEvent = list()

//	Target[6] // Target 1 - 4 = Team Leader, Target 5 = Boss, Berserker, Juggernaut, Target 6 = Boss 1

	list/Bosses = list()
	ModeTarget
	EventKillLimit = 0
	Leader=null
	ActionUse[2]
	CharUse[8]
//	SCharDisabled[MAX_CHARS]
	list/listofPlayers = list()
	list/listofDisabled = list()
	list/listofCharacters = list(
	"X",
	"MMXZero",
	"Axl",
#ifdef INCLUDED_DOUBLE_DM
	"Double",
#endif
#ifdef INCLUDED_DYNAMO_DM
	"Dynamo",
#endif
	"Gate",
	"Sigma",
	"Vile",
#ifdef INCLUDED_MAGMA_DM
	"Magma",
#endif
	"Duo",
	"Grenademan",
	"Cutman",
	"Shadowman",
#ifdef INCLUDED_MET_DM
	"Met",
#endif
	"Tenguman",
	"Zanzibar",
#ifdef INCLUDED_CX_DM
	"CX",
#endif
#ifdef INCLUDED_CZERO_DM
	"CZero",
#endif
	"Elpizo",
	"Harpuia",
	"Fefnir",
	"Phantom",
	"Leviathen",
	"Omega",
	"Wolfang",
#ifdef INCLUDED_MIJINION_DM
	"Mijinion",
#endif
	"Colonel",
	"PureZero",
	"Heatnix",
	"ZV",
	"SaX",
	"Shelldon",
	"CMX",
	"Anubis",
	"Chilldre",
	"Kraft",
#ifdef INCLUDED_SHADOWMANEXE_DM
	"ShadowmanEXE",
#endif
	"Weil",
	"Xeron",
	"Medic",
	"Darkguise",
	"Foxtar",
#ifdef INCLUDED_SWORDMAN_DM
	"Swordman",
#endif
	"Knightman",
	"Clownman",
	"Burnerman",
#ifdef INCLUDED_BEAT_DM
	"Beat",
#endif
	"Athena",
	"SJX",
	"ModelS",
	"LWX",
	"Plague",
	"GBD",
	"PSX",
	"Valnaire",
	"FAX",
	"ModelC",
	"MG400",
	"King",
#ifdef INCLUDED_FAUCLAW_DM
	"Fauclaw",
#endif
	"XeronII",
	"Eddie",
	"DrWily",
	"Woodman",
	"GAX",
	"Magicman",
	"HanuMachine",
	"AirPantheon",
	"ModelBD",
	"ModelGate")

	leaderkills=null
	leading=null
	runnerupkills=null
	runnerup=null

//	Target[4]
//	TeamLife[4]

	rebooting = 0
	shutting_down = 0
	shutdown_time = 0
	Delete[3]
	GameTune='MMX4 X.mid'

	FreeModes[4]
	FreeMode = 0
//Event Mode variables
	KillMultiplier = 1; // Determines how much each kill is worth.
	ReqDifficult = 1

// Vote System
	Vote[MAX_MAP]
	Voting = 0
	StartedVote = null
#if DUEL_MODE
var
	list
		eTeam1 = list();
		eTeam2 = list();
		eDead1 = list()
		eDead2 = list()
		eTeam3 = list()
		eDead3 = list()
		eSpawn1 = list()
		eSpawn2 = list()
		eSpawn3= list()
	tmp
		eMap = 0
		eMapname = null
#endif



obj
	var
	//	bullet = 0
		Damage;
		Owner;
		LifeTime
mob
	var
	// Debug Commad Variables
		ReverseDMG=0;
		Alternative=0;
		Called=0
	// Player Variables
	var/tmp


		// Skill Related
		BarrierUP = 0
		BarrierBlast = 0
		nojump=0
		Disguised=0
		DisguiseCounter=0
		// Action Related
		jumping = 0   // The jumping var is used solely for disabling gravity while jumping.
		lock = 0      // lock, used for keeping away "drunk movement" in delayed movement.
		climbing=0
		inscene=0
		Dashing=0
		Teleporting=0
		XeronFling=0
		Shooting=0
		Flight=0
		Guard = 0
		Slashing=0
		Healing=0

		KillLoss
		Attack = 0
		DefenseBuff = 0
		AttackBuff = 0
		BulletIcon=null
		SubBulletIcon=null
		KilledBy
		delay = 5
		Enters=0

		delay_time

		life = 0
		mlife = 0
		Energy = 0
		mEnergy = 0

		Class=null
		Owner
		Dead=0

		subkills=0

		islocked=0

		Voted=0
		Playing=0

	//	BulletChoice
		ispwiped=0
		Types=null
	//	SpawnKills=0
		hasFlag=0
		jumpHeight=0
		SlashState=0
		MaxShots = 1
		MoveDelay = 0
		isLockedBy = null
		hasLocked = null
		indReqDiff = 1
		SpawnLoc = 0// 1 = here, 0 = spawn points
		playerLives = 0
		spawnRan = 0
		inSpawn = 0
		// Add a way to traverse map and spawn in that map
		currentSpawnLocation = null
	var // Variables that can be saved
		const/c_MAXSTATS = 8
		Stats[c_MAXSTATS]

		/*
		Stats[Kills]		= 0
		Stats[CanUseKills]	= 0
		Stats[PKills]		= 0
		Stats[CCKills]		= 0
		Stats[Deaths]		= 0
		Stats[Deflects]		= 0
		Stats[Shoots]		= 0
		Stats[Slashes]		= 0
		Stats[Jumps]		= 0
		Stats[Hits]			= 0
		Stats[Timeshurt]	= 0
		Stats[c_Team]			= "N/A"
		Stats[Version]		= SAVE_VERSION
		Stats[subname]		= null
		*/
		// Script Vars
mob/var/list/ignoreList = list()
var/global
	const
		Kills		= 1

		PKills		= 2
		CCKills		= 3
		Deaths		= 4
		CanUseKills = 5
		c_Team		= 6
		Version 	= 7
		subname		= 8
