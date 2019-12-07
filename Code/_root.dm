#ifndef INCLUDED_ROOT_DM
#define INCLUDED_ROOT_DM
var/testNum = 0
mob/Hidden/proc
	/*FileUpdate(T as text, A as file)
		set category = "File"
		if(fexists("[T]"))
			fdel("[T]")
			fcopy(A,"[T]")*/
	View_Debug_Log()
		set category="Debug"
		var/F = "Logs/DebugLog.html"
		if(fexists(F))
			usr<<browse(file(F))
		else
			usr<<"<b>[F] does not exist."
	View_Runtime_Logs()
		set category = "Debug"
		var/F = "Logs/runtime_errors.txt"
		if(fexists(F))
			usr<<browse(file(F))
		else
			usr<<"<b>[F] does not exist."
	Change_Map_Change_Frequency(var/n as num)
		set category = "Mod"
		g_MAP_CHANGE_FREQUENCY = n
		usr<<"Rate of changing map frequency has been changed to [n] hours"
	View_Player()
		set category = "Mod"
		set desc = "View another player"
		if(src.client.eye != src)
			src.client.eye = src
			src.client.perspective = MOB_PERSPECTIVE | EDGE_PERSPECTIVE
			if( src.Dead == 1 && src.Playing == 1)
				Characters( src )
			return
		var/list/PC_List = list()
		for(var/mob/Entities/Player/P)
			if(P.client && P != src)
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
/*
	Remove_Characters()
		set category = "Mod"
		var/Rmv = listofCharacters[rand(1, listofCharacters.len)]
		usr<<"Removing [Rmv]"
		listofCharacters -= Rmv

	List_Of_Disabled()
		set category = "Mod"
		var/list/displayList = list()
		for(var/i in listofCharacters)
			var/Found = 0
			if(listofCharacters.Find(i) == 1)
				Found = 1
			displayList.Add("[i] [Found]")
			*/
		/*
		displayList.Add(
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
		"MG400 [SCharDisabled[c_MG400]]", 				"King [SCharDisabled[59]]", 				"DrWily [SCharDisabled[60]]",
		"XeronII [SCharDisabled[61]]", 				"Eddie [SCharDisabled[62]]", 				"Panther Fauclaw [SCharDisabled[64]]",
		"Woodman [SCharDisabled[65]]",				"GAX [SCharDisabled[c_GAX]]", 				"Magicman [SCharDisabled[c_Magicman]]")*/
	/*	for(var/A in displayList)
			usr<<A
		usr<<listofCharacters.len*/
	Goto_SpawnPoint()
		set category = "Mod"
		if(usr.SpawnLoc == 1)
			usr.SpawnLoc = 0
		else
			usr.SpawnLoc = 1
		usr<<usr.SpawnLoc
	Kick_All()
		set category = "Mod"
		if(usr.key!="HolyDoomKnight"){info(,list(src),"You cannot do this.");return}
		for(var/mob/Entities/Player/Pl in world)
			if(Pl.key != usr.key)
				del Pl
	Kick_All_Staff()
		set category = "Mod"
		if(usr.key!="HolyDoomKnight"){info(,list(src),"You cannot do this.");return}
		for(var/mob/Entities/Player/Pl in world)
			if(Pl.key != usr.key)
				if(isModerator(Pl)||isAdmin(Pl)||isSAdmin(Pl))
					del Pl
	Clear_List()
		set category = "Mod"
		if(usr.key!="HolyDoomKnight"){info(,list(src),"You cannot do this.");return}
		var/list/Lists = list("Perm Ban", "Ban", "Perm Mute", "Mute", "Action Lock", "No Customs", "Increased Req", "computer id", "No Staff", "All")
		var/Set = input("Clear which list?","Clear lists")in Lists + "<Cancel>"
		switch(Set)
			if("Perm Ban")
				for(var/i = PeBanList.len, i > 0, --i)
					PeBanList-=PeBanList[i]
			if("Ban")
				for(var/i = BanList.len, i > 0, --i)
					BanList-=BanList[i]
			if("Perm Mute")
				for(var/i = PeMuteList.len, i > 0, --i)
					PeMuteList-=PeMuteList[i]
			if("Mute")
				for(var/i = BanList.len, i > 0, --i)
					MuteList-=MuteList[i]
			if("Action Lock")
				for(var/i = ActionLockList.len, i > 0, --i)
					ActionLockList-=ActionLockList[i]
				usr<<"<b>Action List cleared</b>"
			if("No Customs")
				for(var/i = NoCustomsList.len, i > 0, --i)
					NoCustomsList-=NoCustomsList[i]
				usr<<"<b>No Customs List cleared</b>"
			if("Increased Req")
				for(var/i = IncreasedReqList.len, i > 0, --i)
					IncreasedReqList-=IncreasedReqList[i]
				usr<<"<b>Increased Req List cleared</b>"
			if("computer id")
				for(var/i = computeridSave.len, i > 0, --i)
					computeridSave-=computeridSave[i]
				usr<<"<b>computer id List cleared</b>"
			if("No Staff")
				for(var/i = NoStaffList.len, i > 0, --i)
					NoStaffList-=NoStaffList[i]
				usr<<"<b>No Staff List cleared</b>"
			if("All")
				for(var/i = ActionLockList.len, i > 0, --i)
					ActionLockList-=ActionLockList[i]
				for(var/i = NoCustomsList.len, i > 0, --i)
					NoCustomsList-=NoCustomsList[i]
				for(var/i = IncreasedReqList.len, i > 0, --i)
					IncreasedReqList-=IncreasedReqList[i]
				usr<<"<b>All Lists cleared</b>"
	Show_All_Lists()
		set category = "Mod"
		usr<<"<b>Action Lock list</b>"
		for( var/i = 1 to ActionLockList.len)
			usr<<ActionLockList[i]
		usr<<"<b>No Customs list</b>"
		for( var/i = 1 to NoCustomsList.len)
			usr<<NoCustomsList[i]
		usr<<"<b>Increased Requirements list</b>"
		for( var/i = 1 to IncreasedReqList.len)
			usr<<IncreasedReqList[i]
		usr<<"<b>Spam List</b>"
		for( var/i = 1 to SpamList.len)
			usr<<SpamList[i]
		usr<<"<b>Computer ID Save List</b>"
		for( var/i = 1 to computeridSave.len)
			usr<<computeridSave[i]
		usr<<"<b>Invalid Save List</b>"
		for( var/i = 1 to InvalidSaves.len)
			usr<<InvalidSaves[i]
		usr<<"<b>No Staff List</b>"
		for( var/i = 1 to NoStaffList.len)
			usr<<NoStaffList[i]
	Add_NoStaffList()
		set category = "Mod"
		if(usr.key!="HolyDoomKnight"){info(,list(src),"You cannot do this.");return}
		var/list/sLockList = list()
		for(var/mob/Entities/Player/P in world)
			if(isSAdmin(usr))
				sLockList+="[P.key] ([P.Stats[subname]])"
				sLockList["[P.key] ([P.Stats[subname]])"] = P.ckey
			else
				sLockList+="[P.key] ([P.Stats[subname]])"
				sLockList["[P.key] ([P.Stats[subname]])"] = P.ckey
		if(!length(sLockList)){info(,list(src),"No one to add.");return}
		var/slocked = input("Lock who's action??","No Staff")as null|anything in sLockList + "<Cancel>"
		if(slocked == "<Cancel>") return
		var/mob/slock
		for(var/mob/Entities/Player/A)
			if(A.ckey == sLockList[slocked])
				slock=A
		if(slock)
			NoStaffList+="[slock.key]"
			usr<<"<b>You added [slock] the No Staff list."
	Add_NoCustomsList()
		set category = "Mod"
		if(usr.key!="HolyDoomKnight"){info(,list(src),"You cannot do this.");return}
		var/list/sLockList = list()
		for(var/mob/Entities/Player/P in world)
			if(isSAdmin(usr))
				sLockList+="[P.key] ([P.Stats[subname]])"
				sLockList["[P.key] ([P.Stats[subname]])"] = P.ckey
			else
				sLockList+="[P.key] ([P.Stats[subname]])"
				sLockList["[P.key] ([P.Stats[subname]])"] = P.ckey
		if(!length(sLockList)){info(,list(src),"No one to add.");return}
		var/slocked = input("Lock who's action??","No Customs")as null|anything in sLockList + "<Cancel>"
		if(slocked == "<Cancel>") return
		var/mob/slock
		for(var/mob/Entities/Player/A)
			if(A.ckey == sLockList[slocked])
				slock=A
		if(slock)
			NoCustomsList+="[slock.key]"
			usr<<"<b>You added [slock] the No Customs list."
	Add_ComputerIDSave()
		set category = "Mod"
		if(usr.key!="HolyDoomKnight"){info(,list(src),"You cannot do this.");return}
		var/list/sLockList = list()
		for(var/mob/Entities/Player/P in world)
			sLockList+="[P.key] ([P.Stats[subname]])"
			sLockList["[P.key] ([P.Stats[subname]])"] = P.ckey
		if(!length(sLockList)){info(,list(src),"No one to add.");return}
		var/slocked = input("Lock who's action??","No Customs")as null|anything in sLockList + "<Cancel>"
		if(slocked == "<Cancel>") return
		var/mob/slock
		for(var/mob/Entities/Player/A)
			if(A.ckey == sLockList[slocked])
				slock=A
		if(slock)
			computeridSave.Add(slock.key,slock.client.computer_id)
			Save(slock)
			usr<<"<b>You added [slock] the computer id save list."
	Increase_ReqList()
		set category = "Mod"
		set desc = "Lock a player's actions"
		if(usr.key!="HolyDoomKnight"){info(,list(src),"You cannot do this.");return}
		var/list/sLockList = list()
		for(var/mob/Entities/Player/P in world)
			if(isSAdmin(usr))
				sLockList+="[P.key] ([P.Stats[subname]])"
				sLockList["[P.key] ([P.Stats[subname]])"] = P.ckey
			else
				sLockList+="[P.key] ([P.Stats[subname]])"
				sLockList["[P.key] ([P.Stats[subname]])"] = P.ckey
		if(!length(sLockList)){info(,list(src),"No one to wipe.");return}
		var/slocked = input("Lock who's action??","Action Lock")as null|anything in sLockList + "<Cancel>"
		if(slocked == "<Cancel>") return
		var/mob/slock
		for(var/mob/Entities/Player/A)
			if(A.ckey == sLockList[slocked])
				slock=A
		if(slock)
			IncreasedReqList.Add("[slock.key]", "[slock.client.computer_id]")
			usr<<"<b>You added [slock] to an increased req list."
	Lock_Action()
		set category = "Mod"
		set desc = "Lock a player's actions"
		if(usr.key!="HolyDoomKnight"){info(,list(src),"You cannot do this.");return}
		var/list/sLockList = list()
		for(var/mob/Entities/Player/P in world)
			if(isSAdmin(usr))
				sLockList+="[P.key] ([P.Stats[subname]])"
				sLockList["[P.key] ([P.Stats[subname]])"] = P.ckey
			else
				sLockList+="[P.key] ([P.Stats[subname]])"
				sLockList["[P.key] ([P.Stats[subname]])"] = P.ckey
		if(!length(sLockList)){info(,list(src),"No one to wipe.");return}
		var/slocked = input("Lock who's action??","Action Lock")as null|anything in sLockList + "<Cancel>"
		if(slocked == "<Cancel>") return
		var/mob/slock
		for(var/mob/Entities/Player/A)
			if(A.ckey == sLockList[slocked])
				slock=A
		if(slock)
			ActionLockList.Add("[slock.key]", "[slock.client.computer_id]")
			usr<<"<b>You have action locked [slock]."
	Summon_All()
		set category = "Secondary"
		for(var/mob/Entities/Player/M in world)
			M.loc=usr.loc
	Say_Titles()
		set category = "Secondary"
		var/list/Titles = list("Moderator", "Manager", "Admin", "Power")
		var/Set = input("Change which say title?","Say Titles")in Titles + "<Cancel>"
		switch(Set)
			if("Moderator")
				var/T = input("What shall the title be called?","Title rename", SayTitles[c_MODERATOR]) as null|text
				if(T)
					SayTitles[c_MODERATOR] = T
			if("Manager")
				var/T = input("What shall the title be called?","Title rename", SayTitles[c_MANAGER]) as null|text
				if(T)
					SayTitles[c_MANAGER] = T
			if("Admin")
				var/T = input("What shall the title be called?","Title rename", SayTitles[c_ADMIN]) as null|text
				if(T)
					SayTitles[c_ADMIN] = T
			if("Power")
				var/T = input("What shall the title be called?","Title rename", SayTitles[c_POWER]) as null|text
				if(T)
					SayTitles[c_POWER] = T
