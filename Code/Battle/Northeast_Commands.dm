var
	const
		c_MAX_ACTIVE_ACTIONS = 2
		c_SHOOTING = 1
		c_SLASHING = 1
		c_HEALING = 1
		c_MAX_PASSIVE_ACTIONS = 4
		c_TELEPORTING = 1
		c_CLIMBING = 1
		c_GUARDING = 1
mob/var
	Active_Actions[c_MAX_ACTIVE_ACTIONS]
	Passive_Actions[c_MAX_PASSIVE_ACTIONS]

proc/getAction(var/mob/ref)
	var/Action = 0
	for(var/i = 1 to c_MAX_ACTIVE_ACTIONS)
		if(ref.Active_Actions[i] == 1) Action = 1;break
	for(var/i = 1 to c_MAX_PASSIVE_ACTIONS)
		if(ref.Passive_Actions[i] == 1) Action = 1;break
	return Action;
mob/proc
// ATHENAII_NE
	AthenaII_Slash()
		if(isnull(src) || src.Slashing==1||src.climbing==1||src.Dead==1) return
		src.Slashing=1
		flick("slash[src.icon_state]",src)
		switch( src.icon_state )
			if( "left" )
				for(var/mob/M in oview(1))
					NULL_C(M)
					NULL_R(src)
					if(M.x==src.x-1&&M.y==src.y)
						Sword_Hit(M,src)
						sleep(3)
						NULL_R(src)
						src.Slashing=0
						return
				for(var/obj/O in oview(1))
					NULL_C(O)
					NULL_R(src)
					if(O.y == src.y&&O.x == src.x+1&&O.icon_state == "right")
						O.icon_state = "left"
						O.Owner=src.key
			if( "right" )
				for(var/mob/M in oview(1))
					NULL_C(M)
					NULL_R(src)
					if(M.x==src.x+1&&M.y==src.y)
						Sword_Hit(M,src)
						sleep(3)
						src.Slashing=0
						return
				for(var/obj/O in oview(1))
					NULL_C(O)
					NULL_R(src)
					if(O.y == src.y&&O.x == src.x-1&&O.icon_state == "left")
						O.icon_state = "right"
						O.Owner=src.key

		if(world.time - src.delay_time >= src.delay)    // A simple delay to keep you from macroing it tons.
			src.delay_time = world.time     // You could lengthen or shorten the delay simply by raising or lowering the mob's delay variable.
			var/obj/Blasts/Blast/S = new /obj/Blasts/Blast(locate(src.x, src.y, src.z))   // Make a new instance of a laser (but don't actually create it, yet)
			switch( src.icon_state )
				if( "right")
					S.icon_state = "right"    // Set it's state (important not only for proper glitz, but for movement),
				if( "left")
					S.icon_state = "left"
			S.Damage = (src.Attack/2)
			S.Owner = src.key
			S.icon='AthenaShot.dmi'
			S.pixel_y=src.pixel_y
			S.BlastMove()
		sleep(5)
		NULL_R(src)
		src.Slashing=0
		return
// SOLCOUD_NE
	UpSlash()
		if(src.Slashing==1||src.Teleporting==1||src.Dead==1) return
		if(src.Slashing==0)
			src.Slashing=1
			switch(src.icon_state)
				if("left")
					src.icon_state="upslashleft"
					for(var/i = 0 to 5)
						sleep(1)
						for(var/mob/M in oview(1))
							if(istype(M, /mob/AW2) || M.Dead==1 || M.x >= src.x || M.Guard > 2 || getBarrier_Blast(M) != 0 || M.key == src.key||M.Class=="Zombie") continue
							if(M.Dead==1) continue
							if(M.x >= src.x) continue
							if(istype(M, /mob/Entities))

								isClimbing(M)

								while(src.icon_state=="upslashleft")
									if(src.Dead == 1 || M.Dead == 1 || isnull(src) || isnull(M) ||M.y < src.y || M.x >= src.x) break
									sleep(1)
									Sword_Hit(M,src)
									step(M,NORTH)
									step(src,NORTH)
								if(isnull(M)||M.Dead==1||M.x<=src.x-2||M.y>src.y+1) i=0;break
							else if(istype(M, /mob/Entities/PTB))
								if(M.y>=src.y&&M.y<=src.y+1) Sword_Hit(M,src)
							else
								if(src.Dead!=1)
									sleep(1)
									del M
						step(src,NORTH)
					sleep(1)
					switch(src.icon_state)
						if("left", "upslashleft")
							src.icon_state = "left"
						if("right")
							src.icon_state = "right"
				if("right")
					src.icon_state="upslashright"
					for(var/i= 0 to 5)
						sleep(1)

						for(var/mob/M in oview(1))
							if(istype(M, /mob/AW2) || M.Dead==1 || M.x >= src.x || M.Guard > 2 || getBarrier_Blast(M) != 0 || M.key == src.key||M.Class=="Zombie") continue
							if(M.Dead==1) continue
							if(M.x <= src.x) continue
							if(istype(M, /mob/Entities))

								isClimbing(M)

								while(src.icon_state=="upslashright")
									if(src.Dead == 1 || M.Dead == 1 || isnull(src) || isnull(M) ||M.y < src.y || M.x <= src.x) break
									sleep(1)
									Sword_Hit(M,src)
									step(M,NORTH)
									step(src,NORTH)
								if(isnull(M)||M.Dead==1||M.x<=src.x+2||M.y>src.y+1) i=0;break
							else if(istype(M, /mob/Entities/PTB))
								if(M.y>=src.y&&M.y<=src.y+1) Sword_Hit(M,src)
							else
								if(src.Dead!=1)
									sleep(1)
									del M
						step(src,NORTH)
					sleep(1)
					switch( src.icon_state )
						if("left")
							src.icon_state = "left"
						if("upslashright", "upslashright")
							src.icon_state = "right"
			src.Slashing=0
