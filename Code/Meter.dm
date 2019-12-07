
mob
	proc/GotoBattle()
		if(listofDisabled.Find(src.Class))
			src.overlays = list()
			src.icon = null
			src.icon_state = "right"

			src.BulletIcon = null
			src.SubBulletIcon = null
			src.Flight = 0
			src.density = 1
			src.Class = null
			src<<"<B>Unable to use selected character at this time."
			return

		if(src.Dead == 0 && src.key != "HolyDoomKnight")
			Death(src)
			return
		if(KillUsageCharsList.Find(src.Class) && src.Stats[Kills] < src.Stats[CanUseKills])
			src.overlays = list()
			src.BulletIcon = null
			src.SubBulletIcon=null
			src.icon=null

			src<<"<B>You need [src.Stats[CanUseKills]-src.Stats[Kills]] kills to use [src.Class] again."
			src.Class = null
			return
		if( src.Playing == 1 )
			src.client.screen += new/obj/HP/Meter
			src.client.screen += new/obj/HP/meter2
			src.client.screen += new/obj/HP/meter3
		switch(rand(1,2))
			if(1) src.icon_state="right"
			if(2) src.icon_state="left"
		src.density=1
		src.Dead=0
		src.Disguised=0
		src.DisguiseCounter=0
		src.Teleporting=0
		src.Slashing=0
		src.Shooting=0
		src.inscene=0
		src.climbing=0
		src.GravCheck()
		src.jumpHeight=2.0
		src.MoveDelay = 2

		if(KillUsageCharsList.Find(src.Class) && !isSAdmin(src))
			var/KILL_USAGE = 1
			if(src.Class == "Valnaire" && src.key != "Lord Protector" && src.key != "BloodTerrorX")
				KILL_USAGE = 50
			if(src.Class == "FAX" && src.key != "Sokuryoku")
				KILL_USAGE = 50

			if(src.Class == "ZV" && src.key != "ZeroVirus" )
				KILL_USAGE = 40
			if(src.Class == "XeronII" && src.key != "Hiroyuki" && src.key != "Oondivinezin")
				KILL_USAGE = 40

			if(src.Class == "Plague" || src.Class == "SJX")
				KILL_USAGE = 30

			if(src.Class == "ModelC" && src.key != "Cliff Hatomi")
				KILL_USAGE = 20
			if(src.Class == "LWX" && src.key != "Amarlaxi" && src.key != "Venetiae")
				KILL_USAGE = 20

			if(src.Class == "Xeron" && src.key != "Oondivinezin")
				KILL_USAGE = 10
			if(src.Class == "Athena" && src.key != "Amarlaxi" && src.key != "Venetiae")
				KILL_USAGE = 10
			src.Stats[CanUseKills] = (src.Stats[Kills]+KILL_USAGE)

		switch( src.Class )
			if("SJX","Chilldre","Burnerman","Xeron","CX","CZero")
				src.jumpHeight=2.5
			if("Zombie")
				src.jumpHeight=1.5
			if("XeronII" )
				src.jumpHeight=3.0
		switch( src.Class )
			if( "DrWily" )
				src.mlife = 42
			if( "Abyss" )
				src.mlife = 36
		switch( src.Class )
			if( "King", "Athena", "AthenaII", "LWX", "Beat", "CX", "Shadowman", "HDK", "ModelC", "AdminMode", "Protoman" )
				src.MoveDelay = 0
			#ifdef INCLUDED_SHADOWMANEXE_dM
			if("ShadowmanEXE")
				src.MoveDelay = 0
			#endif
			if( "ModelS", "Plague", "SJX", "Burnerman", "Darkguise", "Clownman", "CMX", "Medic", "PSX", "Phantom", "Tenguman", "Vile", "GBD", "ZV", "Eddie" )
				src.MoveDelay = 1
			if( "Zombie", "GAX" )
				src.MoveDelay = 3


		switch( src.Stats[c_Team] )
			if("Red") src.overlays+=new /obj/Characters/Team/red
			if("Blue") src.overlays+=new /obj/Characters/Team/blue
			if("Yellow") src.overlays+=new /obj/Characters/Team/yellow
			if("Green") src.overlays+=new /obj/Characters/Team/green
			if("Purple")
				if(isModerator(src)||isAdmin(src)||isSAdmin(src)) src.overlays+=new /obj/Characters/Team/purple
				else src.Stats[c_Team]="N/A"
			if("Silver")
				if(src.client.IsByondMember()||isModerator(src)||isAdmin(src)||isSAdmin(src)) src.overlays+=new /obj/Characters/Team/silver
				else src.Stats[c_Team]="N/A"


		switch(get_WorldStatus(c_Mode))
			if("Boss Battle", "Dual Boss Battle", "Battle of the Bosses")
				if(isnull(Bosses))
					Check_End(src)
				else
					if(Bosses.Find(src.key))
						src.Attack=(src.Attack*3)
					else
						src.life = 28; src.mlife = 28
	/*	else if(WorldMode=="Duel Mode")
			if(eTeam1.Find("[src.key]")||eTeam2.Find("[src.key]")||eTeam3.Find("[src.key]"));
				src.life=src.mlife
				src.Event=1
				if(eTeam1.Find("[src.key]"))
					eSpawn1+="[src.key]"
				if(eTeam2.Find("[src.key]"))
					eSpawn2+="[src.key]"
				if(eTeam3.Find("[src.key]"))
					eSpawn3+="[src.key]"
					if(length(eSpawn3)>=length(eTeam3))
						for(var/mob/Entities/Player/M in world)
							if(eTeam3.Find("[M.key]"))
								M<<"<b>Match ready..."
								for(var/i=3 to 1)
									sleep(1)
									M<<"<b>[i]"
								M<<"<b>Match begin!"
								M.Event=0
				if(length(eSpawn1)>=length(eTeam1)&&length(eSpawn2)>=length(eTeam2))
					for(var/mob/Entities/Player/M in world)
						if(eTeam1.Find("[M.key]")||eTeam2.Find("[M.key]"))
							M<<"<b>Match ready..."
							for(var/i=3 to 1)
								sleep(1)
								M<<"<b>[i]"
							M<<"<b>Match begin!"
							M.Event=0*/
			if("Assassination")
				if(TeamLeaders.Find(src.key))
					src.Attack=(src.Attack*2)
				else
					src.life = 28; src.mlife = 28
			if("Berserker")
				if(src.key == ModeTarget)
					src.Attack=(src.Attack*2)
				src.life = 28; src.mlife = 28
			if("Juggernaut")
				src.life = 28; src.mlife = 28
				if(src.key == ModeTarget)
					src.mlife=src.mlife*2

			else
				src.life = 28; src.mlife = 28
		src.mEnergy = 28
		if(src.Attack > 8)
			src.mEnergy = src.Attack*10

		if(src.mEnergy > 0)
			src.client.screen += new/obj/Energy/Meter
			src.client.screen += new/obj/Energy/meter2
			src.client.screen += new/obj/Energy/meter3

		src.life = src.mlife
		src.delay = src.delay
		src.Energy = src.mEnergy
	/*	if(WorldMode=="Duel Mode")
			if(eTeam1.Find("[src.key]")||eTeam2.Find("[src.key]")||eTeam3.Find("[src.key]"));
				eMap_Location(src)
			else
				Map_Location(src)
		else*/

		Map_Location(src)
		src.Update()
		RemovePanel(src)
		isSpawnPoint(src)
	proc/Update()                                  // Compares the percentage of the
		if( !isnull( src ) && !isnull( src.client ) && src.Playing == 1 )
			for(var/obj/HP/O in src.client.screen)     // src's health with the range of
				O.num = round((src.life/src.mlife)*O.width)// each objects, then sets icon
				if(O.num >= O.rangemax)
					switch(O.metertype)
						if(1) O.icon_state = "8"
						if(2) O.icon_state = "16"
						if(3) O.icon_state = "4"
				if(O.num <= O.rangemin) O.icon_state = "0"
				if(O.num < O.rangemax && O.num > O.rangemin)
					O.icon_state = "[O.num - O.rangemin]"
			for(var/obj/Energy/O in src.client.screen)
				O.num = round((src.Energy/src.mEnergy)*O.width)// each objects, then sets icon
				if(O.num >= O.rangemax)
					switch(O.metertype)
						if(1) O.icon_state = "8"
						if(2) O.icon_state = "16"
						if(3) O.icon_state = "4"
				if(O.num <= O.rangemin) O.icon_state = "0"
				if(O.num < O.rangemax && O.num > O.rangemin)
					O.icon_state = "[O.num - O.rangemin]"
	var/tmp
		Disabled[7]
	//	SCharDis[MAX_CHARS]
		CharMode=0 // Sigma Head Only
		/*Disabled[1] = Invisible
		Disabled[2] = AoE
		Disabled[3] = Team Based
		Disabled[4] = Megaman Series
		Disabled[5] = X Series
		Disabled[6] = Zero Series
		Disabled[7] = Custom*/
proc/RemovePanel( var/mob/Entities/Player/A )                                  // Compares the percentage of the
	if(isnull(A)) return
	if(A.Playing == 0) return
	for(var/obj/Panel/O in A.client.screen) del O
proc/RemoveMeter( var/mob/Entities/Player/A )                                  // Compares the percentage of the
	if(isnull(A)) return
	if(A.Playing == 0) return
	for(var/obj/HP/O in A.client.screen) del O
	for(var/obj/Energy/O in A.client.screen) del O

obj
	var
		rangemax      // the range of the var that each tile of the meter will deal with
		rangemin
		num = 0       // This var is used later to help set the icon state
		width = 28
		metertype
	HP
		layer = MOB_LAYER+50;name = "" // Sets it at a layer above the background.
		Meter
			icon = 'Meter.dmi';icon_state = "0"
			screen_loc = "2,12"
			rangemax = 8;rangemin = 0
			metertype = 1
		meter2
			icon = 'Meterm.dmi';icon_state = "0"
			screen_loc = "2,13"
			rangemax = 24;rangemin = 9
			metertype = 2
		meter3
			icon = 'Metert.dmi';icon_state = "0"
			screen_loc = "2,14"
			rangemax = 28;rangemin = 25
			metertype = 3
	Energy
		layer = MOB_LAYER+50;name = "" // Sets it at a layer above the background.
		Meter
			icon = 'EMeter.dmi';icon_state = "0"
			screen_loc = "2,12"
			rangemax = 8;rangemin = 0
			metertype = 1
		meter2
			icon = 'EMeterm.dmi';icon_state = "0"
			screen_loc = "2,13"
			rangemax = 24;rangemin = 9
			metertype = 2
		meter3
			icon = 'EMeterT.dmi';icon_state = "0"
			screen_loc = "2,14"
			rangemax = 28;rangemin = 25
			metertype = 3
	Panel
		icon = 'Characterselect.dmi'//;name=""
		layer = MOB_LAYER+20
		var/A = "<B>Unable to use selected character at this time."