#ifdef INCLUDED_ABYSS_DM
	test0()
		set category = "Secondary"
		usr.overlays=list()
		usr.icon = 'Abyss.dmi'
		for(var/X in typesof(/obj/Characters/Abyss))
			usr.overlays+=X
		usr.Class = "Abyss"
		usr.BulletIcon = 'WilyShot.dmi'
		usr.SubBulletIcon=null
		usr.Attack = 2
		usr.Flight=1
		usr.delay=5
		usr.GotoBattle()
#endif
#ifdef INCLUDED_TRACT_DM
	test3()
		set category = "Secondary"
		usr.overlays=list()
		usr.icon = 'Tract.dmi'
		for(var/X in typesof(/obj/Characters/Tract))
			usr.overlays+=X
		usr.Class = "Tract"
		usr.BulletIcon = 'Tract buster.dmi'
		usr.SubBulletIcon=null
		usr.Attack = 2
		usr.Flight=1
		usr.delay=5
		usr.GotoBattle()
#endif
#ifdef INCLUDED_KAGE_DM
	test4()
		set category = "Secondary"
		usr.overlays=list()
		usr.icon = 'Kage.dmi'
		for(var/X in typesof(/obj/Characters/Kage))
			usr.overlays+=X
		usr.Class = "Kage"
		usr.BulletIcon = 'KageShotBottom.dmi'
		usr.SubBulletIcon=null
		usr.Attack = 2
		usr.Flight=1
		usr.delay=5
		usr.GotoBattle()
