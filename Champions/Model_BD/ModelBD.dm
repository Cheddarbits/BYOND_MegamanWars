#ifndef INCLUDED_MODELBD_DM
#define INCLUDED_MODELBD_DM
obj/Characters
	name=""
	ModelBD
		layer = MOB_LAYER+1
		V1
			icon = 'Model_BD.dmi'
mob/proc
	ModelBD_Push()
		if(src.Teleporting==1||src.Slashing==1||src.Dead==1) return
		for(var/atom/A in get_step(src, SOUTH))
			if(A.density == 1)
				return

		src.Teleporting = 1
		flick("push[src.icon_state]",src)
		switch( src.icon_state )
			if("right")
				for(var/mob/Entities/M in get_step(src, EAST))
					if(M.Guard > 2 || getBarrier_Blast(M) != 0 || M.Class == "Zombie") continue
					isDefending(M)
					isClimbing(M)
					step(M,EAST)
					step(M,EAST)
			if("left")
				for(var/mob/Entities/M in get_step(src, WEST))
					if(M.Guard > 2 || getBarrier_Blast(M) != 0 || M.Class == "Zombie") continue
					isDefending( M )
					isClimbing(M)
					step(M,WEST)
					step(M,WEST)
		sleep(3)
		src.Teleporting = 0
#endif

/*
Model Black Devil's moveset.

Numpad 9/Page Up - Shoot. Average delay, average damage.

Numpad 7/Home - Slash. Consists of two slashes, average delay.

Numpad 3/Page Down - Push. Pushes opponents infront of the player.

Numpad 1/End - Dash
*/