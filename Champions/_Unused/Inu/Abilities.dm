mob
	proc
		ShowEP()
			if(src.EP>src.MaxEP)
				src.EP=src.MaxEP
			for(var/obj/EP/top/T in src.client.screen)
				T.icon_state="[src.EP]"
			for(var/obj/EP/bottom/B in src.client.screen)
				B.icon_state="[src.EP]"
		AddOL()
			if(usr.body=="Ultimate Armor X")
				usr.icon=null
				usr.overlays=null
				usr.icon=/mob/players/X
				usr.overlays+=/mob/players/X/Bottom
				usr.overlays+=/mob/players/X/BottomLeft
				usr.overlays+=/mob/players/X/BottomRight
				usr.overlays+=/mob/players/X/Left
				usr.overlays+=/mob/players/X/Left2
				usr.overlays+=/mob/players/X/Right
				usr.overlays+=/mob/players/X/Right2
				usr.overlays+=/mob/players/X/Top
				usr.overlays+=/mob/players/X/TopLeft
				usr.overlays+=/mob/players/X/TopLeft2
				usr.overlays+=/mob/players/X/TopRight
				usr.overlays+=/mob/players/X/TopRight2
			if(usr.body=="Black Zero")
				usr.icon=null
				usr.overlays=null
				usr.icon=/mob/players/Zero
				usr.overlays+=/mob/players/Zero/Bottom
				usr.overlays+=/mob/players/Zero/BottomLeft
				usr.overlays+=/mob/players/Zero/BottomRight
				usr.overlays+=/mob/players/Zero/BottomRight2
				usr.overlays+=/mob/players/Zero/BottomLeft2
				usr.overlays+=/mob/players/Zero/Left
				usr.overlays+=/mob/players/Zero/Left2
				usr.overlays+=/mob/players/Zero/Right
				usr.overlays+=/mob/players/Zero/Right2
				usr.overlays+=/mob/players/Zero/Top
				usr.overlays+=/mob/players/Zero/Top2
				usr.overlays+=/mob/players/Zero/TopLeft
				usr.overlays+=/mob/players/Zero/Top2Left
				usr.overlays+=/mob/players/Zero/TopRight
				usr.overlays+=/mob/players/Zero/Top2Right
				usr.overlays+=/mob/players/Zero/TopRight2
				usr.overlays+=/mob/players/Zero/TopLeft2
		Hover()
			var/v=usr.icon_state
			usr.icon_state="stillhover"
			usr.hover=1
			spawn(50)
				usr.hover=0
				usr.icon_state="[v]"
				switch(usr.icon_state)
					if("right")
						usr.dir=EAST
					if("left")
						usr.dir=WEST
		Kuuenbu()
			usr.slashing=1
			spawn(9)
				for(var/mob/M in view(1,src))
					if(M!=usr&&M.invincible==0//&&M.team!=usr.team)
						M.HP-=10
						flick("hit",M)
				usr.slashing=0

		BCA(var/direction)
			src.density=0
			//for(var/mob/M in view(7,src))
			var/counter=5
			src.gdash=1
			spawn while(counter>0)
				sleep(1)
				counter--
				var/turf/T = src.loc
				var/turf/T1
				if(usr.dir==EAST)
					T1=locate(src.x+1,src.y,src.z)
				else if(usr.dir==WEST)
					T1=locate(src.x-1,src.y,src.z)
				if(T1.density==0)
					step(src,direction)
				for(var/mob/M in view(1,T))
					if(M!=src&&M.invincible==0//&&M.team!=usr.team)
						M.HP-=10
						flick("hit",M)
				if(counter==0)
					src.density=1
					spawn(3)
						src.gdash=0
		Rakuhouha(var/direction,var/topx,var/topy)
			set hidden=1
			var/obj/H = new/obj/projectile/rakuhouha
			var/obj/O = new/obj/projectile/rakuhouha/top
			O.pixel_y=topy
			O.pixel_x=topx
			H.overlays+=O
			H.loc = src.loc
			H.dir=direction
			spawn while(H)
				step(H,H.dir)
				var/turf/T = H.loc
				if(T.density == 1)
					del(H)
					del(O)
					break
				for(var/mob/M as mob in T)
					if(M == src)
						continue
					else if(istype(M, /turf))
						del(H)
						del(O)
						break
					else
						if(M.invincible==0//&&M.team!=usr.team)
							flick("hit",M)
							M.HP-=10
							del(H)
							del(O)
				sleep(1)
			if(src==null)
				del(H)

		SB()
			var/obj/H = new/obj/projectile/soulbody
			var/obj/Ol
			if(src.icon_state == "right")
				H.dir = EAST
				H.icon_state="SBR"
				Ol = new/obj/projectile/soulbody/right
			else if(src.icon_state == "left")
				H.dir = WEST
				H.icon_state="SBL"
				Ol = new/obj/projectile/soulbody/left
			H.overlays+=Ol
			spawn(usr.shootdelay)
				var/mob/target
				for(var/mob/M in view(10,src))
					target=M
				H.loc = src.loc
				step_towards(H,target)
				while(H)
					step(H,H.dir)
					var/turf/T = H.loc
					if(T.density == 1)
						del(H)
						break
					for(var/mob/M as mob in T)
						if(M == src)
							continue
						else if(istype(M, /turf))
							del(H)
							break
						else
							if(M.invincible==0//&&M.team!=usr.team)
								flick("hit",M)
								M.icon_state="hit"
								M.icon_state="[usr.icon_state]"
								M.HP-=3
					sleep(1)
		UAXShoot()
			var/obj/H = new/obj/projectile/plasmashot/center
			/*if(src.icon_state == "right")
				H.dir = EAST
			else if(src.icon_state == "left")
				H.dir = WEST*/
			H.dir=usr.dir
			if(src.bullets==0)
				spawn(usr.shootdelay)
					src.bullets=1
					H.loc = src.loc
					while(H)
						step(H,H.dir)
						var/turf/T = H.loc
						if(T.density == 1)
							del(H)
							src.bullets=0
							break
						for(var/mob/M as mob in T)
							if(M == src)
								continue
							else if(istype(M, /turf))
								del(H)
								src.bullets=0
								break
							else
								//flick("hit",M)
								var/obj/projectile/spore/center/O =new /obj/projectile/spore/center()
								O.loc = M.loc
						src.BulletCheck()
						sleep(1)