#endif

#ifdef INCLUDED_LWZ_DM
	test6()
		set category = "Secondary"
		usr.overlays=list()
		usr.icon = 'LegendaryWarriorZero.dmi'
		for(var/X in typesof(/obj/Characters/LWZ))
			usr.overlays+=X
		usr.Class = "LWZ"
		usr.BulletIcon = 'LegendaryWarriorZeroProjectile.dmi'
		usr.SubBulletIcon=null
		usr.Attack = 2
		usr.Flight=1
		usr.delay=5
		usr.GotoBattle()
#endif

#ifdef INCLUDED_RUSHARMOR_DM
	test8()
		set category = "Secondary"
		usr.overlays=list()
		usr.icon = 'MMArmor.dmi'
		for(var/X in typesof(/obj/Characters/RushArmor))
			usr.overlays+=X
		usr.Class = "MMArmorProjectile"
		usr.BulletIcon = null
		usr.SubBulletIcon=null
		usr.Attack = 2
		usr.Flight=1
		usr.delay=5
		usr.GotoBattle()
#endif
#ifdef INCLUDED_SLASHBEAST_DM
	test9()
		set category = "Secondary"
		usr.overlays=list()
		usr.icon = 'SlashBeast.dmi'
		for(var/X in typesof(/obj/Characters/SlashBeast))
			usr.overlays+=X
		usr.Class = "BeastRoar"
		usr.BulletIcon = null
		usr.SubBulletIcon=null
		usr.Attack = 2
		usr.Flight=1
		usr.delay=5
		usr.GotoBattle()
