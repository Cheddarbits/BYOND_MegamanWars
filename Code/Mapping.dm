obj
	Switches
		Door
			var/DoorNumber=0
			name=""
			icon='ShutterBottom1.dmi'
			icon_state="closed"
			density=1;pixel_y=-16
			New()
				src.overlays+=new /obj/DoorTop
				new /obj/Blocker(locate(src.x,src.y+1,src.z))
	DoorTop{icon='ShutterTop1.dmi';pixel_y=32}
	Blocker{density=1}
turf


	Junkyard
		icon = 'Junkyard.dmi'
		density = 1
		name = ""
		Tile1
			icon_state = "1"
			New()
				..()
				Conveyers+=2
				sleep(Conveyers)
				src.Conveyer()
		Tile1a
			icon_state = "1a"
			New()
				..()
				Conveyers+=2
				sleep(Conveyers)
				src.Conveyer2()
		Tile2{icon_state = "2"}
	proc
		Conveyer()
			if(g_Map != UNDERGROUND_LABS)
				spawn(40) src.Conveyer()
			else
				for(var/mob/Entities/M in get_step( src, NORTH ) )
					if(M.Flight == 1) continue
					if(M.icon_state == "right") M.icon_state = "left"
					step(M,WEST)
				spawn(4) src.Conveyer()

		Conveyer2()
			if(g_Map != UNDERGROUND_LABS)
				spawn(40) src.Conveyer2()
			else
				for(var/mob/Entities/M in get_step( src, NORTH ) )
					if(M.Flight == 1) continue
					if(M.icon_state == "left") M.icon_state = "right"
					step(M,EAST)
				spawn(4) src.Conveyer2()