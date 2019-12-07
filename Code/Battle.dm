#define c_LIMIT 2
#define c_INVLIMIT -2
proc/
//Objects//
obj
	var
		ShootType = 1
		Hits = 0
		Bounce = 0
	proc
		BlastMove()    // This is how it moves, depending on it's icon_state.
			var/turf/aturf
			switch( src.icon_state )
				if("up", "up2") 	aturf = get_step( src, NORTH )
				if("upleft") 		aturf = get_step( src, NORTHWEST )
				if("upright") 		aturf = get_step( src, NORTHEAST )
				if("down") 			aturf = get_step( src, SOUTH )
				if("downright") 	aturf = get_step( src, SOUTHEAST )
				if("downleft") 		aturf = get_step( src, SOUTHWEST )
				if("right", "right1", "right2", "rightwallclimb" ) 	aturf = get_step( src, EAST )
				if("left", "left1", "left2", "leftwallclimb" ) 		aturf = get_step( src, WEST )

			if(src.icon == 'VileRain.dmi')
				switch(src.icon_state)
					if("right") 	aturf = get_step( src, SOUTHEAST )   // go right.
					if("left") 	aturf = get_step( src, SOUTHWEST )   // go left.

			if(aturf == null||istype(aturf, /turf/Capsules)||istype(aturf, /turf/misc/NoShots)||src.LifeTime>(MAX_LIFE_TIME))     // If the spot it's going to is not really there, then we want it to delete itself.
				del(src)
				return
			++src.LifeTime
			if(istype(aturf, /turf/misc/ShotLifeInc) || aturf.density==1)
				++src.LifeTime
			src.Move(aturf)
			if( !isnull( src ) )
				spawn(1) src.BlastMove()
	Blasts       // The Blast object is for when you Shoot. It's the actual projectile.
		name = "";density = 1   // It needs to be dense to Bump things.
		pixel_y = -11
		Blast
			Bump(M)
				if(istype(M, /mob))
					if(M:icon_state!="hide" && M:Guard<3)
						switch(src.icon)
							if('MagicmanBall.dmi')
								if(src.Bounce==0)
									src.density=0
									sleep(2)
									src.density=1

									return
							if('MagicmanMagicCards.dmi')
								if(getStat(src, Hits)==0)
									src.density=0
									sleep(2)
									src.density=1
									return
						if(istype(M, /mob/Entities/Player))
							if(!isnull(usr) && usr.Class=="Axl" && src.ShootType == 2)
								Axl_Hit(usr, M, src)
								return
							for(var/mob/Entities/Player/A in world)
								if(src.Owner != A.key) continue
								if(M:Stats[c_Team]!="N/A"&&M:Stats[c_Team]==A.Stats[c_Team]&&M:Guard==0&&M:inscene==0)
									switch( src.icon )
										if( 'EddieShotBlue.dmi' )
											if( M:DefenseBuff < c_LIMIT )
												++M:DefenseBuff
												del src
												src = null

												spawn(30) M:DefenseBuff = 0
												return
										if( 'EddieShotRed.dmi' )
											if( M:AttackBuff < c_LIMIT )
												++M:AttackBuff
												del src
												src = null
												spawn(30) M:AttackBuff = 0
												return
									src.density=0
									sleep(2)
									src.density=1
									return
								#ifdef INCLUDED_RANDOMNESS_DM
								else if(M:Class=="Randomness")
									src.density=0
									sleep(2)
									src.density=1
									return
								#endif
								else if(M:key==A.key)
									src.density=0
									sleep(2)
									src.density=1
									return
							switch( src.icon )

								if( 'EddieShotBlue.dmi' )
									if( M:DefenseBuff > c_INVLIMIT )
										--M:DefenseBuff
										spawn(30) M:DefenseBuff = 0
								if( 'EddieShotRed.dmi' )
									if( M:AttackBuff > c_INVLIMIT )
										--M:AttackBuff
										spawn(30) M:AttackBuff = 0

							Hit(M, src)
							return
						else if(istype(M, /mob/Entities/PTB) && src.icon != 'MM8_FlyerShot.dmi')
							for(var/mob/Entities/Player/A)
								if(src.Owner==A.key)
									if(M:Stats[c_Team]!="N/A"&&M:Stats[c_Team]==A.Stats[c_Team])
										src.density=0
										sleep(2)
										src.density=1
										return
									else
										Hit(M, src)
										return
						else if(istype(M, /mob/AW)&&M:Owner==src.Owner)
							src.density=0
							sleep(2)
							src.density=1
							return
						else if(istype(M, /mob/AW2))
							del src
							return
						else
							Hit(M, src)
							return
					else
						src.density=0
						sleep(2)
						src.density=1
						return
				if(istype(M, /obj/Blasts)||istype(M, /obj/Drops))
					if(src.icon=='ShelldonShot1.dmi')
						del M
						return
					else
						src.density=0
						sleep(2)
						src.density=1
						return
				if(istype(M, /turf))
					if(istype(M, /turf/misc/Teleporter))
						switch(rand(1,4))
							if(1)
								src.loc=locate(/turf/misc/Teleporter/TeleporterLeft0)
								src.icon_state="left"
								src.x--;
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
						return
					if(src.icon == 'MagicmanBall.dmi'||src.icon =='WilyShot.dmi' ||src.icon=='CliffBlasts.dmi'||src.icon=='MG400Missiles.dmi'||src.icon=='GrenBomb.dmi'||src.icon=='Bomb.dmi'||src.icon=='MSShot2.dmi'||src.icon=='SolSlash.dmi'||src.icon=='MM8_FlyerShot.dmi'||src.icon=='CubitShots2.dmi'||isSAdmin(usr))
						switch(src.icon)
							if('MagicmanBall.dmi')
								src.Bounce = 1
								switch(src.icon_state)
									if("left")
										src.icon_state="right"
									if("right")
										src.icon_state="left"
								for(var/mob/Entities/E in locate(src.x, src.y, src.z))
									for(var/mob/Entities/Player/A in world)
										if(A.key == src.Owner)
											if(E:Stats[c_Team]!="N/A"&&E:Stats[c_Team]==A.Stats[c_Team])
												src.density=0
												sleep(2)
												src.density=1
											src.density=0
											sleep(2)
											src.density=1
										else
											Hit(E, src)
								return
							if('GrenBomb.dmi', 'Bomb.dmi', 'MG400Missiles.dmi', 'MSShot2.dmi', 'SolSlash.dmi')
								var/Range = 2
								if(src.icon == 'SolSlash.dmi')
									Range = 5
								if(isnull(usr) || ActionUse[AOE] == 1)
									del src
									return
								for(var/mob/A in oview(Range, src.loc))
									var/msgCalled = 0
									if(A.icon_state == "hide"||getBarrier_Blast(A) != 0||A.Guard>2) continue
									if(A.Class=="Leviathen"&&A.icon_state=="guardright") continue
									if(A.Class=="Leviathen"&&A.icon_state=="guardleft") continue
									if( src.Damage > 0 ) // If damage is greater than 0, do the damage process
										if(A.ReverseDMG == 1) src.Damage *= -1
										A.life -= src.Damage*Multiplier


										A.KilledBy = usr.key
										flickHurt(A)
										if(A.life <= 0&&msgCalled==0)

											msgCalled = 1
											isTeamMate( A, usr )
											Death(A)
								del src
								return

							if('MM8_FlyerShot.dmi')
								for(var/mob/Entities/Player/A in oview(4, src.loc))
									if(A.icon_state == "hide"||getBarrier_Blast(A) != 0||A.Guard>2) continue
									if(A.Class=="Leviathen"&&A.icon_state=="guardright") continue
									if(A.Class=="Leviathen"&&A.icon_state=="guardleft") continue
									if(src.Damage > 0)
										A.life -= src.Damage*Multiplier

										A.KilledBy = A.key
										flickHurt(A)
										if(A.life <= 0)
											Death(A)
								del src
								return
							if('WilyShot.dmi')
								switch(src.icon_state)
									if( "left")
										var/turf
											T1 = get_step( src, SOUTHEAST )
											T2 = locate( src.x+1, src.y-2, src.z ) // to the right it checks if
											T3 = get_step( src, NORTHEAST )
											T4 = locate( src.x+1, src.y+2, src.z )
										var/obj/Blasts/Blast
											S1;S2;S3;S4
										var/Damage = 2.5
										if( src.Damage >= 28 ) Damage = 28
										if(T1&&T1.density==0)
											S1 = new /obj/Blasts/Blast(locate( M:x, src.y-1, M:z))
											S1.icon = 'WilyShot2.dmi'
											S1.icon_state = "right"
											if( !isnull( S1 ) )
												S1.Owner=src.Owner
												S1.Damage=Damage
												S1.BlastMove()
										if(T2&&T2.density==0)
											S2 = new /obj/Blasts/Blast(locate( M:x, src.y-2, M:z))
											S2.icon = 'WilyShot2.dmi'
											S2.icon_state = "right"
											if( !isnull( S2 ) )
												S2.Owner=src.Owner
												S2.Damage=Damage
												S2.BlastMove()
										if(T3&&T3.density==0)
											S3 = new /obj/Blasts/Blast(locate( M:x, src.y+1, M:z))
											S3.icon = 'WilyShot2.dmi'
											S3.icon_state = "right"
											if( !isnull( S3 ) )
												S3.Owner=src.Owner
												S3.Damage=Damage
												S3.BlastMove()
										if(T4&&T4.density==0)
											S4 = new /obj/Blasts/Blast(locate( M:x, src.y+2, M:z))
											S4.icon = 'WilyShot2.dmi'
											S4.icon_state = "right"
											if( !isnull( S4 ) )
												S4.Owner=src.Owner
												S4.Damage=Damage
												S4.BlastMove()
										spawn(1) del src
										return
									if( "right" )
										var/turf
											T1 = locate( src.x-1, src.y-1, src.z ) // checks to the left
											T2 = locate( src.x-1, src.y-2, src.z )
											T3 = locate( src.x-1, src.y+1, src.z )
											T4 = locate( src.x-1, src.y+2, src.z )
										var/obj/Blasts/Blast
											S1;S2;S3;S4
										var/Damage = 2.5
										if( src.Damage >= 28 ) Damage = 28
										if(T1&&T1.density==0)
											S1 = new /obj/Blasts/Blast(locate( M:x, src.y-1, M:z))
											S1.icon = 'WilyShot2.dmi'
											S1.icon_state = "left"
											if( !isnull( S1 ) )
												S1.Owner=src.Owner
												S1.Damage=Damage
												S1.BlastMove()
										if(T2&&T2.density==0)
											S2 = new /obj/Blasts/Blast(locate( M:x, src.y-2, M:z))
											S2.icon = 'WilyShot2.dmi'
											S2.icon_state = "left"
											if( !isnull( S2 ) )
												S2.Owner=src.Owner
												S2.Damage=Damage
												S2.BlastMove()
										if(T3&&T3.density==0)
											S3 = new /obj/Blasts/Blast(locate( M:x, src.y+1, M:z))
											S3.icon = 'WilyShot2.dmi'
											S3.icon_state = "left"
											if( !isnull( S3 ) )
												S3.Owner=src.Owner
												S3.Damage=Damage
												S3.BlastMove()
										if(T4&&T4.density==0)
											S4 = new /obj/Blasts/Blast(locate( M:x, src.y+2, M:z))
											S4.icon = 'WilyShot2.dmi'
											S4.icon_state = "left"
											if( !isnull( S4 ) )
												S4.Owner=src.Owner
												S4.Damage=Damage
												S4.BlastMove()
										spawn(1) del src
										return
						if(src.icon=='CubitShots2.dmi'&&src.icon_state=="up")
							sleep(1)
							var/turf
								T1=locate(src.x-1, src.y-1, src.z)
								T2=locate(src.x-2, src.y-1, src.z)
								T3=locate(src.x-3, src.y-1, src.z)
								T4=locate(src.x+1, src.y-1, src.z)
								T5=locate(src.x+2, src.y-1, src.z)
								T6=locate(src.x+3, src.y-1, src.z)
							var/obj/Blasts/Blast
								S1;S2;S3;S4;S5;S6
							if(T1&&T1.density==0)
								S1 = new /obj/Blasts/Blast(locate(src.x-1, M:y, M:z))
								S1.icon_state = "down"
								S1.icon='CubitShots.dmi'
								if( !isnull( S1 ) )
									S1.Owner=src.Owner
									S1.Damage=src.Damage
									S1.BlastMove()
							if(T2&&T2.density==0)
								S2 = new /obj/Blasts/Blast(locate(src.x-2, M:y, M:z))
								S2.icon_state = "down"
								S2.icon='CubitShots.dmi'
								if( !isnull( S2 ) )
									S2.Owner=src.Owner
									S2.Damage=src.Damage
									S2.BlastMove()
							if(T3&&T3.density==0)
								S3 = new /obj/Blasts/Blast(locate(src.x-3, M:y, M:z))
								S3.icon_state = "down"
								S3.icon='CubitShots.dmi'
								if( !isnull( S3 ) )
									S3.Owner=src.Owner
									S3.Damage=src.Damage
									S3.BlastMove()
							if(T4&&T4.density==0)
								S4 = new /obj/Blasts/Blast(locate(src.x+1, M:y, M:z))    // Create it to your right if you're faced right.
								S4.icon_state = "down"
								S4.icon='CubitShots.dmi'
								if( !isnull( S4 ) )
									S4.Owner=src.Owner
									S4.Damage=src.Damage
									S4.BlastMove()
							if(T5&&T5.density==0)
								S5 = new /obj/Blasts/Blast(locate(src.x+2, M:y, M:z))    // Create it to your right if you're faced right.
								S5.icon_state = "down"
								S5.icon='CubitShots.dmi'
								if( !isnull( S5 ) )
									S5.Owner=src.Owner
									S5.Damage=src.Damage
									S5.BlastMove()
							if(T6&&T6.density==0)
								S6 = new /obj/Blasts/Blast(locate(src.x+3, M:y, M:z))    // Create it to your right if you're faced right.
								S6.icon_state = "down"
								S6.icon='CubitShots.dmi'
								if( !isnull( S6 ) )
									S6.Owner=src.Owner
									S6.Damage=src.Damage
									S6.BlastMove()
						//	spawn(1)
							spawn(1) del src
							return
						#ifdef INCLUDED_HDK_DM
						if(!isnull( usr ) && usr.Class=="HDK")
							if(usr.CharMode==1)
								for(var/mob/A in oview(2,src))
									if(A.Class == usr.Class || A.icon_state == "hide"||getBarrier_Blast(A) != 0||A.Guard>2) continue
									if( src.Damage > 0 )
										A.life -= src.Damage*Multiplier

										A.KilledBy = usr.key
										flickHurt(A)
										if(A.life <= 0)
											isTeamMate( A, usr )
											Death(A)
						#endif
						if(src.icon!='CliffBlasts.dmi')
							if(isSAdmin(usr))
								#ifdef INCLUDED_HDK_DM
								if(usr.Class=="HDK"&&usr.CharMode!=1)
									src.density=0
									sleep(2)
									src.density=1
									return
								#endif
								if(usr.Class!="HDK"&&usr.Class!="Model X"&&usr.Class!="Cliff")
									src.density=0
									sleep(2)
									src.density=1
									return
								sleep(1)
								del (src)
						if(src.icon=='CliffBlasts.dmi')

							//counter clockwise rotation
							if(isnull(usr))
								spawn(1) del src
							switch(usr.icon_state)
								if("left")
									if(src.icon_state== "up")
										src.icon_state="upleft"
									if(src.icon_state=="upleft")
										src.icon_state="left"
									if(src.icon_state=="upright")
										src.icon_state="up"
									if(src.icon_state=="down")
										src.icon_state="downright"
									if(src.icon_state=="downright")
										src.icon_state="right"
									if(src.icon_state=="downleft")
										src.icon_state="down"
									if(src.icon_state=="left")
										src.icon_state="downleft"
									if(src.icon_state=="right")
										src.icon_state="upright"
								//clockwise rotation
								if("right")
									if( src.icon_state=="up")
										src.icon_state="upright"
									if(src.icon_state=="upleft")
										src.icon_state="up"
									if(src.icon_state=="upright")
										src.icon_state="right"
									if(src.icon_state=="down")
										src.icon_state="downleft"
									if(src.icon_state=="downright")
										src.icon_state="down"
									if(src.icon_state=="downleft")
										src.icon_state="left"
									if(src.icon_state=="left")
										src.icon_state="upleft"
									if(src.icon_state=="right")
										src.icon_state="downright"

						else
							sleep(1)
							del (src)
					else
						sleep(1)
						del(src)
				else
					sleep(1)
					del(src)





