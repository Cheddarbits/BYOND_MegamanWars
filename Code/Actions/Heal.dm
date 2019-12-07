
#if DEBUG_VARIABLES
proc/DebugVariables(var/mob/A)
	while(A)
		sleep(1)
		A<<"Shooting: [A.Shooting], Dashing: [A.Dashing], Teleporting: [A.Teleporting], Slashing: [A.Slashing], Healing: [A.Healing]"

#endif
mob/proc
	Heal()
		if(src.Dead == 1 || isnull(src)) return
		switch(src.Class)
			if("Cliff")
				if(src.Teleporting == 1|| src.Dashing == 1|| src.Shooting == 1) return
				if(Drain_fromUse(1, src) == 0) return
				src.Teleporting = 1

				flick("heal[src.icon_state]",src)
				src.life+=12
				if(src.life>=src.mlife) src.life=src.mlife
				src.Update()
				sleep(10)
				src.Teleporting=0
			if("Weil")
				if(src.Slashing == 1) return
				src.Slashing = 1
				src.Slashing=1
				flick("morph",src)
				for(var/mob/Entities/M in oview(3))
					if( isnull( M ) || M.key == src.key) continue
					if( isnull( src ) ) break
					if(M.Stats[c_Team]!="N/A"&&M.Stats[c_Team] == src.Stats[c_Team])
						M.life+=rand(1,28)
						if(M.life>=M.mlife){M.life=M.mlife}
						M.Update()
				sleep(5)
				src.Slashing=0

	SelfHeal()
		if(src.Teleporting==1||src.Dead==1) return
		if(Drain_fromUse(1, src) == 0) return
		src.Teleporting=1
		src.lock=1

		flick("heals[src.icon_state]",src)
		sleep(2)
		src.life+=src.Attack
		if(src.life>=src.mlife) src.life=src.mlife
		src.Update()
		sleep(4)
		src.Teleporting=0
		src.lock=0
	TeamHeal()
		if(src.Teleporting==1||src.Dead==1) return
		if(Drain_fromUse(1, src) == 0)  return
		src.Teleporting=1
		flick("healt[src.icon_state]",src)

		sleep(2)
		for(var/mob/Entities/M in oview(1))
			if(M.Stats[c_Team]!="N/A"&&M.Stats[c_Team]==src.Stats[c_Team]&&M.y == src.y)
				switch( src.icon_state )
					if("left")
						if(M.x<src.x)
							M.life+=src.Attack
					if("right")
						if(M.x>src.x)
							M.life+=src.Attack
				if(M.life>=M.mlife) M.life=M.mlife
				M.Update()
		sleep(5)
		src.Teleporting=0
	Athena_HealingFlames()
		if(src.Healing==1||src.climbing==1||src.Dead==1) return
		if(Drain_fromUse(1, src) == 0) return
		src.Healing=1

		flick("flame[src.icon_state]",src)
		src.life += 14
		if(src.life>=src.mlife)
			src.life=src.mlife
		src.Update()
		for(var/mob/A in oview(1))
			if(A.icon_state == "hide" || A.Class =="Randomness") continue
			A.life-=1*Multiplier
			A.KilledBy = src.key
			flickHurt(src)
			if(istype(A, /mob/Entities)||istype(A, /mob/Entities/PTB))
				if(A.life <= 0)
					Death(A)
		for(var/obj/Blasts/B in oview(3))
			switch( B.icon_state )
				if("left")
					B.icon_state="right"
				if("right")
					B.icon_state="left"
				if("up")
					B.icon_state="down"
					if(!B.icon_state)
						sleep(1)
						del B
				if("down")
					B.icon_state="up"
					if(!B.icon_state)
						sleep(1)
						del B
		for(var/mob/Entities/C in oview(3))
			if(C.Class == "Zombie" || C.Guard > 2) continue
			if(C.x>src.x)
				step(C,EAST)
				step(C,EAST)
			if(C.x<src.x)
				step(C,WEST)
				step(C,WEST)
			if(C.y>src.y)
				step(C,NORTH)
				step(C,NORTH)
			if(C.y<src.y)
				step(C,SOUTH)
				step(C,SOUTH)
		if(src.Dead!=1)
			spawn(50) src.Healing=0
			return