/*
listofDisabled = list()
listofCharacters
*/
		#ifdef INCLUDED_XERON_DM
		Customs/Xeron
			icon_state = "xeron";screen_loc = "9,9"
			Click()

				if(!isSAdmin(usr))
					if(CharUse[c_CUSTOM]==1){usr<<A;return}
				usr.overlays = list()
				usr.BulletIcon = 'XeronShot.dmi'
				usr.SubBulletIcon=null
				usr.icon='Xeron.dmi'
				if(!isSAdmin(usr))
					usr.Disabled[c_CUSTOM]=1

				for(var/X in typesof(/obj/Characters/Xeron)) usr.overlays+=X
				usr.Class="Xeron"
				usr.Attack = 3
				usr.pixel_x=0
				usr.Flight=0
				usr.delay=5
				usr.GotoBattle()
				return
		#endif
		#ifdef INCLUDED_TRACT_DM
		Tract
			icon_state = "tract";screen_loc = "14,14"
			Click()
				if(!isSAdmin(usr))
					if(CharUse[c_CUSTOM]==1){usr<<A;return}
				usr.overlays = list()
				usr.BulletIcon = 'Tract buster.dmi'
				usr.SubBulletIcon=null
				usr.icon='Tract.dmi'
				if(!isSAdmin(usr))
					usr.Disabled[c_CUSTOM]=1
				for(var/X in typesof(/obj/Characters/Tract)) usr.overlays+=X
				usr.Class="Tract"
				usr.Attack = 3
				usr.pixel_x=0
				usr.Flight=0
				usr.delay=5
				usr.GotoBattle()
				return
		#endif
		#ifdef INCLUDED_VALNAIRE_DM
		Customs/Valnaire
			icon_state = "dixon";screen_loc = "7,7"
			Click()

				if(!isSAdmin(usr))
					if(CharUse[c_CUSTOM]==1){usr<<A;return}

				usr.overlays = list()
				usr.BulletIcon = 'NormalShot.dmi'
				usr.SubBulletIcon=null
				usr.icon='Dixon1.dmi'
				for(var/X in typesof(/obj/Characters/Valnaire)) usr.overlays+=X

				if(!isSAdmin(usr))
					usr.Disabled[c_CUSTOM]=1

				usr.Attack = 3
				usr.Class="Valnaire"
				usr.pixel_x=0
				usr.Flight=0
				usr.delay=0
				usr.GotoBattle()
				return
		#endif
		#ifdef INCLUDED_CLIFF_DM
		Customs/Cliff
			icon_state = "cliff";screen_loc = "15,14"
			Click()
				if(!isSAdmin(usr))
					if(CharUse[c_CUSTOM]==1) {usr<<A;return}

				usr.overlays = list()
				usr.pixel_x=0
				usr.pixel_y=-12
				if(!isSAdmin(usr)) usr.Disabled[c_CUSTOM]=1
				usr.BulletIcon = 'CliffBlasts.dmi'
				usr.SubBulletIcon=null
				usr.icon = 'Cliff.dmi'
				usr.Class="Cliff"
				for(var/X in typesof(/obj/Characters/Cliff))
					usr.overlays+=X
				usr.Attack = 4
				usr.Flight=0
				usr.delay=4
				usr.Flight=0
				usr.GotoBattle()
				return
		#endif
		#ifdef INCLUDED_SOLCLOUD_DM
		Customs/Solcloud
			icon_state = "sol";screen_loc = "17,14"
			Click()
				if(!isSAdmin(usr))
					if(CharUse[c_CUSTOM]==1){usr<<A;return}

				if(!isSAdmin(usr))  usr.Disabled[c_CUSTOM]=1
				usr.overlays = list()
				usr.pixel_x=0
				usr.pixel_y=-16
				usr.BulletIcon = 'SolSlash.dmi'
				usr.SubBulletIcon=null
				usr.icon = 'Solcloud.dmi'
				usr.Class="Solcloud"
				for(var/X in typesof(/obj/Characters/Solcloud))
					usr.overlays+=X
				usr.Attack = 3
				usr.Flight=0
				usr.delay=5
				usr.GotoBattle()
				return
		#endif
		#ifdef INCLUDED_HDK_DM
		Customs/HDK
			icon_state = "hdk"
			screen_loc = "15,15"
			Click()
				if(!isSAdmin(usr))
					if(CharUse[c_CUSTOM]==1){usr<<A;return}

				usr.overlays = list()
				usr.BulletIcon = 'HDKShot.dmi'
				usr.SubBulletIcon=null
				usr.icon='X6 Head3.dmi'
				for(var/X in typesof(/obj/Characters/HDK)) usr.overlays+=X
				usr.Class="HDK"
				if(!isSAdmin(usr))  usr.Disabled[c_CUSTOM]=1
				usr.Attack = 2
				usr.CharMode=1
				usr.pixel_x=-16
				usr.Flight=1
				usr.delay=0
				usr.GotoBattle()
				return
		#endif
		#ifdef INCLUDED_FAX_DM
		FAX
			icon_state = "fax"
			screen_loc = "8,7"
			Click()
				if(!isSAdmin(usr))
					if(CharUse[c_CUSTOM]==1){usr<<A;return}

				usr.overlays = list()
				usr.BulletIcon = 'FAX Weapon.dmi'
				usr.SubBulletIcon=null
				usr.icon='FAX Main.dmi'
				for(var/X in typesof(/obj/Characters/FAX)) usr.overlays+=X
				usr.Class="FAX"
				if(!isSAdmin(usr))
					usr.Disabled[c_CUSTOM]=1

				usr.Attack = 2
				usr.pixel_x=0
				usr.Flight=0
				usr.delay=5
				usr.GotoBattle()
				return
		#endif
		#ifdef INCLUDED_MODELC_DM
		Customs/ModelC
			icon_state = "modelc"
			screen_loc = "10,7"
			Click()
				if(!isSAdmin(usr))
					if(CharUse[c_CUSTOM]==1){usr<<A;return}

				usr.overlays = list()
				usr.BulletIcon = 'Model-C Weapon.dmi'
				usr.SubBulletIcon=null
				usr.icon='Model-C Main.dmi'
				if(!isSAdmin(usr))
					usr.Disabled[c_CUSTOM]=1

				for(var/X in typesof(/obj/Characters/ModelC)) usr.overlays+=X
				usr.Class="ModelC"
				usr.Attack = 3
				usr.pixel_x=0
				usr.Flight=0
				usr.delay=4
				usr.GotoBattle()
				return
		#endif
		#ifdef INCLUDED_SAX_DM
		SaX
			icon_state="sax"
			screen_loc="10,10"
			Click()
				if(!isSAdmin(usr))
					if(CharUse[c_X]==1){usr<<A;return}

				usr.overlays = list()
				usr.pixel_x=0
				usr.pixel_y=-16
				usr.BulletIcon = 'SAX shuriken.dmi'
				usr.SubBulletIcon=null
				usr.icon = 'SAXBL.dmi'
				if(!isSAdmin(usr))
					usr.Disabled[c_X]=1

				for(var/X in typesof(/obj/Characters/SaX)) usr.overlays+=X
				usr.Class="SaX"
				usr.Attack = 3
				usr.Flight=0
				usr.delay=5
				usr.GotoBattle()
				return
		#endif
		#ifdef INCLUDED_SHADOWMANEXE_DM
		ShadowmanEXE
			icon_state="ryo"
			screen_loc="7,9"
			Click()
				if(!isSAdmin(usr))
					if(CharUse[c_CUSTOM]==1){usr<<A;return}

				usr.overlays = list()
				usr.pixel_x=0
				usr.pixel_y=-16
				usr.BulletIcon = 'Shuriken.dmi'
				usr.SubBulletIcon=null
				usr.icon = 'Ryokashi.dmi'
				if(!isSAdmin(usr))
					usr.Disabled[c_CUSTOM]=1

				for(var/X in typesof(/obj/Characters/ShadowmanEXE)) usr.overlays+=X
				usr.Class="ShadowmanEXE"
				usr.Attack = 2
				usr.Flight=0
				usr.delay=4
				usr.GotoBattle()
				return
		#endif
		#ifdef INCLUDED_DYNAMO_DM
		Dynamo
			icon_state = "dynamo"
			screen_loc = "8,13"
			Click()
				if(!isSAdmin(usr))
					if(CharUse[c_AOE]==1||CharUse[c_X]==1){usr<<A;return}

				usr.overlays = list()
				usr.icon = 'DynMiddle.dmi'
				usr.Class="Dynamo"
				usr.BulletIcon = null
				usr.SubBulletIcon=null
				if(!isSAdmin(usr))
					usr.Disabled[c_AOE]=1
					usr.Disabled[c_X]=1

				for(var/X in typesof(/obj/Characters/Dynamo)) usr.overlays+=X
				usr.Attack=2
				usr.pixel_x=0
				usr.Flight=0
				usr.delay=5
				usr.GotoBattle()
				return
		#endif
		#ifdef INCLUDED_OMEGA_DM
		Omega
			icon_state = "omega"
			screen_loc = "12,11"
			Click()
				if(!isSAdmin(usr))
					if(CharUse[c_AOE]==1||CharUse[c_ZERO]==1){usr<<A;return}

				usr.overlays = list()
				usr.Class="Omega"
				usr.BulletIcon = null
				usr.SubBulletIcon=null
				usr.icon=/obj/Characters/Omega/c
				if(!isSAdmin(usr))
					usr.Disabled[c_AOE]=1
					usr.Disabled[c_ZERO]=1

				for(var/X in typesof(/obj/Characters/Omega)) usr.overlays+=X
				usr.Flight = 1
				usr.Attack=3
				usr.pixel_x=0
				usr.delay=5
				usr.GotoBattle()
				return
		#endif
		#ifdef INCLUDED_DOUBLE_DM
		Double
			icon_state = "double"
			screen_loc = "7,13"
			Click()
				if(!isSAdmin(usr))
					if(CharUse[c_AOE]==1||CharUse[c_X]==1){usr<<A;return}

				usr.overlays = list()
				usr.BulletIcon = null
				usr.SubBulletIcon=null
				usr.icon='Double.dmi'
				if(!isSAdmin(usr))
					usr.Disabled[c_AOE]=1
					usr.Disabled[c_X]=1

				for(var/X in typesof(/obj/Characters/Double)) usr.overlays+=X
				usr.Class="Double"
				usr.Attack = 2
				usr.pixel_x=0
				usr.Flight=0
				usr.delay=5
				usr.GotoBattle()
				return
		#endif
		#ifdef INCLUDED_DUO_DM
		Duo
			icon_state = "duo"
			screen_loc = "7,12"
			Click()
				if(!isSAdmin(usr))
					if(CharUse[c_AOE]==1||CharUse[c_MEGAMAN]==1){usr<<A;return}

				usr.overlays = list()
				usr.BulletIcon = null
				usr.SubBulletIcon=null
				usr.icon='Duo.dmi'
				if(!isSAdmin(usr))
					usr.Disabled[c_AOE]=1
					usr.Disabled[c_MEGAMAN]=1

				for(var/X in typesof(/obj/Characters/Duo)) usr.overlays+=X
				usr.Class="Duo"
				usr.Attack = 2
				usr.pixel_x=0
				usr.Flight=0
				usr.delay=5
				usr.GotoBattle()
				return
		#endif
		#ifdef INCLUDED_COLONEL_DM
		Colonel
			icon_state = "colonel"
			screen_loc = "6,10"
			Click()
				if(!isSAdmin(usr))
					if(CharUse[c_X]==1){usr<<A;return}

				usr.overlays = list()
				usr.BulletIcon = null
				usr.SubBulletIcon=null
				usr.icon='Col.dmi'
				if(!isSAdmin(usr))
					usr.Disabled[c_X]=1

				for(var/X in typesof(/obj/Characters/Colonel)) usr.overlays+=X
				usr.Class="Colonel"
				usr.Attack = 2
				usr.pixel_x=0
				usr.Flight=0
				usr.delay=5
				usr.GotoBattle()
				return
		#endif
		#ifdef INCLUDED_PHANTOM_DM
		Phantom
			icon_state = "phantom"
			screen_loc = "10,11"
			Click()
				if(!isSAdmin(usr))
					if(CharUse[c_INVISIBLE]==1||CharUse[c_ZERO]==1){usr<<A;return}

				usr.overlays = list()
				usr.BulletIcon = 'Star.dmi'
				usr.SubBulletIcon=null
				usr.icon='Phantom.dmi'
				if(!isSAdmin(usr))
					usr.Disabled[c_ZERO]=1
					usr.Disabled[c_INVISIBLE]=1

				for(var/X in typesof(/obj/Characters/Phantom)) usr.overlays+=X
				usr.Class="Phantom"
				usr.Attack = 2
				usr.pixel_x=0
				usr.Flight=0
				usr.delay=5
				usr.GotoBattle()
				return
		#endif
		#ifdef INCLUDED_SWORDMAN_DM
		Swordman
			icon_state = "swordman"
			screen_loc="4,8"
			Click()
				if(!isSAdmin(usr))
					if(CharUse[c_MEGAMAN]==1){usr<<A;return}

				usr.overlays = list()
				usr.BulletIcon = null
				usr.SubBulletIcon=null
				usr.icon='Sword.dmi'
				if(!isSAdmin(usr))
					usr.Disabled[c_MEGAMAN]=1

				for(var/X in typesof(/obj/Characters/Swordman)) usr.overlays+=X
				usr.Class="Swordman"
				usr.Attack = 1
				usr.pixel_x=0
				usr.Flight=0
				usr.delay=5
				usr.GotoBattle()
				return
		#endif
		#ifdef INCLUDED_CX_DM
		CX
			icon_state = "cx"
			screen_loc = "5,11"
			Click()
				if(!isSAdmin(usr))
					if(CharUse[c_ZERO]==1){usr<<A;return}

				usr.overlays = list()
				usr.BulletIcon = 'XShot.dmi'
				usr.SubBulletIcon=null
				usr.icon='CX.dmi'
				if(!isSAdmin(usr))
					usr.Disabled[c_ZERO]=1

				for(var/X in typesof(/obj/Characters/CX)) usr.overlays+=X
				usr.Class="CX"
				usr.Attack = 3
				usr.pixel_x=0
				usr.Flight=0
				usr.delay=4
				usr.GotoBattle()
				return
		#endif
		#ifdef INCLUDED_CZERO_DM
		CZero
			icon_state = "czero"
			screen_loc = "6,11"
			Click()
				if(!isSAdmin(usr))
					if(CharUse[c_ZERO]==1){usr<<A;return}

				usr.overlays = list()
				usr.BulletIcon = 'XShot.dmi'
				usr.SubBulletIcon=null
				usr.icon='CZero.dmi'
				if(!isSAdmin(usr))
					usr.Disabled[c_ZERO]=1

				for(var/X in typesof(/obj/Characters/CZero)) usr.overlays+=X
				usr.Class="CZero"
				usr.Attack = 4
				usr.pixel_x=0
				usr.Flight=0
				usr.delay=5
				usr.GotoBattle()
				return
		#endif
		#ifdef INCLUDED_X_DM
		XSeries/X
			icon_state = "x"
			screen_loc = "4,13"
			Click()
				if(!isSAdmin(usr))
					if(CharUse[c_X]==1){usr<<A;return}

				usr.overlays = list()
				usr.BulletIcon = 'XShot.dmi'
				usr.SubBulletIcon=null
				usr.icon = 'X(2).dmi'
				usr.Class="X"
				if(!isSAdmin(usr))
					usr.Disabled[c_X]=1

				for(var/X in typesof(/obj/Characters/X)) usr.overlays+=X
				usr.Attack = 1
				usr.pixel_x=-16
				usr.Flight=0
				usr.delay=5
				usr.GotoBattle()
				return
		#endif
		#ifdef INCLUDED_FEFNIR_DM
		Fefnir
			icon_state = "fefnir"
			screen_loc = "9,11"
			Click()
				if(!isSAdmin(usr))
					if(CharUse[c_ZERO]==1){usr<<A;return}

				usr.overlays = list()
				usr.BulletIcon = 'FefnirShot2.dmi'
				usr.SubBulletIcon=null
				usr.icon='Fefnir.dmi'
				if(!isSAdmin(usr))
					usr.Disabled[c_ZERO]=1

				for(var/X in typesof(/obj/Characters/Fefnir)) usr.overlays+=X
				usr.Class="Fefnir"
				usr.Attack = 3
				usr.pixel_x=0
				usr.Flight=0
				usr.delay=5
				usr.GotoBattle()
				return
		#endif
		#ifdef INCLUDED_MAGMA_DM
		Magma
			icon_state = "magmadragoon"
			screen_loc = "12,13"
			Click()
				if(!isSAdmin(usr))
					if(CharUse[c_X]==1){usr<<A;return}

				usr.overlays = list()
				usr.BulletIcon = 'MagmaShot.dmi'
				usr.SubBulletIcon=null
				usr.icon='Magma Dragoon.dmi'
				if(!isSAdmin(usr))
					usr.Disabled[c_X]=1

				for(var/X in typesof(/obj/Characters/Magma)) usr.overlays+=X
				usr.Class="Magma"
				usr.Attack = 3
				usr.pixel_x=0
				usr.Flight=0
				usr.delay=4
				usr.GotoBattle()
				return
		#endif
		#ifdef INCLUDED_ZERO_DM
		ZeroSeries/Zero
			icon_state = "zero"
			screen_loc = "4,11"
			Click()
			//	if(!isSAdmin(usr))
			//		if(CharUse[c_ZERO]==1||SCharDisabled[cZero]==1){usr<<A;return}

				usr.overlays = list()
				usr.BulletIcon = null
				usr.SubBulletIcon=null
				usr.icon = 'Zero.dmi'
				usr.Class="Zero"
			//	if(!isSAdmin(usr))
			//		usr.Disabled[c_ZERO]=1

				for(var/X in typesof(/obj/Characters/Zero)) usr.overlays+=X
				usr.Attack = 2
				usr.pixel_x=0
				usr.Flight=0
				usr.delay=5
				usr.GotoBattle()
				return
		#endif
		#ifdef INCLUDED_PUREZERO_DM
		PureZero
			icon_state = "purezero"
			screen_loc = "7,10"
			Click()
				if(!isSAdmin(usr))
					if(CharUse[c_X]==1){usr<<A;return}

				usr.overlays = list()
				usr.Class="PureZero"
				usr.BulletIcon = null
				usr.SubBulletIcon=null
				usr.icon='Purestrain.dmi'
				if(!isSAdmin(usr))
					usr.Disabled[c_X]=1

				for(var/X in typesof(/obj/Characters/PureZero)) usr.overlays+=X
				usr.Flight = 1
				usr.Attack=3
				usr.pixel_x=0
				usr.delay=5
				usr.GotoBattle()
				return
		#endif
		#ifdef INCLUDED_GBD_DM
		GBD
			icon_state = "gbd"
			screen_loc = "5,7"
			Click()
				if(!isSAdmin(usr))
					if(CharUse[c_CUSTOM]==1){usr<<A;return}

				usr.overlays = list()
				usr.BulletIcon = 'GBDShot.dmi'
				usr.SubBulletIcon=null
				usr.icon = 'GBD.dmi'
				usr.Class="GBD"
				if(!isSAdmin(usr))
					usr.Disabled[c_CUSTOM]=1

				for(var/X in typesof(/obj/Characters/GBD)) usr.overlays+=X
				usr.Attack = 2
				usr.pixel_x=0
				usr.Flight=0
				usr.delay=5
				usr.GotoBattle()
				return
		#endif
		#ifdef INCLUDED_MEGAMAN_DM
		MegamanSeries/Megaman
			icon_state = "megaman"
			screen_loc = "4,12"
			Click()
				usr.overlays = list()
				usr.BulletIcon = 'Megashot.dmi'
				usr.SubBulletIcon=null
				usr.icon = 'Megaman(2).dmi'
				usr.Class="Megaman"
				for(var/X in typesof(/obj/Characters/Megaman)) usr.overlays+=X
				usr.Attack = 2
				usr.pixel_x=-16
				usr.Flight=0
				usr.delay=4
				usr.GotoBattle()
				return
		#endif
		#ifdef INCLUDED_PROTOMAN_DM
		MegamanSeries/Protoman
			icon_state = "protoman"
			screen_loc = "5,12"
			Click()
				usr.overlays = list()
				usr.BulletIcon = 'Protoshot.dmi'
				usr.SubBulletIcon=null
				usr.icon = 'Protoman(2).dmi'
				usr.Class="Protoman"
				for(var/X in typesof(/obj/Characters/Protoman)) usr.overlays+=X
				usr.Attack = 3
				usr.pixel_x=-16
				usr.Flight=0
				usr.delay=5
				usr.GotoBattle()
				return
		#endif
		#ifdef INCLUDED_BASS_DM
		MegamanSeries/Bass
			icon_state = "bass"
			screen_loc = "6,12"
			Click()
				usr.overlays = list()
				usr.BulletIcon = 'BassShot.dmi'
				usr.SubBulletIcon=null
				usr.icon = 'Bass(2).dmi'
				usr.Class="Bass"
				for(var/X in typesof(/obj/Characters/Bass)) usr.overlays+=X
				usr.Attack = 3
				usr.pixel_x=-16
				usr.Flight=0
				usr.delay=6
				usr.GotoBattle()
				return
		#endif
		#ifdef INCLUDED_CUTMAN_DM
		MegamanSeries/Cutman
			icon_state = "cutman"
			screen_loc = "9,12"
			Click()
				if(!isSAdmin(usr))
					if(CharUse[c_MEGAMAN]==1) {usr<<A;return}

				usr.overlays = list()
				usr.BulletIcon = 'CutShot.dmi'
				usr.SubBulletIcon=null
				usr.icon = 'Cutman(2).dmi'
				usr.Class="Cutman"
				if(!isSAdmin(usr))
					usr.Disabled[c_MEGAMAN]=1

				for(var/X in typesof(/obj/Characters/Cutman)) usr.overlays+=X
				usr.Attack = 1
				usr.pixel_x=-16
				usr.Flight=0
				usr.delay=5
				usr.GotoBattle()
				return
		#endif
		#ifdef INCLUDED_GATE_DM
		Gate
			icon_state = "gate"
			screen_loc = "9,13"
			Click()
				if(!isSAdmin(usr))
					if(CharUse[c_TEAMBASED]==1||CharUse[c_X]==1){usr<<A;return}


				usr.overlays = list()
				usr.icon = 'Gate(2).dmi'
				usr.Class="Gate"
				usr.BulletIcon = null
				usr.SubBulletIcon=null
				if(!isSAdmin(usr))
					usr.Disabled[c_TEAMBASED]=1
					usr.Disabled[c_X]=1

				for(var/X in typesof(/obj/Characters/Gate)) usr.overlays+=X
				usr.Flight = 1
				usr.Attack=1
				usr.pixel_x=-16
				usr.delay=5
				usr.GotoBattle()
				return
		#endif
		#ifdef INCLUDED_VILE_DM
		Vile
			icon_state = "vile"
			screen_loc = "11,13"
			Click()
				if(!isSAdmin(usr))
					if(CharUse[c_X]==1){usr<<A;return}
				usr.overlays = list()
				usr.BulletIcon = 'VileShot.dmi'
				usr.SubBulletIcon=null
				usr.icon = 'Vile(2).dmi'
				usr.Class="Vile"
				if(!isSAdmin(usr))
					usr.Disabled[c_X]=1

				for(var/X in typesof(/obj/Characters/Vile)) usr.overlays+=X
				usr.Attack = 5
				usr.pixel_x=-16
				usr.Flight=0
				usr.delay=5
				usr.GotoBattle()
				return
		#endif
		#ifdef INCLUDED_ZV_DM
		Customs/ZV
			icon_state = "zv"
			screen_loc = "9,10"
			Click()
				if(!isSAdmin(usr))
					if(CharUse[c_INVISIBLE]==1||CharUse[c_AOE]==1||CharUse[c_CUSTOM]==1){usr<<A;return}

				usr.overlays = list()
				usr.BulletIcon = null
				usr.SubBulletIcon=null
				usr.icon='ZV.dmi'
				if(!isSAdmin(usr))
					usr.Disabled[c_INVISIBLE]=1
					usr.Disabled[c_AOE]=1
					usr.Disabled[c_CUSTOM]=1

				for(var/X in typesof(/obj/Characters/ZV)) usr.overlays+=X
				usr.Class="ZV"
				usr.Attack = 3
				usr.pixel_x=0
				usr.Flight=0
				usr.delay=5
				usr.GotoBattle()
				return
		#endif
		#ifdef INCLUDED_SHADOWMAN_DM
		Shadowman
			icon_state = "shadowman"
			screen_loc = "10,12"
			Click()
				if(!isSAdmin(usr))
					if(CharUse[c_INVISIBLE]==1||CharUse[c_MEGAMAN]==1){usr<<A;return}

				usr.overlays = list()
				usr.BulletIcon = 'Shuriken.dmi'
				usr.SubBulletIcon=null
				usr.icon=/obj/Characters/Shadowman/base
				if(!isSAdmin(usr))
					usr.Disabled[c_INVISIBLE]=1
					usr.Disabled[c_MEGAMAN]=1

				for(var/X in typesof(/obj/Characters/Shadowman)) usr.overlays+=X
				usr.Class="Shadowman"
				usr.Attack = 1
				usr.pixel_x=0
				usr.Flight=0
				usr.delay=0
				usr.GotoBattle()
				return
		#endif
		#ifdef INCLUDED_SIGMA_DM
		Sigma
			icon_state = "sigma"
			screen_loc = "10,13"
			Click()
				if(!isSAdmin(usr))
					if(CharUse[c_INVISIBLE]==1||CharUse[c_X]==1){usr<<A;return}

				usr.overlays = list()
				usr.icon = 'SigX5M.dmi'
				usr.Class="Sigma"
				usr.BulletIcon = null
				usr.SubBulletIcon=null
				if(!isSAdmin(usr))
					usr.Disabled[c_INVISIBLE]=1
					usr.Disabled[c_X]=1

				for(var/X in typesof(/obj/Characters/Sigma)) usr.overlays+=X
				usr.Flight = 0
				usr.Attack=2
				usr.pixel_x=0
				usr.delay=5
				usr.GotoBattle()
				return
		#endif
		#ifdef INCLUDED_HARP_DM
		Harpuia
			icon_state = "harpuia"
			screen_loc = "8,11"
			Click()
				if(!isSAdmin(usr))
					if(CharUse[c_ZERO]==1){usr<<A;return}

				usr.overlays = list()
				usr.icon = 'Harp(2).dmi'
				usr.Class="Harp"
				usr.BulletIcon = null
				usr.SubBulletIcon=null
				if(!isSAdmin(usr))
					usr.Disabled[c_ZERO]=1

				for(var/X in typesof(/obj/Characters/Harp)) usr.overlays+=X
				usr.Flight = 1
				usr.Attack=1
				usr.pixel_x=-16
				usr.delay=5
				usr.GotoBattle()
				return
		#endif
		#ifdef INCLUDED_MET_DM
		Met
			icon_state = "mettaur"
			screen_loc = "11,12"
			Click()
				if(!isSAdmin(usr))
					if(CharUse[c_MEGAMAN]==1){usr<<A;return}

				usr.overlays = list()
				usr.pixel_x=0
				if(!isSAdmin(usr))
					usr.Disabled[c_MEGAMAN]=1

				usr.BulletIcon = 'Megashot.dmi'
				usr.SubBulletIcon=null
				usr.icon = /obj/Characters/Met
				usr.Class="Met"
				usr.Attack = 1
				usr.Flight=0
				usr.delay=6
				usr.GotoBattle()
				return
		#endif
		#ifdef INCLUDED_GRENADEMAN_DM
		Grenademan
			icon_state = "grenman"
			screen_loc = "8,12"
			Click()
				if(!isSAdmin(usr))
					if(CharUse[c_MEGAMAN]==1||CharUse[c_AOE]==1){usr<<A;return}

				usr.overlays = list()
				usr.pixel_x=0
				usr.pixel_y=-16
				usr.BulletIcon = 'Grenbomb.dmi'
				usr.SubBulletIcon=null
				usr.icon = 'Gren.dmi'
				if(!isSAdmin(usr))
					usr.Disabled[c_MEGAMAN]=1
					usr.Disabled[c_AOE]=1

				for(var/X in typesof(/obj/Characters/Grenademan)) usr.overlays+=X
				usr.Class="Grenademan"
				usr.Attack = 3
				usr.Flight=0
				usr.delay=7
				usr.GotoBattle()
				return
		#endif
		#ifdef INCLUDED_TENGUMAN_DM
		Tenguman
			icon_state = "tengu"
			screen_loc = "12,12"
			Click()
				if(!isSAdmin(usr))
					if(CharUse[c_MEGAMAN]==1){usr<<A;return}

				usr.overlays = list()
				usr.pixel_x=0
				usr.pixel_y=-16
				usr.BulletIcon = null
				usr.SubBulletIcon=null
				usr.icon = 'Tengbase.dmi'
				if(!isSAdmin(usr))
					usr.Disabled[c_MEGAMAN]=1

				for(var/X in typesof(/obj/Characters/Tenguman)) usr.overlays+=X
				usr.Class="Tenguman"
				usr.Attack = 2
				usr.Flight=1
				usr.delay=5
				usr.GotoBattle()
				return
		#endif
		#ifdef INCLUDED_PSX_DM
		PSX
			icon_state = "psx"
			screen_loc = "6,7"
			Click()
				if(!isSAdmin(usr))
					if(CharUse[c_CUSTOM]==1){usr<<A;return}

				usr.overlays = list()
				usr.pixel_x=-16
				usr.pixel_y=-16
				usr.BulletIcon = 'psx 1.dmi'
				usr.SubBulletIcon=null
				usr.icon = 'psxl.dmi'
				if(!isSAdmin(usr))
					usr.Disabled[c_CUSTOM]=1

				for(var/X in typesof(/obj/Characters/PSX)) usr.overlays+=X
				usr.Class="PSX"
				usr.Attack = 3
				usr.Flight=1
				usr.delay=3
				usr.GotoBattle()
				return
		#endif
		#ifdef INCLUDED_DARKGUISE_DM
		Darkguise
			icon_state="darkguise"
			screen_loc="11,9"
			Click()
				if(!isSAdmin(usr))
					if(CharUse[c_X]==1){usr<<A;return}

				usr.overlays = list()
				usr.pixel_x=0
				usr.pixel_y=-16
				usr.BulletIcon = null
				usr.SubBulletIcon=null
				usr.icon = 'Dark.dmi'
				if(!isSAdmin(usr))
					usr.Disabled[c_X]=1

				for(var/X in typesof(/obj/Characters/Darkguise)) usr.overlays+=X
				usr.Class="Darkguise"
				usr.Attack = 3
				usr.Flight=0
				usr.delay=5
				usr.GotoBattle()
				return
		#endif
		#ifdef INCLUDED_WEIL_DM
		Weil
			icon_state="weil"
			screen_loc="8,9"
			Click()
				if(!isSAdmin(usr))
					if(CharUse[c_ZERO]==1){usr<<A;return}

				usr.overlays = list()
				usr.pixel_x=0
				usr.pixel_y=-16
				usr.BulletIcon = 'RagShot.dmi'
				usr.SubBulletIcon=null
				usr.icon = 'Weil.dmi'
				if(!isSAdmin(usr))
					usr.Disabled[c_ZERO]=1

				for(var/X in typesof(/obj/Characters/Weil)) usr.overlays+=X
				usr.Class="Weil"
				usr.Attack = 6
				usr.Flight=1
				usr.delay=8
				usr.GotoBattle()
				return
		#endif
		#ifdef INCLUDED_ELPIZO_DM
		Elpizo
			icon_state="elpizo"
			screen_loc = "7,11"
			Click()
				if(!isSAdmin(usr))
					if(CharUse[c_AOE]==1||CharUse[c_ZERO]==1){usr<<A;return}

				usr.overlays = list()
				usr.pixel_x=0
				usr.pixel_y=-16
				usr.BulletIcon = null
				usr.SubBulletIcon=null
				usr.icon = 'Elp.dmi'
				if(!isSAdmin(usr))
					usr.Disabled[c_AOE]=1
					usr.Disabled[c_ZERO]=1

				for(var/X in typesof(/obj/Characters/Elpizo)) usr.overlays+=X
				usr.Class="Elpizo"
				usr.Attack = 1
				usr.Flight=0
				usr.delay=5
				usr.GotoBattle()
				return
		#endif
		#ifdef INCLUDED_LEVIATHEN_DM
		Leviathen
			icon_state="leviathen"
			screen_loc="11,11"
			Click()
				if(!isSAdmin(usr))
					if(CharUse[c_ZERO]==1){usr<<A;return}

				usr.overlays = list()
				usr.pixel_x=0
				usr.pixel_y=-16
				usr.BulletIcon = 'LevShot.dmi'
				usr.SubBulletIcon=null
				usr.icon = 'Leviathen.dmi'
				if(!isSAdmin(usr))
					usr.Disabled[c_ZERO]=1

				for(var/X in typesof(/obj/Characters/Leviathen)) usr.overlays+=X
				usr.Class="Leviathen"
				usr.Attack = 4
				usr.Flight=1
				usr.delay=5
				usr.GotoBattle()
				return
		#endif
		#ifdef INCLUDED_MIJINION_DM
		Mijinion
			icon_state="mijinion"
			screen_loc="5,10"
			Click()
				if(!isSAdmin(usr))
					if(CharUse[c_X]==1||CharUse[c_INVISIBLE]==1){usr<<A;return}

				usr.overlays = list()
				usr.pixel_x=0
				usr.pixel_y=-16
				usr.BulletIcon = 'MijinionBlast.dmi'
				usr.SubBulletIcon=null
				usr.icon = 'Mijinion.dmi'
				if(!isSAdmin(usr))
					usr.Disabled[c_INVISIBLE]=1
					usr.Disabled[c_X]=1

				for(var/X in typesof(/obj/Characters/Mijinion)) usr.overlays+=X
				usr.Class="Mijinion"
				usr.Attack = 4
				usr.Flight=0
				usr.delay=7
				usr.GotoBattle()
				return
		#endif
		#ifdef INCLUDED_AXL_DM
		XSeries/Axl
			icon_state="axl"
			screen_loc="6,13"
			Click()
				if(!isSAdmin(usr))
					if(CharUse[c_X]==1){usr<<A;return}

				usr.overlays = list()
				usr.pixel_x=0
				usr.pixel_y=-16
				usr.BulletIcon = 'XShot.dmi'
				usr.SubBulletIcon=null
				usr.icon = /obj/Characters/Axl/base
				if(!isSAdmin(usr))
					usr.Disabled[c_X]=1

				for(var/X in typesof(/obj/Characters/Axl)) usr.overlays+=X
				usr.Class="Axl"
				usr.Attack = 3
				usr.Flight=0
				usr.delay=6
				usr.GotoBattle()
				return
		#endif
		#ifdef INCLUDED_HEATNIX_DM
		Heatnix
			icon_state="heatnix"
			screen_loc="8,10"
			Click()
				if(!isSAdmin(usr))
					if(CharUse[c_X]==1||CharUse[c_AOE]==1){usr<<A;return}

				usr.overlays = list()
				usr.pixel_x=0
				usr.pixel_y=-16
				usr.BulletIcon = 'WaveBase.dmi'
				usr.SubBulletIcon='WaveTop.dmi'
				usr.icon = 'HeatnixBase.dmi'
				if(!isSAdmin(usr))
					usr.Disabled[c_X]=1
					usr.Disabled[c_AOE]=1

				for(var/X in typesof(/obj/Characters/Heatnix)) usr.overlays+=X
				usr.Class="Heatnix"
				usr.Attack = 2
				usr.Flight=1
				usr.delay=7
				usr.GotoBattle()
				return
		#endif
		#ifdef INCLUDED_MEDIC_DM

		Medic
			icon_state="medic"
			screen_loc="10,9"
			Click()
				if(!isSAdmin(usr))
					if(CharUse[c_X]==1){usr<<A;return}

				usr.overlays = list()
				usr.pixel_x=0
				usr.pixel_y=-16
				usr.BulletIcon = null
				usr.SubBulletIcon=null
				usr.icon = 'Medic.dmi'
				if(!isSAdmin(usr))
					usr.Disabled[c_X]=1

				for(var/X in typesof(/obj/Characters/Medic)) usr.overlays+=X
				usr.Class="Medic"
				usr.Attack = 3
				usr.Flight=0
				usr.delay=5
				usr.GotoBattle()
				return
		#endif
		#ifdef INCLUDED_FOXTAR_DM
		Foxtar
			icon_state="cubit"
			screen_loc="12,9"
			Click()
				if(!isSAdmin(usr))
					if(CharUse[c_ZERO]==1){usr<<A;return}

				usr.overlays = list()
				usr.pixel_x=0
				usr.pixel_y=-16
				usr.BulletIcon = 'CubitShots.dmi'
				usr.SubBulletIcon=null
				usr.icon = 'Cubit.dmi'
				if(!isSAdmin(usr))
					usr.Disabled[c_ZERO]=1

				for(var/X in typesof(/obj/Characters/Foxtar)) usr.overlays+=X
				usr.Class="Foxtar"
				usr.Attack = 2
				usr.Flight=0
				usr.delay=5
				usr.GotoBattle()
				return
		#endif
		#ifdef INCLUDED_ANUBIS_DM
		ZeroSeries/Anubis
			icon_state="anubis"
			screen_loc="4,9"
			Click()
				if(!isSAdmin(usr))
					if(CharUse[c_ZERO]==1||CharUse[c_TEAMBASED]==1||g_WorldMode=="Boss Battle"||g_WorldMode=="Dual Boss Battle"||g_WorldMode=="Battle of the Bosses"){usr<<A;return}

				usr.overlays = list()
				usr.pixel_x=0
				usr.pixel_y=-16
				usr.BulletIcon = 'XShot.dmi'
				usr.SubBulletIcon=null
				usr.icon = 'Anubis.dmi'
				if(!isSAdmin(usr))
					usr.Disabled[c_TEAMBASED]=1
					usr.Disabled[c_ZERO]=1

				for(var/X in typesof(/obj/Characters/Anubis)) usr.overlays+=X
				usr.Class="Anubis"
				usr.Attack = 2
				usr.Flight=0
				usr.delay=7
				usr.GotoBattle()
				return
		#endif
		#ifdef INCLUDED_CHILLDRE_DM
		ZeroSeries/Chilldre
			icon_state="chilldre"
			screen_loc="5,9"
			Click()
				if(!isSAdmin(usr))
					if(CharUse[c_ZERO]==1||CharUse[c_AOE]==1){usr<<A;return}

				usr.overlays = list()
				usr.pixel_x=0
				usr.pixel_y=-16
				usr.BulletIcon = 'ChilldreShot1.dmi'
				usr.SubBulletIcon=null
				usr.icon = 'Chilldre.dmi'
				if(!isSAdmin(usr))
					usr.Disabled[c_ZERO]=1
					usr.Disabled[c_AOE]=1

				for(var/X in typesof(/obj/Characters/Chilldre)) usr.overlays+=X
				usr.Class="Chilldre"
				usr.Attack = 2
				usr.Flight=0
				usr.delay=5
				usr.GotoBattle()
				return
		#endif
		#ifdef INCLUDED_KRAFT_DM
		Kraft
			icon_state="kraft"
			screen_loc="6,9"
			Click()
				if(!isSAdmin(usr))
					if(CharUse[c_ZERO]==1){usr<<A;return}

				usr.overlays = list()
				usr.pixel_x=0
				usr.pixel_y=-16
				usr.BulletIcon = 'KraftShots.dmi'
				usr.SubBulletIcon=null
				usr.icon = 'Kraft.dmi'
				if(!isSAdmin(usr))
					usr.Disabled[c_ZERO]=1

				for(var/X in typesof(/obj/Characters/Kraft)) usr.overlays+=X
				usr.Class="Kraft"
				usr.Attack = 3
				usr.Flight=0
				usr.delay=4
				usr.GotoBattle()
				return
		#endif
		#ifdef INCLUDED_SHELLDON_DM
		Shelldon
			icon_state="shelldon"
			screen_loc="11,10"
			Click()
				if(!isSAdmin(usr))
					if(CharUse[c_X]==1||CharUse[c_INVISIBLE]==1){usr<<A;return}

				usr.overlays = list()
				usr.pixel_x=0
				usr.pixel_y=-16
				usr.BulletIcon = 'ShelldonShot1.dmi'
				usr.SubBulletIcon=null
				usr.icon = 'Sheldon.dmi'
				if(!isSAdmin(usr))
					usr.Disabled[c_X]=1
					usr.Disabled[c_INVISIBLE]=1

				for(var/X in typesof(/obj/Characters/Shelldon)) usr.overlays+=X
				usr.Class="Shelldon"
				usr.Attack = 2
				usr.Flight=1
				usr.delay=6
				usr.GotoBattle()
				return
		#endif
		#ifdef INCLUDED_MMXZERO_DM
		MMXZero
			icon_state="mmxzero"
			screen_loc="5,13"
			Click()
				if(!isSAdmin(usr))
					if(CharUse[c_X]==1){usr<<A;return}

				usr.overlays = list()
				usr.pixel_x=0
				usr.pixel_y=-16
				usr.BulletIcon = 'XShot.dmi'
				usr.SubBulletIcon=null
				usr.icon = 'MMXZero.dmi'
				if(!isSAdmin(usr))
					usr.Disabled[c_X]=1

				for(var/X in typesof(/obj/Characters/MMXZero)) usr.overlays+=X
				usr.Class="MMXZero"
				usr.Attack = 3
				usr.Flight=0
				usr.delay=5
				usr.GotoBattle()
				return
		#endif
		#ifdef INCLUDED_CMX_DM
		CMX
			icon_state="missionx"
			screen_loc="12,10"
			Click()
				if(!isSAdmin(usr))
					if(CharUse[c_X]==1){usr<<A;return}

				usr.overlays = list()
				usr.pixel_x=0
				usr.pixel_y=-16
				usr.BulletIcon = 'CMXShots.dmi'
				usr.SubBulletIcon=null
				usr.icon = 'CMX.dmi'
				if(!isSAdmin(usr))
					usr.Disabled[c_X]=1

				for(var/X in typesof(/obj/Characters/CMX)) usr.overlays+=X
				usr.Class="CMX"
				usr.Attack = 3
				usr.Flight=0
				usr.delay=5
				usr.GotoBattle()
				return
		#endif
		#ifdef INCLUDED_WOLFANG_DM
		Wolfang
			icon_state="wolfang"
			screen_loc="4,10"
			Click()
				if(!isSAdmin(usr))
					if(CharUse[c_X]==1){usr<<A;return}

				usr.overlays = list()
				usr.pixel_x=0
				usr.pixel_y=-16
				usr.BulletIcon = 'WolfangShot.dmi'
				usr.SubBulletIcon=null
				usr.icon = 'Wolfang.dmi'
				if(!isSAdmin(usr))
					usr.Disabled[c_X]=1

				for(var/X in typesof(/obj/Characters/Wolfang)) usr.overlays+=X
				usr.Class="Wolfang"
				usr.Attack = 3
				usr.Flight=0
				usr.delay=7
				usr.GotoBattle()
				return
		#endif
		#ifdef INCLUDED_KNIGHTMAN_DM
		MegamanSeries/Knightman
			icon_state="knightman"
			screen_loc="5,8"
			Click()
				if(!isSAdmin(usr))
					if(CharUse[c_MEGAMAN]==1){usr<<A;return}

				usr.overlays = list()
				usr.pixel_x=0
				usr.pixel_y=-16
				usr.BulletIcon = 'KnightmanShots.dmi'
				usr.SubBulletIcon=null
				usr.icon = 'Knightman.dmi'
				if(!isSAdmin(usr))
					usr.Disabled[c_MEGAMAN]=1

				for(var/X in typesof(/obj/Characters/Knightman)) usr.overlays+=X
				usr.Class="Knightman"
				usr.Attack = 3
				usr.Flight=0
				usr.delay=4
				usr.GotoBattle()
				return
		#endif
		#ifdef INCLUDED_CLOWNMAN_DM
		MegamanSeries/Clownman
			icon_state="clownman"
			screen_loc="6,8"
			Click()
				if(!isSAdmin(usr))
					if(CharUse[c_MEGAMAN]==1){usr<<A;return}

				usr.overlays = list()
				usr.pixel_x=-16
				usr.pixel_y=-16
				usr.BulletIcon = null
				usr.SubBulletIcon=null
				usr.icon = 'ClownBL.dmi'
				if(!isSAdmin(usr))
					usr.Disabled[c_MEGAMAN]=1

				for(var/X in typesof(/obj/Characters/Clownman)) usr.overlays+=X
				usr.Class="Clownman"
				usr.Attack = 3
				usr.Flight=0
				usr.delay=5
				usr.GotoBattle()
				return
		#endif

		#ifdef INCLUDED_BURNERMAN_DM
		MegamanSeries/Burnerman
			icon_state="burnerman"
			screen_loc="7,8"
			Click()
				if(!isSAdmin(usr))
					if(CharUse[c_MEGAMAN]==1){usr<<A;return}

				usr.overlays = list()
				usr.pixel_x=0
				usr.pixel_y=-16
				usr.BulletIcon = null
				usr.SubBulletIcon=null
				usr.icon = 'BurnerMan.dmi'
				if(!isSAdmin(usr))
					usr.Disabled[c_MEGAMAN]=1

				for(var/X in typesof(/obj/Characters/Burnerman)) usr.overlays+=X
				usr.Class="Burnerman"
				usr.Attack = 2
				usr.Flight=0
				usr.delay=5
				usr.GotoBattle()
				return
		#endif
		#ifdef INCLUDED_BEAT_DM
		MegamanSeries/Beat
			icon_state="beat"
			screen_loc="8,8"
			Click()
				if(!isSAdmin(usr))
					if(CharUse[c_MEGAMAN]==1){usr<<A;return}

				usr.overlays = list()
				usr.pixel_x=0
				usr.pixel_y=-16
				usr.BulletIcon = null
				usr.SubBulletIcon=null
				if(!isSAdmin(usr))
					usr.Disabled[c_MEGAMAN]=1

				usr.icon = /obj/Characters/Beat
				usr.Class="Beat"
				usr.Attack = 2
				usr.Flight=1
				usr.delay=5
				usr.GotoBattle()
				return
		#endif
		#ifdef INCLUDED_ATHENA_DM
		Customs/Athena
			icon_state="athena"
			screen_loc="9,8"
			Click()
				if(!isSAdmin(usr))
					if(CharUse[c_CUSTOM]==1){usr<<A;return}

				usr.overlays = list()
				usr.pixel_x=0
				usr.pixel_y=-16
				usr.BulletIcon = 'Athena Shot3.dmi'
				usr.SubBulletIcon=null
				if(!isSAdmin(usr))
					usr.Disabled[c_CUSTOM]=1

				usr.icon = 'Athena.dmi'
				usr.Class="Athena"
				for(var/X in typesof(/obj/Characters/Athena))
					usr.overlays+=X
				usr.Attack = 2
				usr.Flight=0
				usr.delay=5
				usr.GotoBattle()
				return
		#endif
		#ifdef INCLUDED_SJX_DM
		SJX
			icon_state="sjx"
			screen_loc="10,8"
			Click()
				if(!isSAdmin(usr))
					if(CharUse[c_CUSTOM]==1){usr<<A;return}

				usr.overlays = list()
				usr.pixel_x=0
				usr.pixel_y=-16
				usr.BulletIcon = 'SJXShot1.dmi'
				usr.SubBulletIcon=null
				if(!isSAdmin(usr))
					usr.Disabled[c_CUSTOM]=1

				usr.icon = 'SJX.dmi'
				usr.Class="SJX"
				for(var/X in typesof(/obj/Characters/SJX))
					usr.overlays+=X
				usr.Attack = 2
				usr.Flight=0
				usr.delay=4
				usr.GotoBattle()
				return
		#endif
		#ifdef INCLUDED_PLAGUE_DM
		Plague
			icon_state="plague"
			screen_loc="4,7"
			Click()
				if(!isSAdmin(usr))
					if(CharUse[c_CUSTOM]==1){usr<<A;return}

				usr.overlays = list()
				usr.pixel_x=0
				usr.pixel_y=-16
				usr.BulletIcon = 'XShot.dmi'
				usr.SubBulletIcon=null
				if(!isSAdmin(usr))
					usr.Disabled[c_CUSTOM]=1

				usr.icon = 'Plague.dmi'
				usr.Class="Plague"
				for(var/X in typesof(/obj/Characters/Plague))
					usr.overlays+=X
				usr.Attack = 2
				usr.Flight=0
				usr.delay=4
				usr.GotoBattle()
				return
		#endif
		#ifdef INCLUDED_MG400_DM
		MG400
			icon_state = "mg400";screen_loc = "11,7"
			Click()
				if(!isSAdmin(usr))
					if(CharUse[c_CUSTOM]==1) {usr<<A;return}

				usr.overlays = list()
				usr.pixel_x=0
				usr.pixel_y=-10
				if(!isSAdmin(usr))
					usr.Disabled[c_CUSTOM]=1

				usr.BulletIcon = 'MG400Missiles.dmi'
				usr.SubBulletIcon=null
				usr.icon = 'MG400main.dmi'
				usr.Class="MG400"
				for(var/X in typesof(/obj/Characters/MG400))
					usr.overlays+=X
				usr.Attack = 3
				usr.Flight=0
				usr.delay=6
				usr.Flight=0
				usr.GotoBattle()
				return
		#endif
		ModelS
			icon_state="models"
			screen_loc="11,8"
			Click()
				if(!isSAdmin(usr))
					if(CharUse[c_CUSTOM]==1){usr<<A;return}

				usr.overlays = list()
				usr.pixel_x=0
				usr.pixel_y=-14
				usr.BulletIcon = 'MSShot1.dmi'
				usr.SubBulletIcon=null
				if(!isSAdmin(usr))
					usr.Disabled[c_CUSTOM]=1

				usr.icon = 'Model Shadowman.dmi'
				usr.Class="ModelS"
				for(var/X in typesof(/obj/Characters/ModelS))
					usr.overlays+=X
				usr.Attack = 2
				usr.Flight=0
				usr.delay=5
				usr.GotoBattle()
				return
		#ifdef INCLUDED_LWX_DM
		Customs/LWX
			icon_state="lwx"
			screen_loc="12,8"
			Click()
				if(!isSAdmin(usr))
					if(CharUse[c_CUSTOM]==1){usr<<A;return}

				usr.overlays = list()
				usr.pixel_x=0
				usr.pixel_y=-16
				usr.BulletIcon = 'LegendarywarriorX Shot.dmi'
				usr.SubBulletIcon=null
				if(!isSAdmin(usr))
					usr.Disabled[c_CUSTOM]=1

				usr.icon = 'LegendarywarriorX.dmi'
				usr.Class="LWX"
				for(var/X in typesof(/obj/Characters/LWX))
					usr.overlays+=X
				usr.Attack = 3
				usr.Flight=0
				usr.delay=4
				usr.GotoBattle()
				return
		#endif
		#ifdef INCLUDED_ATHENAII_DM
		Customs/AthenaII
			icon_state="athena2"
			screen_loc="16,14"
			Click()
				if(!isSAdmin(usr))
					if(CharUse[c_CUSTOM]==1){usr<<A;return}

				usr.overlays = list()
				usr.pixel_x=0
				usr.pixel_y=-16
				usr.BulletIcon = 'Athena II Shot3.dmi'
				usr.SubBulletIcon=null
				if(!isSAdmin(usr))
					usr.Disabled[c_CUSTOM]=1
				usr.icon = 'AthenaII.dmi'
				usr.Class="AthenaII"
				for(var/X in typesof(/obj/Characters/AthenaII))
					usr.overlays+=X
				usr.Attack = 3
				usr.Flight=0
				usr.delay=5
				usr.GotoBattle()
				return
		#endif
		#ifdef INCLUDED_KING_DM
		MegamanSeries/King
			icon_state = "king"
			screen_loc = "9,7"
			Click()
				if( !isSAdmin( usr ) )
					if( CharUse[ c_MEGAMAN ] == 1 ) { usr << A; return }

				usr.overlays = list()
				usr.pixel_x = 0
				usr.pixel_y = -16
				usr.BulletIcon = null
				usr.SubBulletIcon = null
				if( !isSAdmin( usr ) )
					usr.Disabled[ c_MEGAMAN ] = 1

				usr.icon = 'King.dmi'
				usr.Class = "King"
				for( var/X in typesof( /obj/Characters/King ) )
					usr.overlays += X
				usr.Attack = 1.5
				usr.Flight = 0
				usr.delay = 5
				usr.GotoBattle()
				return
		#endif
		#ifdef INCLUDED_DRWILY_DM
		MegamanSeries/DrWily
			icon_state = "wily"
			screen_loc = "12,7"
			Click()
				if( !isSAdmin( usr ) )
					if( CharUse[ c_MEGAMAN ] == 1) { usr << A; return }

				usr.overlays = list()
				usr.pixel_x = 0
				usr.pixel_y = -16
				usr.BulletIcon = 'WilyShot.dmi'
				usr.SubBulletIcon = null
				if( !isSAdmin( usr ) )
					usr.Disabled[ c_MEGAMAN ] = 1

				usr.icon = 'Wily.dmi'
				usr.Class = "DrWily"
				for( var/X in typesof( /obj/Characters/DrWily ) )
					usr.overlays += X
				usr.Attack = 7.5
				usr.Flight = 1
				usr.delay = 30
				usr.GotoBattle()
				return
		#endif
		#ifdef INCLUDED_XERONII_DM
		Customs/XeronII
			icon_state = "xeron2"
			screen_loc = "4,6"
			Click()
				if(!isSAdmin(usr))
					if(CharUse[c_CUSTOM]==1){usr<<A;return}


				usr.overlays = list()
				usr.pixel_x=0
				usr.pixel_y=-16
				usr.BulletIcon = 'XeronIIS.dmi'
				usr.SubBulletIcon=null

				if( !isSAdmin( usr ) )
					usr.Disabled[ c_CUSTOM ] = 1


				usr.icon = 'XeronII.dmi'
				usr.Class="XeronII"

				for(var/X in typesof(/obj/Characters/XeronII))
					usr.overlays+=X
				usr.Attack = 4
				usr.Flight=0
				usr.delay=6
				usr.GotoBattle()
				return
		#endif
		#ifdef INCLUDED_FAUCLAW_DM
		Fauclaw
			icon_state = "fauclaw"
			screen_loc = "7,6"
			Click()
				if(!isSAdmin(usr))
					if(CharUse[c_ZERO]==1){usr<<A;return}


				usr.overlays=list()
				usr.icon = 'PantherFauclaw.dmi'
				usr.pixel_x=0
				for(var/X in typesof(/obj/Characters/Fauclaw))
					usr.overlays+=X
				usr.Class = "Fauclaw"
				usr.BulletIcon = null
				usr.SubBulletIcon=null

				if( !isSAdmin( usr ) )
					usr.Disabled[ c_ZERO ] = 1


				usr.Attack = 3
				usr.Flight=0
				usr.delay=5
				usr.GotoBattle()
		#endif
		#ifdef INCLUDED_SLASHBEAST_DM
		SlashBeast
			icon_state = "slashbeast"
			screen_loc = "6,6"
			Click()
				if(!isSAdmin(usr))
					if(CharUse[c_X]==1){usr<<A;return}

				if(!isSAdmin(usr)) usr.Disabled[c_X]=1; usr.SCharDis[ c_SlashBeast ] = 1
				usr.overlays=list()
				usr.icon = 'SlashBeast.dmi'
				for(var/X in typesof(/obj/Characters/SlashBeast))
					usr.overlays+=X
				usr.Class = "SlashBeast"
				usr.BulletIcon = 'WilyShot.dmi'
				usr.SubBulletIcon=null
				usr.Attack = 2
				usr.Flight=0
				usr.delay=5
				usr.GotoBattle()
		#endif
		#ifdef INCLUDED_EDDIE_DM
		Eddie
			icon_state = "eddie"
			screen_loc = "5, 6"
			Click()
				if( !isSAdmin( usr ) )
					if( CharUse[ c_MEGAMAN ] == 1) { usr << A; return }

				if( !isSAdmin( usr ) )
					usr.Disabled[ c_MEGAMAN ] = 1


				usr.overlays=list()
				usr.pixel_x=0
				usr.pixel_y=0
				usr.icon = 'Eddie.dmi'
				for(var/X in typesof(/obj/Characters/Eddie))
					usr.overlays+=X
				usr.Class = "Eddie"
				usr.BulletIcon = 'EddieShotRed.dmi'
				usr.SubBulletIcon='EddieShotBlue.dmi'
				usr.Attack = 0
				usr.Flight=1
				usr.delay=5
				usr.GotoBattle()
		#endif
	#ifdef INCLUDED_HANUMACHINE_DM
		HanuMachine
			icon_state = "hanu"
			screen_loc = "8, 6"
			Click()
				if( !isSAdmin( usr ) )
					if( CharUse[ c_ZERO ] == 1 ) { usr << A; return }

				if( !isSAdmin( usr ) )
					usr.Disabled[ c_ZERO ] = 1


				usr.overlays=list()
				usr.icon = 'HanuMachine.dmi'
				for(var/X in typesof(/obj/Characters/HanuMachine))
					usr.overlays+=X
				usr.Class = "HanuMachine"
				usr.BulletIcon = 'Athena Shot3.dmi'
				usr.SubBulletIcon=null
				usr.Attack = 2
				usr.pixel_x = 8
				usr.Flight=0
				usr.delay=4
				usr.GotoBattle()
	#endif