// SWORDMAN_NE
	Swordman_Slash()
		if(src.Slashing == 1||src.Dead==1) return
		src.Slashing=1
		var/Delay1 = 1
		var/Delay2 = 3
		var/Delay3 = 2
		var/Range = 1
		var/yRange
		switch(src.Class)
			if("Swordman")
				flick("slash[src.icon_state]",src)
				Delay1 = 2
				Delay2 = 4
				Delay3 = Delay2
				Range = 2
			if("Dynamo")
				flick("throw[src.icon_state]",src)
				Delay1 = 6
				Delay2 = 4

		yRange = Range
		sleep(Delay1)
		switch( src.icon_state )
			if("left")
				for(var/mob/M in oview(Range))

					if(isnull(M) || M.Dead == 1) continue
					if(M.y >= src.y && M.y <= src.y+yRange && M.x < src.x)
						Sword_Hit(M,src)
						Delay2=Delay3
				for(var/obj/Blasts/O in oview(Range))
					if(O.y == src.y&&O.y <= src.y+yRange&&O.x < src.x&&O.icon_state == "right")
						O.icon_state = "left"
						O.Owner=src.key
			if("right")
				for(var/mob/M in oview(Range))
					if(isnull(M) || M.Dead == 1) continue
					if(M.y >= src.y && M.y <= src.y+yRange && M.x > src.x)
						Sword_Hit(M,src)
						Delay2=Delay3
				for(var/obj/Blasts/O in oview(Range))
					if(O.y == src.y&&O.y <= src.y+yRange&&O.x < src.x&&O.icon_state == "left")
						O.icon_state = "left"
						O.Owner=src.key
		sleep(Delay2)
		src.Slashing=0
// TENGUMAN_NE
	Tengu_Slash()
		if(src.Slashing == 1||src.Dead==1) return
		src.Slashing=1
		flick("mel[src.icon_state]",src)
		var/Delay = 4
		sleep(3)
		switch(src.icon_state)
			if("left")
				for(var/mob/M in oview(1))
					if(M.y<=src.y&&M.x < src.x)
						Sword_Hit(M,src)
						Delay = 2
				for(var/obj/Blasts/O in oview(1))
					if(O.y<=src.y&&O.x < src.x&&O.icon_state == "right")
						O.icon_state = "left"
						O.Owner=src.key
			if("right")
				for(var/mob/M in oview(1))
					if(M.y<=src.y&&M.x > src.x)
						Sword_Hit(M,src)
						Delay = 2
				for(var/obj/Blasts/O in oview(1))
					if(O.y<=src.y&&O.x > src.x&&O.icon_state == "left")
						O.icon_state = "right"
						O.Owner=src.key
		sleep(Delay)
		src.Slashing=0

