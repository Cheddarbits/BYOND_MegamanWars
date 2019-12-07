#ifndef INCLUDED_RANDOMNESS_DM
#define INCLUDED_RANDOMNESS_DM
obj/Characters
	name = ""
	layer=MOB_LAYER+2
	Randomness
		Left
			icon='Random3.dmi'
			pixel_x=-32
		Right
			icon='Random2.dmi'
			pixel_x=32
		Top
			icon='Random4.dmi'
			pixel_y=32
		TopLeft
			icon='Random5.dmi'
			pixel_y=32
			pixel_x=-32
		TopRight
			icon='Random6.dmi'
			pixel_y=32
			pixel_x=32

proc/RandomHit(mob/M,mob/A)
	if(M.key == A.key) return
	if(M.Dead==0)
		var/LifeDamage=0
		LifeDamage = rand(A.Attack,(A.Attack+Multiplier))
		if(LifeDamage<1) LifeDamage = 1
		M.life-=LifeDamage

		M.KilledBy = A.key
		flickHurt(M)
		if(M.life <= 0)
			Death(M)
// right
// tile3
mob
	var/tmp
		Acceleration=1;
		direction
	proc
		UpLoop()
			var/turf/aturf = get_step( src, src.direction )
			if(!isnull(aturf)&&isturf(aturf) &&src.Class == "Randomness")

				switch( aturf.density )
					if( 0 )
						src.density=1
						if(src.direction==NORTH&&src.Dead!=1)
							var/atom/M = get_step(src, src.direction)
							for(var/A=0 to Acceleration - 1)
								step(src, src.direction)
							if(ismob( M ) )
								var/mob/Target = M
								if(istype(Target, /mob/Entities/Player)||istype(Target, /mob/Entities/PTB))
									if( Target.Dead!=1) Target.KilledBy=src.key;Death(Target)
								else del Target
							if(isobj(M))
								del M

							spawn(1) src.UpLoop()
					if(1)
						src.density=0
						for(var/mob/A in view(4, src))
							RandomHit(A,src)
						if(src.direction==NORTH&&src.Dead!=1)
							for(var/A=0 to Acceleration - 1)
								step(src, src.direction)
							spawn(1) src.UpLoop()
					//	spawn(1) del aturf

		DownLoop()
			var/turf/aturf = get_step(src, src.direction)


			if(!isnull(aturf)&&isturf(aturf)&&src.Class == "Randomness" )

				switch( aturf.density )
					if( 0 )
						src.density=1
						if(src.direction==SOUTH&&src.Dead!=1)
							var/atom/M = get_step(src, src.direction)
							for(var/A=0 to Acceleration - 1)
								step(src, src.direction)
							if(istype(M, /mob))
								if(istype(M, /mob/Entities/Player)||istype(M, /mob/Entities/PTB))
									if(M:Dead!=1) M:KilledBy=src.key;Death(M)
								else del M
							if(isobj(M))
								del M
							spawn(1) src.DownLoop()
					if( 1 )
						src.density=0
						for(var/mob/A in view(4, src))
							RandomHit(A,src)
						if(src.direction==SOUTH&&src.Dead!=1)
							for(var/A=0 to Acceleration - 1)
								step(src, src.direction)
							spawn(1) src.DownLoop()
					//	spawn(1) del aturf
		RightLoop()
			var/turf/aturf = get_step(src, src.direction)

			if(!isnull(aturf)&&isturf(aturf)&&src.Class == "Randomness" )

				switch( aturf.density )
					if( 0 )
						src.density=1
						if(src.direction==EAST&&src.Dead!=1)
							var/atom/M = get_step(src, src.direction)
							for(var/A=0 to Acceleration - 1)
								step(src, src.direction)
							if(istype(M, /mob))
								if(istype(M, /mob/Entities/Player)||istype(M, /mob/Entities/PTB))
									if(M:Dead!=1) M:KilledBy=src.key;Death(M)
								else del M
							if(isobj(M))
								del M
							spawn(1) src.RightLoop()
					if( 1 )
						src.density=0
						for(var/mob/A in view(4, src))
							RandomHit(A,src)
						if(src.direction==EAST&&src.Dead!=1)
							for(var/A=0 to Acceleration - 1)
								step(src, src.direction)
							spawn(1) src.RightLoop()
					//	spawn(1) del aturf
		LeftLoop()
			var/turf/aturf = get_step(src, src.direction)

			if(!isnull(aturf)&&isturf(aturf)&&src.Class == "Randomness" )

				switch( aturf.density )
					if( 0 )
						src.density=1
						if(src.direction==WEST&&src.Dead!=1)
							var/atom/M = get_step(src, src.direction)
							for(var/A=0 to Acceleration - 1)
								step(src, src.direction)
							if(istype(M, /mob))
								if(istype(M, /mob/Entities/Player)||istype(M, /mob/Entities/PTB))
									if(M:Dead!=1) M:KilledBy=src.key;Death(M)
								else del M
							if(isobj(M))
								del M
							spawn(1) src.LeftLoop()
					if(1)
						src.density=0
						for(var/mob/A in view(4, src))
							RandomHit(A,src)
						if(src.direction==WEST&&src.Dead!=1)
							for(var/A=0 to Acceleration - 1)
								step(src, src.direction)
							spawn(1) src.LeftLoop()
					//	spawn(1) del aturf

#endif