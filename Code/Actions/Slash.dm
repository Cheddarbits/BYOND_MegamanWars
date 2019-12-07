mob/proc





	Double_Attack()
		if(src.Slashing == 1||src.Dead==1) return
		if(src.Class == "MG400")
			if(src.Shooting == 1||src.Dashing == 1) return
			if(Drain_fromUse(1, src) == 0) return
		src.Slashing=1
		var/Delay1 = 1
		var/Delay2 = 3
		var/Delay3 = 2
		var/Range = 1
		var/yRange = Range
		switch(src.Class)
			if("Double")
				flick("attack[src.icon_state]",src)
			if("Burnerman")
				flick("burn[src.icon_state]",src)
				Range = 3
				yRange = 0
			if("MG400")
				flick("melee[src.icon_state]", src)
				Delay1 = 0
				Delay2 = 10
				Delay3 = 10


		sleep(Delay1)
		switch( src.icon_state )
			if("left")
				for(var/mob/M in oview(Range))

					if(isnull(M) || M.Dead == 1) continue
					if(M.y >= src.y && M.y <= src.y+yRange && M.x < src.x)
						Sword_Hit(M,src)
						Delay2=Delay3
			if("right")
				for(var/mob/M in oview(Range))
					if(isnull(M) || M.Dead == 1) continue
					if(M.y >= src.y && M.y <= src.y+yRange && M.x > src.x)
						Sword_Hit(M,src)
						Delay2=Delay3
		sleep(Delay2)
		src.Slashing=0

	DarkG_Slash()
		if(src.Slashing == 1||src.Dead==1) return
		if(Drain_fromUse(1, src) == 0) return
		src.Slashing=1
		flick("sword[src.icon_state]",src)

		sleep(1)
		var/Delay = 4
		src.Attack--
		switch( src.icon_state )
			if("left")
				for(var/mob/M in oview(2))
					if(M.y >= src.y&&M.y<=src.y+1&&M.x != src.x)
						Sword_Hit(M,src)
						Delay=3
				for(var/obj/Blasts/O in oview(2))
					if(O.y >= src.y&&O.y<=src.y+1&&O.x != src.x&&O.icon_state == "right")
						O.icon_state = "left"
						O.Owner=src.key

			if("right")
				for(var/mob/M in oview(2))
					if(M.y >= src.y&&M.y<=src.y+1&&M.x != src.x)
						Sword_Hit(M,src)
						Delay = 3
				for(var/obj/Blasts/O in oview(2))
					if(O.y >= src.y&&O.y<=src.y+1&&O.x != src.x&&O.icon_state == "left")
						O.icon_state = "right"
						O.Owner=src.key
		src.Attack++
		sleep(Delay)
		src.Slashing=0


	Kraft_Slash()
		if(src.Slashing==1||src.Dead==1) return
		if(Drain_fromUse(1, src) == 0) return
		src.Slashing=1
		flick("sword[src.icon_state]",src)

		switch( src.icon_state )
			if("right")
				for( var/i = 0 to 2 )
					NULL_R( src )
					for(var/mob/M in get_step( src, EAST ))
						if(istype(M, /mob/Entities/Player)&&M.key!=src.key)
						/*	if(M.Class=="Zombie")
								M.nojump=0
								M.density=1
								if(M.icon_state=="sandleft")
									M.icon_state="left"
								if(M.icon_state=="sandright")
									M.icon_state="right"*/
							isClimbing(M)
							if(M.Class!="Zombie")
								sleep(1)
								NULL_C( M )
								NULL_R( src )
								if(src.icon_state=="right"&&M.Dead!=1)
									Sword_Hit(M,src)
									step(M,EAST)
									step(src,EAST)
									step(M,EAST)
									step(src,EAST)
						else
							Sword_Hit(M,src)
					var/turf/aturf = locate(src.x+1, src.y, src.z)
					if( isturf( aturf ) && !isnull( aturf ) && aturf.density == 0 )
						step(src,EAST)
						step(src,EAST)
						sleep(1)
			if("left")
				for( var/i = 0 to 2 )
					NULL_R( src )
					for(var/mob/M in get_step( src, WEST ) )
						if(istype(M, /mob/Entities/Player)&&M.key!=src.key)
					/*	if(M.Class=="Zombie")
							M.nojump=0
							M.density=1
							if(M.icon_state=="sandleft")
								M.icon_state="left"
							if(M.icon_state=="sandright")
								M.icon_state="right"*/
							isClimbing(M)
							if(M.Class!="Zombie")
								sleep(1)
								NULL_C( M )
								NULL_R( src )
								if(src.icon_state=="left"&&M.Dead!=1)
									Sword_Hit(M,src)
									step(M,WEST)
									step(src,WEST)
									step(M,WEST)
									step(src,WEST)
						else
							Sword_Hit(M,src)
					var/turf/aturf = locate(src.x-1, src.y, src.z)
					if( isturf( aturf ) && !isnull( aturf ) && aturf.density == 0 )
						step(src,WEST)
						step(src,WEST)
						sleep(1)
		sleep(2)
		src.Slashing=0

	Chilldre_Slash()
		if(src.Slashing==1||src.Dead==1) return
		src.Slashing=1
		flick("slash[src.icon_state]",src)
		switch( src.icon_state )
			if("left")
				for(var/mob/M in view(2))
					if(M.y == src.y&&M.x < src.x)
						Sword_Hit(M,src)
				for(var/obj/Blasts/O in view(2))
					if(O.y == src.y&&O.x < src.x&&O.icon_state == "right")
						O.icon_state = "left"
						O.Owner=src.key
				sleep(4)
				if(src.Dead!=1&&!isnull(src)) src.Shoot()
			if( "right")
				for(var/mob/M in view(2))
					if(M.y == src.y&&M.x > src.x)
						Sword_Hit(M,src)
				for(var/obj/Blasts/O in view(2))
					if(O.y == src.y&&O.x > src.x&&O.icon_state == "left")
						O.icon_state = "right"
						O.Owner=src.key
				sleep(4)
				if(src.Dead!=1&&!isnull(src)) src.Shoot()
		sleep(2)
		src.Slashing=0
	Sigma_Slash()
		NULL_R( src )
		if( src.Slashing == 1 || src.Teleporting == 1 || src.Dead == 1 ) return
		if(Drain_fromUse(1, src) == 0) return
		src.Slashing = 1

		flick( "slash[src.icon_state]", src )
		sleep( 1 )
		NULL_R( src )
		switch( src.icon_state )
			if( "left" )
				for( var/mob/M in oview(1) )
					NULL_C( M )
					NULL_R( src )
					if( M.y >= src.y && M.x < src.x )
						isClimbing(M)
						Sword_Hit( M, src )
						NULL_C( M )
						if( istype(M, /mob/Entities/Player) )
							if( M.Guard > 2 || M.Dead == 1 || M.Class == "Zombie" ) continue;
							if( M.Stats[c_Team] == src.Stats[c_Team] && M.Stats[c_Team] != "N/A" ) continue
							isClimbing( M )
							for( var/i = 0 to 8 )
								NULL_R( src )
								NULL_B( M )
								step(M, NORTH)
				for( var/obj/M in oview(1) )
					NULL_C( M )
					NULL_R( src )
					if( M.y >= src.y && M.x < src.x )
						if( M.icon_state != "right" && M.icon_state != "left" ) continue
						switch( M.icon_state )
							if( "right" )
								M.icon_state = "left"
			if( "right")
				for( var/mob/M in oview(1) )
					NULL_C( M )
					NULL_R( src )
					if( M.y >= src.y && M.x > src.x )
						isClimbing(M)
						Sword_Hit( M, src )
						NULL_C( M )
						if( istype(M, /mob/Entities/Player) )
							if( M.Guard > 2 || M.Dead == 1 || M.Class == "Zombie" ) continue;
							if( M.Stats[c_Team] == src.Stats[c_Team] && M.Stats[c_Team] != "N/A" ) continue
							isClimbing( M )
							for( var/i = 0 to 8 )
								NULL_R( src )
								NULL_B( M )
								step(M, NORTH)
				for( var/obj/M in oview(1) )
					NULL_C( M )
					NULL_R( src )
					if( M.y >= src.y && M.x > src.x )
						if( M.icon_state != "right" && M.icon_state != "left" ) continue
						switch( M.icon_state )
							if( "left" )
								M.icon_state = "right"
		sleep(3)
		NULL_R( src )
		src.Slashing=0


	Slash()
		if(src.Slashing==1||src.Dead==1) return
		var/list/NoCost = list("Harp", "Zero", "Medic", "Colonel", "Elpizo", "Fauclaw", "King", "ZV")
		if(!NoCost.Find(src.Class))
			if(Drain_fromUse(1, src) == 0) return
		src.Slashing=1
		var/Delay1=0
		var/Delay2=0
		switch( src.Class )
			if("Valnaire")
				flick("slash[src.icon_state]", src)
				Delay1 = 1
				Delay2 = 1
			if("Shadowman")
				flick("slash[src.icon_state]",src)
				Delay1=1
				Delay2=6
			if("Harp")
				flick("slash[src.icon_state]", src)
				Delay1 = 1
				Delay2 = 2
			if("ModelBD")
				switch(src.SlashState)
					if(1)
						flick("slash1[src.icon_state]",src)
						Delay1=1
						Delay2=6
					if(2)
						flick("slash2[src.icon_state]",src)
						Delay1=1
						Delay2=6
			if("CMX", "ModelGate")
				switch( src.SlashState )
					if(1)
						flick("slash1[src.icon_state]",src)
						Delay1=1
						Delay2=6
					if(2)
						flick("slash2[src.icon_state]",src)
						Delay1=1
						Delay2=6
					if(3)
						flick("slash3[src.icon_state]",src)
						Delay1=1
						Delay2=3
			if("ModelS")
				switch( src.SlashState )
					if(1)
						flick("slash[src.icon_state]1",src)
						Delay1=3
						Delay2=2
					if(2)
						flick("slash[src.icon_state]2",src)
						Delay1=3
						Delay2=2
			if("X", "SaX", "MMXZero", "Medic") // X_Slash() flick
				flick("slash[src.icon_state]",src)
				Delay1=3
				Delay2=2
			if("Zero") // Zero_Slash() flick
				flick("[src.icon_state] slash",src)
				Delay1=1
				Delay2=6
			if("Xeron", "ZV", "Colonel", "Elpizo", "Athena", "Fauclaw")
				flick("slash[src.icon_state]",src)
				Delay1=1
				Delay2=3