// CLOWNMAN_NE
	#ifdef INCLUDED_CLOWNMAN_DM
	ClownGrab()
		if(src.Slashing==1||src.Dead==1) return
		src.Slashing=1
		flick("shoot[src.icon_state]",src)
		switch( src.icon_state )
			if("right")
				for(var/mob/M in oview(4))
					NULL_C( M )
					if( M.x <= src.x ) continue
					if(M.Stats[c_Team]=="N/A"||M.Stats[c_Team]!=src.Stats[c_Team])
						var/turf/aturf = locate(M.x, M.y-1, M.z)  // Get the turf directly below you.
						var/dense = 0
						if(aturf)
							for(var/atom/A in aturf)
								if(A.density == 1)
									dense = 1
									break
							if(aturf.density == 1) dense = 1
						if(!aturf) dense = 1
						if(dense == 1)
							if(istype(M, /mob/Entities/Player)||istype(M, /mob/Entities/PTB))
								Sword_Hit(M,src)
								if(M.Dead!=1&&src.Dead!=1)
									NULL_C( M )
									for(var/X in typesof(/obj/Projectiles/ClownmanShot)) M.overlays+=X
									sleep(6)
									NULL_C( M )
									for(var/Y in typesof(/obj/Projectiles/ClownmanShot)) M.overlays-=Y
									if(!isnull(M)&&!isnull(src))
										if(M.Dead!=1&&istype(M, /mob/Entities/Player)&&M.key!=src.key)
											M.islocked=2
											LockCheck(M)
							else
								Sword_Hit(M,src)
							src.Slashing=0
							return
			if("left")
				for(var/mob/M in oview(4))
					NULL_C( M )
					if( M.x >= src.x ) continue
					if(M.Stats[c_Team]=="N/A"||M.Stats[c_Team]!=src.Stats[c_Team])
						var/turf/aturf = locate(M.x, M.y-1, M.z)  // Get the turf directly below you.
						var/dense = 0
						if(aturf)
							for(var/atom/A in aturf)
								if(A.density == 1)
									dense = 1
									break
							if(aturf.density == 1) dense = 1
						if(!aturf) dense = 1
						if(dense == 1)
							if(istype(M, /mob/Entities/Player)||istype(M, /mob/Entities/PTB))
								Sword_Hit(M,src)
								if(M.Dead!=1&&src.Dead!=1)
									NULL_C( M )
									for(var/X in typesof(/obj/Projectiles/ClownmanShot)) M.overlays+=X
									sleep(6)
									NULL_C( M )
									for(var/Y in typesof(/obj/Projectiles/ClownmanShot)) M.overlays-=Y
									if(!isnull(M)&&!isnull(src))
										if(M.Dead!=1&&istype(M, /mob/Entities/Player)&&M.key!=src.key)
											M.islocked=2
											LockCheck(M)
							else
								Sword_Hit(M,src)
							src.Slashing=0
							return
		sleep(3)
		src.Slashing=0
		return
	#endif
	ZanzibarSlash()
		if(src.Slashing == 1 || src.Dead == 1 || isnull(src)) return // Error handler, also spam handler
		src.Slashing=1
		var/Range = 3
		var/Delay = 3
		var/Delay1 = 8
		flick("slash[src.icon_state]",src)
		sleep(Delay)
		switch(src.icon_state)
			if("left")
				for(var/mob/Entities/M in oview(Range))
					if( isnull( M ) || M.Guard > 2 || M.key == src.key || M.Dead == 1 || M.Playing == 0) continue;
					if( isnull( src ) ) break
					if(M.y == src.y && M.x < src.x)
						Sword_Hit(M,src)
						if(ActionUse[AOE]==0)
							Smash_Hit(M,src)
			if("right")
				for(var/mob/Entities/M in oview(Range))
					if( isnull( M ) || M.Guard > 2 || M.key == src.key || M.Dead == 1 || M.Playing == 0) continue;
					if( isnull( src ) ) break
					if(M.y == src.y && M.x > src.x)
						Sword_Hit(M,src)
						if(ActionUse[AOE]==0)
							Smash_Hit(M,src)
		sleep(Delay1)
		src.Slashing = 0
	DG_Slash()
		if(src.Slashing == 1||src.Dead==1) return
		src.Slashing=1
		flick("slash[src.icon_state]",src)
		sleep(1)
		switch( src.icon_state )
			if("left")
				for(var/mob/M in oview(1))
					if(M.y == src.y&&M.x < src.x)
						Sword_Hit(M,src)
						sleep(1)
						src.Slashing=0
						return
				for(var/obj/Blasts/O in oview(1))
					if(O.y == src.y&&O.x < src.x&&O.icon_state == "right")
						O.icon_state = "left"
						O.Owner=src.key
			if("right")
				for(var/mob/M in oview(1))
					if(M.y == src.y&&M.x > src.x)
						Sword_Hit(M,src)
						sleep(1)
						src.Slashing=0
						return
				for(var/obj/Blasts/O in oview(1))
					if(O.y == src.y&&O.x > src.x&&O.icon_state == "left")
						O.icon_state = "right"
						O.Owner=src.key
		sleep(2)
		src.Slashing=0
	PureZero_Slash()
		NULL_R( src )
		if( src.Slashing == 1 || src.Dead == 1 ) return
		src.Slashing = 1
		flick( "attack[src.icon_state]", src )
		sleep(3)
		NULL_R( src )
		var/Range = 3;
		switch( src.icon_state )
			if( "left" )
				for( var/mob/M in oview(Range) )
					NULL_C( M )
					NULL_R( src )
					if( M.y < src.y || M.x >= src.x ) continue
					isClimbing(M)
					Sword_Hit( M, src )
					NULL_C( M )
					if( M.Guard > 2 || M.Dead == 1 || M.Class == "Zombie") continue
					if( M.Stats[c_Team] == src.Stats[c_Team] && M.Stats[c_Team] != "N/A" ) continue
					if( istype( M, /mob/Entities ) )
						for( var/i = 0 to 16 )
							NULL_B( M )
							NULL_R( src )
							for( var/turf/Capsules/T in view( 3, M.loc ) )
								break
							step( M, WEST )
				for( var/obj/Blasts/O in oview(Range) )
					NULL_C( O )
					NULL_R( src )
					if( O.y < src.y || O.x >= src.x || O.icon_state != "right" ) continue
					O.icon_state = "left"
					O.Owner = src.key
					if( LockList.Find( "[src.key]" ) ) break
			if( "right" )
				for( var/mob/M in oview(Range) )
					NULL_C( M )
					NULL_R( src )
					if( M.y < src.y || M.x <= src.x ) continue
					isClimbing(M)
					Sword_Hit( M, src )
					NULL_C( M )
					if( M.Guard > 2 || M.Dead == 1 ) continue
					if( M.Stats[c_Team] == src.Stats[c_Team] && M.Stats[c_Team] != "N/A" ) continue
					if( M.Class == "Zombie" ) continue
					if( istype( M, /mob/Entities ) )
						for( var/i = 0 to 16 )
							NULL_B( M )
							NULL_R( src )
							for( var/turf/Capsules/T in view( 3, M.loc ) )
								break
							step( M, EAST )
				for( var/obj/Blasts/O in oview(Range) )
					NULL_C( O )
					NULL_R( src )
					if( O.y < src.y || O.x <= src.x || O.icon_state != "left" ) continue
					O.icon_state = "right"
					O.Owner = src.key
					if( LockList.Find( "[src.key]" ) ) break

		sleep(3)
		NULL_R( src )
		src.Slashing=0



	Sigma_Double()
		NULL_R( src )
		if( src.Shooting == 1 || src.Teleporting == 1 || src.Dead == 1 ) return
		src.Shooting = 1
		flick( "double[src.icon_state]", src )
		for( var/mob/M in oview(1) )
			NULL_C( M )
			NULL_R( src )
			if( M.density == 0 || M.x == src.x || M.y < src.y || getBarrier_Blast(M) != 0 || M.Guard > 2 ) continue
			if( M.x > src.x )
				Smash_Hit( M, src )
				NULL_C( M )
				if( M.Dead == 1 ) continue
				if( istype(M, /mob/Entities/Player ) )
					isDefending( M )
					isClimbing(M)
					if(M.icon_state == "") M.Flight = 0
					M.icon_state = "right"
					if( M.Class == "Vile" ) M.Flight = 0
					if( M.Stats[c_Team] == src.Stats[c_Team] && M.Stats[c_Team] != "N/A" ) continue
					if( M.Class == "Zombie" ) continue
					for( var/i = 0 to 5 )
						for( var/turf/Capsules/T in view(2, M.loc) )
							break
						step( M, EAST )
			if( M.x < src.x )
				Smash_Hit( M, src )
				NULL_C( M )
				if( M.Dead == 1 ) continue
				if( istype(M, /mob/Entities/Player ) )
					isDefending( M )
					isClimbing(M)
					if(M.icon_state == "") M.Flight = 0
					M.icon_state = "left"
					if( M.Class == "Vile" ) M.Flight = 0
					if( M.Stats[c_Team] == src.Stats[c_Team] && M.Stats[c_Team] != "N/A" ) continue
					if( M.Class == "Zombie" ) continue
					for( var/i = 0 to 5 )
						for( var/turf/Capsules/T in view(2, M.loc) )
							break
						step( M, WEST )
		sleep(2)
		src.Shooting = 0