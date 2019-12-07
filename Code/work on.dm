
mob/proc
	FAXCharge()
		if(src.Teleporting==1||src.Dead==1 || Drain_fromUse(1, usr) == 0) return;
		src.Teleporting=1
		src.Guard=1
		switch( src.icon_state )
			if("right")
				src.icon_state="sidedashright"
				var/iMAX = 4
				for(var/i= 0 to iMAX)
					sleep(1)
					var/turf/_aturf = get_step(src, EAST)
					if( isnull( _aturf ) || _aturf.density==1) break;
					for(var/mob/M in oview(2))
						if(src.Dead == 1||isnull(src)) break
						if(M.x <= src.x || istype(M, /mob/AW2)) continue
						if(istype(M, /mob/Entities) )
							if( M.key == src.key || M.Guard >= 3 || getBarrier_Blast(M) != 0 || M.Class == "Zombie" || M.x != src.x+1 || M.y != src.y) continue

							isDefending( M )
							isClimbing(M)
							for(var/u = i to iMAX)
							//	sleep(1)
								Smash_Hit(M,src)
								var/turf/aturf = locate(src.x+2, src.y, src.z)  // Get the turf directly below you.
								var/dense = 0
								if(aturf)
									for(var/atom/A in aturf)
										if(A.density == 1) dense = 1;break
									if(aturf.density == 1) dense = 1
								if(!aturf) dense = 1
								if(dense == 1)
									step(M,EAST)
									step(M,EAST)
								else
									src.loc=locate(src.x+2, src.y, src.z)
								step(src,EAST)
								step(src,EAST)
							i = iMAX
						else if(istype(M, /mob/Entities/PTB)) Smash_Hit(M,src)
						else
							sleep(1)
							del M
					step(src,EAST)
					step(src,EAST)
			if("left")
				src.icon_state="sidedashleft"
				var/iMAX = 4
				for(var/i= 0 to iMAX)
					sleep(1)
					var/turf/_aturf = get_step(src, WEST)
					if( isnull( _aturf ) || _aturf.density==1) break;
					for(var/mob/M in oview(2))
						if(src.Dead == 1 || isnull(src)) break
						if( M.x >= src.x || istype(M, /mob/AW2)) continue
						else if(istype(M, /mob/Entities))
							if( M.key == src.key || M.Guard >= 3 || getBarrier_Blast(M) != 0 || M.Class == "Zombie" || M.y != src.y || M.x != src.x-1) continue
							isDefending( M )
							isClimbing(M)
							for(var/u = i to iMAX)
							//	sleep(1)
								Smash_Hit(M,src)
								var/turf/aturf = locate(src.x-2, src.y, src.z)  // Get the turf directly below you.
								var/dense = 0
								if(aturf)
									for(var/atom/A in aturf)
										if(A.density == 1) dense = 1;break
									if(aturf.density == 1) dense = 1
								if(!aturf) dense = 1
								if(dense == 1)
									step(M,WEST)
									step(M,WEST)
								else
									src.loc=locate(src.x-2,src.y,src.z)
								step(src,WEST)
								step(src,WEST)
							i = iMAX
						else if(istype(M, /mob/Entities/PTB)) Smash_Hit(M,src)
						else
							sleep(1)
							del M
					step(src,WEST)
					step(src,WEST)
		switch( src.icon_state )
			if("sidedashright") src.icon_state="right"
			if("sidedashleft") src.icon_state="left"
		src.Guard=0
		src.Teleporting=0
	RushCharge1()
		if(src.Teleporting==1||src.Dead==1) return
		if(Drain_fromUse(1, usr) == 0) return;
		src.Teleporting=1
		switch( src.icon_state )
			if("right")
				src.icon_state="downrightdash"
				var/iMAX = 4
				for(var/i= 0 to iMAX)
					sleep(1)
					var/turf/aturf = get_step(src, SOUTHEAST)
					if(isnull( aturf ) || aturf.density==1) break;
					for(var/mob/M in oview(1))
						if(src.Dead == 1 || isnull(src)) break;
						if( M.x <= src.x || M.Guard>= 3 ) continue
						if(istype(M, /mob/Entities))
							if(M.Guard >= 3 || getBarrier_Blast(M) != 0 || M.key == src.key || M.Class == "Zombie") continue
							isDefending( M )
							isClimbing(M)
							for(var/u = i to iMAX)
								Smash_Hit(M,src)
								for(var/mob/Entities/N in oview(1))
									if(isnull(src)) break
									if(isnull(M) || isnull(N) || N.key == M.key || N.Guard >= 3 || getBarrier_Blast(N) != 0) continue
									Smash_Hit(N,src)
								step(M,SOUTHEAST)
								step(M,SOUTHEAST)
								step(src,SOUTHEAST)
								step(src,SOUTHEAST)
							i = iMAX
						else if(istype(M, /mob/Entities/PTB)) Smash_Hit(M,src)
						else
							sleep(1)
							del M
					step(src,SOUTHEAST)
					step(src,SOUTHEAST)
			if("left")
				src.icon_state="downleftdash"
				var/iMAX = 4
				for(var/i= 0 to 4)
					sleep(1)
					var/turf/aturf = get_step(src, SOUTHWEST)
					if( isnull( aturf ) || aturf.density==1) break;
					for(var/mob/M in oview(1))
						if(src.Dead == 1 || isnull(src)) break;
						if( M.x >= src.x || M.Guard >= 3 ) continue
						if(istype(M, /mob/Entities))
							if(M.Guard >= 3 || getBarrier_Blast(M) != 0 || M.key == src.key || M.Class == "Zombie") continue
							isDefending( M )
							isClimbing(M)
							for(var/u = i to 4)
								Smash_Hit(M,src)
								for(var/mob/Entities/N in oview(1))
									if(isnull(src)) break
									if(isnull(M) || isnull(N) || N.key == M.key || N.Guard >= 3 || getBarrier_Blast(N) != 0) continue
									Smash_Hit(N,src)
								step(M,SOUTHWEST)
								step(M,SOUTHWEST)
								step(src,SOUTHWEST)
								step(src,SOUTHWEST)
							i = iMAX
						else if(istype(M, /mob/Entities/PTB)) Smash_Hit(M,src)
						else
							sleep(1)
							del M
					step(src,SOUTHWEST)
					step(src,SOUTHWEST)
		switch( src.icon_state )
			if("downrightdash") src.icon_state="right"
			if("downleftdash") src.icon_state="left"
		src.Teleporting=0
	RushCharge2()
		if(src.Teleporting==1||src.Dead==1) return
		if(Drain_fromUse(1, usr) == 0) return;
		src.Teleporting=1
		switch( src.icon_state )
			if("right")
				src.icon_state="uprightdash"
				var/iMAX = 4
				for(var/i= 0 to iMAX)
					sleep(1)
					var/turf/aturf = get_step(src, NORTHEAST)
					if(isnull( aturf ) || aturf.density==1) break;
					for(var/mob/M in oview(1))
						if(src.Dead == 1 || isnull(src)) break;
						if( M.x <= src.x || M.Guard>= 3 ) continue
						if(istype(M, /mob/Entities))
							if(M.Guard >= 3 || getBarrier_Blast(M) != 0 || M.key == src.key || M.Class == "Zombie") continue
							isDefending( M )
							isClimbing(M)
							for(var/u = i to iMAX)
								Smash_Hit(M,src)
								for(var/mob/Entities/N in oview(1))
									if(isnull(src)) break
									if(isnull(M) || isnull(N) || N.key == M.key || N.Guard >= 3 || getBarrier_Blast(N) != 0) continue
									Smash_Hit(N,src)
								step(M,NORTHEAST)
								step(M,NORTHEAST)
								step(src,NORTHEAST)
								step(src,NORTHEAST)
							i = iMAX
						else if(istype(M, /mob/Entities/PTB)) Smash_Hit(M,src)
						else
							sleep(1)
							del M
					step(src,NORTHEAST)
					step(src,NORTHEAST)
			if("left")
				src.icon_state="upleftdash"
				var/iMAX = 4
				for(var/i= 0 to iMAX)
					sleep(1)
					var/turf/aturf = get_step(src, NORTHWEST)
					if( isnull( aturf ) || aturf.density==1) break;
					for(var/mob/M in oview(1))
						if(src.Dead == 1 || isnull(src)) break;
						if( M.x >= src.x || M.Guard >= 3 ) continue
						if(istype(M, /mob/Entities))
							if(M.Guard >= 3 || getBarrier_Blast(M) != 0 || M.key == src.key || M.Class == "Zombie") continue
							isDefending( M )
							isClimbing(M)
							for(var/u = i to iMAX)
								Smash_Hit(M,src)
								for(var/mob/Entities/N in oview(1))
									if(isnull(src)) break
									if(isnull(M) || isnull(N) || N.key == M.key || N.Guard >= 3 || getBarrier_Blast(N) != 0) continue
									Smash_Hit(N,src)
								step(M,NORTHWEST)
								step(M,NORTHWEST)
								step(src,NORTHWEST)
								step(src,NORTHWEST)
							i = iMAX
						else if(istype(M, /mob/Entities/PTB)) Smash_Hit(M,src)
						else
							sleep(1)
							del M
					step(src,NORTHWEST)
					step(src,NORTHWEST)
		switch( src.icon_state )
			if("uprightdash") src.icon_state="right"
			if("upleftdash") src.icon_state="left"
		src.Teleporting=0
