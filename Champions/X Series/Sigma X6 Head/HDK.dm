#ifndef INCLUDED_HDK_DM
#define INCLUDED_HDK_DM
obj/Characters
	HDK
		part1{icon='X6 Head1.dmi';icon_state="";pixel_y=-32}
		part2{icon='X6 Head2.dmi';icon_state="";pixel_y=-32;pixel_x=32}
		part4{icon='X6 Head4.dmi';icon_state="";pixel_x=32}
		part5{icon='X6 Head5.dmi';icon_state="";pixel_y=32}
		part6{icon='X6 Head6.dmi';icon_state="";pixel_y=32;pixel_x=32}

mob/proc
	ChargeBeam()
		if(src.Slashing==1||src.Dead==1){return}
		if(src.Slashing==0&&src.CharMode==1)
			src.Slashing=1
			src.density=0
			flick("charge[icon_state]",src)
			switch( src.icon_state )
				if("right")
					for(var/mob/Entities/M in oview(5))
						if(M.x <= src.x) continue
						if(M.y>=src.y-1&&M.y<=src.y+1)
							step(M,WEST)
							step(M,WEST)
				if("left")
					for(var/mob/Entities/M in oview(5))
						if(M.x >= src.x) continue
						if(M.y>=src.y-1&&M.y<=src.y+1)
							step(M,EAST)
							step(M,EAST)
			for(var/obj/Blasts/O in oview(7))
				src.life += 1
				O.icon_state=null
				src.Update()
				sleep(1)
				del O
			sleep(3)
			src.Slashing=0
			src.density=1
			return
	RepelBeam()
		if(src.Dead!=1&&src.Class=="HDK"&&src.CharMode==1)
			for(var/mob/Entities/M in oview(6))
				if(M.key==src.key) continue
				if(M.x>src.x)
					for(var/i= 0 to 6)
						step(M,EAST)
				if(M.x<src.x)
					for(var/i= 0 to 6)
						step(M,NORTH)
				if(M.x==src.x)
					if(M.y>src.y)
						for(var/i= 0 to 6)
							step(M,NORTH)
					if(M.y<src.y)
						for(var/i= 0 to 6)
							step(M,SOUTH)
			for(var/obj/Blasts/O in oview(6))
				if(O.Owner==src.key) continue
				src.life += 1
				O.icon_state=null
				src.Update()
				sleep(1)
				del O
			spawn(10) src.RepelBeam()
	LockBeam()
		if(src.Dead!=1&&src.Class=="HDK"&&src.CharMode==1)
			var/Range = 6
			for(var/mob/Entities/M in oview(Range))
				if(M.key==src.key) continue
				step_to(M,src,2)
				step_away(M,src,3)
				if(!isnull(M)&&!isnull(src))
					if(M.islocked==0)
						M.islocked=1
						LockCheck(M)
			for(var/obj/Blasts/O in oview(Range))
				if(O.Owner==src.key) continue
				src.life += 1
				O.icon_state=null
				src.Update()
				sleep(1)
				del O
			sleep(5)
			src.LockBeam()
#endif