#ifdef INCLUDED_WOODMAN_DM
		Woodman
			icon_state = "wood"
			screen_loc = "9, 6"
			Click()
				if( !isSAdmin( usr ) )
					if( CharUse[ c_MEGAMAN ] == 1  ) { usr << A; return }

				if( !isSAdmin( usr ) )
					usr.Disabled[ c_MEGAMAN ] = 1

				usr.overlays=list()
				usr.pixel_x=0
				usr.icon = 'Woodman.dmi'
				for(var/X in typesof(/obj/Characters/Woodman))
					usr.overlays+=X
				usr.Class = "Woodman"
				usr.BulletIcon = 'WoodmanProjectile.dmi'
				usr.SubBulletIcon=null
				usr.Attack = 3
				usr.Flight=0
				usr.delay=5
				usr.GotoBattle()
#endif
#ifdef INCLUDED_ADMINMODE_DM
		Customs/AdminMode
			icon_state = "admin"
			screen_loc = "16, 15"
			Click()
				usr.overlays=list()
				usr.icon = 'Admin Mode.dmi'
				for(var/X in typesof(/obj/Characters/AdminMode))
					usr.overlays+=X
				usr.Class = "AdminMode"
				usr.BulletIcon = null
				usr.SubBulletIcon=null
				usr.pixel_x=2
				usr.Attack = 0
				usr.density = 0
				usr.Guard = 4
				usr.Flight=1
				usr.delay=5
				usr.GotoBattle()
