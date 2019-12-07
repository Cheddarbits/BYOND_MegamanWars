mob/proc
// BEAT_NE
	BeatCharge()
		if(src.Slashing==1||src.Dead==1) return
		src.Slashing=1
		var/const/Range = 5
		switch( src.icon_state )
			if("right")
				src.icon_state="attackright"
				for(var/mob/M in oview(Range))
					if( M.x <= src.x || isnull(M) || istype(M, /mob/AW2) || M.y != src.y) continue
					if( isnull(src) ) break
					if(istype(M, /mob/Entities)||istype(M, /mob/Entities/PTB))
						while(M.x>=src.x+1&&M.y==src.y)
							sleep(1)
							if(isnull(M)) break
							if(M.x == src.x+1 && M.y == src.y)
								Sword_Hit(M,src)
								break
							var/turf/aturf = get_step( src, EAST )   // Get the turf directly below you.
							var/dense = 0
							if(aturf&&aturf.density == 1) dense = 1
							if(!aturf) dense = 1
							if(dense == 1)
								break
							step(src,EAST)
					else
						if(src.Dead!=1)
							sleep(1)
							del M
				sleep(1)
				src.icon_state="right"
			if("left")
				src.icon_state="attackleft"
				for(var/mob/M in oview(Range))
					if( M.x >= src.x || isnull(M) || istype(M, /mob/AW2) || M.y != src.y ) continue
					if(isnull(src)) break
					if(istype(M, /mob/Entities)||istype(M, /mob/Entities/PTB))
						while(M.x<=src.x-1&&M.y==src.y)
							sleep(1)
							if(isnull(M)) break
							if(M.x==src.x-1&&M.y==src.y)
								Sword_Hit(M,src)
								break
							var/turf/aturf = get_step( src, WEST )   // Get the turf directly below you.
							var/dense = 0
							if(aturf&&aturf.density == 1) dense = 1
							if(!aturf) dense = 1
							if(dense == 1)
								break
							step(src,WEST)

					else
						if(src.Dead!=1)
							sleep(1)
							del M
				sleep(1)
				src.icon_state="left"
		sleep(5)
		src.Slashing=0
// BEAT_NW
/*
	Beat_Charge_NW()
		if(src.Slashing == 1 || src.Dead == 1 || Drain_fromUse(1, src) == 0) return
		src.Slashing = 1
		switch(src.icon_state)
			if("left")
				src.icon_state="attackleft"
				var/dense = 0
				while(dense == 0)
					sleep(1)
					var/turf/aturf = get_step(src, WEST)
					for(var/atom/A in aturf)
						if(A.density == 1) dense = 1
						if(aturf.density == 1 dense = 1
					if(!aturf) dense = 1
					step(src, WEST)

			if("right")
				src.icon_state="attackright"*/