mob/proc
	Shoot()     // For shooting off your harming projectiles. Keep out of reach of children.
		if(src.icon_state==""||src.Dead==1||isnull(src)||src.Shooting == 0)
			return

		if((world.time - src.delay_time) >= src.delay)    // A simple delay to keep you from macroing it tons.

			src.delay_time = world.time
			if(src.Class=="Vile")
				switch( src.icon_state )
					if("rainleft", "rainright") src.delay_time = null // You could lengthen or shorten the delay simply by raising or lowering the mob's delay variable.
			var/obj/Blasts/Blast
				S;S1;S2;S3;S4;S5;S6;S7
			switch( src.icon_state )
				if( "right", "clingright", "wallclingright", "rainright" )
					S = new /obj/Blasts/Blast(locate(src.x, src.y, src.z))    // Create it to your right if you're faced right.
					S.icon_state = "right"    // Set it's state (important not only for proper glitz, but for movement),

					if( src.MaxShots >= 8 )
						S1 = new /obj/Blasts/Blast(locate(src.x, src.y, src.z))    // Create it to your right if you're faced right.
						S1.icon_state = "right"
						S2 = new /obj/Blasts/Blast(locate(src.x, src.y, src.z))    // Create it to your right if you're faced right.
						S2.icon_state = "right"
						S3 = new /obj/Blasts/Blast(locate(src.x, src.y, src.z))    // Create it to your right if you're faced right.
						S3.icon_state = "right"
						S4 = new /obj/Blasts/Blast(locate(src.x, src.y, src.z))    // Create it to your right if you're faced right.
						S4.icon_state = "right"
						S5 = new /obj/Blasts/Blast(locate(src.x, src.y, src.z))    // Create it to your right if you're faced right.
						S5.icon_state = "right"
						S6 = new /obj/Blasts/Blast(locate(src.x, src.y, src.z))    // Create it to your right if you're faced right.
						S6.icon_state = "right"
						S7 = new /obj/Blasts/Blast(locate(src.x, src.y, src.z))    // Create it to your right if you're faced right.
						S7.icon_state = "right"
					switch( src.Class )
						if("AirPantheon")
							if(src.XeronFling == 0)
								S1 = new /obj/Blasts/Blast(locate(src.x, src.y, src.z))    // Create it to your right if you're faced right.
								S1.icon_state = "right"
								S2 = new /obj/Blasts/Blast(locate(src.x, src.y, src.z))    // Create it to your right if you're faced right.
								S2.icon_state = "right"
						#ifdef INCLUDED_HDK_DM
						if( "HDK" )
							S1 = new /obj/Blasts/Blast(locate(src.x, src.y, src.z))    // Create it to your right if you're faced right.
							S1.icon_state = "right"
							S2 = new /obj/Blasts/Blast(get_step( src, NORTH ))    // Create it to your right if you're faced right.
							S2.icon_state = "right"
							S3 = new /obj/Blasts/Blast(get_step( src, NORTH ))    // Create it to your right if you're faced right.
							S3.icon_state = "right"
							S4 = new /obj/Blasts/Blast(get_step( src, SOUTH ))    // Create it to your right if you're faced right.
							S4.icon_state = "right"
							S5 = new /obj/Blasts/Blast(get_step( src, SOUTH ))    // Create it to your right if you're faced right.
							S5.icon_state = "right"
						#endif
						if("Ragnarok")
							S1 = new /obj/Blasts/Blast(locate(src.x, src.y, src.z))    // Create it to your right if you're faced right.
							S1.icon_state = "left"
						if("Wolfang")
							if(src.icon_state=="clingright")
								S1 = new /obj/Blasts/Blast( get_step( src, NORTH ) )    // Create it to your right if you're faced right.
								S1.icon_state = "right"
								S2 = new /obj/Blasts/Blast(get_step( src, SOUTH ))    // Create it to your right if you're faced right.
								S2.icon_state = "right"
				if("left","clingleft","wallclingleft","rainleft")
					S = new /obj/Blasts/Blast(locate(src.x, src.y, src.z))    // Create it to your left if you're faced left.
					S.icon_state = "left"

					if( src.MaxShots >= 8 )
						S1 = new /obj/Blasts/Blast(locate(src.x, src.y, src.z))    // Create it to your right if you're faced right.
						S1.icon_state = "left"
						S2 = new /obj/Blasts/Blast(locate(src.x, src.y, src.z))    // Create it to your right if you're faced right.
						S2.icon_state = "left"
						S3 = new /obj/Blasts/Blast(locate(src.x, src.y, src.z))    // Create it to your right if you're faced right.
						S3.icon_state = "left"
						S4 = new /obj/Blasts/Blast(locate(src.x, src.y, src.z))    // Create it to your right if you're faced right.
						S4.icon_state = "left"
						S5 = new /obj/Blasts/Blast(locate(src.x, src.y, src.z))    // Create it to your right if you're faced right.
						S5.icon_state = "left"
						S6 = new /obj/Blasts/Blast(locate(src.x, src.y, src.z))    // Create it to your right if you're faced right.
						S6.icon_state = "left"
						S7 = new /obj/Blasts/Blast(locate(src.x, src.y, src.z))    // Create it to your right if you're faced right.
						S7.icon_state = "left"
					switch( src.Class )
						if("AirPantheon")
							if(src.XeronFling == 0)
								S1 = new /obj/Blasts/Blast(locate(src.x, src.y, src.z))    // Create it to your right if you're faced right.
								S1.icon_state = "left"
								S2 = new /obj/Blasts/Blast(locate(src.x, src.y, src.z))    // Create it to your right if you're faced right.
								S2.icon_state = "left"
						#ifdef INCLUDED_HDK_DM
						if("HDK")
							S1 = new /obj/Blasts/Blast(locate(src.x, src.y, src.z))    // Create it to your right if you're faced right.
							S1.icon_state = "left"
							S2 = new /obj/Blasts/Blast(get_step( src, NORTH ))    // Create it to your right if you're faced right.
							S2.icon_state = "left"
							S3 = new /obj/Blasts/Blast(get_step( src, NORTH ))    // Create it to your right if you're faced right.
							S3.icon_state = "left"
							S4 = new /obj/Blasts/Blast(get_step( src, SOUTH ))    // Create it to your right if you're faced right.
							S4.icon_state = "left"
							S5 = new /obj/Blasts/Blast(get_step( src, SOUTH ))    // Create it to your right if you're faced right.
							S5.icon_state = "left"
						#endif
						if("Ragnarok")
							S1 = new /obj/Blasts/Blast(locate(src.x, src.y, src.z))    // Create it to your right if you're faced right.
							S1.icon_state = "right"
						if("Wolfang")
							if(src.icon_state=="clingleft")
								S1 = new /obj/Blasts/Blast(get_step( src, NORTH ))    // Create it to your right if you're faced right.
								S1.icon_state = "left"
								S2 = new /obj/Blasts/Blast(get_step( src, SOUTH ))    // Create it to your right if you're faced right.
								S2.icon_state = "left"
			var/Attack = src.Attack+src.AttackBuff
			var/Owner = src.key
			#ifdef INCLUDED_AI_DM
			if( istype( src, /mob/Entities/AIs ) )
				Owner = src.name
			#endif
			S.icon = src.BulletIcon;S.Owner = Owner
			S.pixel_y = src.pixel_y
			if(src.Class == "ModelS")

				switch(rand(1,3))
					if(1)
						if( !isnull( S ) )
							S.icon='MSShot1.dmi'
							S.pixel_y = src.pixel_y+11
					if(2)
						if( !isnull( S ) )
							if(ActionUse[AOE]==1)
								S.icon='MSShot1.dmi';S.pixel_y = src.pixel_y+11
							else
								S.icon='MSShot2.dmi';S.pixel_y = src.pixel_y+2
					if(3)
						if( !isnull( S ) )
						{
							S.icon='MSShot3 1.dmi'
							Attack = 28
							if(src.Attack < 28)
								Attack = rand(1,4)+src.AttackBuff
							S.Damage = Attack
							for(var/X in typesof(/obj/Projectiles/MSShot3)) S.overlays+=X
							S.pixel_y = src.pixel_y+11
							}
			S.Damage = Attack;
			switch(src.XeronFling)
				if(1)
					if( !isnull( S ) )
						S.icon_state = "up"
						switch( src.Class )
							if("Kraft") S.icon_state = "up[src.icon_state]"
							if("Foxtar")
								if( !isnull( S ) ) S.icon='CubitShots2.dmi'
							if("ModelC")
								S1 = new /obj/Blasts/Blast(locate(src.x, src.y, src.z))    // Create it to your right if you're faced right.
								S1.icon_state = "left"
								S2 = new /obj/Blasts/Blast(locate(src.x, src.y, src.z))    // Create it to your right if you're faced right.
								S2.icon_state = "right"
								S3 = new /obj/Blasts/Blast(locate(src.x, src.y, src.z))    // Create it to your right if you're faced right.
								S3.icon_state = "upleft"
								S4 = new /obj/Blasts/Blast(locate(src.x, src.y, src.z))    // Create it to your right if you're faced right.
								S4.icon_state = "upright"
								if( !isnull( S1 ) ) S1.Damage = Attack;S1.icon = src.BulletIcon;S1.Owner = Owner;S1.pixel_y=src.pixel_y
								if( !isnull( S2 ) ) S2.Damage = Attack;S2.icon = src.BulletIcon;S2.Owner = Owner;S2.pixel_y=src.pixel_y
								if( !isnull( S3 ) ) S3.Damage = Attack;S3.icon = src.BulletIcon;S3.Owner = Owner
								if( !isnull( S4 ) ) S4.Damage = Attack;S4.icon = src.BulletIcon;S4.Owner = Owner
							if("Cliff")
								S1 = new /obj/Blasts/Blast(locate(src.x, src.y, src.z))    // Create it to your right if you're faced right.
								S1.icon_state = "left"
								S2 = new /obj/Blasts/Blast(locate(src.x, src.y, src.z))    // Create it to your right if you're faced right.
								S2.icon_state = "right"
								S3 = new /obj/Blasts/Blast(locate(src.x, src.y, src.z))    // Create it to your right if you're faced right.
								S3.icon_state = "upleft"
								S4 = new /obj/Blasts/Blast(locate(src.x, src.y, src.z))    // Create it to your right if you're faced right.
								S4.icon_state = "upright"
								if( !isnull( S1 ) ) S1.Damage = Attack;S1.icon = src.BulletIcon;S1.Owner = Owner;S1.pixel_y=src.pixel_y
								if( !isnull( S2 ) ) S2.Damage = Attack;S2.icon = src.BulletIcon;S2.Owner = Owner;S2.pixel_y=src.pixel_y
								if( !isnull( S3 ) ) S3.Damage = Attack;S3.icon = src.BulletIcon;S3.Owner = Owner
								if( !isnull( S4 ) ) S4.Damage = Attack;S4.icon = src.BulletIcon;S4.Owner = Owner
				if(2)
					if( !isnull( S ) )
						S.icon_state = "down"
						switch(src.Class)
							if("Kraft", "AirPantheon")
								if( !isnull( S ) )
									S.icon_state = "down[src.icon_state]"
							if("Cliff")
								S1 = new /obj/Blasts/Blast(locate(src.x, src.y, src.z))    // Create it to your right if you're faced right.
								S1.icon_state = "left"
								S2 = new /obj/Blasts/Blast(locate(src.x, src.y, src.z))    // Create it to your right if you're faced right.
								S2.icon_state = "right"
								S3 = new /obj/Blasts/Blast(locate(src.x, src.y, src.z))    // Create it to your right if you're faced right.
								S3.icon_state = "downleft"
								S4 = new /obj/Blasts/Blast(locate(src.x, src.y, src.z))    // Create it to your right if you're faced right.
								S4.icon_state = "downright"
								S5 = new /obj/Blasts/Blast(locate(src.x, src.y, src.z))    // Create it to your right if you're faced right.
								S5.icon_state = "upleft"
								S6 = new /obj/Blasts/Blast(locate(src.x, src.y, src.z))    // Create it to your right if you're faced right.
								S6.icon_state = "upright"
								S7 = new /obj/Blasts/Blast(locate(src.x, src.y, src.z))    // Create it to your right if you're faced right.
								S7.icon_state = "up"
								if( !isnull( S1 ) ) S1.Damage = Attack;S1.icon = src.BulletIcon;S1.Owner = Owner;S1.pixel_y=src.pixel_y
								if( !isnull( S2 ) ) S2.Damage = Attack;S2.icon = src.BulletIcon;S2.Owner = Owner;S2.pixel_y=src.pixel_y
								if( !isnull( S3 ) ) S3.Damage = Attack;S3.icon = src.BulletIcon;S3.Owner = Owner
								if( !isnull( S4 ) ) S4.Damage = Attack;S4.icon = src.BulletIcon;S4.Owner = Owner
								if( !isnull( S5 ) ) S5.Damage = Attack;S5.icon = src.BulletIcon;S5.Owner = Owner;S5.pixel_y=src.pixel_y
								if( !isnull( S6 ) ) S6.Damage = Attack;S6.icon = src.BulletIcon;S6.Owner = Owner;S6.pixel_y=src.pixel_y
								if( !isnull( S7 ) ) S7.Damage = Attack;S7.icon = src.BulletIcon;S7.Owner = Owner
			if( !isnull( S ) )
				switch( src.Class )
					if("Knightman") S.pixel_y = src.pixel_y+9
					if("ModelC","Protoman","Valnaire") S.pixel_y = src.pixel_y+5
					if("Bass","Cutman","SaX","CMX") S.pixel_y = src.pixel_y+10
					if("Megaman","Axl") S.pixel_y = src.pixel_y+4
					if("FAX","Fefnir","Leviathen","Mijinion") S.pixel_y = src.pixel_y+12
					if("Vile","Wolfang") S.pixel_y = src.pixel_y+8
				#ifdef INCLUDED_MAGMA_DM
					if("Magma") S.pixel_y = src.pixel_y+14
				#endif
					if("Grenademan","Foxtar") S.pixel_y = src.pixel_y+20
					if("Shadowman") S.pixel_y = src.pixel_y+17
					if("CX") S.pixel_y=src.pixel_y-3
					if("CZero") S.pixel_y=src.pixel_y-4
					if("Met") S.pixel_y = src.pixel_y-10
					if("Shelldon") S.pixel_y=src.pixel_y+16
					if("PSX") S.pixel_y=src.pixel_y+18
				#ifdef INCLUDED_SHADOWMANEXE_DM
					if("ShadowmanEXE") S.pixel_y=src.pixel_y+23
				#endif
					if("Xeron") S.pixel_y=src.pixel_y+11
					if("Ragnarok") S.pixel_y=src.pixel_y+28
					if("Model X") S.pixel_y=src.pixel_y+8
					if("MG400") S.pixel_y=src.pixel_y+17
					if("Cliff") S.pixel_y=src.pixel_y+10
					if("Woodman") S.pixel_y=src.pixel_y+8
					if("GAX") S.pixel_y = src.pixel_y+8
					if("AirPantheon") S.pixel_y = src.pixel_y+8
					if("ModelBD") S.pixel_y = src.pixel_y - 8
			if( src.MaxShots >= 8 )
				if(!isnull(S1)) S1.Damage = Attack;S1.icon = src.BulletIcon;S1.Owner = Owner;S1.pixel_y = S.pixel_y
				if(!isnull(S2)) S2.Damage = Attack;S2.icon = src.BulletIcon;S2.Owner = Owner;S2.pixel_y = S.pixel_y
				if(!isnull(S3)) S3.Damage = Attack;S3.icon = src.BulletIcon;S3.Owner = Owner;S3.pixel_y = S.pixel_y
				if(!isnull(S4)) S4.Damage = Attack;S4.icon = src.BulletIcon;S4.Owner = Owner;S4.pixel_y = S.pixel_y
				if(!isnull(S5)) S5.Damage = Attack;S5.icon = src.BulletIcon;S5.Owner = Owner;S5.pixel_y = S.pixel_y
				if(!isnull(S6)) S6.Damage = Attack;S6.icon = src.BulletIcon;S6.Owner = Owner;S6.pixel_y = S.pixel_y
				if(!isnull(S7)) S7.Damage = Attack;S7.icon = src.BulletIcon;S7.Owner = Owner;S7.pixel_y = S.pixel_y

				#ifdef INCLUDED_XERONII_DM
				if(src.Class== "XeronII" )
					for(var/X in typesof(/obj/Projectiles/XeronIIshot)) S1.overlays+=X
					S1.pixel_y = src.pixel_y+8

					for(var/X in typesof(/obj/Projectiles/XeronIIshot)) S2.overlays+=X
					S2.pixel_y = src.pixel_y+8

					for(var/X in typesof(/obj/Projectiles/XeronIIshot)) S3.overlays+=X
					S3.pixel_y = src.pixel_y+8
					for(var/X in typesof(/obj/Projectiles/XeronIIshot)) S4.overlays+=X
					S4.pixel_y = src.pixel_y+8

					for(var/X in typesof(/obj/Projectiles/XeronIIshot)) S5.overlays+=X
					S5.pixel_y = src.pixel_y+8

					for(var/X in typesof(/obj/Projectiles/XeronIIshot)) S6.overlays+=X
					S6.pixel_y = src.pixel_y+8
					for(var/X in typesof(/obj/Projectiles/XeronIIshot)) S7.overlays+=X
					S7.pixel_y = src.pixel_y+8
				#endif
			if( !isnull( S ) )
				switch( src.Class )
					if("AirPantheon")
						if(!isnull(S1))
							S1.Damage = Attack;S1.icon = src.BulletIcon;S1.Owner = Owner;S1.pixel_y = S.pixel_y
						if(!isnull(S2))
							S2.Damage = Attack;S2.icon = src.BulletIcon;S2.Owner = Owner;S2.pixel_y = S.pixel_y
					#ifdef INCLUDED_HDK_DM
					if("HDK")
						if(!isnull(S1)) S1.Damage = Attack;S1.icon = src.BulletIcon;S1.Owner = Owner;S1.pixel_y = S.pixel_y
						if(!isnull(S2)) S2.Damage = Attack;S2.icon = src.BulletIcon;S2.Owner = Owner;S2.pixel_y = S.pixel_y
						if(!isnull(S3)) S3.Damage = Attack;S3.icon = src.BulletIcon;S3.Owner = Owner;S3.pixel_y = S.pixel_y
						if(!isnull(S4)) S4.Damage = Attack;S4.icon = src.BulletIcon;S4.Owner = Owner;S4.pixel_y = S.pixel_y
						if(!isnull(S5)) S5.Damage = Attack;S5.icon = src.BulletIcon;S5.Owner = Owner;S5.pixel_y = S.pixel_y
					#endif
					if("Wolfang")
						if(src.climbing==1)
							if(!isnull(S) && !isnull(src))
								if(!isnull(S1) )
									S1.Damage = Attack;
									S1.icon = S.icon;
									S1.Owner = Owner;
									S1.pixel_y = src.pixel_y+8
								if(!isnull(S2) )
									S2.Damage = Attack;
									S2.icon = S.icon;
									S2.Owner = Owner;
									S2.pixel_y = src.pixel_y+8
					if("Ragnarok")
						if(!isnull(S1)) S1.Damage = Attack;S1.icon = src.BulletIcon;S1.Owner = Owner;S1.pixel_y=S.pixel_y
					if(  "DrWily" )
						S.pixel_y = src.pixel_y-16
					#ifdef INCLUDED_HEATNIX_DM
					if( "Heatnix")
						for(var/X in typesof(/obj/Projectiles/HeatnixShot)) S.overlays+=X
					#endif
					#ifdef INCLUDED_CHILLDRE_DM
					if( "Chilldre")
						for(var/X in typesof(/obj/Projectiles/ChilldreShot)) S.overlays+=X
						switch(S.icon_state)
							if("right") S.pixel_x=4
							if("left") S.pixel_x=-36
					#endif
					#ifdef INCLUDED_SOLCLOUD_DM
					if( "Solcloud")
						for(var/X in typesof(/obj/Projectiles/SolSlash)) S.overlays+=X
					#endif
					#ifdef INCLUDED_XERONII_DM
					if( "XeronII" )
						for(var/X in typesof(/obj/Projectiles/XeronIIshot)) S.overlays+=X
						S.pixel_y = src.pixel_y+8
					#endif
					#ifdef INCLUDED_ATHENA_DM
					if( "Athena")
						for(var/X in typesof(/obj/Projectiles/AthenaShot1)) S.overlays+=X
						switch(S.icon_state)
							if("right") S.pixel_x=48
							if("left") S.pixel_x=16
					#endif
					#ifdef INCLUDED_HANUMACHINE_DM
					if( "HanuMachine")
						for(var/X in typesof(/obj/Projectiles/AthenaShot1)) S.overlays+=X
						switch(S.icon_state)
							if("right") S.pixel_x=48
							if("left") S.pixel_x=16
					#endif
					#ifdef INCLUDED_ATHENAII_DM
					if("AthenaII")
						switch( S.icon_state )
							if("up", "down")
								for(var/X in typesof(/obj/Projectiles/AthenaShot3)) S.overlays+=X
								if( S.icon_state== "up")
									S.pixel_y=48;S.pixel_x=src.pixel_x+4
								if(S.icon_state== "down")
									S.pixel_y=-8;S.pixel_x=src.pixel_x+4
							else
								for(var/X in typesof(/obj/Projectiles/AthenaShot2)) S.overlays+=X
								switch(S.icon_state)
									if( "right")
										S.pixel_x=48;S.pixel_y=src.pixel_y+8
									if( "left")
										S.pixel_x=16;S.pixel_y=src.pixel_y+8
					#endif
					#ifdef INCLUDED_SJX_DM
					if( "SJX")
						for(var/X in typesof(/obj/Projectiles/SJXShot)) S.overlays+=X
						S.pixel_y=src.pixel_y+22
						switch( S.icon_state )
							if("right") S.pixel_x=10
							if("left") S.pixel_x=-34
					#endif
					if("Mijinion")
						switch( src.icon_state )
							if("right") S.pixel_x=32
							if("left") S.pixel_x=-32
					if("Kraft")
						switch( S.icon_state )
							if("right") S.pixel_x=18
							if("left") S.pixel_x=-18
					if("Leviathen")
						switch( src.icon_state )
							if("right") S.pixel_x=16
							if("left") S.pixel_x=-16
					#ifdef INCLUDED_MAGMA_DM
					if("Magma")
						for(var/X in typesof(/obj/Projectiles/MagmaShot)) S.overlays+=X
						S.pixel_x=16
					#endif
					#ifdef INCLUDED_SHELLDON_DM
					if("Shelldon")
						for(var/X in typesof(/obj/Projectiles/ShellShot)) S.overlays+=X
						if(S.icon_state=="right") S.pixel_x=32
					#endif
					#ifdef INCLUDED_PSX_DM
					if("PSX")
						for(var/X in typesof(/obj/Projectiles/PSXShot)) S.overlays+=X
						S.pixel_x=0
					#endif
					#ifdef INCLUDED_CMX_DM
					if("CMX")
						for(var/X in typesof(/obj/Projectiles/CMXShot)) S.overlays+=X
						if(S.icon_state=="left") S.pixel_x=-32
					#endif
					if("SaX")
						S.pixel_x=0
				switch(src.icon_state)
					if("rainleft", "rainright")
						S.Damage = 1*Multiplier
						S.icon = 'VileRain.dmi'
						switch( rand( 1, 3 ) )
							if( 1 )
								switch(S.icon_state)
									if("left") --S.x
									if("right") ++S.x
							if( 3 )
								--S.y

			if(!isnull(S)) spawn(1) S.BlastMove()    // Start your movement thing.
			else del S
			if(!isnull(S1)) spawn(1) S1.BlastMove()
			if(!isnull(S2)) spawn(1) S2.BlastMove()
			if(!isnull(S3)) spawn(1) S3.BlastMove()    // Start your movement thing.
			if(!isnull(S4)) spawn(1) S4.BlastMove()
			if(!isnull(S5)) spawn(1) S5.BlastMove()
			if(!isnull(S6)) spawn(1) S6.BlastMove()
			if(!isnull(S7)) spawn(1) S7.BlastMove()

	DNAShot()     // For shooting off your harming projectiles. Keep out of reach of children.
		if(src.icon_state==""||src.Dead==1){return}
		if(world.time - src.delay_time >= src.delay)    // A simple delay to keep you from macroing it tons.
			src.delay_time = world.time     // You could lengthen or shorten the delay simply by raising or lowering the mob's delay variable.
			var/obj/Blasts/Blast/S = new /obj/Blasts/Blast(locate(src.x, src.y, src.z))   // Make a new instance of a laser (but don't actually create it, yet)
			switch(src.icon_state)
				if("right")
					S.icon_state = "right"    // Set it's state (important not only for proper glitz, but for movement),
				if("left")
					S.icon_state = "left"
			S.ShootType = 2
			S.Damage = src.Attack
			S.Owner = src.key
			S.icon = src.BulletIcon

			S.BlastMove()    // Start your movement thing.
			return
	Bomb()     // For shooting off your harming projectiles. Keep out of reach of children.
		if(src.icon_state==""||src.Dead==1){return}
		if(world.time - src.delay_time >= src.delay)    // A simple delay to keep you from macroing it tons.
			src.delay_time = world.time     // You could lengthen or shorten the delay simply by raising or lowering the mob's delay variable.
			var/obj/Blasts/Blast/S = new /obj/Blasts/Blast(locate(src.x, src.y, src.z))
			S.icon_state="down"
			S.Owner = src.key
			S.Damage = src.Attack
			S.icon = 'Bomb.dmi'

			S.BlastMove()
			return

	WaveShotAfter()
		if(src.icon_state==""||src.Dead==1){return}
		if(world.time - src.delay_time >= src.delay)    // A simple delay to keep you from macroing it tons.
			src.delay_time = world.time     // You could lengthen or shorten the delay simply by raising or lowering the mob's delay variable.
			var/obj/Blasts/Blast/S = new /obj/Blasts/Blast(locate(src.x, src.y, src.z))
			switch(src.Type)
				if(1) S.icon_state="up"
				if(2) S.icon_state="up2"
			S.Owner = src.Owner
			S.Damage = 2
			S.icon = 'Athena Shot4.dmi'
			S.BlastMove()
			return
	Admin_Grab()
		NULL_R(src)
		if(src.Dead == 1||ModeratorList[src.key] == "Moderator") return
		var/Timer = 40
		var/Delay = 200

		if(ModeratorList[src.key] == "Admin"||isSAdmin(src))
			Timer = 0
			Delay = 0
		if(src.Slashing == 0)
			src.Slashing = 1
			if(src.icon_state != "")
				flick("grab[src.icon_state]", src)
				if(src.icon_state=="right"||src.dir==EAST)
					for(var/mob/Entities/M in locate(src.x+1,src.y,src.z))
						NULL_C(M)
						#ifdef INCLUDED_RANDOMNESS_DM
						if(M.Class == "Randomness") continue
						#endif
						M.icon_state="left"
						M.density = 1
						M.Guard = 0
						for(var/Z in typesof("/obj/Characters/Team/[lowertext(M.Stats[c_Team])]")) M.overlays+=Z
						if(M.Class == "Vile") M.Flight = 0
						isClimbing(M)
						if(M.Class == "Plague" && M.Teleporting == 1)
							M.PlagueWallStick()
						M.isLockedBy = src.key
						src.hasLocked = M.key
						if(isSAdmin(src)) M.islocked = 1
						src<<src.hasLocked
						if(Timer>0)
							spawn(Timer)
							NULL_R(M)
							M.isLockedBy = null
							src.hasLocked = null
				if(src.icon_state=="left"||src.dir==WEST)
					for(var/mob/Entities/M in locate(src.x-1,src.y,src.z))
						NULL_C(M)
						#ifdef INCLUDED_RANDOMNESS_DM
						if(M.Class == "Randomness") continue
						#endif
						M.icon_state="right"
						M.density = 1
						M.Guard = 0
						for(var/Z in typesof("/obj/Characters/Team/[lowertext(M.Stats[c_Team])]")) M.overlays+=Z
						if(M.Class == "Vile") M.Flight = 0
						isClimbing(M)
						if(M.Class == "Plague" && M.Teleporting == 1)
							M.PlagueWallStick()
						M.isLockedBy = src.key
						src.hasLocked = M.key
						src<<src.hasLocked
						if(isSAdmin(src)) M.islocked = 1
						if(Timer>0)
							spawn(Timer)
							NULL_R(M)
							M.isLockedBy = null
							src.hasLocked = null

		else
			for(var/mob/Entities/M in world)
				if(M.isLockedBy == src.hasLocked)
					M.isLockedBy = null
					src.hasLocked = null
			sleep(Delay)
			src.Slashing = 0
	ZanzibarSpinSlash()
		if(isnull(src)||src.inscene ==1 || src.Slashing==1||src.Dead==1) return // Error handler, also spam handler
		if(Drain_fromUse(1, src) == 0) return
		src.Slashing = 1

		sleep(1)
		if(isnull(src)||src.inscene ==1 ||src.Dead==1) return // Error handler, also spam handler
		flick("smash[src.icon_state]",src)
		switch( src.icon_state )
			if("right")
				var/iMAX = 4
				for(var/i= 0 to iMAX)
					sleep(1)
					var/turf/_aturf = get_step(src, EAST)
					if( isnull( _aturf ) || _aturf.density==1) break;
					for(var/mob/M in oview(2))
						if(src.Dead == 1||isnull(src)) break
						if(M.x <= src.x || istype(M, /mob/AW2)) continue
						if(istype(M, /mob/Entities) )
							if( M.key == src.key || M.inscene == 1 || M.Guard > 0 || getBarrier_Blast(M) != 0 || M.Class == "Zombie" || M.x != src.x+1 || M.y != src.y) continue
							//	sleep(1)
							Smash_Hit(M,src)
						else if(istype(M, /mob/Entities/PTB)) Smash_Hit(M,src)
						else continue
					step(src,EAST)
					step(src,EAST)

			if("left")

				var/iMAX = 4
				for(var/i= 0 to iMAX)
					sleep(1)
					var/turf/_aturf = get_step(src, WEST)
					if( isnull( _aturf ) || _aturf.density==1) break;
					for(var/mob/M in oview(2))
						if(src.Dead == 1||isnull(src)) break
						if(M.x >= src.x || istype(M, /mob/AW2)) continue
						if(istype(M, /mob/Entities) )
							if( M.key == src.key || M.inscene == 1 || M.Guard > 0 || getBarrier_Blast(M) != 0 || M.Class == "Zombie" || M.x != src.x-1 || M.y != src.y) continue

							//	sleep(1)
							Smash_Hit(M,src)
						else if(istype(M, /mob/Entities/PTB)) Smash_Hit(M,src)
						else continue
					step(src,WEST)
					step(src,WEST)
		sleep(20)
		src.Slashing=0
	HanuTransform()
		if(isnull(src)||src.inscene ==1 || src.Slashing==1||src.Dead==1) return // Error handler, also spam handler
		if(Drain_fromUse(1, src) == 0) return
		src.Slashing=1
		var/Range = 3
		var/Delay = 2
		var/Delay1 = 3
		var/Delay2 = 50
		var/Delay3 = 40

		sleep(Delay)
		flick("smash[src.icon_state]",src)
		for(var/mob/Entities/M in oview(Range, src))
			if( isnull( M ) || M.Guard > 2 || M.key == src.key || M.Dead == 1 || M.Playing == 0 ) continue;
			if( isnull( src )) break
			if(M.Stats[c_Team]!=src.Stats[c_Team]||M.Stats[c_Team]=="N/A")
				if(M.Class=="Leviathen"&&M.icon_state=="guardright"||M.Class=="Leviathen"&&M.icon_state=="guardleft") continue
				isClimbing( M )
				Smash_Hit(M,src)
		sleep(Delay1)
		if(src.Dead == 1)
			src.Slashing = 0
			return
		for(var/A in typesof(/obj/Characters/HanuMachine)) src.overlays-=A
		for(var/B in typesof(/obj/Characters/HanuFireball)) src.overlays+=B
		src.icon = 'HanuFireball.dmi'
		src.Class = "HanuFireball"
		src.DefenseBuff+=3
		src.Flight = 1
		src.MoveDelay = 0
		if(!Bosses.Find(src.key) && !TeamLeaders.Find(src.key)) src.Attack=1
		sleep(Delay2)
		if(src.Class == "HanuFireball")
			for(var/A in typesof(/obj/Characters/HanuFireball)) src.overlays-=A
			for(var/B in typesof(/obj/Characters/HanuMachine)) src.overlays+=B
			src.icon = 'HanuMachine.dmi'
			src.Class = "HanuMachine"
			src.Flight = 0
			src.MoveDelay = 2
			if(src.DefenseBuff > 0)
				src.DefenseBuff-=3
			if(src.Attack!=28) src.Attack=2
		sleep(Delay3)
		src.Slashing=0
		return
	RushingStrike()
		if(isnull(src)) return
		if(src.Teleporting==1||src.Shooting==1||src.Dashing==1||src.Dead==1) return
		if(Drain_fromUse(1, src) == 0) return
		src.lock=1

		switch( src.icon_state )
			if("left")
				src.Dashing = 1
				sleep(1)
				if(isnull(src)) return
				flick("rushleft",src)
				for(var/i=1 to 7)
					sleep(1)
					if(isnull(src))
						return
					var/turf/aturf = get_step( src, WEST )  // Get the turf directly below you.
					var/dense = 0
					if(aturf)
						for(var/atom/A in aturf)
							if(A.density == 1) dense = 1;break
						if(aturf.density == 1) dense = 1
					if(!aturf) dense = 1
					switch( dense )
						if( 0 )
							step(src,WEST)
							step(src,WEST)
						if( 1 )
							for(var/mob/A in aturf)
								if(isnull(A)) continue
								if( isnull( src ) ) break;
								if(istype(A,/mob/Entities/Player)||istype(A,/mob/Entities/PTB))
									if(istype(A, /mob/Entities/Player)&&A.key!=src.key&&A.Guard<3&&getBarrier_Blast(A)==0)
										isDefending( A )
									if(src.Attack!=28) src.Attack=5
									Smash_Hit(A,src)
									if(src.Attack!=28) src.Attack=3
								if(istype(A,/mob/AW)||istype(A,/mob/GB))
									del A
								if(istype(A, /obj/Blasts))
									dense = 0
									del A
									continue
							step(src,EAST)
							switch( src.icon_state )
								if("left")
									src.dir=WEST
									src.icon_state="left"
								if("right")
									src.dir=EAST
									src.icon_state="right"
							break;
				src.lock=0
				sleep(7)
				if(isnull(src)) return
				src.Dashing = 0
				return
			if("right")
				src.Dashing = 1
				sleep(1)
				if(isnull(src))
					return
				flick("rushright",src)
				for(var/i=1 to 7)
					sleep(1)
					if(isnull(src))
						return
					var/turf/aturf = get_step( src, EAST )  // Get the turf directly below you.
					var/dense = 0
					if(aturf)
						for(var/atom/A in aturf)
							if(A.density == 1) dense = 1;break
						if(aturf.density == 1) dense = 1
					if(!aturf) dense = 1
					switch( dense )
						if(0)
							step(src,EAST)
							step(src,EAST)
						if(1)
							for(var/mob/A in aturf)
								if(isnull(A)) 	continue
								if( isnull( src ) ) break
								if(istype(A,/mob/Entities/Player)||istype(A,/mob/Entities/PTB))
									if(istype(A, /mob/Entities/Player)&&A.key!=src.key&&A.Guard<3&&getBarrier_Blast(A)==0)
										isDefending( A )
									if(src.Attack!=28) src.Attack=5
									Smash_Hit(A,src)
									if(src.Attack!=28) src.Attack=3
								if(istype(A,/mob/AW)||istype(A,/mob/GB))
									del A
								if(istype(A, /obj/Blasts))
									dense = 0
									del A
									continue
							step(src,WEST)
							switch( src.icon_state )
								if("left")
									src.dir=WEST
									src.icon_state="left"
								if("right")
									src.dir=EAST
									src.icon_state="right"
							break;
				src.lock=0
				sleep(7)
				if(isnull(src))
					return
				src.Dashing = 0
				return
	CliffDash()
		if(src.Teleporting==1||src.Shooting==1||src.Dashing==1||src.Dead==1||isnull( src ) ) return
		if(Drain_fromUse(1, src) == 0) return
		src.lock=1
		switch( src.icon_state )
			if( "left")
				src.Dashing = 1
				sleep(1)
				if( isnull( src ) ) return
				flick("dashleft",src)
				for(var/i=1 to 6)
					sleep(1)
					var/turf/aturf = get_step( src, WEST )  // Get the turf directly below you.
					var/dense = 0
					if(aturf)
						for(var/atom/A in aturf)
							if(A.density == 1) dense = 1;break
						if(aturf.density == 1) dense = 1
					if(!aturf) dense = 1
					switch( dense )
						if(0)
							step(src,WEST)
							step(src,WEST)
						if(1)
							for(var/mob/A in aturf)
								if( isnull( A ) ) continue;
								if( isnull( src ) ) return
								if(istype(A,/mob/Entities/Player)||istype(A,/mob/Entities/PTB))
									if(istype(A, /mob/Entities/Player)&&A.key!=src.key&&A.Guard<3&&getBarrier_Blast(A)==0)
										isDefending( A )
									if(src.Attack!=28) src.Attack=6
									Smash_Hit(A,src)
									if( isnull( A ) ) continue
									if( isnull( src ) ) return
									if(src.Attack!=28) src.Attack=4
									if(A.islocked==0)
										A.islocked=1
										spawn(1) src.Dashing=0
										LockCheck(A)
								if(istype(A,/mob/AW)||istype(A,/mob/GB))
									del A
							step(src,EAST)
							switch( src.icon_state )
								if("left")
									src.dir=WEST
									src.icon_state="left"
								if("right")
									src.dir=EAST
									src.icon_state="right"
							break
				src.lock=0
				sleep(7)
				if( isnull( src ) ) return
				src.Dashing = 0
				return
			if( "right")
				src.Dashing = 1
				sleep(1)
				if( isnull( src ) ) return
				flick("dashright",src)
				for(var/i=1 to 6)
					sleep(1)
					var/turf/aturf = get_step( src, EAST )  // Get the turf directly below you.
					var/dense = 0
					if(aturf)
						for(var/atom/A in aturf)
							if(A.density == 1) dense = 1;break
						if(aturf.density == 1) dense = 1
					if(!aturf) dense = 1
					switch( dense )
						if(0)
							step(src,EAST)
							step(src,EAST)
						if(1)
							for(var/mob/A in aturf)
								if( isnull( A ) ) continue
								if( isnull( src ) ) return
								if(istype(A,/mob/Entities/Player)||istype(A,/mob/Entities/PTB))
									if(istype(A, /mob/Entities/Player)&&A.key!=src.key&&A.Guard<3&&getBarrier_Blast(A)==0)
										isDefending( A )
									if(src.Attack!=28) src.Attack=6
									Smash_Hit(A,src)
									if( isnull( A ) ) continue
									if( isnull( src ) ) return
									if(src.Attack!=28) src.Attack=4
									if(A.islocked==0)
										A.islocked=1
										spawn(1) src.Dashing=0
										LockCheck(A)
								if(istype(A,/mob/AW)||istype(A,/mob/GB))
									del A
							step(src,WEST)
							switch( src.icon_state )
								if("left")
									src.dir=WEST
									src.icon_state="left"
								if("right")
									src.dir=EAST
									src.icon_state="right"
							break
				src.lock=0
				sleep(7)
				if( isnull( src ) ) return
				src.Dashing = 0
				return

	BusterFlare() // Xeron II
		if(src.Shooting==1||src.Slashing==1||src.Dead==1|| isnull( src ) ) return
		if(Drain_fromUse(1, src) == 0) return
		src.Slashing=1

		flick("flare[src.icon_state]", src)
		for( var/mob/M in oview(3) )
			NULL_C( M )
			NULL_R( src )
			var/bHit = 0;
			if(src.Attack<28) src.Attack=6
			switch( src.icon_state )
				if( "left" )
					if( M.x >= src.x ) continue
					bHit = 1
				if( "right" )
					if( M.x <= src.x ) continue
					bHit = 1
			if( bHit == 1 )
				Smash_Hit(M, src)
				NULL_C( M )
				NULL_R( src )
			if(src.Attack<28) src.Attack=4
		sleep(10)
		if( isnull( src ) ) return
		src.Slashing=0

	PlagueWallStick()
		if(src.Dashing==1||src.Shooting==1||src.Slashing==1||src.Dead==1||isnull( src ) ) return
		if(src.Teleporting==0)
			src.Teleporting=1
			sleep(2)
			if( isnull( src ) ) return
			flick("vanish[src.icon_state]",src)
			for(var/i=1 to 5)
				var/turf/aturf = get_step( src, NORTH )  // Get the turf directly below you.
				var/turf/aturf1 = locate(src.x, src.y, src.z)  // Get the turf directly below you.
				var/dense = 0
				if(aturf)
					for(var/atom/A in aturf)
						if(A.density == 1)
							dense = 0;
							break;
					if(aturf.density == 1)
						dense = 1
				if(!aturf)
					dense = 0
				if(aturf)
					if(dense == 1&&aturf1.density==0&&src.density==1)
						src.y=aturf.y-1
						switch( src.icon_state )
							if("left")
								src.icon_state="wallstickleft"
							if("right")
								src.icon_state="wallstickright"

						switch( get_WorldStatus(c_Map) )
							if(DESERT_TEMPLE)
								src.pixel_y=3
							if(SLEEPING_FOREST, WARZONE, BATTLEFIELD)
								src.pixel_y=4
							if(GROUND_ZERO)
								src.pixel_y=14
							else src.pixel_y=0
						src.climbing=1
						src.density=0
						src.nojump=1
						break
				if(src.density==1)
					step(src,NORTH)
			return
		if(src.Teleporting==1)
			src.Teleporting=0
			switch( src.icon_state )
				if("wallstickleft")
					src.icon_state="left"
					src.pixel_y=-16


					switch( get_WorldStatus(c_Map) )
						if(DESERT_TEMPLE)
							src.pixel_y=-3
						if(SLEEPING_FOREST, WARZONE, BATTLEFIELD)
							src.pixel_y=-4
						if(GROUND_ZERO)
							src.pixel_y=-14
				if("wallstickright")
					src.icon_state="right"
					src.pixel_y=-16
					switch( get_WorldStatus(c_Map) )
						if(DESERT_TEMPLE)
							src.pixel_y=-3
						if(SLEEPING_FOREST, WARZONE, BATTLEFIELD)
							src.pixel_y=-4
						if(GROUND_ZERO)
							src.pixel_y=-14
			src.nojump=0
			src.density=1
			src.climbing=0
			return
	PlagueDropSlash()
		if(src.Slashing==1||src.Shooting==1||src.Dead==1||isnull(src)) return
		if(Drain_fromUse(1, src) == 0) return
		src.Slashing=1
		src.density=1
		sleep(2)
		if( isnull( src ) ) return
		flick("vanishslash[src.icon_state]",src)
		switch( src.icon_state )
			if("right")
				for(var/i=0 to 4)
					if( isnull( src ) ) return
					step(src,NORTHEAST)
				src.icon_state="dropslashright"
			if("wallstickright")
				src.nojump=0
				src.climbing=0
				src.Teleporting=0
				src.density = 1
				src.icon_state="dropslashright"
			if("left")
				for(var/i=0 to 4)
					if( isnull( src ) ) return
					step(src,NORTHWEST)
				src.icon_state="dropslashleft"
			if("wallstickleft")
				src.nojump=0
				src.climbing=0
				src.Teleporting=0
				src.density = 1
				src.icon_state="dropslashleft"
		src.pixel_y=-16


		switch( get_WorldStatus(c_Map) )
			if(DESERT_TEMPLE)
				src.pixel_y=-3
			if(SLEEPING_FOREST, WARZONE, BATTLEFIELD)
				src.pixel_y=-4
			if(GROUND_ZERO)
				src.pixel_y=-14
		sleep(1)
		if( isnull( src ) ) return
		var/dense = 0
		while(dense==0&&src.Slashing==1)
			var/turf/spot = get_step( src, SOUTH )
			if(spot)
				for(var/atom/A in spot)
					if(A.density == 1)
						dense = 1
				if(dense == 0 && spot.density == 0)
					sleep(1)
					step(src,SOUTH)
				else
					for(var/mob/M in oview(3, src.loc))
						if( isnull( M ) || M.Guard >=3 || getBarrier_Blast(M) == 1) continue
						NULL_R( src )
						if(ActionUse[AOE]!=1) Smash_Hit(M,src)
					for(var/mob/N in oview(2, src.loc))
						if( isnull( N ) || N.Guard >=3 || getBarrier_Blast(N) == 1 || N.y > src.y) continue
						NULL_R( src )

				switch( src.icon_state )
					if("dropslashright")
						src.icon_state="right"
					if("dropslashleft")
						src.icon_state="left"
				sleep( 1 )
				if( isnull( src ) ) return
				src.Slashing=0
			else
				switch( src.icon_state )
					if("dropslashright")
						src.icon_state="right"
					if("dropslashleft")
						src.icon_state="left"
				sleep( 1 )
				if( isnull( src ) ) return
				src.Slashing=0
				dense = 1
	ZombieArmPierce()
		if(src.Shooting==1||src.Teleporting==0||src.Dead==1||isnull( src )) return
		if(src.Slashing==0)
			if(Drain_fromUse(1, src) == 0) return;
			src.Slashing=1
			switch( src.icon_state )
				if("sandright")
					flick("armpeirceright",src)
					src.icon_state="armright"
				if("sandleft")
					flick("armpeirceleft",src)
					src.icon_state="armleft"
			var/mob/ZIW/P1 = new
			var/mob/ZIW/P2 = new
			P1.Owner = "[src.key]"
			P2.Owner = "[src.key]"
			P1.loc=get_step( src, NORTH )
			P2.loc=locate(src.x,src.y+2,src.z)
			switch( src.icon_state )
				if("armleft")
					P1.Types="left1"
					P2.Types="left1"
				if("armright")
					P1.Types="right1"
					P2.Types="right1"
			src.BarrierUP=1
			src.density=1
			src.Guard=4
			for(var/mob/M in view(3, src.loc))
				if( isnull( M ) ) return
				if( isnull( src ) ) return
				if(M.x==src.x&&M.y>=src.y)
					if(istype(M, /mob/Entities/Player)||istype(M, /mob/Entities/PTB))
						M.KilledBy=src.key
						if(istype(M, /mob/Entities/Player)&&M.key!=src.key)
							M.life -= src.Attack*Multiplier
							M.Update()
						else if(istype(M, /mob/Entities/PTB))
							M.life -= src.Attack*Multiplier
						flickHurt(M)
						if(M.life <= 0)
							Death(M)
					else if(istype(M, /mob/AWB)||istype(M, /mob/AW)||istype(M, /mob/GB))
						del M
		else
			src.Guard=0
			src.density=0
			if(src.BarrierUP == 1)
				for(var/mob/ZIW/G)
					if(G.Owner == src.key)
						del G
				src.BarrierUP=0
			switch( src.icon_state )
				if("armright", "brokenarmright")
					flick("recallarmright",src)
					src.icon_state="sandright"
				if("armleft", "brokenarmleft")
					flick("recallarmleft",src)
					src.icon_state="sandleft"
			src.Slashing=0

	ZombieDive()
		if(src.Shooting==1||src.Slashing==1||src.Dead==1||isnull(src)) return
		if(src.Teleporting==1)
			if(Drain_fromUse(1, src) == 0) return;
			var/turf/aturf = locate(src.x, src.y, src.z)  // Get the turf directly below you.
			if(aturf)
				if(aturf.density==0)
					switch( src.icon_state )
						if("sandright")
							flick("riseright",src)
							src.icon_state="right"
						if("sandleft")
							flick("riseleft",src)
							src.icon_state="left"
					src.density=1
					src.nojump=0
					src.Teleporting=0
					for(var/Z in typesof("/obj/Characters/Team/[lowertext(src.Stats[c_Team])]")) src.overlays+=Z
					return
		else
			var/turf/aturf = locate(src.x, src.y-1, src.z)  // Get the turf directly below you.
			if(aturf)
				if(aturf.density==1)
					src.Teleporting=1
					src.density=0
					src.nojump=1
					flick("dive[src.icon_state]",src)
					src.icon_state="sand[src.icon_state]"
					for(var/Z in typesof("/obj/Characters/Team/[lowertext(src.Stats[c_Team])]")) src.overlays-=Z
					if(src.Disguised==1||src.hasFlag==1) src.density=1
	ZombieLunge()
		if(src.Dead==1||src.Shooting==1) return
		if(src.Teleporting==1)
			if(Drain_fromUse(1, src) == 0) return;
			src.Shooting=1
			sleep(2)
			if( isnull( src ) ) return
			switch( src.icon_state )
				if("sandright")
					flick("sandgrabright",src)
					for(var/mob/Entities/M in view(2, src.loc))
						if( isnull( M ) ) continue
						if( isnull( src ) ) return
						if(M.key!=src.key && M.y>=src.y && M.x==src.x)
							src.icon_state="sandgrabedright"
							M.icon_state="left"
							M.islocked=1
							M.density=1
							for(var/i=0 to 4)
								if(isnull( M ) ) break
								if( isnull( src ) ) return
								sleep(10)
								if( isnull( src ) ) return
								if(src.Attack==28)
									M.life-=src.Attack
								else M.life-=1*Multiplier
								M.KilledBy = src.key
								flickHurt(M)
								M.Update()
								if(M.life <= 0)
									Death(M)
									src.icon_state="sandright"
									src.Shooting=0
									break
							src.icon_state="sandright"
							if(!isnull(M)) M.islocked=0
				if("sandleft")
					flick("sandgrableft",src)
					for(var/mob/Entities/M in view(2, src.loc))
						if(isnull( M ) ) break
						if( isnull( src ) ) return
						if(M.key!=src.key&&M.y>=src.y&&M.x==src.x)
							src.icon_state="sandgrabbedleft"
							M.icon_state="right"
							M.islocked=1
							M.density=1
							for(var/i=0 to 5)
								if(isnull( M ) ) break
								if( isnull( src ) ) return
								sleep(10)
								if( isnull( src ) ) return
								if(src.Attack==28)
									M.life-=src.Attack
								else M.life-=1*Multiplier
								M.KilledBy = src.key
								flickHurt(M)
								if(M.life <= 0)
									Death(M)
									src.icon_state="sandleft"
									src.Shooting=0
									break
							src.icon_state="sandleft"
							if(!isnull(M)) M.islocked=0
			sleep(1)
			if( isnull( src ) ) return
			src.Shooting=0
			return
		else
			src.Shooting=1
			sleep(2)
			if( isnull( src ) ) return
			switch( src.icon_state )
				if("right")
					src.icon_state="lungeright"
					for(var/b = 1 to 4)
						if( isnull( src ) ) return
						sleep(1)
						if( isnull( src ) ) return
						step(src,EAST)
						for(var/mob/Entities/amob in view(1, src.loc))
							if( isnull( amob ) ) continue
							if( isnull(src) ) return
							if(amob.density==1&&amob.y==src.y&&amob.x==src.x+1)
								b=4
								src.icon_state="grabbedright"
								amob.icon_state="left"
								amob.islocked=1
								amob.density=1
								for(var/i= 0 to 4)
									if( isnull( src ) ) return
									if(amob)
										sleep(10)
										if( isnull( src ) ) return
										if(src.Attack==28)
											amob.life-=src.Attack
										else amob.life-=1*Multiplier
										amob.KilledBy = src.key
										flickHurt(amob)
										if(amob.life <= 0)
											Death(amob)
											src.Shooting=0
											src.icon_state="right"
											break
								if(!isnull(amob)) amob.islocked=0
					src.icon_state="right"
				if("left")
					src.icon_state="lungeleft"
					for(var/b = 1 to 4)
						if( isnull( src ) ) return
						sleep(1)
						if( isnull( src ) ) return
						step(src,WEST)
						for(var/mob/Entities/amob in view(1, src.loc))
							if( isnull( amob ) ) continue
							if( isnull( src ) ) return
							if(amob.density==1&&amob.y==src.y&&amob.x==src.x-1)
								b=4
								src.icon_state="grabbedleft"
								amob.icon_state="right"
								amob.islocked=1
								amob.density=1
								for(var/i=0 to 4)
									if( isnull( src ) ) return
									if(amob)
										sleep(10)
										if( isnull( src ) ) return
										if(src.Attack==28)
											amob.life-=src.Attack
										else amob.life-=1*Multiplier
										amob.life-=1*Multiplier
										amob.KilledBy = src.key
										flickHurt(amob)
										if(amob.life <= 0)
											Death(amob)
											src.Shooting=0
											src.icon_state="left"
											break
								if(!isnull(amob)) amob.islocked=0
					src.icon_state="left"
			sleep(1)
			if( isnull( src ) ) return
			src.Shooting=0
			return
	LWXPunch()
		if(src.Teleporting==1||src.Shooting==1||src.Dead==1||isnull( src )) return
		if(src.Slashing==1)
			if(Drain_fromUse(1, src) == 0)
				src.Slashing = 0;
				switch(src.icon_state)
					if("grabbedright") src.icon_state="right"
					if("grabbedleft") src.icon_state="left"
				return;
			sleep(3)
			if( isnull( src ) ) return
			switch( src.icon_state )
				if("grabbedright")
					flick("punchright",src)
					for(var/mob/Entities/M in oview(1))
						if( isnull( M ) ) continue
						if( isnull( src ) ) return;
						if(M.x==src.x-1&&M.islocked==1)
							if(src.Attack>=28)
								M.life-=src.Attack
							else M.life-=1*Multiplier
							M.KilledBy = src.key
							flickHurt(M)
							if(M.life <= 0)
								Death(M)
						src.Slashing=0
						src.icon_state="right"
				if("grabbedleft")
					flick("punchleft",src)
					for(var/mob/Entities/M in oview(1))
						if( isnull( M ) )continue;
						if( isnull( src ) ) return
						if(M.x==src.x-1&&M.islocked==1)
							if(src.Attack>=28)
								M.life-=src.Attack
							else M.life-=1*Multiplier
							M.KilledBy = src.key
							flickHurt(M)
							if(M.life <= 0)
								Death(M)
						src.Slashing=0
						src.icon_state="left"

	LWXUpThrow()
		if(src.Teleporting==1||src.Shooting==1||src.Dead==1||isnull(src)) return
		if(src.Slashing==1)
			if(Drain_fromUse(1, src) == 0)
				src.Slashing = 0;
				switch(src.icon_state)
					if("grabbedright") src.icon_state="right"
					if("grabbedleft") src.icon_state="left"
				return;
			switch( src.icon_state )
				if("grabbedright")
					flick("throwupright",src)
					for(var/mob/Entities/M in oview(1))
						if( isnull( M ) ) continue
						if( isnull( src ) ) return
						if(M.x==src.x+1&&M.islocked==1)
							M.loc=locate(src.x,src.y+1,src.z)
							for(var/i= 0 to 6)
								step(M,NORTH)
						if(M.x==src.x-1&&M.islocked==1)
							M.loc=locate(src.x,src.y+1,src.z)
							for(var/i= 0  to 6)
								step(M,NORTH)
						src.icon_state="right"
						src.Slashing=0
						if(M.Dead!=1)
							sleep(20)
							if( isnull( M ) ) continue
							if( isnull( src ) ) return
							M.islocked=0
				if("grabbedleft")
					flick("throwupleft",src)
					for(var/mob/Entities/M in oview(1))
						if( isnull( M ) ) continue
						if( isnull( src ) ) return
						if(M.x==src.x-1&&M.islocked==1)
							M.loc=locate(src.x,src.y+1,src.z)
							for(var/i= 0 to 6)
								step(M,NORTH)
						if(M.x==src.x+1&&M.islocked==1)
							M.loc=locate(src.x,src.y+1,src.z)
							for(var/i= 0 to 6)
								step(M,NORTH)
						src.icon_state="left"
						src.Slashing=0
						if(M&&M.Dead!=1)
							sleep(20)
							if( isnull( M ) ) continue
							if( isnull( src ) ) return
							M.islocked=0
	LWXThrow()
		if(src.Teleporting==1||src.Shooting==1||src.Dead==1||isnull( src )) return
		if(src.Slashing==1)
			if(Drain_fromUse(1, src) == 0)
				src.Slashing = 0;
				switch(src.icon_state)
					if("grabbedright") src.icon_state="right"
					if("grabbedleft") src.icon_state="left"
				return;
			switch( src.icon_state )
				if("grabbedright")
					flick("throwright",src)
					for(var/mob/Entities/M in oview(1))
						if( isnull( M ) ) continue
						if( isnull( src ) ) return
						isDefending( M )
						M.loc=locate(src.x+1,src.y,src.z)
						for(var/i= 0 to 4)
							if( isnull( M ) ) break
							if( isnull( src ) ) return
							step(M,EAST)
						src.icon_state="right"
						src.Slashing=0
						if(M.Dead!=1)
							sleep(20)
							if( isnull( M ) ) continue
							if( isnull( src ) ) return
							M.islocked=0
				if("grabbedleft")
					flick("throwleft",src)
					for(var/mob/Entities/M in oview(1))
						if( isnull( M ) ) continue
						if( isnull( src ) ) return
						isDefending( M )
						if(M.islocked==1)
							M.loc=locate(src.x-1,src.y,src.z)
							for(var/i= 0 to 4)
								if( isnull( M ) ) break
								if( isnull( src ) ) return
								step(M,WEST)
						src.icon_state="left"
						src.Slashing=0
						if(M.Dead!=1)
							sleep(20)
							if( isnull( M ) ) continue
							if( isnull( src ) ) return
							M.islocked=0
	LWXGrapple()
		if(src.Slashing==1||src.Shooting==1||src.Dead==1||isnull( src)) return
		if(Drain_fromUse(1, src) == 0)  return;
		src.Slashing=1
		flick("grapple[src.icon_state]",src)
		switch(src.icon_state)
			if("left")
				for(var/mob/Entities/M in oview(1))
					NULL_C(M)
					if(M.x >= src.x) continue
					if(M.Stats[c_Team] == src.Stats[c_Team] && M.Stats[c_Team] != "N/A") continue
					if(M.Class == "Zombie" || M.islocked != 0 || M.Guard >= 3) continue
					src.icon_state = "grabbed[src.icon_state]"
					if(M.icon_state == "")
						M.Flight = 0
						M.density = 1
						for(var/Z in typesof("/obj/Characters/Team/[lowertext(M.Stats[c_Team])]")) M.overlays+=Z
					M.icon_state="right"
					if( M.Class == "Vile" ) M.Flight = 0
					isClimbing( M )
					if( M.Class == "Plague" && M.Teleporting == 1 )
						M.PlagueWallStick()
					if(!Bosses.Find(M.key) && !TeamLeaders.Find(M.key) && M.key != ModeTarget)
						M.islocked=1
						sleep(40)
						NULL_B( M )
						M.islocked=0
					if(src.Slashing==1)
						src.icon_state="left"
						src.Slashing=0
						return
			if("right")
				for(var/mob/Entities/M in oview(1))
					NULL_C(M)
					if(M.x <= src.x) continue
					if(M.Stats[c_Team] == src.Stats[c_Team] && M.Stats[c_Team] != "N/A") continue
					if(M.Class == "Zombie" || M.islocked != 0 || M.Guard >= 3) continue
					src.icon_state = "grabbed[src.icon_state]"
					if(M.icon_state == "")
						M.Flight = 0
						M.density = 1
						for(var/Z in typesof("/obj/Characters/Team/[lowertext(M.Stats[c_Team])]")) M.overlays+=Z
					M.icon_state="left"
					if( M.Class == "Vile" ) M.Flight = 0
					isClimbing( M )
					if( M.Class == "Plague" && M.Teleporting == 1 )
						M.PlagueWallStick()
					if(!Bosses.Find(M.key) && !TeamLeaders.Find(M.key) && M.key != ModeTarget)
						M.islocked=1
						sleep(40)
						NULL_B( M )
						M.islocked=0
					if(src.Slashing==1)
						src.icon_state="right"
						src.Slashing=0
						return

		sleep(3)
		NULL_R(src)
		src.Slashing=0
		return
	LWXUpDash()
		NULL_R(src)
		if(src.Teleporting==1||src.Dead==1) return
		if(src.Teleporting==0)
			if(Drain_fromUse(1, src) == 0) return;
			src.Teleporting=1
			if(src.Slashing==1)
				switch( src.icon_state )
					if("grabbedleft")
						flick("teleportleft",src)
					if("grabbedright")
						flick("teleportright",src)
				for(var/i= 0 to 7)
					NULL_R(src)
					var/turf/aturf = get_step( src, NORTH )
					var/dense = 0
					if(aturf)
						for(var/atom/A in aturf)
							if(A.density == 1)
								dense = 0
								break
						if(aturf.density == 1)
							dense = 1
					if(!aturf)
						dense = 0
					if(aturf&&dense == 0)
						src.loc=locate(src.x, src.y+1, src.z)
						for(var/mob/Entities/M in oview(1))
							NULL_R(src)
							NULL_C(M)
							var/turf/bturf = get_step( M, NORTH )
							if(src.icon_state=="grabbedleft"&&M.x<=src.x-1&&M.islocked==1)
								if(bturf&&dense==0)
									M.loc=locate(M.x, M.y+1, M.z)
								step(M,NORTH)
							if(src.icon_state=="grabbedright"&&M.x>=src.x+1&&M.islocked==1)
								if(bturf&&dense==0)
									M.loc=locate(M.x, M.y+1, M.z)
								step(M,NORTH)
					step(src,NORTH)
				sleep(1)
				NULL_R(src)
				switch( src.icon_state )
					if("grabbedleft")
						flick("reformleft",src)
					if("grabbedright")
						flick("reformright",src)
			else
				flick("teleport[src.icon_state]",src)
				for(var/i= 0 to 7)
					NULL_R(src)
					var/atom/dest = get_step( src, NORTH )
					if(dest)
						var/dense = 0
						if( isturf(dest) )
							if( dest.density == 1 )
								dense = 1

						if(dense == 0)
							src.loc=dest
							step(src,NORTH)
				sleep(1)
				NULL_R(src)
				flick("reform[src.icon_state]",src)
			src.Teleporting=0
			return