#endif
#ifdef INCLUDED_GAX_DM
		GAX
			icon_state = "gaeax"
			screen_loc = "6,6"
			Click()
				if(!isSAdmin(usr))
					if(CharUse[c_X]==1){usr<<A;return}

				usr.overlays=list()
				usr.icon = /obj/Characters/GAX/V1
				if(!isSAdmin(usr))
					usr.Disabled[c_X]=1

				for(var/X in typesof(/obj/Characters/GAX))
					usr.overlays+=X
				usr.Class = "GAX"
				usr.BulletIcon = 'GaeaX_shots.dmi'
				usr.SubBulletIcon='GaeaX_shots2.dmi'
				usr.Attack = 2
				usr.pixel_x = 8
				usr.density = 0
				usr.Flight=0
				usr.delay=5
				usr.GotoBattle()

#endif
// c_Magicman
#ifdef INCLUDED_MAGICMAN_DM
		Magicman
			icon_state = "magicman"
			screen_loc = "10,6"
			Click()
				if(!isSAdmin(usr))
					if(CharUse[c_MEGAMAN]==1){usr<<A;return}

				usr.overlays=list()
				usr.icon = /obj/Characters/Magicman/V1
				if(!isSAdmin(usr))
					usr.Disabled[c_MEGAMAN]=1

				for(var/X in typesof(/obj/Characters/Magicman))
					usr.overlays+=X
				usr.Class = "Magicman"
				usr.BulletIcon = 'MagicmanMagicCards.dmi'
				usr.SubBulletIcon=null
				usr.Attack = 3
				usr.pixel_x = 8
				usr.density = 0
				usr.Flight=0
				usr.delay=6
				usr.GotoBattle()