#ifdef INCLUDED_SHADOWMANEXE_DM
			if("ShadowmanEXE")
				flick("slash[src.icon_state]",src)
				Delay1=1
				Delay2=3
#endif
			if(  "King" )
				flick("slash[src.icon_state]",src )
				Delay1 = 0
				Delay2 = 9
		sleep(Delay1)
		switch( src.icon_state )
			if( "left")
				if( src.Class == "King" )
					for( var/mob/M in oview( 1 ) )
						if(M.Guard > 2) continue
						if( !isnull( M ) && M.Dead != 1 && istype( M, /mob/Entities ) )
							if( src.icon_state == "left" && M.y >= src.y && M.x < src.x )
								isClimbing(M)
								Sword_Hit( M, src )
								if( istype( M, /mob/Entities ) )
									for( var/i = 0 to 6 )
										step( M, WEST )
				else if( src.Class == "Fauclaw" )
					for( var/mob/M in oview( 1 ) )
						if( !isnull( M ) && M.Dead != 1 )
							if( src.icon_state == "left" && M.y >= src.y && M.x < src.x )
								isClimbing(M)
								Sword_Hit( M, src )
					spawn(6)
					for( var/mob/M in oview( 1 ) )
						if( !isnull( M ) && M.Dead != 1 )
							if( src.icon_state == "left" && M.y >= src.y && M.x < src.x )
								isClimbing(M)
								Sword_Hit( M, src )
				else
					for(var/mob/M in oview(1))
						if(M.y >= src.y&&M.x < src.x&&M.Dead!=1)
							Sword_Hit(M,src)
							sleep(1)
							src.Slashing=0
							return
					for(var/obj/Blasts/O in oview(1))
						if(O.y >= src.y&&O.x < src.x&&O.icon_state == "right")
							O.icon_state = "left"
							O.Owner=src.key
			if( "right")

				if( src.Class == "King" )
					for( var/mob/M in oview( 1 ) )
						if(M.Guard > 2) continue
						if( !isnull( M ) && M.Dead != 1 )
							if( src.icon_state == "right" && M.y >= src.y && M.x > src.x )
								isClimbing(M)
								Sword_Hit( M, src )
								if( istype( M, /mob/Entities ) )
									for( var/i = 0 to 6 )
										step( M, EAST )
				else if( src.Class == "Fauclaw" )
					for( var/mob/M in oview( 1 ) )
						if( !isnull( M ) && M.Dead != 1)
							if( src.icon_state == "right" && M.y >= src.y && M.x > src.x )
								Sword_Hit( M, src )
					spawn(6)
					for( var/mob/M in oview( 1 ) )
						if( !isnull( M ) && M.Dead != 1 )
							if( src.icon_state == "right" && M.y >= src.y && M.x > src.x )
								Sword_Hit( M, src )
				else
					for(var/mob/M in oview(1))
						if(M.y >= src.y&&M.x >src.x&&M.Dead!=1)
							Sword_Hit(M,src)
							sleep(1)
							src.Slashing=0
							return
					for(var/obj/Blasts/O in view(1))
						if(O.y >= src.y&&O.x > src.x&&O.icon_state == "left")
							O.icon_state = "right"
							O.Owner=src.key
		sleep(Delay2)
		src.Slashing=0