//================================
/////////////////////////////////
/////////////////////////////////
/////////////////////////////////
//================================
	AthenaII_SpinShot()
		#ifdef INCLUDED_ATHENAII_DM
		NULL_R(src)
		if(src.Shooting==1||src.climbing==1||src.Dead==1) return
		if(Drain_fromUse(1, src) == 0) return;
		src.Shooting=1
		flick("fallingspin[src.icon_state]",src)
		if(world.time - src.delay_time >= src.delay)    // A simple delay to keep you from macroing it tons.
			src.delay_time = world.time     // You could lengthen or shorten the delay simply by raising or lowering the mob's delay variable.
			var/obj/Blasts/Blast
				S;S1;S2;S3;S4;S5;S6;S7;S8
			if(src.Dead==1) return
			S = new /obj/Blasts/Blast(locate(src.x, src.y, src.z))    // Create it to your right if you're faced right.
			S.icon_state = "up"
			S.Owner = src.key
			S.Damage = src.Attack
			S.icon = src.BulletIcon
			S.pixel_y = src.pixel_y
			for(var/X in typesof(/obj/Projectiles/AthenaShot3)) S.overlays+=X
			S.pixel_y=48;S.pixel_x=src.pixel_x+4
			S.BlastMove()
			sleep(1)
			if(src.Dead==1) return
			S1 = new /obj/Blasts/Blast(locate(src.x, src.y, src.z))    // Create it to your right if you're faced right.
			switch( src.icon_state )
				if("left") S1.icon_state = "upleft"
				if("right") S1.icon_state = "upright"
			S1.Owner = src.key
			S1.Damage = src.Attack
			S1.icon = src.BulletIcon
			S1.pixel_y = src.pixel_y
			for(var/X in typesof(/obj/Projectiles/AthenaShot4)) S1.overlays+=X

			if(S1.icon_state== "upright") S1.pixel_x=48;S1.pixel_x=src.pixel_x+4
			if(S1.icon_state== "upleft") S1.pixel_x=16;S1.pixel_x=src.pixel_x+4
			S1.BlastMove()
			sleep(1)
			if(src.Dead==1) return
			S2 = new /obj/Blasts/Blast(locate(src.x, src.y, src.z))    // Create it to your right if you're faced right.
			switch( src.icon_state )
				if("left") S2.icon_state = "left"
				if("right") S2.icon_state = "right"
			S2.Owner = src.key
			S2.Damage = src.Attack
			S2.icon = src.BulletIcon
			S2.pixel_y = src.pixel_y
			for(var/X in typesof(/obj/Projectiles/AthenaShot2)) S2.overlays+=X

			if(S2.icon_state== "right") S2.pixel_x=48;S2.pixel_y=src.pixel_y+8
			if(S2.icon_state== "left") S2.pixel_x=16;S2.pixel_y=src.pixel_y+8
			S2.BlastMove()
			sleep(1)
			if(src.Dead==1) return
			S3 = new /obj/Blasts/Blast(locate(src.x, src.y, src.z))    // Create it to your right if you're faced right.
			switch( src.icon_state )
				if("left") S3.icon_state = "downleft"
				if("right") S3.icon_state = "downright"
			S3.Owner = src.key
			S3.Damage = src.Attack
			S3.icon = src.BulletIcon
			S3.pixel_y = src.pixel_y
			for(var/X in typesof(/obj/Projectiles/AthenaShot4)) S3.overlays+=X

			if(S3.icon_state=="downright") S3.pixel_x=48;S3.pixel_x=src.pixel_x+4
			if(S3.icon_state=="downleft") S3.pixel_x=16;S3.pixel_x=src.pixel_x+4
			S3.BlastMove()
			sleep(1)
			if(src.Dead==1) return
			S4 = new /obj/Blasts/Blast(locate(src.x, src.y, src.z))    // Create it to your right if you're faced right.
			S4.icon_state = "down"
			S4.Owner = src.key
			S4.Damage = src.Attack
			S4.icon = src.BulletIcon
			for(var/X in typesof(/obj/Projectiles/AthenaShot3)) S4.overlays+=X
			S4.pixel_y = src.pixel_y
			S4.pixel_y=-8;S4.pixel_x=src.pixel_x+4
			S4.BlastMove()
			sleep(1)
			if(src.Dead==1) return
			S5 = new /obj/Blasts/Blast(locate(src.x, src.y, src.z))    // Create it to your right if you're faced right.
			switch( src.icon_state )
				if("left") S5.icon_state = "downright"
				if("right") S5.icon_state = "downleft"
			S5.Owner = src.key
			S5.Damage = src.Attack
			S5.icon = src.BulletIcon
			S5.pixel_y = src.pixel_y
			for(var/X in typesof(/obj/Projectiles/AthenaShot4)) S5.overlays+=X
			if(S5.icon_state=="downright") S5.pixel_x=48;S5.pixel_x=src.pixel_x+4
			if(S5.icon_state=="downleft") S5.pixel_x=16;S5.pixel_x=src.pixel_x+4
			S5.BlastMove()
			sleep(1)
			if(src.Dead==1) return
			S6 = new /obj/Blasts/Blast(locate(src.x, src.y, src.z))    // Create it to your right if you're faced right.
			switch( src.icon_state )
				if("left") S6.icon_state = "right"
				if("right") S6.icon_state = "left"
			S6.Owner = src.key
			S6.Damage = src.Attack
			S6.icon = src.BulletIcon
			S6.pixel_y = src.pixel_y
			for(var/X in typesof(/obj/Projectiles/AthenaShot2)) S6.overlays+=X
			if(S6.icon_state=="right") S6.pixel_x=48;S6.pixel_y=src.pixel_y+8
			if(S6.icon_state=="left") S6.pixel_x=16;S6.pixel_y=src.pixel_y+8
			S6.BlastMove()
			sleep(1)
			if(src.Dead==1) return
			S7 = new /obj/Blasts/Blast(locate(src.x, src.y, src.z))    // Create it to your right if you're faced right.
			switch( src.icon_state )
				if("left") S7.icon_state = "upright"
				if("right") S7.icon_state = "upleft"
			S7.Owner = src.key
			S7.Damage = src.Attack
			S7.icon = src.BulletIcon
			S7.pixel_y = src.pixel_y
			for(var/X in typesof(/obj/Projectiles/AthenaShot4)) S7.overlays+=X
			if(S7.icon_state=="upright") S7.pixel_x=48;S7.pixel_x=src.pixel_x+4
			if(S7.icon_state=="upleft") S7.pixel_x=16;S7.pixel_x=src.pixel_x+4
			S7.BlastMove()
			sleep(1)
			if(src.Dead==1) return
			S8 = new /obj/Blasts/Blast(locate(src.x, src.y, src.z))    // Create it to your right if you're faced right.
			S8.icon_state = "up"
			S8.Owner = src.key
			S8.Damage = src.Attack
			S8.icon = src.BulletIcon
			S8.pixel_y = src.pixel_y
			for(var/X in typesof(/obj/Projectiles/AthenaShot3)) S8.overlays+=X
			S8.pixel_y=48;S8.pixel_x=src.pixel_x+4
			S8.BlastMove()

		sleep(1)
		src.Shooting=0
		#endif

	Athena_FireWave()
		#ifdef INCLUDED_ATHENA_DM
		if(src.Teleporting == 1||src.Slashing==1||src.Dead==1||src.climbing==1) return
		if(Drain_fromUse(1, src) == 0) return;
		src.Teleporting=1
		flick("wave[src.icon_state]",src)
		var/mob/AWB/S = new
		var/mob/AWB/S1 = new
		var/mob/AWB/S2 = new
		var/mob/AWB/S3 = new
		var/mob/AWB/S4 = new
		var/mob/AWB/S5 = new
		S.Type=2;S1.Type=2;S2.Type=2;S3.Type=2;S4.Type=2;S5.Type=2
		var/D[6]
		for(var/i = 1 to 6)
			D[i]=0;
		switch( src.icon_state )
			if("left")
				if( isnull( src ) || isnull( src ) ) return
				var/turf
					T1=locate(src.x-1, src.y-1, src.z)
					T2=locate(src.x-2, src.y-1, src.z)
					T3=locate(src.x-3, src.y-1, src.z)
					T4=locate(src.x-4, src.y-1, src.z)
					T5=locate(src.x-5, src.y-1, src.z)
					T6=locate(src.x-6, src.y-1, src.z)
				var/turf
					R1
					R2
					R3
					R4
					R5
					R6
				if( !isnull( T1 ) )
					R1=locate(T1.x, src.y, src.z)
				if( !isnull( T2 ) )
					R2=locate(T2.x, src.y, src.z)
				if( !isnull( T3 ) )
					R3=locate(T3.x, src.y, src.z)
				if( !isnull( T4 ) )
					R4=locate(T4.x, src.y, src.z)
				if( !isnull( T5 ) )
					R5=locate(T5.x, src.y, src.z)
				if( !isnull( T6 ) )
					R6=locate(T6.x, src.y, src.z)
				if(T1&&T1.density==1&&R1&&R1.density==0&&src.Dead==0)
					S.loc=locate(R1.x, R1.y, R1.z)
					D[1]=1
					for(var/mob/M in S.loc)
						if( M.Guard != 0 \
						|| M.icon_state == "hide" \
						|| M.icon_state == "armleft"\
						|| M.icon_state == "armright"\
						|| M.icon_state == "brokenarmleft"\
						|| M.icon_state == "brokenarmright" ) continue
						M.life-=(src.Attack*2)*Multiplier
						M.KilledBy = src.key
						flickHurt(M)
						if(M.life <= 0)
							isTeamMate( M, src )
							Death(M)
				if(T2&&T2.density==1&&R2&&R2.density==0&&src.Dead==0)
					S1.loc=locate(R2.x, R2.y, src.z)
					D[2]=1
					for(var/mob/M in S1.loc)
						if(M.Guard==0&&M.icon_state!="hide"&&M.icon_state!="armleft"&&M.icon_state!="armright"&&M.icon_state!="brokenarmleft"&&M.icon_state!="brokenarmright")
							M.life-=(src.Attack*2)*Multiplier
							M.KilledBy = src.key
							flickHurt(M)
							if(M.life <= 0)
								isTeamMate( M, src )
								Death(M)
						else continue
				if(T3&&T3.density==1&&R3&&R3.density==0&&src.Dead==0)
					S2.loc=locate(R3.x, R3.y, src.z)
					D[3]=1
					for(var/mob/M in S2.loc)
						if(M.Guard==0&&M.icon_state!="hide"&&M.icon_state!="armleft"&&M.icon_state!="armright"&&M.icon_state!="brokenarmleft"&&M.icon_state!="brokenarmright")
							M.life-=(src.Attack*2)*Multiplier
							M.KilledBy = src.key
							flickHurt(M)
							if(M.life <= 0)
								isTeamMate( M, src )
								Death(M)
						else continue
				if(T4&&T4.density==1&&R4&&R4.density==0&&src.Dead==0)
					S3.loc=locate(R4.x, R4.y, src.z)
					D[4]=1
					for(var/mob/M in S3.loc)
						if(M.Guard==0&&M.icon_state!="hide"&&M.icon_state!="armleft"&&M.icon_state!="armright"&&M.icon_state!="brokenarmleft"&&M.icon_state!="brokenarmright")
							M.life-=(src.Attack*2)*Multiplier
							M.KilledBy = src.key
							flickHurt(M)
							if(M.life <= 0)
								isTeamMate( M, src )
								Death(M)
						else continue
				if(T5&&T5.density==1&&R5&&R5.density==0&&src.Dead==0)
					S4.loc=locate(R5.x, R5.y, src.z)
					D[5]=1
					for(var/mob/M in S4.loc)
						if(M.Guard==0&&M.icon_state!="hide"&&M.icon_state!="armleft"&&M.icon_state!="armright"&&M.icon_state!="brokenarmleft"&&M.icon_state!="brokenarmright")
							M.life-=(src.Attack*2)*Multiplier
							M.KilledBy = src.key
							flickHurt(M)
							if(M.life <= 0)
								isTeamMate( M, src )
								Death(M)
						else continue
				if(T6&&T6.density==1&&R6&&R6.density==0&&src.Dead==0)
					S5.loc=locate(R6.x, R6.y, src.z)
					D[6]=1
					for(var/mob/M in S5.loc)
						if(M.Guard==0&&M.icon_state!="hide"&&M.icon_state!="armleft"&&M.icon_state!="armright"&&M.icon_state!="brokenarmleft"&&M.icon_state!="brokenarmright")
							M.life-=(src.Attack*2)*Multiplier
							M.KilledBy = src.key
							flickHurt(M)
							if(M.life <= 0)
								isTeamMate( M, src )
								Death(M)
						else continue
			if("right")
				if( isnull( src ) || isnull( src ) ) return
				var/turf
					T1=locate(src.x+1, src.y-1, src.z)
					T2=locate(src.x+2, src.y-1, src.z)
					T3=locate(src.x+3, src.y-1, src.z)
					T4=locate(src.x+4, src.y-1, src.z)
					T5=locate(src.x+5, src.y-1, src.z)
					T6=locate(src.x+6, src.y-1, src.z)
				var/turf
					R1
					R2
					R3
					R4
					R5
					R6
				if( !isnull( T1 ) )
					R1=locate(T1.x, src.y, src.z)
				if( !isnull( T2 ) )
					R2=locate(T2.x, src.y, src.z)
				if( !isnull( T3 ) )
					R3=locate(T3.x, src.y, src.z)
				if( !isnull( T4 ) )
					R4=locate(T4.x, src.y, src.z)
				if( !isnull( T5 ) )
					R5=locate(T5.x, src.y, src.z)
				if( !isnull( T6 ) )
					R6=locate(T6.x, src.y, src.z)
				if(T1&&T1.density==1&&R1&&R1.density==0&&src.Dead==0)
					S.loc=locate(R1.x, R1.y, src.z)
					D[1]=1
					for(var/mob/M in S.loc)
						if(M.Guard==0&&M.icon_state!="hide"&&M.icon_state!="armleft"&&M.icon_state!="armright"&&M.icon_state!="brokenarmleft"&&M.icon_state!="brokenarmright")
							M.life-=(src.Attack*2)*Multiplier
							M.KilledBy = src.key
							flickHurt(M)
							if(M.life <= 0)
								isTeamMate( M, src )
								Death(M)
						else M.Guard=M.Guard
				if(T2&&T2.density==1&&R2&&R2.density==0&&src.Dead==0)
					S1.loc=locate(R2.x, R2.y, src.z)
					D[2]=1
					for(var/mob/M in S1.loc)
						if(M.Guard==0&&M.icon_state!="hide"&&M.icon_state!="armleft"&&M.icon_state!="armright"&&M.icon_state!="brokenarmleft"&&M.icon_state!="brokenarmright")
							M.life-=(src.Attack*2)*Multiplier
							M.KilledBy = src.key
							flickHurt(M)
							if(M.life <= 0)
								isTeamMate( M, src )
								Death(M)
						else M.Guard=M.Guard
				if(T3&&T3.density==1&&R3&&R3.density==0&&src.Dead==0)
					S2.loc=locate(R3.x, R3.y, src.z)
					D[3]=1
					for(var/mob/M in S2.loc)
						if(M.Guard==0&&M.icon_state!="hide"&&M.icon_state!="armleft"&&M.icon_state!="armright"&&M.icon_state!="brokenarmleft"&&M.icon_state!="brokenarmright")
							M.life-=(src.Attack*2)*Multiplier
							M.KilledBy = src.key
							flickHurt(M)
							if(M.life <= 0)
								isTeamMate( M, src )
								Death(M)
						else M.Guard=M.Guard
				if(T4&&T4.density==1&&R4&&R4.density==0&&src.Dead==0)
					S3.loc=locate(R4.x, R4.y, src.z)
					D[4]=1
					for(var/mob/M in S3.loc)
						if(M.Guard==0&&M.icon_state!="hide"&&M.icon_state!="armleft"&&M.icon_state!="armright"&&M.icon_state!="brokenarmleft"&&M.icon_state!="brokenarmright")
							M.life-=(src.Attack*2)*Multiplier
							M.KilledBy = src.key
							flickHurt(M)
							if(M.life <= 0)
								isTeamMate( M, src )
								Death(M)
						else M.Guard=M.Guard
				if(T5&&T5.density==1&&R5&&R5.density==0&&src.Dead==0)
					S4.loc=locate(R5.x, R5.y, src.z)
					D[5]=1
					for(var/mob/M in S4.loc)
						if(M.Guard==0&&M.icon_state!="hide"&&M.icon_state!="armleft"&&M.icon_state!="armright"&&M.icon_state!="brokenarmleft"&&M.icon_state!="brokenarmright")
							M.life-=(src.Attack*2)*Multiplier
							M.KilledBy = src.key
							flickHurt(M)
							if(M.life <= 0)
								isTeamMate( M, src )
								Death(M)
						else M.Guard=M.Guard
				if(T6&&T6.density==1&&R6&&R6.density==0&&src.Dead==0)
					S5.loc=locate(R6.x, R6.y, src.z)
					D[6]=1
					for(var/mob/M in S5.loc)
						if(M.Guard==0&&M.icon_state!="hide"&&M.icon_state!="armleft"&&M.icon_state!="armright"&&M.icon_state!="brokenarmleft"&&M.icon_state!="brokenarmright")
							M.life-=(src.Attack*2)*Multiplier
							M.KilledBy = src.key
							flickHurt(M)
							if(M.life <= 0)
								isTeamMate( M, src )
								Death(M)
						else M.Guard=M.Guard
		if(S)
			S.icon = 'Athena Shot1.dmi'
			for(var/W in typesof(/obj/Projectiles/AthenaWaveShot)) S.overlays+=W
			S.Owner = "[src.key]"
			S.pixel_y = src.pixel_y
			S.pixel_x = src.pixel_x

		if(S1)
			S1.icon = 'Athena Shot1.dmi'
			for(var/X in typesof(/obj/Projectiles/AthenaWaveShot)) S1.overlays+=X
			S1.Owner = "[src.key]"
			S1.pixel_y = src.pixel_y
			S1.pixel_x = src.pixel_x

		if(S2)
			S2.icon = 'Athena Shot1.dmi'
			for(var/Y in typesof(/obj/Projectiles/AthenaWaveShot)) S2.overlays+=Y
			S2.Owner = "[src.key]"
			S2.pixel_y = src.pixel_y
			S2.pixel_x = src.pixel_x

		if(S3)
			S3.icon = 'Athena Shot1.dmi'
			for(var/Z in typesof(/obj/Projectiles/AthenaWaveShot)) S3.overlays+=Z
			S3.Owner = "[src.key]"
			S3.pixel_y = src.pixel_y
			S3.pixel_x = src.pixel_x

		if(S4)
			S4.icon = 'Athena Shot1.dmi'
			for(var/Y in typesof(/obj/Projectiles/AthenaWaveShot)) S4.overlays+=Y
			S4.Owner = "[src.key]"
			S4.pixel_y = src.pixel_y
			S4.pixel_x = src.pixel_x

		if(S5)
			S5.icon = 'Athena Shot1.dmi'
			for(var/Z in typesof(/obj/Projectiles/AthenaWaveShot)) S5.overlays+=Z
			S5.Owner = "[src.key]"
			S5.pixel_y = src.pixel_y
			S5.pixel_x = src.pixel_x
		sleep(2)
		if(S)
			flick("burn",S)
			S.WaveShotAfter()
			S.icon_state="burnt"
			spawn(60) flick("burned",S)
			spawn(66) del S
		if(S1)
			flick("burn",S1)
			S1.WaveShotAfter()
			S1.icon_state="burnt"
			spawn(60) flick("burned",S1)
			spawn(66) del S1
		if(S2)
			flick("burn",S2)
			S2.WaveShotAfter()
			S2.icon_state="burnt"
			spawn(60) flick("burned",S2)
			spawn(66) del S2
		if(S3)
			flick("burn",S3)
			S3.WaveShotAfter()
			S3.icon_state="burnt"
			spawn(60) flick("burned",S3)
			spawn(66) del S3
		if(S4)
			flick("burn",S4)
			S4.WaveShotAfter()
			S4.icon_state="burnt"
			spawn(60) flick("burned",S4)
			spawn(66) del S4
		if(S5)
			flick("burn",S5)
			S5.WaveShotAfter()
			S5.icon_state="burnt"
			spawn(60) flick("burned",S5)
			spawn(66) del S5
		if(D[1]!=1&&D[2]!=1&&D[3]!=1&&D[4]!=1&&D[5]!=1&&D[6]!=1)
			src.Teleporting=0
		else
			var/slpDelay = 30
			if( src.key=="HolyDoomKnight" ) slpDelay = src.delay*10
			sleep(slpDelay)
			src.Teleporting=0
		#endif
	Athena_Shoot()
		#ifdef INCLUDED_ATHENA_DM
		if(src.Teleporting == 1||src.Slashing==1||src.Dead==1||src.climbing==1) return
		if(Drain_fromUse(1, src) == 0) return;
		src.Teleporting=1
		flick("wave[src.icon_state]",src)
		var/mob/AWB/S = new
		var/mob/AWB/S1 = new
		var/mob/AWB/S2 = new
		var/mob/AWB/S3 = new
		var/D[4]
		switch( src.icon_state )
			if("left")
				if( isnull( src ) || isnull( src ) ) return
				var/turf
					T1=locate(src.x-1, src.y-1, src.z)
					T2=locate(src.x-2, src.y-1, src.z)
					T3=locate(src.x-3, src.y-1, src.z)
					T4=locate(src.x-4, src.y-1, src.z)
				var/turf
					R1
					R2
					R3
					R4
				if( !isnull( T1 ) )
					R1=locate(T1.x, src.y, src.z)
				if( !isnull( T2 ) )
					R2=locate(T2.x, src.y, src.z)
				if( !isnull( T3 ) )
					R3=locate(T3.x, src.y, src.z)
				if( !isnull( T4 ) )
					R4=locate(T4.x, src.y, src.z)
				if(T1&&T1.density==1&&R1&&R1.density==0&&src.Dead==0)
					S.loc=locate(R1.x, R1.y, R1.z)
					D[1]=1
					for(var/mob/M in S.loc)
						if(M.Guard==0&&M.icon_state!="hide"&&M.icon_state!="armleft"&&M.icon_state!="armright"&&M.icon_state!="brokenarmleft"&&M.icon_state!="brokenarmright")
							M.life-=(src.Attack*2)*Multiplier
							M.KilledBy = src.key
							flickHurt(M)
							if(M.life <= 0)
								isTeamMate( M, src )
								Death(M)
						else M.Guard=M.Guard
				if(T2&&T2.density==1&&R2&&R2.density==0&&src.Dead==0)
					S1.loc=locate(R2.x, R2.y, R2.z)
					D[2]=1
					for(var/mob/M in S1.loc)
						if(M.Guard==0&&M.icon_state!="hide"&&M.icon_state!="armleft"&&M.icon_state!="armright"&&M.icon_state!="brokenarmleft"&&M.icon_state!="brokenarmright")
							M.life-=(src.Attack*2)*Multiplier
							M.KilledBy = src.key
							flickHurt(M)
							if(M.life <= 0)
								isTeamMate( M, src )
								Death(M)
						else M.Guard=M.Guard
				if(T3&&T3.density==1&&R3&&R3.density==0&&src.Dead==0)
					S2.loc=locate(R3.x, R3.y, R3.z)
					D[3]=1
					for(var/mob/M in S2.loc)
						if(M.Guard==0&&M.icon_state!="hide"&&M.icon_state!="armleft"&&M.icon_state!="armright"&&M.icon_state!="brokenarmleft"&&M.icon_state!="brokenarmright")
							M.life-=(src.Attack*2)*Multiplier
							M.KilledBy = src.key
							flickHurt(M)
							if(M.life <= 0)
								isTeamMate( M, src )
								Death(M)
						else M.Guard=M.Guard
				if(T4&&T4.density==1&&R4&&R4.density==0&&src.Dead==0)
					S3.loc=locate(R4.x, R4.y, R4.z)
					D[4]=1
					for(var/mob/M in S3.loc)
						if(M.Guard==0&&M.icon_state!="hide"&&M.icon_state!="armleft"&&M.icon_state!="armright"&&M.icon_state!="brokenarmleft"&&M.icon_state!="brokenarmright")
							M.life-=(src.Attack*2)*Multiplier
							M.KilledBy = src.key
							flickHurt(M)
							if(M.life <= 0)
								isTeamMate( M, src )
								Death(M)
						else M.Guard=M.Guard
			if("right")
				if( isnull( src ) || isnull( src ) ) return
				var/turf
					T1=locate(src.x+1, src.y-1, src.z)
					T2=locate(src.x+2, src.y-1, src.z)
					T3=locate(src.x+3, src.y-1, src.z)
					T4=locate(src.x+4, src.y-1, src.z)
				var/turf
					R1
					R2
					R3
					R4
				if( !isnull( T1 ) )
					R1=locate(T1.x, src.y, src.z)
				if( !isnull( T2 ) )
					R2=locate(T2.x, src.y, src.z)
				if( !isnull( T3 ) )
					R3=locate(T3.x, src.y, src.z)
				if( !isnull( T4 ) )
					R4=locate(T4.x, src.y, src.z)
				if(T1&&T1.density==1&&R1&&R1.density==0&&src.Dead==0)
					S.loc=locate(R1.x, R1.y, src.z)
					D[1]=1
					for(var/mob/M in S.loc)
						if(M.Guard==0&&M.icon_state!="hide"&&M.icon_state!="armleft"&&M.icon_state!="armright"&&M.icon_state!="brokenarmleft"&&M.icon_state!="brokenarmright")
							M.life-=(src.Attack*2)*Multiplier
							M.KilledBy = src.key
							flickHurt(M)
							if(M.life <= 0)
								isTeamMate( M, src )
								Death(M)
						else M.Guard=M.Guard
				if(T2&&T2.density==1&&R2&&R2.density==0&&src.Dead==0)
					S1.loc=locate(R2.x, R2.y, src.z)
					D[2]=1
					for(var/mob/M in S1.loc)
						if(M.Guard==0&&M.icon_state!="hide"&&M.icon_state!="armleft"&&M.icon_state!="armright"&&M.icon_state!="brokenarmleft"&&M.icon_state!="brokenarmright")
							M.life-=(src.Attack*2)*Multiplier
							M.KilledBy = src.key
							flickHurt(M)
							if(M.life <= 0)
								isTeamMate( M, src )
								Death(M)
						else M.Guard=M.Guard
				if(T3&&T3.density==1&&R3&&R3.density==0&&src.Dead==0)
					S2.loc=locate(R3.x, R3.y, src.z)
					D[3]=1
					for(var/mob/M in S2.loc)
						if(M.Guard==0&&M.icon_state!="hide"&&M.icon_state!="armleft"&&M.icon_state!="armright"&&M.icon_state!="brokenarmleft"&&M.icon_state!="brokenarmright")
							M.life-=(src.Attack*2)*Multiplier
							M.KilledBy = src.key
							flickHurt(M)
							if(M.life <= 0)
								isTeamMate( M, src )
								Death(M)
						else M.Guard=M.Guard
				if(T4&&T4.density==1&&R4&&R4.density==0&&src.Dead==0)
					S3.loc=locate(R4.x, R4.y, src.z)
					D[4]=1
					for(var/mob/M in S3.loc)
						if(M.Guard==0&&M.icon_state!="hide"&&M.icon_state!="armleft"&&M.icon_state!="armright"&&M.icon_state!="brokenarmleft"&&M.icon_state!="brokenarmright")
							M.life-=(src.Attack*2)*Multiplier
							M.KilledBy = src.key
							flickHurt(M)
							if(M.life <= 0)
								isTeamMate( M, src )
								Death(M)
						else M.Guard=M.Guard
		if(S)
			S.icon = 'Athena Shot1.dmi'
			for(var/W in typesof(/obj/Projectiles/AthenaWaveShot)) S.overlays+=W
			S.Owner = "[src.key]"
			S.pixel_y = src.pixel_y
			S.pixel_x = src.pixel_x

		if(S1)
			S1.icon = 'Athena Shot1.dmi'
			for(var/X in typesof(/obj/Projectiles/AthenaWaveShot)) S1.overlays+=X
			S1.Owner = "[src.key]"
			S1.pixel_y = src.pixel_y
			S1.pixel_x = src.pixel_x

		if(S2)
			S2.icon = 'Athena Shot1.dmi'
			for(var/Y in typesof(/obj/Projectiles/AthenaWaveShot)) S2.overlays+=Y
			S2.Owner = "[src.key]"
			S2.pixel_y = src.pixel_y
			S2.pixel_x = src.pixel_x

		if(S3)
			S3.icon = 'Athena Shot1.dmi'
			for(var/Z in typesof(/obj/Projectiles/AthenaWaveShot)) S3.overlays+=Z
			S3.Owner = "[src.key]"
			S3.pixel_y = src.pixel_y
			S3.pixel_x = src.pixel_x

		sleep(2)
		if(S)

			flick("burn",S)
			S.WaveShotAfter()
			S.icon_state="burnt"
			spawn(50) flick("burned",S)
			spawn(56) del S
		if(S1)

			flick("burn",S1)
			S1.WaveShotAfter()
			S1.icon_state="burnt"
			spawn(50) flick("burned",S1)
			spawn(56) del S1
		if(S2)

			flick("burn",S2)
			S2.WaveShotAfter()
			S2.icon_state="burnt"
			spawn(50) flick("burned",S2)
			spawn(56) del S2
		if(S3)
			flick("burn",S3)
			S3.WaveShotAfter()
			S3.icon_state="burnt"
			spawn(50) flick("burned",S3)
			spawn(56) del S3
		if(D[1]!=1&&D[2]!=1&&D[3]!=1&&D[4]!=1)
			src.Teleporting=0
		else
			sleep(30)
			src.Teleporting=0
		#endif
	SpinShot()
		#ifdef INCLUDED_ATHENA_DM
		if(src.Slashing==1||src.Shooting==1||src.Dead==1) return
		if(Drain_fromUse(1, src) == 0) return;
		src.Shooting=1
		flick("spinshot",src)
		if(world.time - src.delay_time >= src.delay)    // A simple delay to keep you from macroing it tons.
			src.delay_time = world.time     // You could lengthen or shorten the delay simply by raising or lowering the mob's delay variable.
			var/obj/Blasts/Blast
				S;S1;S2;S3
			if(src.Dead==1) return
			S = new /obj/Blasts/Blast(locate(src.x, src.y, src.z))    // Create it to your right if you're faced right.
			S.icon_state = "left"
			S.Owner = src.key
			S.Damage = src.Attack
			S.icon = src.BulletIcon
			S.pixel_y = src.pixel_y
			for(var/X in typesof(/obj/Projectiles/AthenaShot1)) S.overlays+=X
			if(S.icon_state=="right") S.pixel_x=48
			if(S.icon_state=="left") S.pixel_x=16
			S.BlastMove()
			sleep(1)
			if(src.Dead==1) return
			S1 = new /obj/Blasts/Blast(locate(src.x, src.y, src.z))    // Create it to your right if you're faced right.
			S1.icon_state = "right"
			S1.Owner = src.key
			S1.Damage = src.Attack
			S1.icon = src.BulletIcon
			S1.pixel_y = src.pixel_y
			for(var/X in typesof(/obj/Projectiles/AthenaShot1)) S1.overlays+=X
			if(S1.icon_state=="right") S1.pixel_x=48
			if(S1.icon_state=="left") S1.pixel_x=16
			S1.BlastMove()
			if(src.Dead==1) return
			sleep(2)
			S2 = new /obj/Blasts/Blast(locate(src.x, src.y, src.z))    // Create it to your right if you're faced right.
			S2.icon_state = "left"
			S2.Owner = src.key
			S2.Damage = src.Attack
			S2.icon = src.BulletIcon
			S2.pixel_y = src.pixel_y
			for(var/X in typesof(/obj/Projectiles/AthenaShot1)) S2.overlays+=X
			if(S2.icon_state=="right") S2.pixel_x=48
			if(S2.icon_state=="left") S2.pixel_x=16
			S2.BlastMove()
			sleep(1)
			if(src.Dead==1) return
			S3 = new /obj/Blasts/Blast(locate(src.x, src.y, src.z))    // Create it to your right if you're faced right.
			S3.icon_state = "right"
			S3.Owner = src.key
			S3.Damage = src.Attack
			S3.icon = src.BulletIcon
			S3.pixel_y = src.pixel_y
			for(var/X in typesof(/obj/Projectiles/AthenaShot1)) S3.overlays+=X
			if(S3.icon_state=="right") S3.pixel_x=48
			if(S3.icon_state=="left") S3.pixel_x=16
			S3.BlastMove()

		sleep(1)
		src.Shooting=0
		#endif
	ModelS_Slash()//Finish up ModelS  Slash
		if(src.Slashing == 1||src.Teleporting==1||src.Dead==1) return
		if(Drain_fromUse(1, src) == 0) return;
		src.Slashing=1

		if(world.time - src.delay_time >= src.delay)    // A simple delay to keep you from macroing it tons.
			src.delay_time = world.time     // You could lengthen or shorten the delay simply by raising or lowering the mob's delay variable.
			var/obj/Blasts/Blast/S = new /obj/Blasts/Blast(locate(src.x, src.y, src.z))   // Make a new instance of a laser (but don't actually create it, yet)
			if(src.icon_state == "right")
				S.icon_state = "right"    // Set it's state (important not only for proper glitz, but for movement),
			else if(src.icon_state == "left")
				S.icon_state = "left"
			S.Damage = src.Attack
			S.Owner = src.key
			S.icon='MSShot4 1.dmi'
			for(var/X in typesof(/obj/Projectiles/MSShot4)) S.overlays+=X
			S.BlastMove()
		flick("slash[src.icon_state]3",src)
		sleep(3)
		if( isnull( src ) || isnull( src ) ) return
		switch( src.icon_state )
			if( "left")
				for(var/mob/M in oview(1))
					if(M.y == src.y&&M.x < src.x&&M.Dead!=1)
						Sword_Hit(M,src)
						sleep(1)
						src.Slashing=0
						return
					if(M.y == src.y+1&&M.x == src.x-1&&M.Dead!=1)
						Sword_Hit(M,src)
						sleep(1)
						src.Slashing=0
						return
				for(var/obj/Blasts/O in oview(1))
					if(O.y == src.y&&O.x < src.x&&O.icon_state == "right")
						O.icon_state = "left"
						O.Owner=src.key

					if(O.y == src.y+1&&O.x == src.x-1&&O.icon_state == "right")
						O.icon_state = "left"
						O.Owner=src.key

			if( "right")
				for(var/mob/M in oview(1))
					if(M.y == src.y&&M.x >src.x&&M.Dead!=1)
						Sword_Hit(M,src)
						sleep(1)
						src.Slashing=0
						return
					if(M.y == src.y+1&&M.x == src.x+1&&M.Dead!=1)
						Sword_Hit(M,src)
						sleep(1)
						src.Slashing=0
						return
				for(var/obj/Blasts/O in oview(1))
					if(O.y == src.y&&O.x > src.x&&O.icon_state == "left")
						O.icon_state = "right"
						O.Owner=src.key

					if(O.y == src.y+1&&O.x == src.x+1&&O.icon_state == "left")
						O.icon_state = "right"
						O.Owner=src.key

		sleep(2)
		src.Slashing=0


	SJXPoke()
		if(src.Teleporting==1||src.Dead==1) return
		if(Drain_fromUse(1, src) == 0) return;
		src.Teleporting=1
		flick("poke[src.icon_state]",src)
		switch( src.icon_state )
			if("right")
				for(var/mob/Entities/M in get_step(src, EAST))
					if(M.Guard > 2 || getBarrier_Blast(M) != 0 || M.Class == "Zombie") continue
					isDefending(M)
					isClimbing(M)
				/*	if(M.Class=="Zombie")
						M.nojump=0
						M.density=1
						if(M.icon_state=="sandleft")
							M.icon_state="left"
						if(M.icon_state=="sandright")
							M.icon_state="right"
						else M.icon_state=M.icon_state*/
					step(M,EAST)
					step(M,EAST)
					Sword_Hit(M,src)
			if("left")
				for(var/mob/Entities/M in get_step(src, WEST))
					if(M.Guard > 2 || getBarrier_Blast(M) != 0 || M.Class == "Zombie") continue
					isDefending( M )
					isClimbing(M)
				/*	if(M.Class=="Zombie")
						M.nojump=0
						M.density=1
						if(M.icon_state=="sandleft")
							M.icon_state="left"
						if(M.icon_state=="sandright")
							M.icon_state="right"
						else M.icon_state=M.icon_state*/
					step(M,WEST)
					step(M,WEST)
					Sword_Hit(M,src)
		sleep(2)
		src.Teleporting=0
	SJXDouble()
		if(src.Teleporting==1||src.Dead==1) return
		if(Drain_fromUse(1, src) == 0) return;
		src.Teleporting=1
		flick("double[src.icon_state]",src)
		switch( src.icon_state )
			if("right")
				for(var/mob/Entities/M in oview(3))

					if(M.Guard<3&&getBarrier_Blast(M)==0&&M.x!=src.x&&M.y>=src.y)
						isDefending( M )
						isClimbing(M)
					/*	if(M.Class=="Zombie")
							M.nojump=0
							M.density=1
							if(M.icon_state=="sandleft")
								M.icon_state="left"
							if(M.icon_state=="sandright")
								M.icon_state="right"
							else M.icon_state=M.icon_state*/
						if(M.Class!="Zombie")
							step(M,EAST)
							step(M,EAST)
							step(M,EAST)
						if(M.x<=src.x+1&&M.x>=src.x-1&&M.x!=src.x&&M.y==src.y)
							Sword_Hit(M,src)
						else
							Smash_Hit(M,src)
			if("left")
				for(var/mob/Entities/M in oview(3))
					if(M.Guard<3&&getBarrier_Blast(M)==0&&M.x!=src.x&&M.y>=src.y)
						isDefending( M )
						isClimbing(M)
					/*	if(M.Class=="Zombie")
							M.nojump=0
							M.density=1
							if(M.icon_state=="sandleft")
								M.icon_state="left"
							if(M.icon_state=="sandright")
								M.icon_state="right"
							else M.icon_state=M.icon_state*/
						if(M.Class!="Zombie")
							step(M,WEST)
							step(M,WEST)
							step(M,WEST)
						if(M.x<=src.x+1&&M.x>=src.x-1&&M.x!=src.x&&M.y==src.y)
							Sword_Hit(M,src)
						else
							Smash_Hit(M,src)
		sleep(2)
		src.Teleporting=0






	StunSlash()
		if(src.Teleporting==1||src.Dead==1) return
		if(Drain_fromUse(1, src) == 0) return;
		src.Teleporting=1
		flick("thunder[src.icon_state]",src)
		var/Range = 4;
		switch( src.icon_state )
			if("right")
				for(var/mob/Entities/M in oview(Range))
					NULL_C( M )
					NULL_R( src )
					if( M.x <= src.x || M.y != src.y || M.Guard > 2 || M.islocked != 0 ) continue
					//	Sword_Hit(M,src)
					if(istype(M, /mob/Entities/Player))
						M.islocked=3
						spawn(2) src.Teleporting=0
						LockCheck(M)
			if("left")
				for(var/mob/Entities/M in oview(Range))
					NULL_C( M )
					NULL_R( src )
					if( M.x >= src.x || M.y != src.y || M.Guard > 2 || M.islocked != 0 ) continue
					//	Sword_Hit(M,src)
					if(istype(M, /mob/Entities/Player))
						M.islocked=3
						spawn(2) src.Teleporting=0
						LockCheck(M)
		sleep(6)
		src.Teleporting=0
	RushCharge()
		if( src.Teleporting == 1 || src.Dead == 1 ) return
		if(Drain_fromUse(1, src) == 0) return;
		src.Teleporting = 1
		flick( "charge[src.icon_state]", src )
		var/targetRange = 1
		switch( src.icon_state )
			if( "right" )
				var/Dir = EAST
				for( var/mob/target in oview( targetRange ) )
					if( target.x <= src.x ) continue
					if( src.Dead != 0 ) continue
					if( istype( target, /mob/AW2 ) ) continue
					else if( istype( target, /mob/Entities/Player ) )
						if( target.key != src.key \
							&& target.Guard < 3 \
							&& getBarrier_Blast(target) == 0  \
							&& target.Class != "Zombie" )
							isDefending( target )
							Smash_Hit( target, src )
							isClimbing(target)
							step( target, EAST )
							step( target, EAST )
							step( target, EAST )
					else if( istype( target, /mob/Entities/PTB ) )
						Smash_Hit( target, src )
					else
						sleep( 1 )
						del target
						target = null
				step( src, Dir )
				step( src, Dir )
				step( src, Dir )
			if( "left" )
				var/Dir = WEST
				for( var/mob/target in oview( targetRange ) )
					if( target.x >= src.x ) continue
					if( src.Dead != 0 ) continue
					if( istype( target, /mob/AW2 ) ) continue
					else if( istype( target, /mob/Entities/Player ) )
						if( target.key != src.key \
						&& target.Guard < 3 \
						&& getBarrier_Blast(target) == 0 \
						&& target.Class != "Zombie" )
							isDefending( target )
							Smash_Hit( target, src )
							isClimbing(target)
							step( target, Dir )
							step( target, Dir )
							step( target, Dir )
					else if( istype( target, /mob/Entities/PTB ) )
						Smash_Hit( target, src )
					else
						sleep( 1 )
						del target
						target = null
				step( src, Dir )
				step( src, Dir )
				step( src, Dir )
		sleep(3)
		src.Teleporting=0
		return

	Chilldre_Fall()
		if(src.Slashing==1||src.Dead==1) return
		if(Drain_fromUse(1, src) == 0) return;
		src.Slashing=1
		src.icon_state="fall"
		sleep(2)
		var/i = 0
		var/Original = src.Attack
		while(src.Slashing == 1)
			if(i % 3 == 0)
				++src.Attack
			var/turf/aturf = get_step( usr, SOUTH )  // Get the turf directly below you.
			var/dense = 0
			if(aturf)
				for(var/atom/A in aturf)
					if(A.density == 1)
						dense = 1
						break
				if(aturf.density == 1)
					dense = 1
			if(!aturf)
				dense = 1
			if( dense == 1 || src.y < 2)
				for(var/mob/M in oview(2))
					if(M.Guard >=3 || getBarrier_Blast(M) != 0) continue
					Smash_Hit(M, src)
				sleep(2)
				src.icon_state="left"
				src.Slashing = 0
				break

			sleep(1)
			step(src, SOUTH)
			++i
		src.Attack = Original









	THold()
		NULL_R( src )
		if(src.Teleporting==1||src.Dead==1 ) return
		if(Drain_fromUse(1, src) == 0) return;
		src.Teleporting=1
		flick("thold[src.icon_state]",src)
		for(var/mob/Entities/M in oview(1))
			NULL_C( M )
			NULL_R( src )
			if( M.Stats[c_Team] == src.Stats[c_Team] && M.Stats[c_Team] != "N/A" ) continue
			if( M.key == src.key || M.Guard > 2 || M.islocked != 0 ) continue
			NULL_C( M )
			NULL_R( src )
			switch( src.icon_state )
				if( "left" )
					if( M.x >= src.x ) continue
					M.islocked=1
					LockCheck(M)
				if( "right" )
					if( M.x <= src.x ) continue
					M.islocked=1
					LockCheck(M)
		sleep(10)
		src.Teleporting=0
		return

	Weil_Trans()
		#ifdef INCLUDED_WEIL_DM
		if(Drain_fromUse(1, src) == 0) return;
		if(src.Slashing==0)
			src.Slashing=1
			flick("morph",src)
			src.overlays-=/obj/Characters/Weil/Top
			for(var/X in typesof(/obj/Characters/Ragnarok)) src.overlays+=X
			src.Class="Ragnarok"
			src.icon='RagWeil.dmi'
		else
			src.Slashing=0
			for(var/X in typesof(/obj/Characters/Ragnarok)) src.overlays-=X
			src.overlays+=/obj/Characters/Weil/Top
			src.Class="Weil"
			src.icon='Weil.dmi'
			src.pixel_y=-16
		switch( get_WorldStatus(c_Map) )
			if(DESERT_TEMPLE)
				src.pixel_y+=-3
			if(SLEEPING_FOREST, WARZONE)
				src.pixel_y+=-4
			if(WARZONE)
				src.pixel_y+=-14

		return
		#endif