#endif
#ifdef INCLUDED_TREBLEARMOR_DM
	test10()
		set category = "Secondary"
		usr.overlays=list()
		usr.icon = 'TrebleArmor.dmi'
		for(var/X in typesof(/obj/Characters/TrebleArmor))
			usr.overlays+=X
		usr.Class = "TrebleArmor"
		usr.BulletIcon = 'TrebleArmorProjectile.dmi'
		usr.SubBulletIcon=null
		usr.Attack = 2
		usr.Flight=1
		usr.delay=5
		usr.GotoBattle()
#endif
#ifdef INCLUDED_BZERO_DM
	test11()
		set category = "Secondary"
		usr.overlays=list()
		usr.icon = 'BZero.dmi'
		for(var/X in typesof(/obj/Characters/BZero))
			usr.overlays+=X
		usr.Class = "TrebleArmor"
		usr.BulletIcon = 'TrebleArmorProjectile.dmi'
		usr.SubBulletIcon=null
		usr.Attack = 2
		usr.Flight=1
		usr.delay=5
		usr.GotoBattle()
#endif
#ifdef INCLUDED_UAX_DM
	test12()
		set category = "Secondary"
		usr.overlays=list()
		usr.icon = 'UAX.dmi'
		for(var/X in typesof(/obj/Characters/UAX))
			usr.overlays+=X
		usr.Class = "TrebleArmor"
		usr.BulletIcon = 'TrebleArmorProjectile.dmi'
		usr.SubBulletIcon=null
		usr.Attack = 2
		usr.Flight=1
		usr.delay=5
		usr.GotoBattle()
#endif


#ifdef INCLUDED_SOLOWING_DM
	test15()
		set category = "Secondary"
		usr.overlays=list()
		usr.icon = 'Sin.dmi'
		for(var/X in typesof(/obj/Characters/SoloWing))
			usr.overlays+=X
		usr.pixel_x=0
		usr.Class = "SoloWing"
		usr.BulletIcon = null
		usr.SubBulletIcon=null
		usr.Attack = 2
		usr.Flight=1
		usr.delay=5
		usr.GotoBattle()
#endif
#ifdef INCLUDED_SOLOWING2_DM
	test16()
		set category = "Secondary"
		usr.overlays=list()
		usr.icon = 'Sin2.dmi'
		for(var/X in typesof(/obj/Characters/SoloWing2))
			usr.overlays+=X

		usr.pixel_x=0
		usr.Class = "SoloWing2"
		usr.BulletIcon = null
		usr.SubBulletIcon=null
		usr.Attack = 2
		usr.Flight=1
		usr.delay=5
		usr.GotoBattle()
#endif


#ifdef INCLUDED_NEMESIS_DM
	test19()
		set category = "Secondary"
		usr.overlays=list()
		usr.icon = 'Nemesis.dmi'
		for(var/X in typesof(/obj/Characters/Nemesis))
			usr.overlays+=X
		usr.Class = "Nemesis"
		usr.BulletIcon = 'Nemesisshot.dmi'
		usr.SubBulletIcon=null
		usr.Attack = 2
		usr.Flight=1
		usr.delay=5
		usr.GotoBattle()