#endif
#ifdef INCLUDED_ZANZIBAR_DM
		ZeroSeries/Zanzibar
			icon_state = "zanzibar"
			screen_loc = "11,6"
			Click()
				if(!isSAdmin(usr))
					if(CharUse[c_ZERO]==1){usr<<A;return}

				usr.overlays=list()
				usr.icon = /obj/Characters/Zanzibar/V1
				if(!isSAdmin(usr))
					usr.Disabled[c_ZERO]=1

				for(var/X in typesof(/obj/Characters/Zanzibar))
					usr.overlays+=X
				usr.Class = "Zanzibar"
				usr.BulletIcon = null
				usr.SubBulletIcon=null
				usr.Attack = 2
				usr.pixel_x = 8
				usr.density = 0
				usr.Flight=0
				usr.delay=6
				usr.GotoBattle()
#endif
#ifdef INCLUDED_AIRPANTHEON_DM
		ZeroSeries/AirPantheon
			icon_state = "pantheon"
			screen_loc = "12,6"
			Click()
				if(!isSAdmin(usr))
					if(CharUse[c_ZERO]==1){usr<<A;return}

				usr.overlays=list()
				usr.icon = /obj/Characters/AirPantheon/V1
				if(!isSAdmin(usr))
					usr.Disabled[c_ZERO]=1

				for(var/X in typesof(/obj/Characters/AirPantheon))
					usr.overlays+=X
				usr.Class = "AirPantheon"
				usr.BulletIcon = 'Pantheon_shots.dmi'
				usr.SubBulletIcon=null
				usr.Attack = 2
				usr.pixel_x = -4
				usr.density = 0
				usr.Flight=1
				usr.delay=8
				usr.GotoBattle()