/*	XAZ_Trans()
		if(src.Class=="BZero")
			flick("teleout",src)
			src.overlays=list()
			for(var/X in typesof(/obj/Characters/UAX)) src.overlays+=X
			src.Class="UAX"
			src.icon='UAX.dmi'
			return
		else
			flick("teleout",src)
			src.overlays=list()
			for(var/X in typesof(/obj/Characters/BZero)) src.overlays+=X
			flick("telein",src)
			src.Class="BZero"
			src.icon='BZero.dmi'
			return*/





	Disguise()
	//	if(Drain_fromUse(1, src) == 0) return;

		if(src.Disguised>0&&src.Class!="Axl")
			if(src.DisguiseCounter>=30||src.Dead==1)
				src.DisguiseCounter=0
				src.overlays = list()
				for(var/Y in typesof(/obj/Characters)) src.overlays-=Y
				#ifdef INCLUDED_AXL_DM
				for(var/Z in typesof(/obj/Characters/Axl)) src.overlays+=Z
				#endif
				for(var/X in typesof("/obj/Characters/Team/[lowertext(src.Stats[c_Team])]")) src.overlays+=X
				if(src.BarrierUP == 1)
					switch( src.Class )
						if("Gate")
							for(var/mob/GB/G in world)
								if(G.Owner == src.key)
									del G
						if("Anubis")
							for(var/mob/AW/G in world)
								if(G.Owner == src.key)
									del G
					src.BarrierUP=0
				src.Class="Axl"
				if( src.Attack < 28 )
					src.Attack = 3
				src.pixel_x=0
				if(get_WorldStatus(c_Map)<DESERT_TEMPLE) src.pixel_y=-16
				src.BulletIcon = 'XShot.dmi'
				src.SubBulletIcon=null
				src.icon = null
				src.Flight=0
				src.Disguised=0
				src.Teleporting=0
				for(var/i = 1 to 7) src.Disabled[i]=0
				src.Disabled[5]=1
				src.Slashing=0
				src.Shooting=0
				src.delay=6
				if(src.climbing == 1) src.climbing=0
				src.density=1
				if(src.nojump==1) src.nojump=0
				src.lock=0
				src.inscene=0
				src.Guard=0
				src.icon_state="right"
				src.jumpHeight=2.0
				src.MoveDelay = 2
			else
				if(src.Disabled[7]==1)
					src.DisguiseCounter+=1
				src.DisguiseCounter+=1
			sleep(10)
			src.Disguise()