mob/proc
	OverDrive()
		if(src.Slashing==1||src.Teleporting==1||src.Dead==1) return
		if(src.Slashing==0)
			if(Drain_fromUse(1, usr) == 0) return;
			src.Slashing=1
			flick("slash[src.icon_state]",src)
			switch( src.icon_state )
				if( "right" )
					for( var/mob/M in oview( 2 ) )
						NULL_C( M )
						NULL_B( src )
						if( M.x > src.x )
							Sword_Hit( M, src )
					for( var/obj/Blasts/O in oview( 2 ) )
						NULL_C( O )
						NULL_B( src )
						if( O.x > src.x && O.icon_state == "left" )
							O.icon_state = "right"
							O.Owner = src.key

				if( "left" )
					for( var/mob/M in oview( 2 ) )
						NULL_C( M )
						NULL_B( src )
						if( M.x < src.x )
							Sword_Hit( M, src )
					for( var/obj/Blasts/O in oview( 2 ) )
						NULL_C( O )
						NULL_B( src )
						if( O.x < src.x && O.icon_state == "right" )
							O.icon_state = "left"
							O.Owner = src.key


			if(src.Teleporting==0)
				src.Shooting = 1
				src.Shoot()
				src.Shooting = 0

			sleep(5)
			src.Slashing=0
			return
	SolMDash()
		if(src.Teleporting==1||src.Slashing==1||src.Dead==1) return
		if(src.Teleporting==0)
			if(Drain_fromUse(1, usr) == 0) return;
			src.Teleporting=1
			src.Guard=1
			switch(src.icon_state)
				if("right")
					src.icon_state="dashright"
					for(var/i=0 to 4)
						sleep(1)
						for(var/mob/M in oview(3))
							if(istype(M, /mob/AW2)) continue
							if(M.x <= src.x) continue
							if(M.y != src.y) continue
							if(istype(M, /mob/Entities))
								if(M.Guard >= 3) continue
								if(getBarrier_Blast(M) == 1) continue
								if(M.key==src.key) continue
								if(M.Class=="Zombie") continue
								isDefending(M)
								for(var/u=1 to i)
									sleep(1)
									var/turf/aturf = locate(src.x+2, src.y, src.z)  // Get the turf directly below you.
									var/dense = 0
									if(aturf)
										for(var/atom/A in aturf)
											if(A.density == 1) dense = 1;break
										if(aturf.density == 1) dense = 1
									if(!aturf) dense = 1
									if(dense == 1)
										Smash_Hit(M,src)
										for(var/a=1 to 4)
											step(M,EAST)
											step(src,EAST)
									else
										Smash_Hit(M,src)
										src.loc=locate(src.x+2,src.y,src.z)
										for(var/a=1 to 4)
											step(src,EAST)
									i=u
							else if(istype(M, /mob/Entities/PTB))
								Smash_Hit(M,src)
							else
								if(src.Dead==1)
									break
								sleep(1)
								del M
						for(var/a=1 to 4)
							step(src,EAST)
					switch(src.icon_state)
						if("right","dashright")
							src.icon_state="right"
						if("left")
							src.icon_state="left"

				if("left")
					src.icon_state="dashleft"
					for(var/i=0 to 4)
						sleep(1)
						for(var/mob/M in oview(2))
							if(istype(M, /mob/AW2)) continue
							if(M.x >= src.x) continue
							if(M.y != src.y) continue
							if(istype(M, /mob/Entities))
								if(M.key == src.key) continue
								if(M.Guard >= 3) continue
								if(getBarrier_Blast(M) == 1) continue
								if(M.Class=="Zombie") continue
								isDefending(M)
								for(var/u=1 to i)
									sleep(1)
									var/turf/aturf = locate(src.x-2, src.y, src.z)  // Get the turf directly below you.
									var/dense = 0
									if(aturf)
										for(var/atom/A in aturf)
											if(A.density == 1) dense = 1;break
										if(aturf.density == 1) dense = 1
									if(!aturf) dense = 1
									if(dense == 1)
										Smash_Hit(M,src)
										for(var/a=1 to 4)
											step(M,WEST)
											step(src,WEST)
									else
										Smash_Hit(M,src)
										src.loc=locate(src.x-2,src.y,src.z)
										for(var/a=1 to 4)
											step(src,WEST)
									i=u
							else if(istype(M, /mob/Entities/PTB)) Smash_Hit(M,src)
							else
								if(src.Dead!=1)
									sleep(1)
									del M
						for(var/a=1 to 4)
							step(src,WEST)
					switch(src.icon_state)
						if("right")
							src.icon_state="right"
						if("left", "dashleft")
							src.icon_state="left"
			sleep(1)
			src.Guard=0
			src.Teleporting=0
			return
	SolDash()
		if(src.Teleporting==1||src.Slashing==1||src.Dead==1 ) return
		if(src.Teleporting==0)
			src.Teleporting=1
			src.Guard=1
			var/const/c_maxDashDist = 6
			var/const/c_DashView = 2
			switch(src.icon_state)
				if("right")
					src.icon_state="dashslashright"
					for(var/i=1 to c_maxDashDist)
						sleep(1)
						for(var/mob/M in oview(c_DashView))
							if(istype(M, /mob/AW2) || M.x <= src.x || M.y != src.y) continue
							if(istype(M, /mob/Entities))
								if(M.key == src.key || M.Guard >= 3 || getBarrier_Blast(M) == 1) continue
								if(M.Class=="Zombie") continue
								isDefending(M)
								for(var/u=1 to i)
									sleep(1)
									var/turf/aturf = locate(src.x+2, src.y, src.z)  // Get the turf directly below you.
									var/dense = 0
									if(aturf)
										for(var/atom/A in aturf)
											if(A.density == 1) dense = 1;break
										if(aturf.density == 1) dense = 1
									if(!aturf) dense = 1
									if(dense == 1)
										Smash_Hit(M,src)
										for(var/a=1 to 5)
											step(M,EAST)
											step(src,EAST)
									else
										Smash_Hit(M,src)
										src.loc=locate(src.x+2,src.y,src.z)
										for(var/a=1 to 5)
											step(src,EAST)
									i=u
							else if(istype(M, /mob/Entities/PTB)) Smash_Hit(M,src)
							else
								if(src.Dead!=1)
									sleep(1)
									del M
						for(var/a=1 to 5)
							step(src,EAST)
					switch(src.icon_state)
						if("right","dashslashright")
							src.icon_state="right"
						if("left")
							src.icon_state="left"
				if("left")
					src.icon_state="dashslashleft"
					for(var/i  = 1 to c_maxDashDist)
						sleep(1)
						for(var/mob/M in oview(c_DashView))
							if(istype(M, /mob/AW2) || M.x >= src.x || M.y != src.y) continue
							if(istype(M, /mob/Entities))
								if(M.key == src.key || M.Guard >= 3 || getBarrier_Blast(M) == 1) continue
								if(M.Class=="Zombie") continue
								isDefending(M)
								for(var/u = 1 to i )
									sleep(1)
									var/turf/aturf = locate(src.x-2, src.y, src.z)  // Get the turf directly below you.
									var/dense = 0
									if(aturf)
										for(var/atom/A in aturf)
											if(A.density == 1) dense = 1;break
										if(aturf.density == 1) dense = 1
									if(!aturf) dense = 1
									if(dense == 1)
										Smash_Hit(M,src)
										for(var/a = 1 to 5)
											step(M,WEST)
											step(src,WEST)
									else
										Smash_Hit(M,src)
										src.loc=locate(src.x-2,src.y,src.z)
										for(var/a = 1 to 5)
											step(src,WEST)
									i=u
							else if(istype(M, /mob/Entities/PTB)) Smash_Hit(M,src)
							else
								if(src.Dead!=1)
									sleep(1)
									del M
						for(var/a = 1 to 5)
							step(src,WEST)
					switch(src.icon_state)
						if("right")
							src.icon_state="right"
						if("left", "dashslashleft")
							src.icon_state="left"
			sleep(1)
			src.Guard=0
			src.Teleporting=0
			return
