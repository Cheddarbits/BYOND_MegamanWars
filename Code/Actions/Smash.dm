mob/proc

	Smash()
		if(isnull(src)||src.inscene ==1 || src.Slashing==1||src.Dead==1) return // Error handler, also spam handler
		if(src.Class != "Duo" && src.Class != "Omega")
			if(Drain_fromUse(1, src) == 0) return
		src.Slashing=1
		var/Range = 1
		var/Delay = 2
		var/Delay1 = 2
		switch( src.Class )
			if("Dynamo", "Woodman", "HanuMachine", "ModelGate")
				Delay1 = 4
				Range = 2
				Delay = 5
				flick("smash[src.icon_state]", src)
			if("ZV")
				Delay1 = 6
				Range = 4
				flick("areahit",src)
			if("Double")
				Delay1 = 5
				Range = 2
				Delay = 5
				flick("area[src.icon_state]",src)
			if("Duo")
				var/turf/aturf = get_step( src, SOUTH )   // Get the turf directly below you.
				var/dense = 0
				if(aturf)
					for(var/atom/A in aturf)
						if(A.density == 1)
							dense = 1
							break
					if(aturf.density == 1) dense = 1
				if(!aturf) dense = 1
				if(dense == 0)
					src.Slashing = 0
					return
				Delay1 = 5
				Delay = 4
				flick("areahit[src.icon_state]",src)
			if("Fefnir")
				Delay1 = 3
				Range = 1
				Delay = 7
				flick("ground[src.icon_state]",src)
			if("Omega")
				Delay1 = 1
				Range = 2
				Delay = 9
				flick("shoot[src.icon_state]",src)
			if("Elpizo")
				Delay1 = 2
				Range = 3
				Delay = 7
				flick("area[src.icon_state]",src)
			if("King" )
				Delay1 = 1;
				Range = 2
				Delay = 9
				flick("around[src.icon_state]",src )

		if(isnull(src))
			Range = null // Garbage collector, frees up the RAM so declare these local variables as null
			Delay1 = null
			Delay = null
			return // Error handler if the user no longer exists after the sleep.

		sleep(Delay1)
		if( src.Class == "Duo" )
			var/turf/aturf = get_step( src, SOUTH )   // Get the turf directly below you.
			var/dense = 0
			if(aturf)
				for(var/atom/A in aturf)
					if( A.density == 0 ) continue
					if(A.density == 1)
						dense = 1
						break
				if(aturf.density == 1) dense = 1
			if(!aturf) dense = 1
			switch( dense )
				if( 1 ) Range = 4
				if( 0 ) Range = 0
		for(var/mob/Entities/M in view(Range, src))
			if( isnull( M ) || M.Guard > 2 || M.key == src.key || M.Dead == 1 || M.Playing == 0) continue;
			if( isnull( src ) ) break
			switch(src.Class)
				if("Elpizo")
					if(M.y == src.y)
						switch(src.icon_state)
							if("left")
								if(M.x<src.x)
									Smash_Hit(M,src)
							if("right")
								if(M.x>src.x)
									Smash_Hit(M,src)
				if("King" )
					if(isnull(src)||isnull(M))
						src.Slashing = 0
						return
					Smash_Hit( M, src )
					if(M.x < src.x)
						step(M, WEST)
						step(M, WEST)
					else if(M.x > src.x)
						step(M, EAST)
						step(M, EAST)
					else if(M.y > src.y)
						step(M, NORTH)
						step(M, NORTH)
					else if(M.y < src.y)
						step(M, SOUTH)
						step(M, SOUTH)
				else
				// Omega and ZV are not declared in here as they only damage the target, not move or heal them.
					Smash_Hit(M,src)
					if(src.Class == "Double")

						if(M.Stats[c_Team]!="N/A"&&M.Stats[c_Team] == src.Stats[c_Team])
							M.life+=src.Attack
							if(M.life>=M.mlife){M.life=M.mlife}
							M.Update()
					else
						if(M.Stats[c_Team]!=src.Stats[c_Team]||M.Stats[c_Team]=="N/A")
							if(M.Class=="Leviathen"&&M.icon_state=="guardright"||M.Class=="Leviathen"&&M.icon_state=="guardleft") continue

							isClimbing( M )
							if(M.Class!="Zombie")
								switch( src.Class )
									if( "Dynamo", "Fefnir")
										if( M.Dead != 1 )
											switch( M.icon_state )
												if( "left") step(M, WEST)
												if( "right") step(M, EAST)
									if("Duo")
										switch(rand(1,2))
											if(1)
												spawn(1)
													for(var/i = 1 to 3)
														if( isnull( M ) || M.Dead == 1) break;
														sleep(1)
														step(M, NORTH)
														step(M, NORTH)
											if(2)
												spawn(1)
													for(var/i = 1 to 3)
														if( isnull( M ) || M.Dead==1) break;
														sleep(1)
														step(M, SOUTH)
														step(M, SOUTH)


		if(src.Class == "Fefnir")
			sleep( 3 )
			for(var/i=0 to 7)
				step(src,NORTH)
		sleep(Delay)
		if(isnull(src))
			Range = null // Garbage collector, frees up the RAM so declare these local variables as null
			Delay = null
			Delay1 = null
			return // Error handler if the user no longer exists.
		src.Slashing=0