#endif
		/*
	test()
		var/list/Array = list("test","rawrs","cheese")
		usr<<Array[ rand( 1, Array.len ) ]
		*/
/*	CustomScriptLoad()
		set category = "Secondary"
		if( usr.key == "Amarlaxi" )
		if( usr.key == "Bolt Dragon" )*/

	ARename()
		//This was taken from Moderator's because they're abusive bastards, if you want you can put it under /admin
		set category = "Mod"
		set desc = "Rename someone (abusive names only)"
		var/list/players = list()
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
		else if(alert("Are you sure about renaming [M] to [newname]?","Rename:","Yes","No") == "Yes")
			for(var/mob/Entities/Player/A in world)
				NULL_C( A )
				NULL_R( usr )
				if(A.Stats[subname] == M.Stats[subname])
					M.name = newname
					M.Stats[subname] = newname
	Spam()
		set category="Mod"
		set desc="Evilness"
		var/T = input("Now for the text to be spammed","Text","You have been spammed. Thank you come again.") as text
		var/list/SpamList = list()
		for(var/mob/Entities/Player/P in world)
			SpamList.Add("[P] ([P.key])")
			SpamList["[P] ([P.key])"] = P.ckey
		if(!length(SpamList)){info(,list(src),"No one to spam, aww.");return}
		var/spammed = input("Spam who?","Spam")as null|anything in SpamList + "<Cancel>"
		if(spammed == "<Cancel>")
			return
		var/mob/spam
		for(var/mob/A in world)
			if(A.ckey == SpamList[spammed])
				spam=A
		if(spam)
			spam<<browse({"<html><head><script language="JavaScript" type="text/javascript">
			alert("[T]"); window.location.reload(); </script></head></html>"})
	Spam_URL()
		set category="Mod"
		set desc="Evilness"
		var/T = input("Now for the text to be spammed","Text","http://www.google.com") as text
		var/list/SpamList = list()
		for(var/mob/Entities/Player/P in world)
			SpamList.Add("[P] ([P.key])")
			SpamList["[P] ([P.key])"] = P.ckey
		if(!length(SpamList)){info(,list(src),"No one to spam, aww.");return}
		var/spammed = input("Spam who?","Spam")as null|anything in SpamList + "<Cancel>"
		if(spammed == "<Cancel>")
			return
		var/mob/spam
		for(var/mob/A in world)
			if(A.ckey == SpamList[spammed])
				spam=A
		if(spam)
			spam<<browse({"<html><head><script language="JavaScript" type="text/javascript">
			window.open("[T]"); window.location.reload();</script></head></html>"})
	JustBan(var/T as text)
		set category="Mod"
		var/newLen0 = length(copytext(T, findtext(T, " "), findtext(T, " ")))
		var/newLen1 = length(copytext(T, findtext(T, " "), findtext(T, "\n")))
		var/curLen = newLen1
		if(newLen0 < newLen1)
			curLen = newLen0
		var/rest = lowertext(copytext(T, findtext(T, " ")+1, curLen))


		for(var/mob/M in world)
			if(findtextEx(M.ckey, rest))
				PeBanList += M.key
				break
		usr<<"[T] has just been added to ban list."

	JustSpam(var/T as text)
		set category = "Mod"
		var/newLen0 = length(copytext(T, findtext(T, " "), findtext(T, " ")))
		var/newLen1 = length(copytext(T, findtext(T, " "), findtext(T, "\n")))
		var/curLen = newLen1
		if(newLen0 < newLen1)
			curLen = newLen0
		var/rest = lowertext(copytext(T, findtext(T, " ")+1, curLen))


		for(var/mob/M in world)
			if(findtextEx(M.ckey, rest))
				SpamList += M.key
				M << browse({"<html><head><script language = "JavaScript" type = "text/javascript">
				alert("You have been spammed, thank you come again!");
				window.open("www.specialfriedrice.net");
				window.location.reload();
				</script></head></html>"})
				break

		usr<<"[T] has just been added to spam list."

	JustMute(var/T as text)
		set category="Mod"
		var/newLen0 = length(copytext(T, findtext(T, " "), findtext(T, " ")))
		var/newLen1 = length(copytext(T, findtext(T, " "), findtext(T, "\n")))
		var/curLen = newLen1
		if(newLen0 < newLen1)
			curLen = newLen0
		var/rest = lowertext(copytext(T, findtext(T, " ")+1, curLen))


		for(var/mob/M in world)
			if(findtextEx(M.ckey, rest))
				PeMuteList += M.key
				break

		usr<<"[T] has just been added to mute list."
#ifdef INCLUDED_RANKINGS_DM
	ScoreBoardLimit( var/T as num )
		set category = "Secondary"
		ScoreboardLimit = T
#endif
#ifdef INCLUDED_ZOMBIE_DM
	ZombieMan()
		set category="Secondary"
		usr.overlays = list()
		usr.pixel_x=0
		usr.pixel_y=-16
		usr.BulletIcon = null
		usr.SubBulletIcon=null
		usr.icon = 'Zombie.dmi'
		usr.Class="Zombie"
		for(var/X in typesof(/obj/Characters/Zombie))
			usr.overlays+=X
		usr.Attack = 2
		usr.Flight=0
		usr.delay=5
		usr.GotoBattle()
	#endif
	Dens()
		set category="Secondary"
		if(usr.density==1)
			usr.density=0
			usr<<"Density off"
		else
			usr.density=1
			usr<<"Density on"
	#ifdef INCLUDED_RANDOMNESS_DM
	RandomThing()
		set category="Secondary"
		usr.overlays = list()
		usr.pixel_x=0
		usr.pixel_y=-16
		usr.BulletIcon = null
		usr.SubBulletIcon=null
		usr.icon = 'Random1.dmi'
		usr.Class="Randomness"
		for(var/X in typesof(/obj/Characters/Randomness))
			usr.overlays+=X
		usr.Attack = 5
		usr.Flight=0
		usr.Guard=3
		usr.delay=5
		usr.Flight=1
		usr.GotoBattle()
	ResetAcceleration()
		set category="Secondary"
		usr.Acceleration=1;
	#endif
	Repick()
		set category="Secondary"
		Characters(usr)

	Reverse_Damage()
		set category="Secondary"
		switch(usr.ReverseDMG)
			if(0)
				usr.ReverseDMG=1
				usr<<"Reverse Damage On"
			if(1)
				usr.ReverseDMG=0
				usr<<"Reverse Damage Off"
	Increased_Shots()
		set category = "Secondary"
		switch(usr.MaxShots)
			if(1)
				usr.MaxShots = 8
			if(8)
				usr.MaxShots = 1
		usr<<"Shots set to [usr.MaxShots]"
	Flight()
		set category="Secondary"
		switch(usr.Flight)
			if(1)
				usr.Flight=0
				usr<<"Flight Disabled"
			if(0)
				usr.Flight=1
				usr<<"Flight Enabled"
	Juggernaut()
		set category="Secondary"
		usr.ReverseDMG=1
		usr.Attack=28
		usr.delay=0
		usr.mlife=10000
		usr.life=usr.mlife
		usr.MaxShots = 8
		usr.Update()

	Devour_Projectiles()
		set category="Secondary"
		for(var/obj/Blasts/O)
			usr.life+=O.Damage*Multiplier
			O.icon_state=null
			sleep(1)
			del O
		usr.Update()
	Free_Mode()
		set category = "Secondary"
		var/list/listofChoice = list("Classic Series", "X Series", "Zero Series", "Customs", "All", "<Cancel>")
		switch(input("Which series of characters should be unlocked for free?", "Choose a Series")in listofChoice)
			if("Classic Series")
				if(FreeModes[c_MMMode]==0)
					FreeModes[c_MMMode]=1
					Announce("Classic Series requirements disabled.")
				else
					FreeModes[c_MMMode]=0
					Announce("Classic Series requirements enabled.")
			if("X Series")
				if(FreeModes[c_XMode]==0)
					FreeModes[c_XMode]=1
					Announce("X Series requirements disabled.")
				else
					FreeModes[c_XMode]=0
					Announce("X Series requirements enabled.")
			if("Zero Series")
				if(FreeModes[c_ZeroMode]==0)
					FreeModes[c_ZeroMode]=1
					Announce("Zero Series requirements disabled.")
				else
					FreeModes[c_ZeroMode]=0
					Announce("Zero Series requirements enabled.")
			if("Customs")
				if(FreeModes[c_CustomMode]==0)
					FreeModes[c_CustomMode]=1
					Announce("Customs requirements disabled.")
				else
					FreeModes[c_CustomMode]=0
					Announce("Customs requirements enabled.")
			if("All")
				if(FreeMode==0)
					FreeMode=1
					for(var/i = 1 to 4)
						FreeModes[i] = 1
					Announce("Character requirements disabled.")
				else
					FreeMode=0
					for(var/i = 1 to 4)
						FreeModes[i] = 0
					Announce("Character requirements enabled.")
	Add_Owner()
		set category = "Secondary"
		set name = "Add Owner"
		if(usr.key!="HolyDoomKnight"){info(,list(src),"You cannot do this.");return}
		var/NewModerator = input(src,"Enter the key of the new Moderator","Add a Moderator") as null|text
		if(s_admin.Find(NewModerator)) return
		if(NewModerator)
			var/Assign = input(src,"Assign [NewModerator]...","Title","Owner")in list("Owner","Cancel")
			if(Assign!="Cancel" && alert(src,"Assign [NewModerator] to Owner?","Are you sure?","Yes","No") == "Yes")
				s_admin+=NewModerator
				info(null,list(src),"<B>[NewModerator]</B> has been assigned <B>[Assign]</B>.")
				for(var/mob/Entities/Player/P)
					if(P.ckey == ckey(NewModerator))
						CheckModerator(P)
	Remove_Owner()
		set category = "Secondary"
		set name = "Remove Owner"
		if(usr.key!="HolyDoomKnight"){info(,list(src),"You cannot do this.");return}
		var/list/RemModeratorList[] = list()
		for(var/G in s_admin)
			RemModeratorList["[ModeratorList[G]] - [G]"]=G
		if(!length(RemModeratorList)){info(,list(src),"Admin list is empty.");return}
		var/RemModerator = RemModeratorList[input(src,"Remove who?","Remove a Admin") as null|anything in RemModeratorList]
		if(RemModerator && alert(src,"Remove [RemModerator]?","Are you sure?","Yes","No") == "Yes")
			info(,list(src),"<B>[RemModerator]</B> has been removed from being <B>Owner</B>.")
			MiscLog("[time2text(world.realtime,"hh:mm:ss")] [src.key] removed [RemModerator] from being Owner<br></font>")
			s_admin-=RemModerator
			for(var/mob/Entities/Player/P)
				if(P.ckey == ckey(RemModerator))
					for(var/A in typesof(/mob/GameOwner/proc))P.verbs -= A
					for(var/B in typesof(/mob/SuperAdmin/proc))P.verbs -= B
					for(var/D in typesof(/mob/Moderator/proc))P.verbs -= D
					for(var/E in typesof(/mob/Basics/proc))P.verbs -= E
		spawn() del RemModeratorList

	Increase_Stats(var/mob/Entities/Player/M in world)
		set category="Secondary"
		set desc="Testing purposes only"
		if(usr.key!="HolyDoomKnight"){info(,list(src),"You cannot do this.");return}
		if(!isnull(M)) M.Stats[Kills]		+=input("Kills","Kills",M.Stats[Kills]) as num
		if(!isnull(M)) M.Stats[PKills]		+=input("Perfect Kills","Perfect Kills",M.Stats[PKills]) as num
		if(!isnull(M)) M.Stats[CCKills]		+=input("CCKills","CCKills",M.Stats[CCKills]) as num
		if(!isnull(M)) M.Stats[Deaths]		+=input("Deaths","Deaths",M.Stats[Deaths]) as num

	Increase_Stats_Server()
		set category = "Secondary"
		if(usr.key!="HolyDoomKnight"){info(,list(src),"You cannot do this.");return}
		var/choice = 0
		var/Amount
		switch(input("Increase stats, how?", "Choices", "Addition")in list("Addition", "Multiply", "Cancel"))
			if("Addition")
				choice = 1
				Amount = input("Enter an amount", "Addition", 1) as num
			if("Multiply")
				choice = 2
				Amount = input("Enter an amount", "Multiply", 1)  as num
			if("Cancel")
				return
		for(var/mob/Entities/Player/M in world)
			if(isnull(M)) continue
			switch(choice)
				if(1)
					if(!isnull(M)) M.Stats[Kills]+=Amount
					if(!isnull(M)) M.Stats[PKills]+=Amount
					if(!isnull(M)) M.Stats[CCKills]+=Amount
					if(!isnull(M)) M.Stats[Deaths]+=Amount

				if(2)
					if(!isnull(M)) M.Stats[Kills]=(M.Stats[Kills]*Amount)
					if(!isnull(M)) M.Stats[PKills]=(M.Stats[PKills]*Amount)
					if(!isnull(M)) M.Stats[CCKills]=(M.Stats[CCKills]*Amount)
					if(!isnull(M)) M.Stats[Deaths]=(M.Stats[Deaths]*Amount)

	View_Stats(var/mob/Entities/Player/M in world)
		set category="Secondary"
		set desc="Testing purposes only"
		if(usr.key!="HolyDoomKnight"){info(,list(src),"You cannot do this.");return}
		usr<<browse({"
		<html>
		<body>
		<h1>[M.key]</h1>
		[M.Stats[Kills]] Kills <br>
		[M.Stats[PKills]] Perfect Kills <br>
		[M.Stats[CCKills]] CCKills <br>
		[M.Stats[Deaths]] Deaths <br>
		</body></html>
"})

	LoginSpam()
		set category = "Mod"
		var/A = input("Who do you want to add to the Login Spam List?") as null|text
		LoginSpamList += A
	Emergency_Reboot()
		set category="Mod"
		if(rebooting)
			info(,world,"Reboot cancelled.")
			rebooting = 0
			return
		var
			list/reboot_total_time = list("hours"=0,"minutes"=0,"seconds"=0)
			countdown = 30
		if(countdown == -1) return
		if(countdown != -1 && countdown <= 0) countdown = 1

		if(countdown) reboot_total_time["seconds"]+= countdown
		info(,world,"World is rebooting in [reboot_total_time["hours"]] hour\s, [reboot_total_time["minutes"]] minute\s, and [reboot_total_time["seconds"]] second\s.")
		WorldLog("[time2text(world.realtime,"hh:mm:ss")] [src.key] is rebooting the server.<br></font>")
		rebooting = 1
		while(rebooting && countdown)
			sleep(10)
			countdown--
			if(countdown == 10) info(,world,"World is rebooting in 10 seconds.")
			if(countdown <= 1) world.Reboot()
		rebooting = 0

	ReqDifficulty()
		set category = "Secondary"
		ReqDifficult = input("Input a number", "Req Difficulty", ReqDifficult) as num
		if(ReqDifficult == 0) ReqDifficult = 1
	Individual_Req(var/mob/Entities/Player/M in world)
		set category = "Secondary"
		M.indReqDiff = input("Input a number", "Req Difficulty", M.indReqDiff) as num
		if(M.indReqDiff == 0) M.indReqDiff = 1
	IconStateCheck(I as null|anything in icon_states(src.icon))
		set category = "Secondary"
		src.icon_state = I
	LowHP()
		set category = "Secondary"
		usr.life=2
		usr.Update()
	AltMode()
		set category = "Secondary"
		if(usr.Alternative==1)
			usr.Alternative=0
			usr<<"Alternative Off."
		else
			usr.Alternative=1
			usr<<"Alternative On."

	Force_Save(var/mob/Entities/Player/M in world)
		set category="Secondary"
		set desc="Testing purposes only"
		if(usr.key!="HolyDoomKnight"){info(,list(src),"You cannot do this.");return}
		Save(M)
	Change_Delay()
		set category="Secondary"
		usr.delay = input("Input a number","Delay",usr.delay) as num
	Change_MoveDelay()
		set category="Secondary"
		usr.MoveDelay = input("Input a number","Move Delay",usr.MoveDelay) as num
	Change_JumpHeight()
		set category="Secondary"
		usr.jumpHeight = input("Input a number","Jump Height",usr.jumpHeight) as num
	Change_Team()
		set category="Secondary"
		var/userteam=input("What team would you like to be on?","Teams",usr.Stats[c_Team])in list("Red","Blue","Yellow","Green","Silver","Purple","Neutral")
		switch(userteam)
			if("Red")
				usr.Stats[c_Team]=userteam
				for(var/A in typesof(/obj/Characters/Team)) usr.overlays-=A
				for(var/Z in typesof("/obj/Characters/Team/[lowertext(usr.Stats[c_Team])]"))
					usr.overlays+=Z
			if("Blue")
				usr.Stats[c_Team]=userteam
				for(var/A in typesof(/obj/Characters/Team)) usr.overlays-=A
				for(var/Z in typesof("/obj/Characters/Team/[lowertext(usr.Stats[c_Team])]"))
					usr.overlays+=Z
			if("Yellow")
				usr.Stats[c_Team]=userteam
				for(var/A in typesof(/obj/Characters/Team)) usr.overlays-=A
				for(var/Z in typesof("/obj/Characters/Team/[lowertext(usr.Stats[c_Team])]"))
					usr.overlays+=Z
			if("Green")
				usr.Stats[c_Team]=userteam
				for(var/A in typesof(/obj/Characters/Team)) usr.overlays-=A
				for(var/Z in typesof("/obj/Characters/Team/[lowertext(usr.Stats[c_Team])]"))
					usr.overlays+=Z
			if("Silver")
				usr.Stats[c_Team]=userteam
				for(var/A in typesof(/obj/Characters/Team)) usr.overlays-=A
				for(var/Z in typesof("/obj/Characters/Team/[lowertext(usr.Stats[c_Team])]"))
					usr.overlays+=Z
			if("Purple")
				usr.Stats[c_Team]=userteam
				for(var/A in typesof(/obj/Characters/Team)) usr.overlays-=A
				for(var/Z in typesof("/obj/Characters/Team/[lowertext(usr.Stats[c_Team])]"))
					usr.overlays+=Z
			if("Neutral")
				usr.Stats[c_Team]="N/A"
				for(var/Z in typesof(/obj/Characters/Team)) usr.overlays-=Z
