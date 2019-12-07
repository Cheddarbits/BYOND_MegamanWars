mob/proc
	Barrier()
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
		else
			switch( src.Class )
				if("Gate")
					var/mob/GB/Part1/P1 = new
					var/mob/GB/Part2/P2 = new
					var/mob/GB/Part3/P3 = new
					var/mob/GB/Part4/P4 = new
					var/mob/GB/Part5/P5 = new
					P1.Owner = src.key
					P2.Owner = src.key
					P3.Owner = src.key
					P4.Owner = src.key
					P5.Owner = src.key
					switch( src.icon_state )
						if("left")
							P1.loc=locate(src.x,src.y-1,src.z)
							P2.loc=locate(src.x-1,src.y-1,src.z)
							P3.loc=locate(src.x-1,src.y,src.z)
							P4.loc=locate(src.x-1,src.y+1,src.z)
							P5.loc=locate(src.x,src.y+1,src.z)
							P1.icon_state = "right"
							P2.icon_state = "right"
							P3.icon_state = "right"
							P4.icon_state = "right"
							P5.icon_state = "right"
						if("right")
							P1.icon_state = "left"
							P2.icon_state = "left"
							P3.icon_state = "left"
							P4.icon_state = "left"
							P5.icon_state = "left"
							P1.pixel_x = 16
							P2.pixel_x = 16
							P3.pixel_x = 16
							P4.pixel_x = 16
							P5.pixel_x = 16
							P1.loc=locate(src.x,src.y-1,src.z)
							P2.loc=locate(src.x+1,src.y-1,src.z)
							P3.loc=locate(src.x+1,src.y,src.z)
							P4.loc=locate(src.x+1,src.y+1,src.z)
							P5.loc=locate(src.x,src.y+1,src.z)
					P1.pixel_y = 4
					P2.pixel_y = 4
					P3.pixel_y = 4
					P4.pixel_y = 4
					P5.pixel_y = 4

					switch( get_WorldStatus(c_Map) )
						if(DESERT_TEMPLE)
							P1.pixel_y+=-3
							P2.pixel_y+=-3
							P3.pixel_y+=-3
							P4.pixel_y+=-3
							P5.pixel_y+=-3
						if(SLEEPING_FOREST,WARZONE)
							P1.pixel_y+=-4
							P2.pixel_y+=-4
							P3.pixel_y+=-4
							P4.pixel_y+=-4
							P5.pixel_y+=-4
						if(GROUND_ZERO)
							P1.pixel_y+=-14
							P2.pixel_y+=-14
							P3.pixel_y+=-14
							P4.pixel_y+=-14
							P5.pixel_y+=-14

				if("Anubis")
					var/mob/AW/Part1/P1 = new
					var/mob/AW/Part2/P2 = new
					var/mob/AW/Part3/P3 = new
					P1.Owner = src.key
					P2.Owner = src.key
					P3.Owner = src.key
					switch( src.icon_state )
						if("left")
							P1.loc=locate(src.x-1,src.y,src.z)
							P2.loc=locate(src.x-1,src.y+1,src.z)
							P3.loc=locate(src.x-1,src.y+2,src.z)
						if("right")
							P1.loc=locate(src.x+1,src.y,src.z)
							P2.loc=locate(src.x+1,src.y+1,src.z)
							P3.loc=locate(src.x+1,src.y+2,src.z)
					P1.pixel_x=0
					P2.pixel_x=0
					P3.pixel_x=0
					P1.pixel_y=src.pixel_y
					P2.pixel_y=src.pixel_y
					P3.pixel_y=src.pixel_y
			src.BarrierUP=1
			while(src.BarrierUP == 1)
				sleep(5)
				if(Drain_fromUse(1, src) == 0)
					src.Barrier()
					break
	Shield()
		switch( src.Class )
			if("PSX")
				if(src.Teleporting==1)
					src.Teleporting=0
					src.icon_state="right"
					src.Guard=0
					return
				else
					src.Teleporting=1
					src.icon_state="hide"
					src.Guard=3
					while(src.icon_state == "hide")
						sleep(5)
						if(Drain_fromUse(1, src) == 0)
							src.Shield()
							break
					return
			if("Met","Shelldon")
				if(src.Shooting==1||src.Dead==1||src.icon_state==""){return}
				if(src.inscene == 1)
					src.inscene = 0
					src.Guard = 0
					if(src.Class=="Met")
						switch( src.icon_state )
							if( "guardleft") src.icon_state = "left"
							if( "guardright") src.icon_state = "right"
					else
						src.icon_state="right"
						switch( src.dir )
							if(EAST) src.icon_state="right"
							if(WEST) src.icon_state="left"

				else
					if(src.Class=="Met")
						flick("duck[src.icon_state]",src)
						src.icon_state = "guard[src.icon_state]"
					else src.icon_state="guard"
					src.Guard = 1
					src.inscene = 1
					while(src.inscene == 1)
						sleep(5)
						if(Drain_fromUse(1, src) == 0)
							src.Shield()
							break
			if("Colonel","Elpizo")
				switch( src.icon_state )
					if("left","right")
						src.icon_state = "block[src.icon_state]"
						src.inscene=1
						src.Slashing=1
						while(src.inscene == 1)
							sleep(5)
							if(Drain_fromUse(1, src) == 0)
								src.Shield()
								break
						return
					if("blockleft")
						src.icon_state = "left"
						src.inscene=0
						src.Slashing=0

						return
					if("blockright")
						src.icon_state = "right"
						src.inscene=0
						src.Slashing=0

						return
			if("SaX","Dynamo")
				switch( src.icon_state )
					if("left", "right")
						if( src.Teleporting == 1 ) return
						src.icon_state = "shield[src.icon_state]"
						src.inscene=1
						while(src.inscene == 1)
							sleep(5)
							if(Drain_fromUse(1, src) == 0)
								src.Shield()
								break
						return
					if("shieldleft")
						if( src.Teleporting == 1 ) return
						src.icon_state = "left"
						src.inscene=0

						return
					if("shieldright")
						if( src.Teleporting == 1 ) return
						src.icon_state = "right"
						src.inscene=0

						return
			if("Valnaire", "ZV","SJX","Burnerman","Foxtar", "Leviathen", "Woodman", "GAX", "Zanzibar")
				switch( src.icon_state )
					if( "left", "right")
						src.icon_state = "guard[src.icon_state]"
						src.inscene=1
						while(src.inscene == 1)
							sleep(5)
							if(Drain_fromUse(1, src) == 0)
								src.Shield()
								break
						return
					if("guardleft")
						src.icon_state = "left"
						src.inscene=0

						return
					if( "guardright")
						src.icon_state = "right"
						src.inscene=0

						return