#ifndef INCLUDED_AI_EASY_DM
#define INCLUDED_AI_EASY_DM
mob/proc
	Set_AI_Direction()
		src.icon_state="left"
		src.dir=WEST
		var/turf/T = get_step(src, src.dir)
		if(!isnull(T) && T.density == 1)
			src.icon_state="right"
			src.dir=EAST
		if(prob(50))
			src.icon_state="right"
			src.dir=EAST
			T = get_step(src, src.dir)
			if(!isnull(T) && T.density == 1)
				src.icon_state="left"
				src.dir=WEST

		spawn()
		for(var/mob/Entities/Player/M in oview(AI_SIGHT, src))
			if(M.Guard >= 3) continue
			if(M.x >= src.x)
				src.icon_state = "right"
			if(M.x <= src.x)
				src.icon_state = "left"

	Easy_AI_Move() // move and jump
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
	Easy_AI_MoveDash() // move, jump and dash

		switch(rand(1,4))
			if(1) // Simple Move
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
			if(2) // Jump and Move
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
			if(3) // Dash
				switch( src.icon_state )
					if("left")
						var/turf/aturf = locate(src.x-1, src.y, src.z)  // Get the turf directly below you.
						if( !isnull(aturf) )
							if(aturf.density == 1)
								src.icon_state="right"
						else
							src.icon_state="right"
					if("right")
						var/turf/aturf = locate(src.x+1, src.y, src.z)  // Get the turf directly below you.
						if( !isnull(aturf) )
							if(aturf.density == 1)
								src.icon_state="left"
						else
							src.icon_state="left"
				src.Dash()
			if(4) // Jump and Dash
				src.jump()
				switch( src.icon_state )
					if("left")
						var/turf/aturf = locate(src.x-1, src.y, src.z)  // Get the turf directly below you.
						if( !isnull(aturf) )
							if(aturf.density == 1)
								src.icon_state="right"
						else
							src.icon_state="right"
					if("right")
						var/turf/aturf = locate(src.x+1, src.y, src.z)  // Get the turf directly below you.
						if( !isnull(aturf) )
							if(aturf.density == 1)
								src.icon_state="left"
						else
							src.icon_state="left"
				src.Dash()

	Easy_AI_FloatMove() // move and float
		switch(rand(1,3))
			if(1) // Simple Move
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
			if(2) // Move up
				var/turf/aturf = locate(src.x, src.y+1, src.z)  // Get the turf directly below you.
				if( !isnull(aturf) )
					if(aturf.density == 1)
						step(src,SOUTH)
					else
						step(src,NORTH)
				else
					step(src,SOUTH)
			if(3)
				var/turf/aturf = locate(src.x, src.y-1, src.z)  // Get the turf directly below you.
				if( !isnull(aturf) )
					if(aturf.density == 1)
						step(src,NORTH)
					else
						step(src,SOUTH)
				else
					step(src,NORTH)
	Easy_AI_FloatMoveDash() // move, float and dash
		switch(rand(1,2))
			if(1) // Simple Move
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
			if(2) // Move up
				switch(rand(1,3))
					if(1)
						var/turf/aturf = locate(src.x, src.y+1, src.z)  // Get the turf directly below you.
						if( !isnull(aturf) )
							if(aturf.density == 1)
								step(src,SOUTH)
							else
								step(src,NORTH)
						else
							step(src,SOUTH)
					if(2)
						var/turf/aturf = locate(src.x, src.y-1, src.z)  // Get the turf directly below you.
						if( !isnull(aturf) )
							if(aturf.density == 1)
								step(src,NORTH)
							else
								step(src,SOUTH)
						else
							step(src,NORTH)
					if(3)
						switch( src.icon_state )
							if("left")
								var/turf/aturf = locate(src.x-1, src.y, src.z)  // Get the turf directly below you.
								if( !isnull(aturf) )
									if(aturf.density == 1)
										src.icon_state="right"
								else
									src.icon_state="right"
							if("right")
								var/turf/aturf = locate(src.x+1, src.y, src.z)  // Get the turf directly below you.
								if( !isnull(aturf) )
									if(aturf.density == 1)
										src.icon_state="left"
								else
									src.icon_state="left"
						src.Dash()
//===============================================================
//
// Easy Shoot AI
//
//===============================================================
	Easy_Shoot_AI() // AI that can only shoot
		spawn(2) src.GravCheck()
		if(AISpawn == SpawnP)
			src.GotoBattle()
		src.Stats[c_Team] = AITeam
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
							src.Easy_ShootAI_Attack()
						if(2)
							src.Easy_AI_Move()
						if(3)
							src.Easy_AI_Move()
							src.Easy_ShootAI_Attack()
			if(1)
				while(src)
					sleep(1)
					Set_AI_Direction()

					switch(rand(1,3))
						if(1)
							src.Easy_ShootAI_Attack()
						if(2)
							src.Easy_AI_FloatMove()
						if(3)
							src.Easy_AI_FloatMove()
							src.Easy_ShootAI_Attack()
	Easy_ShootAI_Attack()
		src.Shooting = 1
		for(var/mob/Entities/Player/M in oview(AI_ATTACK_SIGHT, src))
			if(M.x>=src.x)
				src.icon_state="right"
			if(M.x<=src.x)
				src.icon_state="left"
		src.Shoot()