#endif
#ifdef INCLUDED_MODELGATE_DM
		ModelGate
			icon_state = "modelgate"
			screen_loc = "4,5"
			Click()
				if(!isSAdmin(usr))
					if(CharUse[c_CUSTOM]==1) {usr<<A;return}
				usr.overlays=list()
				usr.icon = /obj/Characters/ModelGate/V1
				if(!isSAdmin(usr))
					usr.Disabled[c_CUSTOM]=1

				for(var/X in typesof(/obj/Characters/ModelGate))
					usr.overlays+=X
				usr.Class = "ModelGate"
				usr.BulletIcon = 'Model_G Shots.dmi'
				usr.SubBulletIcon=null
				usr.Attack = 3
				usr.pixel_x = -32
				usr.pixel_y = 4
				usr.density = 0
				usr.Flight=0
				usr.delay=5
				usr.GotoBattle()
#endif
#ifdef INCLUDED_MODELBD_DM
		ModelBD
			icon_state = "modelbd"
			screen_loc = "5,5"
			Click()
				if(!isSAdmin(usr))
					if(CharUse[c_CUSTOM]==1){usr<<A;return}

				usr.overlays=list()
				usr.icon = /obj/Characters/ModelBD/V1
				if(!isSAdmin(usr))
					usr.Disabled[c_CUSTOM]=1

				for(var/X in typesof(/obj/Characters/ModelBD))
					usr.overlays+=X
				usr.Class = "ModelBD"
				usr.BulletIcon = 'Model_BD_Shots.dmi'
				usr.SubBulletIcon=null
				usr.Attack = 3
				usr.pixel_x = -32
				usr.pixel_y = 4
				usr.density = 0
				usr.Flight=0
				usr.delay=5
				usr.GotoBattle()
