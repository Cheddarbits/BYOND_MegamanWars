
//client
	//perspective = EDGE_PERSPECTIVE
mob
	pixel_y = -16
	pixel_x = -16
	Stat()
		if(usr.Playing==1)
			statpanel("Scores")
			stat("=====How to Play=====")
			stat("Desktop Controls", "9, 7, 3, and 1 on numpad numlock off" )
			stat("Laptop Controls", "Page up, home, page down, and end" )
			stat("Say Commands", "#who, #stopmusic, #suicide, #rules")
			stat("#gamemid, #repick, #help, #ignore \[name], #unignore \[name], #ignorelist")
			stat("")
			stat("=====World Info=====")
			stat("Map:", "[get_WorldStatus(c_Mapname)]")
			stat("Mode:", "[get_WorldStatus(c_Mode)]")
			stat("Damage Setting:", "[DamageSetting]")
			stat("Version:", world_version)
			stat("")
			stat("Your Team", "[usr.Stats[c_Team]]")
			stat("Character", "[usr.Class]")
			stat("Kills", "[usr.Stats[Kills]]")
			stat("Perfect Kills", "[usr.Stats[PKills]]")
			stat("Close Call Kills", "[usr.Stats[CCKills]]")
			stat("Deaths", "[usr.Stats[Deaths]]")
			if(usr.mEnergy > 0)
				var/En = round(usr.Energy/usr.mEnergy*100)
				stat("Energy", "[En]%")
			stat("")
			if(usr.Stats[Kills]>0&&usr.Stats[Deaths]>0)
				var/KDR = round((usr.Stats[Kills]/usr.Stats[Deaths])*10)*0.1
				if(KDR>0)
					stat("Kill/Death Ratio", "[KDR]")

			if(isSAdmin(usr)||isDebugger(usr))
				stat("CPU: ", "[world.cpu]")


			switch( get_WorldStatus(c_Mode) )
				if("Boss Battle")
					statpanel("Boss Stats")
					for(var/mob/Entities/Player/P)
						if(Bosses.Find(P.key))
							stat("Player Name","[P.key]")
							stat("Character","[P.Class]")
							stat("Life","[P.life]/[P.mlife]")
							stat("Kills","[TeamScores[c_BLUE]]/[EventKillLimit]")
				if("Dual Boss Battle")
					statpanel("Boss Stats")
					for(var/mob/Entities/Player/P)
						if(Bosses.Find(P.key))
							stat("Player Name","[P.key]")
							stat("Character","[P.Class]")
							stat("Life","[P.life]/[P.mlife]")
					stat("Kills","[TeamScores[c_BLUE]]/[EventKillLimit]")
				if("Battle of the Bosses")
					statpanel("Boss Information")
					for(var/mob/Entities/Player/P)
						if(Bosses.Find(P.key))
							stat("Player Name","[P.key]")
							stat("Character","[P.Class]")
							stat("Life","[P.life]/[P.mlife]")
					stat("Kills","[TeamScores[c_BLUE]]")
					stat("Kills","[TeamScores[c_YELLOW]]")
				if("Assassination")
					statpanel("Leader Info")
					for(var/mob/Entities/Player/A)
						if(TeamLeaders.Find(A.key))
							stat("[A.Stats[c_Team]] Leader","[A.key]")
							stat("Life","[A.life]/[A.mlife]")
				if("Berserker", "Juggernaut", "Neutral Flag", "Double Kill", "Deathmatch")
					statpanel("Status in [get_WorldStatus(c_Mode)]")
					stat("Player Name","[usr]")
					stat("Kills","[usr.subkills]/[EventKillLimit]")
					stat("")
					stat("Leader","[leading]")
					stat("Leading Score","[leaderkills]")
					stat("Runner-up","[runnerup]")
					stat("Runner-up Score","[runnerupkills]")
					if(get_WorldStatus(c_Mode) == "Berserker" || get_WorldStatus(c_Mode) == "Juggernaut")
						stat("Current [get_WorldStatus(c_Mode)]", "[ModeTarget]")
				if("Survival")
					if(!isnull(playerEvent) && playerEvent.Find(usr.key))
						statpanel("Status in Survival")
						stat("Virtual Map", get_WorldStatus(c_vMapname))
						stat("Lives", usr.playerLives)
						stat("Remaining Players", playerEvent.len)
						for(var/i = 1 to playerEvent.len)
							stat(playerEvent[i])
				if("Team Deathmatch")
					statpanel("Team Scores")
					stat("Red Score:","[TeamScores[c_RED]]/[EventKillLimit]")
					stat("Blue Score:","[TeamScores[c_BLUE]]/[EventKillLimit]")
					stat("Yellow Score:","[TeamScores[c_YELLOW]]/[EventKillLimit]")
					stat("Green Score:","[TeamScores[c_GREEN]]/[EventKillLimit]")
				if("Capture The Flag")
					statpanel("Team Scores")
					stat("Red Team: ","[redTeam.len]")
					stat("Red Score:","[TeamScores[c_RED]]/[EventKillLimit]")
					stat("Blue Team: ","[blueTeam.len]")
					stat("Blue Score:","[TeamScores[c_BLUE]]/[EventKillLimit]")
			if(usr.Stats[c_Team]!="N/A"&&usr.Stats[c_Team]!="Silver"&&usr.Stats[c_Team]!="Purple")
				switch(get_WorldStatus(c_Mode))
					if("Protect The Base", "Advanced Protect The Base")
						statpanel("[usr.Stats[c_Team]] Team's Stat")
						for(var/mob/Entities/PTB/PT)
							if(!isSAdmin(usr)&&PT.Stats[c_Team]==usr.Stats[c_Team])
								stat("[usr.Stats[c_Team]] Base HP","[PT.life]")
							if(isSAdmin(usr))
								switch(PT.Stats[c_Team])
									if("Red")
										stat("Red Base HP","[PT.life]")
									if("Blue") stat("Blue Base HP","[PT.life]")
									if("Yellow") stat("Yellow Base HP","[PT.life]")
									if("Green") stat("Green Base HP","[PT.life]")
						stat("Red Team: ","[redTeam.len]")
						stat("Blue Team: ","[blueTeam.len]")
						stat("Yellow Team: ","[yellowTeam.len]")
						stat("Green Team: ","[greenTeam.len]")
			switch(usr.Stats[c_Team])
				if("Red", "Blue")
					if(get_WorldStatus(c_Mode)=="Warzone")
						statpanel("[usr.Stats[c_Team]] Team's Stat")
						for(var/mob/Entities/PTB/PT in world)
							if(!isSAdmin(usr)&&PT.Stats[c_Team]==usr.Stats[c_Team])
								stat("Base HP","[PT.life]")
							if(isSAdmin(usr))
								switch(PT.Stats[c_Team])
									if("Red")
										stat("Red Base HP","[PT.life]")
									if("Blue")
										stat("Blue Base HP","[PT.life]")
						stat("Red Team: ","[redTeam.len]")
						stat("Blue Team: ","[blueTeam.len]")
	Bump(M)
		if(istype(M, /obj/Drops/Energy))
			if(src.Dead == 1) return
			src.Energy += M:restoreValue
			if(src.Energy > src.mEnergy) src.Energy = src.mEnergy
			M:density = 0
			del M
			return
		if(istype(M, /obj/Drops/Health))
			if(src.Dead == 1) return
			src.life += M:restoreValue
			if(src.life > src.mlife) src.life = src.mlife
			src.Update()
			M:density = 0
			del M
			return
		if(istype(M, /obj/Flags))
			if(src.hasFlag == 0)
				switch(get_WorldStatus(c_Mode))
					if("Neutral Flag")
						for(var/X in typesof(/obj/oFlags)) src.overlays-=X
						for(var/Z in typesof("/obj/oFlags/[M:name]")) src.overlays+=Z
						src.hasFlag=1
						src.density=1
						del M
						return
					if("Capture The Flag")
						if(src.Stats[c_Team]!=M:name)
							Announce("[src.Stats[c_Team]] Team has the [M:name] flag.")
							for(var/X in typesof(/obj/oFlags)) src.overlays-=X
							for(var/Z in typesof("/obj/oFlags/[M:name]")) src.overlays+=Z
							switch(M:name)
								if("Red")
									src.hasFlag=3
								if("Blue")
									src.hasFlag=2
							src.density=1
							del M
							return
						src.loc=locate(M:x,M:y,M:z)
		if(istype(M, /turf/misc/Teleporter))
			switch(rand(1,4))
				if(1)
					src.loc=locate(/turf/misc/Teleporter/TeleporterLeft0)
					src.icon_state="left"
					src.x--
				if(2)
					src.loc=locate(/turf/misc/Teleporter/TeleporterLeft1)
					src.icon_state="left"
					src.x--
				if(3)
					src.loc=locate(/turf/misc/Teleporter/TeleporterRight0)
					src.icon_state="right"
					src.x++
				if(4)
					src.loc=locate(/turf/misc/Teleporter/TeleporterRight1)
					src.icon_state="right"
					src.x++
		if(istype(M, /turf/FlagPoint))
			if(get_WorldStatus(c_Mode)=="Capture The Flag")
				if(src.hasFlag==2&&M:x<42)
					src.hasFlag=0
					src.loc=locate(M:x,M:y,M:z)
					Announce("[src.Stats[c_Team]] Team has captured the Blue flag.")
					for(var/X in typesof(/obj/oFlags)) src.overlays-=X
					++TeamScores[c_RED]
					if(get_WorldStatus(c_Mode)=="Capture The Flag")
						new /obj/Flags/Blue(locate(53,22,10))
						Announce("Blue Flag respawned")
				if(src.hasFlag==3&&M:x>58)
					src.hasFlag=0
					src.loc=locate(M:x,M:y,M:z)
					Announce("[src.Stats[c_Team]] Team has captured the Red flag.")
					for(var/X in typesof(/obj/oFlags)) src.overlays-=X
					++TeamScores[c_BLUE]
					if(get_WorldStatus(c_Mode)=="Capture The Flag")
						new /obj/Flags/Red(locate(47,22,10))
						Announce("Red Flag respawned")
				Check_End(src)
			if(get_WorldStatus(c_Mode)=="Neutral Flag")
				if(src.hasFlag==1)
					src.hasFlag=0
					src.loc=locate(M:x,M:y,M:z)
					Announce("Flag Captured")
					for(var/X in typesof(/obj/oFlags)) src.overlays-=X
					src.subkills++
					Check_End(src)
					if(get_WorldStatus(c_Mode)=="Neutral Flag")
						Flag_Respawn()
						Announce("Flag respawned.")
				else
					src.loc=locate(M:x,M:y,M:z)
			else
				src.loc=locate(M:x,M:y,M:z)

			/*	else
					del M
					switch(Map)
						if(1) // Underground Lab
							new /obj/Flags/Neutral(locate(46,19,3))
						if(2) // Combat Facility
							new /obj/Flags/Neutral(locate(51,50,2))
						if(3) // Twin Towers
							new /obj/Flags/Neutral(locate(50,69,4))
						if(4) // Lava Caves
							new /obj/Flags/Neutral(locate(51,51,5))
						if(5) // Frozen Tundra
							new /obj/Flags/Neutral(locate(51,18,6))
						if(6) // Neo Arcadia
							new /obj/Flags/Neutral(locate(47,27,7))
						if(7) // Desert Temple
							new /obj/Flags/Neutral(locate(91,55,8))
						if(8) // Sleeping Forest
							new /obj/Flags/Neutral(locate(44,5,9))
						if(9) // Warzone
							new /obj/Flags/Neutral(locate(50,2,10))
						if(10) // Ground Zero
							new /obj/Flags/Neutral(locate(50,14,11))*/

		if(istype(M, /mob/GB))
			#ifdef INCLUDED_RANDOMNESS_DM
			if(src.Class=="Randomness")
				del M
				return
			#endif
			if(istype(src, /mob/Entities/Player))
				src.life -= 5
				src.KilledBy = M:Owner
				flickHurt(src)
				if(src.life <= 0)
					var/msgCalled=0
					for(var/mob/Entities/Player/A in world)
						if(isnull(M)) continue
						if(A.key==M:Owner&&msgCalled==0)
							++msgCalled
							var/LostKills = 2*A.KillLoss
							if(src.Stats[c_Team]==A.Stats[c_Team]&&A.Stats[c_Team]!="N/A"&&src.Dead!=1&&src.key!=A.key)
								A.Stats[Kills]-=LostKills
								A.Stats[CCKills]-=LostKills
								A.Stats[PKills] -=LostKills
								Save(A)
								A<<"<B><I><font color = #6698FF face = modern>You have Team Killed [src]!!"
					Death(src)
		else if(istype(M, /mob/AWB))
			#ifdef INCLUDED_RANDOMNESS_DM
			if(src.Class=="Randomness")
				del M
				return
			#endif
			if(src.Guard == 4 || src.key == M:Owner) return
			if(istype(src, /mob/Entities/Player))
				src.life -= 2*Multiplier
				src.KilledBy = M:Owner
				flickHurt(src)
				if(src.life <= 0)
					var/msgCalled=0
					for(var/mob/Entities/Player/A in world)
						if(!isnull( M ) && A.key==M:Owner && msgCalled == 0)
							++msgCalled
							var/LostKills = 2*A.KillLoss
							if(src.Stats[c_Team]==A.Stats[c_Team]&&A.Stats[c_Team]!="N/A"&&src.Dead!=1&&src.key!=A.key)
								A.Stats[Kills]-=LostKills
								A.Stats[CCKills]-=LostKills
								A.Stats[PKills] -=LostKills
								Save(A)
								A<<"<B><I><font color = #6698FF face = modern>You have Team Killed [src]!!"
					Death(src)
		else if(istype(M, /mob/AW/Part3)||istype(M, /mob/AW2/Part3))
			#ifdef INCLUDED_RANDOMNESS_DM
			if(src.Class=="Randomness")
				del M
				return
			#endif
			if(src.Guard == 4 || src.key == M:Owner ) return
			if(istype(src, /mob/Entities/Player))
				src.KilledBy = M:Owner
				var/msgCalled=0
				for(var/mob/Entities/Player/A in world)
					if(isnull(M)) continue
					if(A.key==M:Owner && msgCalled == 0 )
						sleep( 1 )
						if(isnull(M)) continue
						++msgCalled
						var/LostKills = 2*A.KillLoss
						if(src.Stats[c_Team]==A.Stats[c_Team]&&A.Stats[c_Team]!="N/A"&&src.Dead!=1&&src.key!=A.key)
							A.Stats[Kills]-=LostKills
							A.Stats[CCKills]-=LostKills
							A.Stats[PKills] -=LostKills
							Save( A )
							A<<"<B><I><font color = #6698FF face = modern>You have Team Killed [src]!!"
				Death(src)
		else if(istype(M, /mob/ZIW))
			switch(M:Types)
				if("right1", "left1")
					switch(src.icon_state)
						if("left")
							if(M:icon_state=="right1")
								src.life-= (src.mlife*0.5)
								for(var/mob/Entities/Player/B in world)
									if(B.key==M:Owner) src.KilledBy=B.key
							//	src.KilledBy = M:Owner
								src.Update()
								if(src.life <= 0) Death(src)
						if("right")
							if(M:icon_state=="left1")
								src.life-= (src.mlife*0.5)
								for(var/mob/Entities/Player/B in world)
									if(B.key==M:Owner) src.KilledBy=B.key
								//src.KilledBy = M:Owner
								src.Update()
								if(src.life <= 0) Death(src)
				if("right2", "left2")
					switch(src.icon_state)
						if("left")
							if(M:icon_state=="right2")
								src.life-= 1
								for(var/mob/Entities/Player/B in world)
									if(B.key==M:Owner) src.KilledBy=B.key
								//src.KilledBy = M:Owner
								src.Update()
								if(src.life <= 0) Death(src)
						if("right")
							if(M:icon_state=="left2")
								src.life-= 1
								for(var/mob/Entities/Player/B in world)
									if(B.key==M:Owner) src.KilledBy=B.key
								//src.KilledBy = M:Owner
								src.Update()
								if(src.life <= 0) Death(src)
		else if(istype(M, /mob/Entities/AIs))
			if(isnull(M) || isnull(src)) return
			#ifdef INCLUDED_RANDOMNESS_DM
			if(src.Class=="Randomness"||M:Class=="Randomness")
				Death(src)
			#endif
			if(src.Class=="HanuFireball"||M:Class=="HanuFireball")
				sleep(1)
				Sword_Hit(M, src)
		else if(istype(M, /mob/Entities/Player))
			if(isnull(M)) return
			#ifdef INCLUDED_RANDOMNESS_DM
			if(src.Class=="Randomness")
				M:KilledBy=src.key;Death(M)
			#endif
			if(src.Class=="HanuFireball")
				sleep(1)
				Sword_Hit(M, src)

			switch(M:Class)
				if("HanuFireball")
					sleep(1)
					if(M:Guard == 0 || M:inscene == 0)
						Sword_Hit(M, src)
				#ifdef INCLUDED_RANDOMNESS_DM
				if("Randomness")
					src.KilledBy=M:key;Death(src)
				#endif
				if("Zombie")
					var/isDamaged = 0
					switch(src.icon_state)
						if("left")
							switch(M:icon_state)
								if("armright")
									src.life-= (src.mlife*0.5)
									isDamaged = 1
								if("brokenarmright")
									src.life-= 1
									isDamaged = 1
						if("right")
							switch(M:icon_state)
								if("armleft")
									src.life-= (src.mlife*0.5)
									isDamaged = 1
								if("brokenarmleft")
									src.life-= 1
									isDamaged = 1
					if(isDamaged==1)
						for(var/mob/Entities/Player/B in world)
							if(B.key==M:Owner) src.KilledBy=B.key
						//src.KilledBy = M:Owner
						src.Update()
						if(src.life <= 0) Death(src)

			return
		if((get_dir(src, M) == NORTH)) src.jumping = 0
		else return
	proc
		jump()        // jump, used for projecting yourself into the air, for your own reasons.
			if(src.jumping == 1)   // You can't jump if you're already jumping.
				return
			// Check if we're trying to jump when somethings above our head
			var/dense = 0
			var/turf/aturf = get_step(src,NORTH)
			for(var/atom/A in aturf)
				if(A.density == 1) dense = 1; break
				if(aturf.density == 1) dense = 1
			if(!aturf) dense = 1
			if(dense == 1) return

			aturf = get_step( src, SOUTH )  // Get the turf directly below you.
			if(aturf)
				for(var/atom/A in aturf)
					if(A.density == 1) dense = 1;break
				if(aturf.density == 1) dense = 1
			// Those few lines above are used to make sure you're on something dense. You can't jump if you're falling.
			if(!aturf) dense = 1
			if(src.Flight != 1)
				if(dense == 1 )    // If they're on something...
					src.jumping = 1
					for(var/I = 0 to ( (gravity * src.jumpHeight ) -1 ) )    // This is a traditional for loop that loops until I(init 0) is equal to gravity times 1.5.
						spawn()
							if(src.loc != null)
								if(src.climbing==1)
									switch(usr.Class)
										if("AthenaII","Plague") break
									switch( src.icon_state )
										if("clingleft","wallclingleft") src.icon_state="left"
										if("clingright","wallclingright") src.icon_state="right"
									src.climbing=0
								else

									step(src, NORTH)
						sleep(gravity)
						if(src.jumping == 0) break
					src.jumping = 0
					spawn(gravity) src.GravCheck()
				if(dense == 0&&src.climbing==1)
					src.jumping = 1
					for(var/I = 0 to ( (gravity * src.jumpHeight ) -1 ) )    // This is a traditional for loop that loops until I(init 0) is equal to gravity times 1.5.
						spawn()
							if(src.loc != null)
								if(src.climbing==1)
									switch(usr.Class)
										if("AthenaII","Plague") break
									switch( src.icon_state )
										if("clingleft","wallclingleft") src.icon_state="left"
										if("clingright","wallclingright") src.icon_state="right"
									src.climbing=0
								else
									if(src.Class!="Randomness")

										step(src, NORTH)
						sleep(gravity)
						if(src.jumping == 0) break
					src.jumping = 0
					spawn(gravity) src.GravCheck()


		GravCheck()       // Your artificial gravity.
			if(src.jumping == 0&&src.Dead!=1)   // If they're in the process of going up, don't do the gravity thing.
				var/Dest = get_step( src, SOUTH )
				var/offsetx = 0
				var/offsety = 0
				if(fall_type == 1)
					var/dense = 0
					var/turf/spot = Dest
					if(spot)
						for(var/atom/A in spot)
							if(istype(A, /mob/AW/Part3)||istype(A, /mob/AW2/Part3))
								if(src.density==1)
									src.Move(Dest)
							else if(istype(A, /mob/AWB))
								if(src.density==1)
									sleep(1)
									src.Move(Dest)
							else if(istype(A, /obj/Flags)||istype(A, /obj/Drops))
								if(src.density==1)
									sleep(1)
									src.Move(Dest)
							else
								if(A.density == 1)
									dense = 1
						if(dense == 0 )
							if(src.climbing==1||src.Flight==1||src.icon_state=="sandleft"||src.icon_state=="sandright") src.climbing+=0
							else src.Move(Dest)
					// The above few lines (again) are for checking if you're on something dense. If you are, there's no need to attempt going down.
					// This is merely for the CPU, it'll work without them, since a mere Bump would occur if you went South into a dense object.
				else

					src.Move(locate(Dest), offsetx, offsety)
				spawn(gravity) src.GravCheck()   // And loop the process...

mob/verb

	Suicide()
		set hidden = 1
		if(usr.Dead!=1)
			if(!Bosses.Find(usr.key) && !TeamLeaders.Find(usr.key) && usr.key != ModeTarget) usr.KilledBy=usr.key
			Death(usr)
