proc
	Death(var/mob/M)
		sleep(1)
		if(isnull(M))
			DebugLog("Death - null target");
			return;
		#ifdef INCLUDED_AI_DM
		if( istype(M, /mob/Entities/AIs ) )
			for(var/mob/Entities/Player/P in world)
				if(P.key == M.KilledBy)
					if(!isStatLocked(P))
						if(M.Stats[Kills]>=(P.Stats[Kills]*10) && M.Stats[Kills]<(P.Stats[Kills]*100))
							P.Stats[Kills]+=2*KillMultiplier
						else if(M.Stats[Kills]>=(P.Stats[Kills]*100) && M.Stats[Kills]<(P.Stats[Kills]*1000))
							P.Stats[Kills]+=3*KillMultiplier
						else if(M.Stats[Kills]>=(P.Stats[Kills]*1000) && M.Stats[Kills]<(P.Stats[Kills]*10000))
							P.Stats[Kills]+=4*KillMultiplier
						else if(M.Stats[Kills]>=(P.Stats[Kills]*10000) && M.Stats[Kills]<(P.Stats[Kills]*100000))
							P.Stats[Kills]+=5*KillMultiplier
						else P.Stats[Kills]+=1*KillMultiplier
						if(P.life == P.mlife) P.Stats[PKills]+=1*KillMultiplier
						if(P.life <= (P.mlife*0.33)) P.Stats[CCKills]+=1*KillMultiplier

			switch( M.Class )
				if( "GBD", "Athena", "AthenaII")
					for(var/mob/Entities/Player/player_in_range in view(5,M.loc))
						if( player_in_range.Guard < 4  \
						|| player_in_range.Class == "Randomness" ) continue
						var/Damage = 0;
						var/expDmg = 0;
						if( isnull(M)) continue
						switch( M.Class )
							if("GBD")
								expDmg = 8
								Damage = expDmg*Multiplier
							if("Athena", "AthenaII")
								expDmg = 4
								Damage = expDmg*Multiplier
						switch( player_in_range.Class )
							if( "SJX", "Plague" )
								Damage = Multiplier
						if( player_in_range.icon_state == "hide" )
							Damage = Multiplier
						player_in_range.life -= Damage;
						player_in_range.KilledBy = M.name
						flickHurt(player_in_range)
						if(player_in_range.life <= 0) Death(player_in_range)
			spawn(1) del M
		#endif
		else if(istype(M, /mob/Entities/Player))
			if(M.Dead==1) return // Already dead?
			if(M.BarrierUP == 1)
				for(var/mob/GB/G) if(G.Owner == M.key) del G
				for(var/mob/AW/G) if(G.Owner == M.key) del G
				for(var/mob/ZIW/G) if(G.Owner == M.key) del G
				M.BarrierUP=0
			M.Dead=1
			//=============================================================
			// #KILLSELF
			//=============================================================
			//DebugLog("[M.key] == [M.KilledBy]")
			if(M.key == M.KilledBy)
				M <<"<B><I><font color = green>You killed yourself!!"
				switch( get_WorldStatus(c_Mode) )
					if("Berserker", "Juggernaut")
						if(M.key==ModeTarget)
							if(M.key!=leading && M.key!=runnerup) // if your not leader or runnerup
								M.KilledBy=leading
							if(M.key==leading)
								M.KilledBy=runnerup
							if(M.key==runnerup)
								M.KilledBy=leading
			switch( get_WorldStatus(c_Mode) )
			#if DUEL_MODE
				if("Duel Mode")
					if(eTeam1.Find(M.key))
						eDead1+=M.key
						eTeam1-=M.key
						if(!length(eTeam1))
							for(var/mob/Entities/Player/mAlive in world)
								if(eTeam2.Find("[mAlive.key]")||eDead2.Find("[mAlive.key]"))
									++mAlive.ChallP
									mAlive<<"<b>Your side wins!"
								if(eTeam1.Find("[mAlive.key]")||eDead1.Find("[mAlive.key]"))
									--mAlive.ChallP
									mAlive<<"<b>Your side loses!"
							eTeam1 = null
							eDead1 = null
							eTeam2 = null
							eDead2 = null
							WorldMode="Battle"
							Announce("Duel Mode is over!")
					if(eTeam2.Find("[M.key]"))
						eDead2+="[M.key]"
						eTeam2-="[M.key]"
						if(!length(eTeam2))
							for(var/mob/Entities/Player/mAlive in world)
								if(eTeam2.Find("[mAlive.key]")||eDead2.Find("[mAlive.key]"))
									++mAlive.ChallP
									mAlive<<"<b>Your side wins!"
								if(eTeam1.Find("[mAlive.key]")||eDead1.Find("[mAlive.key]"))
									--mAlive.ChallP
									mAlive<<"<b>Your side loses!"
							eTeam1 = null
							eDead1 = null
							eTeam2 = null
							eDead2 = null
							WorldMode="Battle"
							Announce("Duel Mode is over!")
					if(eTeam3.Find("[M.key]"))
						eDead3+="[M.key]"
						eTeam3-="[M.key]"
						if(length(eTeam3)<2)
							for(var/mob/Entities/Player/mAlive in world)
								if(eTeam3.Find("[mAlive.key]"))
									++mAlive.ChallP
									mAlive<<"<b>You win!"
								if(eDead3.Find("[mAlive.key]"))
									--mAlive.ChallP
									mAlive<<"<b>You lose!"
							eTeam3 = null
							eDead3 = null
							WorldMode="Battle"
							Announce("Duel Mode is over!")
				#endif
				if("Capture The Flag")
					switch( M.hasFlag )
						if(3)
							M.hasFlag=0
							new /obj/Flags/Red(locate(47,22,10))
							Announce("Red Flag respawned.")
						if(2)
							M.hasFlag=0
							new /obj/Flags/Blue(locate(53,22,10))
							Announce("Blue Flag respawned.")
				if("Neutral Flag")
					if(M.hasFlag==1)
						M.hasFlag=0
						Flag_Respawn()
						Announce("Flag respawned.")

			//=============================================================
			// #KILLTARGET
			//=============================================================
			if(M.key != M.KilledBy)
				//DebugLog("[M.key] != [M.KilledBy]")
				for(var/mob/Entities/Player/P in world)
					if(P.key == M.KilledBy)
						if(!isSAdmin(M)) P <<"<B><I><font color = green>You have defeated [M]"
						if(!isStatLocked(P)&&P.client.address != M.client.address)
							if(M.Stats[Kills]>=(P.Stats[Kills]*10)&&M.Stats[Kills]<(P.Stats[Kills]*100))
								P.Stats[Kills]+=2*KillMultiplier
							else if(M.Stats[Kills]>=(P.Stats[Kills]*100)&&M.Stats[Kills]<(P.Stats[Kills]*1000))
								P.Stats[Kills]+=3*KillMultiplier
							else if(M.Stats[Kills]>=(P.Stats[Kills]*1000)&&M.Stats[Kills]<(P.Stats[Kills]*10000))
								P.Stats[Kills]+=4*KillMultiplier
							else if(M.Stats[Kills]>=(P.Stats[Kills]*10000)&&M.Stats[Kills]<(P.Stats[Kills]*100000))
								P.Stats[Kills]+=5*KillMultiplier
							else P.Stats[Kills]+=1*KillMultiplier

							if(P.life == P.mlife) P.Stats[PKills]+=1*KillMultiplier
							if(P.life <= 3)  P.Stats[CCKills]+=1*KillMultiplier
						if(!isSAdmin(P)) M <<"<B><I><font color = green>[P] has defeated you!"
						switch( get_WorldStatus(c_Mode) )
							if("Deathmatch", "Double Kill")
								++P.subkills
								Check_End(P)

							if("Berserker")
								if(ModeTarget==P.key)
									P.life+=3
									P.subkills+=1
									if(P.life>=P.mlife)
										P.life=P.mlife
									P.Update()
								if(ModeTarget==M.key)
									M.Stats[c_Team]="N/A"
									ModeTarget=P.key
									P.Stats[c_Team]="Blue"
									P.subkills+=2
									if(P.Dead!=1)
										for(var/X in typesof(/obj/Characters/Team)) P.overlays-=X
										P.overlays+=new /obj/Characters/Team/blue
									P.life=P.mlife
									P.Attack=(P.Attack*2)
									P.Update()
								Check_End(P)
							if("Juggernaut")
								if(ModeTarget==P.key)
									P.subkills+=1
								if(ModeTarget==M.key)
									M.Stats[c_Team]="N/A"
									ModeTarget=P.key
									P.Stats[c_Team]="Blue"
									P.subkills+=2
									if(P.Dead!=1)
										for(var/X in typesof(/obj/Characters/Team)) P.overlays-=X
										P.overlays+=new /obj/Characters/Team/blue
									P.mlife=P.mlife*2
									P.life=P.mlife
									P.Update()
								Check_End(P)
						switch( P.Stats[c_Team] )
							if("Red")
								++TeamScores[c_RED]
								Check_End(P)


							if("Blue")
								++TeamScores[c_BLUE]
								Check_End(P)

							if("Yellow")
								++TeamScores[c_YELLOW]
								Check_End(P)

							if("Green")
								++TeamScores[c_GREEN]
								Check_End(P)
			if(!isnull(M))
				if(!isStatLocked(M)) ++M.Stats[Deaths]
				M.Dead = 1
				M.mlife = 28
				M.nojump = 0
				M.life = M.mlife

				for(var/G = 1 to 7) M.Disabled[G] = 0
				M.islocked = 0
				M.DisguiseCounter = 31
				M.Disguised = 0
				M.overlays = list()
				M.icon = null
				M.icon_state = "right"

				M.BulletIcon = null
				M.SubBulletIcon = null
				M.Flight = 0
				spawn() M.loc = locate(50,50,1)
				M.DefenseBuff = 0
				M.AttackBuff = 0
				RemoveMeter(M)
				M.climbing = 0
				M.density = 1
				M.Guard = 0
				M.inscene = 0
				M.Dashing = 0
				M.Healing = 0
				M.Teleporting = 0
				M.Slashing = 0
				M.pixel_y = -16
				M.lock = 0
				M.Class = null
				Characters(M)
				Check_End(M)
				M.KilledBy = M.key
			switch( M.Class )
				if( "GBD", "Athena", "AthenaII")
					for(var/mob/Entities/Player/player_in_range in view(5,M.loc))
						if( player_in_range.Guard > 3  \
						|| player_in_range.Class == "Randomness" \
						|| isnull(M) ) continue
						var/mKilledBy = M.name
						if( istype(M, /mob/Entities/Player ) )
							if(M.KilledBy == M.key || M.key == player_in_range.key) continue
							mKilledBy = M.key
						var/Damage = 0
						var/expDmg = 0
						switch( M.Class )
							if("GBD")
								expDmg = 8
								Damage = expDmg*Multiplier
							if("Athena", "AthenaII")
								expDmg = 4
								Damage = expDmg*Multiplier
						switch( player_in_range.Class )
							if( "SJX", "Plague" )
								Damage = Multiplier
						if( player_in_range.icon_state == "hide" )
							Damage = Multiplier
						if(player_in_range.ReverseDMG == 1) Damage *= -1
						player_in_range.life -= Damage
						player_in_range.KilledBy = mKilledBy
						flickHurt(player_in_range)
						if(player_in_range.life <= 0) Death(player_in_range)
			switch(rand(1, 5))
				if(1)
					var/turf/aturf = locate(M.x, M.y, M.z)
					var/dense = 0
					if(aturf)
						for(var/turf/A in aturf)
							if(A.density == 1)
								dense = 1
								break
					if(!aturf) dense = 1
					if(dense == 0)
						switch(rand(1,10))
							if(1,2) 		new /obj/Drops/Energy/Large(locate(M.x,M.y,M.z))
							if(3,4,5,6,7) 	new /obj/Drops/Energy/Small(locate(M.x,M.y,M.z))
							if(8) 		new /obj/Drops/Health/Large(locate(M.x,M.y,M.z))
							if(9,10) 	new /obj/Drops/Health/Small(locate(M.x,M.y,M.z))
		else if(istype(M, /mob/Entities/PTB))
			for(var/mob/Entities/Player/P in world)
				Return_Players(P)
				if(P.key == M.KilledBy)
					Announce("[M]'s base control has been destroyed by [P.key]!")
					var/const/teamBonus = 500
					switch( P.Stats[c_Team] )
						if("Red")
							TeamScores[c_RED]+=teamBonus
						if("Blue")
							TeamScores[c_BLUE]+=teamBonus
						if("Yellow")
							TeamScores[c_YELLOW]+=teamBonus
						if("Green")
							TeamScores[c_GREEN]+=teamBonus
					switch( get_WorldStatus(c_Mode) )
						if("Protect The Base", "Advanced Protect The Base")
							Announce("The final Scores are: Red - [TeamScores[c_RED]] Blue - [TeamScores[c_BLUE]] Yellow - [TeamScores[c_YELLOW]] Green - [TeamScores[c_GREEN]]")
						if("Warzone")
							for(var/mob/Entities/AIs/Ships/target in world)
								spawn(1) del target
			Mode_Reset()
			set_WorldStatus(c_Mode, "Battle")
		else
			del M