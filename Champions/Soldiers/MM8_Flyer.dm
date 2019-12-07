#ifndef INCLUDED_MM8FLYER_DM
#define INCLUDED_MM8FLYER_DM
obj/Characters
	layer=MOB_LAYER+1
	MM8Flyer
		Base
			icon = 'MM8_FlyerBottom.dmi'
		Top
			icon = 'MM8_FlyerTop.dmi'
			pixel_y = 32
mob/Entities/AIs
	Ships
		name = "Ships"
		New()
			src.icon = /obj/Characters/MM8Flyer/Base
			src.pixel_x = 16
			src.overlays = list()
			src.Guard = 4
			for(var/X in typesof(/obj/Characters/MM8Flyer)) src.overlays+=X
			src.Ship_AI()
			..()

mob/proc
	Set_ShipAI_Direction(var/Itr)
		switch(Itr)
			if(0)
				switch(rand(1,2))
					if(1)
						src.icon_state="right"
					if(2)
						src.icon_state="left"
			if(3)
				switch(src.icon_state)
					if("left")
						src.icon_state="right"
					if("right")
						src.icon_state="left"
				Itr = 0
		return Itr
	Ship_AI()
		var/moveItr = 0
		while(src)
			sleep(10)
			moveItr = src.Set_ShipAI_Direction(moveItr)
			switch(rand(1,3))
				if(1)
					src.ShipAI_Attack()
				if(2)
					src.ShipAI_Move()
					++moveItr
				if(3)
					src.ShipAI_Move()
					src.ShipAI_Attack()
					++moveItr
	ShipAI_Attack()
		if(src.icon_state==""||src.Dead==1){return}
		if(world.time - src.delay_time >= src.delay)    // A simple delay to keep you from macroing it tons.
			src.delay_time = world.time     // You could lengthen or shorten the delay simply by raising or lowering the mob's delay variable.
			var/obj/Blasts/Blast/S = new /obj/Blasts/Blast(locate(src.x, src.y, src.z))
			S.icon_state="down"
			S.Owner = "HolyDoomKnight"
			S.Damage = 2
			S.icon = 'MM8_FlyerShot.dmi'
			S.BlastMove()
	ShipAI_Move()
		if(get_WorldStatus(c_Mode) != "Warzone")
			spawn(1) del src
		switch(src.icon_state)
			if("left")
				step(src, WEST)
			if("right")
				step(src, EAST)
#endif