proc
	LockCheck(mob/A)
		if(isnull(A)) return
		if(istype(A,/mob/Entities/Player)&&!Bosses.Find(A.key)&&!TeamLeaders.Find(A.key)&&ModeTarget != A.key&&A.islocked!=0&&A.islocked<4)
			A.islocked+=1
			sleep(10)
			if( !isnull( A ) ) LockCheck(A)
		else
			A.islocked=-1
			sleep(20)
			if( !isnull( A ) ) A.islocked=0
		#ifdef INCLUDED_AXL_DM
/*	Axl_Hit(var/mob/U, var/mob/T, var/obj/S)
		if(isnull(U) || isnull(T) || isnull(S)) return
		if(U.Dead == 1 || U.Class != "Axl" || U.Disguised > 0)
			del S
			return
		if(T.Class == "Axl" || T.Disalbed[7] == 1 || T.Class == "Zombie" || T.key == U.key || T.Guard != 0 )
			del C return*/
	Axl_Hit(mob/A, mob/B, obj/C)
		if(isnull(A)||isnull(B)||isnull(C)) return
		if(B.Class == "Axl" || B.Disabled[7] == 1 || B.Class == "Zombie" || B.key == A.key || A.Dead == 1 || B.Guard != 0 || A.Class != "Axl" || A.Disguised > 0)
			del C
			return

		for(var/Y in typesof(/obj/Characters/Axl)) A.overlays-=Y

		for(var/Z in typesof("/obj/Characters/Team/[lowertext(A.Stats[c_Team])]")) A.overlays+=Z
		for(var/X in typesof("/obj/Characters/[B.Class]")) A.overlays+=X
		A.Disguised=1
		A.Class=B.Class
		A.icon = B.icon
		if( A.Attack >= 28 )
			A.Attack = 28
		else if( A.Attack < 28 )
			A.Attack = B.Attack
			if( B.Attack >= 28 )
				A.Attack = 3
		A.pixel_x=B.pixel_x
		A.pixel_y=B.pixel_y
		if( B.Class != "Vile" )
			A.Flight=B.Flight
		A.delay=B.delay
		A.BulletIcon=B.BulletIcon
		if(B.SubBulletIcon!=null) A.SubBulletIcon=B.SubBulletIcon
		A.Teleporting=0
		A.Slashing=0
		A.Shooting=0
		A.inscene=0
		A.Guard=0
		A.BarrierUP=0
		A.jumpHeight = B.jumpHeight.
		A.MoveDelay = B.MoveDelay
		for(var/i = 1 to 7) A.Disabled[i]=B.Disabled[i]
		switch( A.dir )
			if(EAST) A.icon_state="right"
			if(WEST) A.icon_state="left"
		A.lock=0
		del C
		A.Disguise()
		#endif
	Hit(mob/M, obj/B)
		if(isnull(M)||isnull(B)||M.Guard>2)
			return
		switch(M.icon_state)
			if("armleft", "armright", "brokenarmleft", "brokenarmright")
				del B
				return
		switch(M.Types)
			if("right1", "left1", "right2", "left2")
				del B
				return
		switch( B.icon )
			if('HDKShot.dmi', 'MSShot4 1.dmi', 'Model-C Weapon.dmi','WaveBase.dmi')//||B.icon=='WaveTop.dmi')
				if(getBarrier_Blast(M)==1)
					del M
					return
				if(B.icon!='WaveBase.dmi'&&getBarrier_Blast(M)==2)
					del B
					return
				if(B.icon=='WaveBase.dmi'&&getBarrier_Blast(M)==2)
					del M
					return
				if(B.icon == 'Model-C Weapon.dmi')
					if(M.Class!="Zombie"&&M.Dead!=1&&istype( M, /mob/Entities ) )
						isClimbing(M)
						switch(B.icon_state)
							if("up")
								for(var/i=0 to 3) step(M, NORTH)
							if("upleft")
								for(var/i=0 to 3) step(M, NORTHWEST)
							if("upright")
								for(var/i=0 to 3) step(M, NORTHEAST)
							if("left")
								for(var/i=0 to 3) step(M, WEST)
							if("right")
								for(var/i=0 to 3) step(M, EAST)
			if('SolSlash.dmi')
				for(var/mob/U in view(5, src))
					if(istype(U, /mob/Entities/Player&&U.key!=B.Owner&&U.key!=M.key))
						Smash_Hit(M,B.Owner)
					if(istype(U, /mob/Entities/PTB&&U!=B.Owner&&U!=M))
						Smash_Hit(M,B.Owner)
			if('CubitShots2.dmi')
				if(M.inscene!=1&&B.icon_state=="up"&&getBarrier_Blast(M)==0&&M.y==B.y+1)
					var/turf
						T1=locate(B.x-1, B.y, B.z)
						T2=locate(B.x-2, B.y, B.z)
						T3=locate(B.x-3, B.y, B.z)
						T4=locate(B.x+1, B.y, B.z)
						T5=locate(B.x+2, B.y, B.z)
						T6=locate(B.x+3, B.y, B.z)
					var/obj/Blasts/Blast
						S1;S2;S3;S4;S5;S6
					if(T1&&T1.density==0)
						S1 = new /obj/Blasts/Blast(T1)
						S1.icon_state = "down"
						S1.icon='CubitShots.dmi'
						S1.Damage=B.Damage
						S1.Owner=B.Owner
						spawn(1)
						S1.BlastMove()
					if(T2&&T2.density==0)
						S2 = new /obj/Blasts/Blast(T2)
						S2.icon_state = "down"
						S2.icon='CubitShots.dmi'
						S2.Damage=B.Damage
						S2.Owner=B.Owner
						spawn(1)
						S2.BlastMove()
					if(T3&&T3.density==0)
						S3 = new /obj/Blasts/Blast(T3)
						S3.icon_state = "down"
						S3.icon='CubitShots.dmi'
						S3.Damage=B.Damage
						S3.Owner=B.Owner
						spawn(1)
						S3.BlastMove()
					if(T4&&T4.density==0)
						S4 = new /obj/Blasts/Blast(T4)    // Create it to your right if you're faced right.
						S4.icon_state = "down"
						S4.icon='CubitShots.dmi'
						S4.Damage=B.Damage
						S4.Owner=B.Owner
						spawn(1)
						S4.BlastMove()
					if(T5&&T5.density==0)
						S5 = new /obj/Blasts/Blast(T5)    // Create it to your right if you're faced right.
						S5.icon_state = "down"
						S5.icon='CubitShots.dmi'
						S5.Damage=B.Damage
						S5.Owner=B.Owner
						spawn(1)
						S5.BlastMove()
					if(T6&&T6.density==0)
						S6 = new /obj/Blasts/Blast(T6)    // Create it to your right if you're faced right.
						S6.icon_state = "down"
						S6.icon='CubitShots.dmi'
						S6.Damage=B.Damage
						S6.Owner=B.Owner
						spawn(1)
						S6.BlastMove()

			if('CliffBlasts.dmi')
				if(M.Class!="Zombie"&&M.Dead!=1&&istype( M, /mob/Entities ))
					isClimbing(M)
					switch( B.icon_state )
						if("up")
							for(var/i=0 to 3) step(M, NORTH)
						if("upleft")
							for(var/i=0 to 3) step(M, NORTHWEST)
						if("upright")
							for(var/i=0 to 3) step(M, NORTHEAST)
						if("left")
							for(var/i=0 to 3) step(M, WEST)
						if("right")
							for(var/i=0 to 3) step(M, EAST)
						if("down")
							for(var/i=0 to 3) step(M, SOUTH)
						if("downleft")
							for(var/i=0 to 3) step(M, SOUTHWEST)
						if("downright")
							for(var/i=0 to 3) step(M, SOUTHEAST)

		if(B.icon_state=="up2")
			if(M.x<=B.x)
				for(var/i=0 to 3) step(M, NORTHWEST)
			if(M.x>=B.x)
				for(var/i=0 to 3) step(M, NORTHEAST)

		if(M.Guard==1)
			if(getBarrier_Blast(M) == 1)
				if(B.icon=='MM8_FlyerShot.dmi'||B.icon=='MG400Missiles.dmi'||B.icon=='GrenBomb.dmi'||B.icon=='Bomb.dmi'||B.icon_state=="up"||B.icon_state=="down"||B.icon_state=="downright"||B.icon_state=="downleft"||B.icon_state=="upleft"||B.icon_state=="upright")
					switch(B.icon)
						if('MM8_FlyerShot.dmi', 'MG400Missiles.dmi', 'GrenBomb.dmi', 'Bomb.dmi')
							del B
							return
					if(B.icon=='CubitShots.dmi'&&B.icon_state!="right"&&B.icon_state!="left")
						del B
						return
					if(B.icon!='GrenBomb.dmi'&&B.icon!='Bomb.dmi'&&B.icon!='CubitShots.dmi')
						del M
						return
				else
					if( B.icon == 'WoodmanProjectile.dmi' )
						B.LifeTime = MAX_LIFE_TIME - 1
					B.Damage = B.Damage*3
					B.overlays -= B.overlays
					B.icon = 'GateBlast.dmi'
					for(var/mob/Entities/Player/N)
						if(N.key==M.Owner)

							B.Owner=N.key
					switch( B.icon_state )
						if( "left")
							B.icon_state = "right"
							if( !isnull( B.LifeTime ) ) ++B.LifeTime;
							return
						if( "right")
							B.icon_state = "left"
							if( !isnull( B.LifeTime ) ) ++B.LifeTime;
							return
			else
				if( B.icon == 'WoodmanProjectile.dmi' )
					B.LifeTime = MAX_LIFE_TIME - 1
				switch( B.icon_state )
					if("left")

						B.icon_state = "right"
						if( !isnull( B.LifeTime ) ) ++B.LifeTime;
						B.Owner = M.key
						return
					if("right")

						B.icon_state = "left"
						if( !isnull( B.LifeTime ) ) ++B.LifeTime;
						B.Owner = M.key
						return
		if(M.Guard==2)
			if(getBarrier_Blast(M) == 2)
				del B
				return
		if(M.Class == "Knightman")
			switch(M.icon_state)
				if("right")
					if(B.x > M.x)
						del B
						return
				if("left")
					if(B.x < M.x)
						del B
						return
		switch( M.icon_state )

			if( "guardleft" )
				if(M.Guard==0&&B.icon_state == "right")
					ShieldDrain_fromHit(B.Damage, M)
					switch(M.Class)
						if("SJX", "ZV", "Valnaire", "Burnerman", "Woodman", "GAX")
							M.life += B.Damage
							del B
							if(M.life >= M.mlife) M.life=M.mlife
							M.Update()
							return
					if(M.Class!="Foxtar" && M.Class != "Zanzibar")
						if( B.icon == 'WoodmanProjectile.dmi' )
							del B
							return

						B.icon_state = "left"
						if( !isnull( B.LifeTime ) ) ++B.LifeTime;
						B.Owner = M.key
						return
					del B
					return
			if( "guardright" )
				if(M.Guard==0&&B.icon_state == "left")
					ShieldDrain_fromHit(B.Damage, M)
					switch(M.Class)
						if("SJX", "ZV", "Valnaire", "Burnerman", "Woodman", "GAX")
							M.life += B.Damage
							del B
							if(M.life >= M.mlife) M.life=M.mlife
							M.Update()
							return
					if(M.Class!="Foxtar" && M.Class != "Zanzibar")
						if( B.icon == 'WoodmanProjectile.dmi' )
							del B
							return
						B.icon_state = "right"
						if( !isnull( B.LifeTime ) ) ++B.LifeTime;
						B.Owner = M.key
						return
					del B
					return
			if( "shieldleft" )
				if(B.icon_state == "right")
					ShieldDrain_fromHit(B.Damage, M)
					if(M.Class=="SaX")
						M.life += B.Damage
						del B
						if(M.life >= M.mlife) M.life=M.mlife;M.Update()
						return
					if( B.icon == 'WoodmanProjectile.dmi' )
						del B
						return
					B.icon_state = "left"
					B.Owner = M.key
					if( !isnull( B.LifeTime ) ) ++B.LifeTime;
					return
			if("shieldright")
				if( B.icon_state == "left")
					ShieldDrain_fromHit(B.Damage, M)
					if(M.Class=="SaX")
						M.life += B.Damage
						del B
						if(M.life >= M.mlife) M.life=M.mlife;M.Update()
						return
					if( B.icon == 'WoodmanProjectile.dmi' )
						B.LifeTime = MAX_LIFE_TIME

					B.icon_state = "right"
					B.Owner = M.key
					if( !isnull( B.LifeTime ) ) ++B.LifeTime;
					return
			if("blockleft")
				if(B.icon_state == "right")
					ShieldDrain_fromHit(B.Damage, M)
					if( B.icon == 'WoodmanProjectile.dmi' )
						del B
						return

					B.icon_state = "left"
					B.Owner = M.key
					if( !isnull( B.LifeTime ) ) ++B.LifeTime;
					return
			if("blockright" )
				if(B.icon_state == "left")
					ShieldDrain_fromHit(B.Damage, M)
					if( B.icon == 'WoodmanProjectile.dmi' )
						B.LifeTime = MAX_LIFE_TIME

					B.icon_state = "right"
					B.Owner = M.key
					if( !isnull( B.LifeTime ) ) ++B.LifeTime;
					return
		for(var/mob/Entities/Player/P in world)
			if(P.key==B.Owner)

				if(M.Stats[c_Team]!="N/A"&&M.Stats[c_Team]==P.Stats[c_Team])
					del B
					return
		if(istype(M,/mob/Entities/Player)&&M.Stats[Kills]<125&&B.Damage>1&&B.Damage < 28)
			B.Damage--
		B.Damage = (B.Damage-M.DefenseBuff)*Multiplier
		var/DamageDivTwo = round(B.Damage * 0.5)
		if(B.icon == 'CutShot.dmi') B.Damage = rand(B.Damage,(B.Damage*4))
		switch( M.Class )
			if("Valnaire") B.Damage=Multiplier
			if("Plague") B.Damage=2
			if("Cliff")
				B.Damage=DamageDivTwo
			if( "King" )
				B.Damage = round( B.Damage * 0.33 )
			if("GAX") B.Damage = round( B.Damage * 0.25)
			if("Zombie")
				if(B.Damage>14) B.Damage=14
				else B.Damage=DamageDivTwo
		if(B.Damage<1) B.Damage=1
		if(M.ReverseDMG==1) B.Damage*=-1
		M.life-=round(B.Damage)
		M.KilledBy = B.Owner
		flickHurt(M)
		if(M.life <= 0)
			Death(M)
		del B

	Sword_Hit(var/mob/M, mob/A)
		if(isnull(M)||isnull(A)||M.Guard>2) return
		// mob/M is the target
		// mob/A is the user
		if(M.Stats[c_Team] != "N/A"&&M.Stats[c_Team] == A.Stats[c_Team]) return
		var/LifeDamage=A.Attack

		if(istype(M,/mob/Entities/Player)&&M.Stats[Kills]<125&&LifeDamage>1&&LifeDamage< 28)
			LifeDamage--
		LifeDamage = (((LifeDamage+A.AttackBuff)-M.DefenseBuff)*2)*Multiplier
		for(var/turf/T in view(1, M.loc))
			if(istype(T, /turf/FlagPoint)|| istype(T, /turf/SpawnPoints))
				A.life-=round(LifeDamage)
				LifeDamage = A.Attack*Multiplier
				flickHurt(A, A)
				if(A.life <= 0) Death(A)
		if(M.Class!="Leviathen")
			if(M.icon_state == "guardleft"&&A.icon_state == "right") return
			if(M.icon_state == "guardright"&&A.icon_state == "left") return
		switch(M.Types)
			if("right1", "right2", "left1", "left2") return
		if(M.Class=="Zombie")
			switch(M.icon_state)
				if("armleft", "armright", "brokenarmleft", "brokenarmright")
					if(M.icon_state=="armleft"&&A.icon_state=="left"&&A.x==M.x+1)
						flick("armbreakleft",M)
						M.icon_state="brokenarmleft"
						if(istype(M, /mob/ZIW))
							M.Types="left2"
							for(var/mob/ZIW/L in world)
								L.Types=M.Types
					else if(M.icon_state=="armright"&&A.icon_state=="right"&&A.x==M.x-1)
						flick("armbreakright",M)
						M.icon_state="brokenarmright"
						if(istype(M, /mob/ZIW))
							M.Types="right2"
							for(var/mob/ZIW/L in world)
								L.Types=M.Types
					else return
			if(A.Attack>14) LifeDamage=14
			else LifeDamage=round(((A.Attack*2)*Multiplier)*0.5)
		switch( M.icon_state )
			if( "shieldleft", "blockleft")
				ShieldDrain_fromHit(LifeDamage, M)
				if(M.Class!="SaX"&&M.Class!="Burnerman")
					if( A.x <= M.x-1 )


						LifeDamage = M.Attack*Multiplier
						A.life -= LifeDamage

						A.KilledBy = M.key
						flickHurt(A)
						if( A.life <= 0 )
							Death( A )
						return
				if(A.icon_state=="right") return
			if("shieldright", "blockright")
				ShieldDrain_fromHit(LifeDamage, M)
				if(M.Class!="SaX"&&M.Class!="Burnerman")
					if( A.x >= M.x+1 )

						LifeDamage = M.Attack*Multiplier
						A.life -= LifeDamage

						A.KilledBy = A.key
						flickHurt(A)
						if( A.life <= 0 )
							Death( A )
						return
				if(A.icon_state=="left") return
		if(M.Guard>0)
			switch( M.icon )
				if('GateSlash.dmi','GateSlash(2).dmi','GateSlash(3).dmi','GateSlash(4).dmi','GateSlash(5).dmi')
					del M
					return
				else return // if anubis wall's or athena's fire pits, return
		switch( M.Class )
			if("Valnaire") 	LifeDamage=Multiplier
			if("SJX") 		LifeDamage=2
			if("Cliff") 	LifeDamage=round(((A.Attack*2)*Multiplier) * 0.5)
			if("King") 		LifeDamage = round( LifeDamage * 0.33 )
			if("GAX") 		LifeDamage = round(LifeDamage * 0.25)
	//	if(M.Class=="SJX") return
		if(LifeDamage<1) 	LifeDamage = 1
		if(M.ReverseDMG==1) LifeDamage*=-1

		M.life-=round(LifeDamage)

		M.KilledBy = A.key
		flickHurt(M)
		if(M.life <= 0)
			Death(M)
	Smash_Hit(var/mob/M, mob/A)
		if(isnull(M)||isnull(A)) return
		if(M.Stats[c_Team] != "N/A"&&M.Stats[c_Team] == A.Stats[c_Team]) return
		switch( M.Types )
			if("right1","right2","left1","left2") return
		if(M.Guard>2) return
		var/LifeDamage=A.Attack
		if(istype(M,/mob/Entities/Player)&&M.Stats[Kills]<125&&A.Attack>1&&A.Attack < 28)
			LifeDamage--
		LifeDamage = (((A.Attack+A.AttackBuff)-M.DefenseBuff)*Multiplier)
		for(var/turf/T in view(1,M.loc))
			if(istype(T, /turf/FlagPoint)|| istype(T, /turf/SpawnPoints))
				if(!isnull(A))
					ShieldDrain_fromHit(LifeDamage, M)


					A.life-=round(LifeDamage)
					LifeDamage = A.Attack
					A.KilledBy = A.key
					flickHurt(A)
					if(A.life <= 0) Death(A)

		if(isnull(M)) return
		switch( M.Class )
			if("Valnaire") 	LifeDamage=Multiplier
			if("Cliff") 	LifeDamage=round(LifeDamage* 0.5)
			if( "King" ) 	LifeDamage = round( LifeDamage * 0.33 )
			if("GAX") 		LifeDamage = round(LifeDamage * 0.25)
			if("Zombie")
				switch(M.icon_state)
					if("armleft", "armright", "brokenarmleft", "brokenarmright") return
				if(A.Attack>14)  LifeDamage=14
				else  LifeDamage=round((A.Attack*Multiplier)* 0.5)
			if("Leviathen")
				switch( M.icon_state )
					if("guardright","guardleft") return
		if(LifeDamage<1) LifeDamage = 1
		if(M.ReverseDMG==1) LifeDamage*=-1


		M.life-=round(LifeDamage)


		M.KilledBy = A.key
		flickHurt(M)
		if(M.life <= 0)
			Death(M)