#endif
#ifdef INCLUDED_HADES_DM
		Hades
			icon_state = "hades"
			screen_loc = "6,5"
			Click()
				if(!isSAdmin(usr))
					if(CharUse[c_CUSTOM]==1||SCharDisabled[c_Hades]==1){usr<<A;return}

				usr.overlays=list()
				usr.icon = /obj/Characters/Hades/V1
				if(!isSAdmin(usr))
					usr.Disabled[c_CUSTOM]=1

				for(var/X in typesof(/obj/Characters/Hades))
					usr.overlays+=X
				usr.Class = "Hades"
				usr.BulletIcon = 'MagicmanMagicCards.dmi'
				usr.SubBulletIcon=null
				usr.Attack = 3
				usr.pixel_x = 8
				usr.density = 0
				usr.Flight=0
				usr.delay=6
				usr.GotoBattle()
#endif
		Teams
			Nuetral
				icon = 'TeamStuff.dmi';icon_state = "nuetral";screen_loc = "1,1"
				Click()
					switch(g_WorldMode)
						if("Battle", "Deathmatch", "Double Kill", "Neutral Flag")
							usr.Stats[c_Team] = "N/A"
							return
					if(TeamLocked[c_NEUTRAL] == 1)
						usr<<"<b>Cannot be Neutral at this time.";return

			Red_Team
				icon = 'TeamStuff.dmi';icon_state = "redselect";screen_loc = "2,1"
				Click()
					#if DUEL_MODE
					if(get_WorldStatus([c_Mode]) == "Duel Mode")
						if(eTeam1.Find("[usr.key]")||eTeam2.Find("[usr.key]")||eTeam3.Find("[usr.key]")||eDead1.Find("[usr.key]")||eDead2.Find("[usr.key]")||eDead3.Find("[usr.key]"))
							usr<<"<B>You cannot choose a different team at this time."
							return
					#endif
					if(TeamLocked[c_RED]==1||Invalid_Team_Change())
						usr<<"<B>You cannot choose a different team at this time.";return
					usr.Stats[c_Team] = "Red"
			Blue_Team
				icon = 'TeamStuff.dmi';icon_state = "blueselect";screen_loc = "3,1"
				Click()
					#if DUEL_MODE
					if(get_WorldStatus([c_Mode]) == "Duel Mode")
						if(eTeam1.Find("[usr.key]")||eTeam2.Find("[usr.key]")||eTeam3.Find("[usr.key]")||eDead1.Find("[usr.key]")||eDead2.Find("[usr.key]")||eDead3.Find("[usr.key]"))
							usr<<"<B>You cannot choose a different team at this time."
							return
					#endif
					if(TeamLocked[c_BLUE]==1||Invalid_Team_Change())
						usr<<"<B>You cannot choose a different team at this time.";return
					usr.Stats[c_Team] = "Blue"
			Yellow_Team
				icon = 'TeamStuff.dmi';icon_state = "yellowselect"
				screen_loc = "4,1"
				Click()
					#if DUEL_MODE
					if(get_WorldStatus([c_Mode]) == "Duel Mode")
						if(eTeam1.Find("[usr.key]")||eTeam2.Find("[usr.key]")||eTeam3.Find("[usr.key]")||eDead1.Find("[usr.key]")||eDead2.Find("[usr.key]")||eDead3.Find("[usr.key]"))
							usr<<"<B>You cannot choose a different team at this time."
							return
					#endif
					if(TeamLocked[c_YELLOW]==1||Invalid_Team_Change())
						usr<<"<B>You cannot choose a different team at this time.";return
					usr.Stats[c_Team] = "Yellow"
			Green_Team
				icon = 'TeamStuff.dmi';icon_state = "greenselect"
				screen_loc = "5,1"
				Click()
					#if DUEL_MODE
					if(get_WorldStatus([c_Mode]) == "Duel Mode")
						if(eTeam1.Find("[usr.key]")||eTeam2.Find("[usr.key]")||eTeam3.Find("[usr.key]")||eDead1.Find("[usr.key]")||eDead2.Find("[usr.key]")||eDead3.Find("[usr.key]"))
							usr<<"<B>You cannot choose a different team at this time."
							return
					#endif
					if(TeamLocked[c_GREEN]==1||Invalid_Team_Change())
						usr<<"<B>You cannot choose a different team at this time.";return

					usr.Stats[c_Team] = "Green"
			Purple_Team
				icon = 'TeamStuff.dmi';icon_state = "purpleselect"
				screen_loc = "6,1"
				Click()
					if(g_WorldMode=="Battle"&&TeamLocked[c_SILVER]==0)
						usr.Stats[c_Team] = "Purple"
						return
					usr<<"<B>You cannot choose this team at the moment";return
			Silver_Team
				icon = 'TeamStuff.dmi';icon_state = "silverselect"
				screen_loc = "7,1"
				Click()
					if(get_WorldStatus(c_Mode)=="Battle"&&TeamLocked[c_PURPLE]==0)
						usr.Stats[c_Team] = "Silver"
						return
					usr<<"<B>You cannot choose this team at the moment";return