//===============================================================
//
// Easy Shoot and Dash AI
//
//===============================================================
	Easy_Shoot_Dash_AI() // AI that can only shoot and dash
		spawn(2) src.GravCheck()
		if( AISpawn == SpawnP )
			src.GotoBattle()
		src.Stats[c_Team] = AITeam
		for(var/A in typesof(/obj/Characters/Team)) src.overlays-=A
		for(var/Z in typesof("/obj/Characters/Team/[lowertext(AITeam)]"))
			src.overlays+=Z
		while( src )
			sleep(1)
			Set_AI_Direction()
			switch(rand(1,3))
				if(1)
					src.Easy_ShootAI_Attack()
				if(2)
					src.Easy_AI_MoveDash()
				if(3)
					src.Easy_AI_MoveDash()
					src.Easy_ShootAI_Attack()

//===============================================================
//
// Easy Shoot and Guard AI
//
//===============================================================
	Easy_Shoot_Guard_AI() // Ai that can only shoot and guard
		spawn(2) src.GravCheck()
		if( AISpawn == SpawnP )
			src.GotoBattle()
		src.Stats[c_Team] = AITeam
		for(var/A in typesof(/obj/Characters/Team)) src.overlays-=A
		for(var/Z in typesof("/obj/Characters/Team/[lowertext(AITeam)]"))
			src.overlays+=Z
		while( src )
			sleep(1)
			Set_AI_Direction()
			switch(rand(1,6))
				if(1,2)
					src.Easy_ShootAI_Attack()
				if(3,4)
					src.Easy_AI_Move()
				if(5)
					src.Easy_AI_Move()
					src.Easy_ShootAI_Attack()
				if(6)
					src.Shield()
//===============================================================
//
// Easy AOE AI
//
//===============================================================
	Easy_AOE_AI()
		spawn(2) src.GravCheck()
		if( AISpawn == SpawnP )
			src.GotoBattle()
		src.Stats[c_Team] = AITeam
		for(var/A in typesof(/obj/Characters/Team)) src.overlays-=A
		for(var/Z in typesof("/obj/Characters/Team/[lowertext(AITeam)]"))
			src.overlays+=Z
		while(src)
			sleep(1)
			Set_AI_Direction()
			switch(rand(1,3))
				if(1)
					src.Easy_AOE_Attack()
				if(2)
					src.Easy_AI_Move()
				if(3)
					src.Easy_AI_Move()
					src.Easy_AOE_Attack()

	Easy_AOE_Attack()
		for(var/mob/Entities/Player/M in oview(AI_ATTACK_SIGHT, src))
			if(M.x>=src.x)
				src.icon_state="right"
			if(M.x<=src.x)
				src.icon_state="left"
		src.Smash()
//===============================================================
//
// Easy Float AOE AI
//
//===============================================================
	Easy_Float_AOE_AI()
		spawn(2) src.GravCheck()
		if( AISpawn == SpawnP )
			src.GotoBattle()
		src.Stats[c_Team] = AITeam
		for(var/A in typesof(/obj/Characters/Team)) src.overlays-=A
		for(var/Z in typesof("/obj/Characters/Team/[lowertext(AITeam)]"))
			src.overlays+=Z
		while(src)
			sleep(1)
			Set_AI_Direction()
			switch(rand(1,3))
				if(1)
					src.Easy_Float_AOE_Attack()
				if(2)
					src.Easy_AI_FloatMove()
				if(3)
					src.Easy_AI_FloatMove()
					src.Easy_Float_AOE_Attack()
	Easy_Float_AOE_Attack()
		for(var/mob/Entities/Player/M in oview(AI_ATTACK_SIGHT, src))
			if(M.x>=src.x)
				src.icon_state="right"
			if(M.x<=src.x)
				src.icon_state="left"
		src.Smash()
//===============================================================
//
// X AI
//
//===============================================================
	X_AI()
		spawn(2) src.GravCheck()
		if( AISpawn == SpawnP )
			src.GotoBattle()
		src.Stats[c_Team] = AITeam
		for(var/A in typesof(/obj/Characters/Team)) src.overlays-=A
		for(var/Z in typesof("/obj/Characters/Team/[lowertext(AITeam)]"))
			src.overlays+=Z
		while( src )
			sleep(1)
			Set_AI_Direction()
			switch(rand(1,3))
				if(1)
					src.XAIAttack()
				if(2)
					src.Easy_AI_MoveDash()
				if(3)
					src.Easy_AI_MoveDash()
					src.XAIAttack()
	XAIAttack()
		switch(rand(1,3))
			if(1,2)
				for(var/mob/Entities/Player/M in oview(AI_ATTACK_SIGHT, src))
					if(M.x>=src.x)
						src.icon_state="right"
					if(M.x<=src.x)
						src.icon_state="left"
				src.Shoot()
			if(3)
				src.Slash()


		if(prob(50))
			src.icon_state="right"
		if(prob(50))
			src.icon_state="left"
		for(var/mob/Entities/Player/M in oview(AI_SIGHT, src))
			if(M.Guard >= 3) continue
			if(M.x >= src.x)
				src.icon_state = "right"
			if(M.x <= src.x)
				src.icon_state = "left"
//===============================================================
//
// Randomness AI
//
//===============================================================
#endif