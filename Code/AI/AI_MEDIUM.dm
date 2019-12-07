#ifndef INCLUDED_AI_MEDIUM_DM
#define INCLUDED_AI_MEDIUM_DM
mob/proc

	MEDIUM_AI_Move() // move and jump
		if(prob(50))
			src.jump()
		switch( src.icon_state )
			if("left")
				var/turf/aturf = locate(src.x-1, src.y, src.z)  // Get the turf directly below you.
				if( !isnull(aturf) )
					if(aturf.density == 1)
						src.icon_state="right"
					else
						step(src,WEST)
				else
					src.icon_state="right"
			if("right")
				var/turf/aturf = locate(src.x+1, src.y, src.z)  // Get the turf directly below you.
				if( !isnull(aturf) )
					if(aturf.density == 1)
						src.icon_state="left"
					else
						step(src,EAST)
				else
					src.icon_state="left"
//===============================================================
//
// MEDIUM Shoot AI
//
//===============================================================
	MEDIUM_Shoot_AI() // AI that can only shoot
		spawn(2) src.GravCheck()
		if(AISpawn == SpawnP)
			src.GotoBattle()
		src.Team = AITeam
		for(var/A in typesof(/obj/Characters/Team)) src.overlays-=A
		for(var/Z in typesof("/obj/Characters/Team/[lowertext(AITeam)]"))
			src.overlays+=Z
		switch( src.Flight )
			if(0)
				while(src)
					sleep(1)
					Set_AI_Direction()

					switch(rand(1,3))
						if(1)
							src.MEDIUM_ShootAI_Attack()
						if(2)
							src.MEDIUM_AI_Move()
						if(3)
							src.MEDIUM_AI_Move()
							src.MEDIUM_ShootAI_Attack()
			if(1)
				while(src)
					sleep(1)
					Set_AI_Direction()

					switch(rand(1,3))
						if(1)
							src.MEDIUM_ShootAI_Attack()
						if(2)
							src.Easy_AI_FloatMove()
						if(3)
							src.Easy_AI_FloatMove()
							src.MEDIUM_ShootAI_Attack()
	MEDIUM_ShootAI_Attack()
		for(var/mob/Entities/Player/M in oview(AI_ATTACK_SIGHT, src))
			if(M.x>=src.x)
				src.icon_state="right"
			if(M.x<=src.x)
				src.icon_state="left"
		src.Shoot()
#endif