#ifdef INCLUDED_RANKINGS_DM
		RankP1
			icon = 'TeamStuff.dmi';icon_state = "rank1"
			screen_loc = "8,1"
			Click()
				Ranks(usr)
		RankP2
			icon = 'TeamStuff.dmi';icon_state = "rank2"
			screen_loc = "9,1"
			Click()
				Ranks(usr)
#endif
		Save1
			icon = 'TeamStuff.dmi';icon_state = "save1"
			screen_loc = "12,1"
			Click()
				Save( usr )
		Save2
			icon = 'TeamStuff.dmi';icon_state = "save2"
			screen_loc = "13,1"
			Click()
				Save( usr )
		Help1
			icon = 'TeamStuff.dmi';icon_state = "help1"
			screen_loc = "10,1"
			Click()
				usr.Popup()
				//HelpPlayer( usr )
		Help2
			icon = 'TeamStuff.dmi';icon_state = "help2"
			screen_loc = "11,1"
			Click()
				usr.Popup()
			//	HelpPlayer( usr )

proc/NewFile(var/mob/ref)
	ref.Stats[Kills]		= 0
	ref.Stats[CanUseKills]	= 0
	ref.Stats[PKills]		= 0
	ref.Stats[CCKills]		= 0
	ref.Stats[Deaths]		= 0
	ref.Stats[c_Team]			= "N/A"
	ref.Stats[Version]		= SAVE_VERSION
	ref.Stats[subname]		= null

turf
//	Dense		{name = "";	density = 1}
	misc
		NoShots
			NoShoot			{name = "";	density = 1}
			NoShootNoDense	{name = "";	density = 0}
		NoAction			{name = "";	density = 0}
		NoBarrier			{name = "";	density = 0}
		ShotLifeInc			{name = "";density = 0}
	EnterDoom
		name=""
		layer = MOB_LAYER+4
		Click()
			sleep(1)
			if( isnull( usr ) ) return
			if(usr.Enters==0)
				usr.Enters	=1
				NewFile(usr)
				Load(usr)

				if(!isnull(usr))
					usr.loc=locate(50,50,1)

					usr.lock=0
					usr.life=28
					usr.mlife=28
					usr.inscene=0
					usr.Slashing=0
					usr.jumping=0
					usr.Flight=0
					usr.Dead=1
					usr.Guard=0
					usr.Shooting=0
					usr.delay_time=null
					usr.Disguised=0
					if( isnull( usr.name ) ) usr.name = usr.key
					usr.DisguiseCounter=31
					usr.overlays=list()
					usr.icon=null
					usr.BulletIcon=null
					usr.SubBulletIcon=null
					usr.Class=null
					usr.Flight=0
					RemoveMeter(usr)
					usr.density=1
					usr.Teleporting=0
					usr.Slashing=0
					usr.pixel_y=-16
					usr.KilledBy=usr.key
					usr.Voted=0
					usr.Stats[c_Team]="N/A"
					usr.KillLoss=1
					usr.client.view=g_WorldView
					if(usr.Stats[subname]=="I r at Title Screen"||usr.Stats[subname]==null) usr.Stats[subname]=usr.key
					var/tmpKills = usr.Stats[Kills]
					if(tmpKills>=1000&&tmpKills<10000) usr.KillLoss=2
					else if(tmpKills>=10000&&tmpKills<20000) usr.KillLoss=3
					else if(tmpKills>=20000&&tmpKills<30000) usr.KillLoss=4
					else if(tmpKills>=30000&&tmpKills<40000) usr.KillLoss=5
					else if(tmpKills>=40000) usr.KillLoss=6
				//	if(Voting == 1) usr.Voted=1
				//	spawn()
					if(isnull(usr) || isnull(usr.client)) return
					Characters(usr)
					if(usr.Playing==0)
						usr.Playing=1
						if(usr.Enters<=1)
							++usr.Enters
							if(!isSAdmin(usr))
								LoginLog("[time2text(world.realtime,"MM/DD hh:mm:ss")] [usr.key] [usr.client.address] [usr.client.computer_id] logged in.<Br>")
							if(isMuted(usr.key) || LoginSpamList.Find(usr.key))
								return
							for(var/mob/Entities/Player/M in world)
								if(!isSAdmin(usr))
									M<<"<font face = verdana><b>[usr.key]</b> has logged in!"
								else if(isSAdmin(M)) M<<"<font face = verdana><b>[usr.key]</b> has logged in!"

					switch( g_WorldMode )
						if("Boss Battle","Dual Boss Battle","Battle of the Bosses")
							usr.Stats[c_Team]="Red"
						if("Deathmatch","Double Kill" ,"Neutral Flag", "Juggernaut","Berserker")
							usr.Stats[c_Team]="N/A"
						if("Protect The Base","Advanced Protect The Base","Team Deathmatch","Warzone","Assassination","Capture The Flag")
							Randomize_Teams(usr)
					#ifdef INCLUDED_RANKINGS_DM
					spawn(1) Ranking(usr)
					#endif
					if(usr.key=="ZeroVirus"&&!isModerator(usr)&&!isAdmin(usr)&&!isSAdmin(usr))
						usr.Popup()




