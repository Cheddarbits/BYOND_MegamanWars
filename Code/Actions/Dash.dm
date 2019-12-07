mob/proc
	Dash()
		NULL_R( src )
		if(src.inscene==1 ) return
		if( src.icon_state !="left"&&src.icon_state!="right" ) return
		if(src.Dashing == 0)
			src.lock=1
			var/energyDrain = 1
			switch( src.Class )
				if( "Megaman", "Bass" )
					switch( src.icon_state )
						if("left")
							var/turf/aturf = locate(src.x, src.y-1, src.z)
							var/dense = 0
							if(aturf)
								for(var/atom/A in aturf)
									if(A.density == 1) dense = 1;break
								if(aturf.density == 1) dense = 1
							if(!aturf) dense = 1
							if(dense == 1)
								src.Dashing = 1
								sleep(1.5)
								flick("dashleft",src)
								for(var/i=0 to 4)
									sleep(1)
									step(src,WEST)
								src.Dashing = 0
							src.lock=0
							return
						if("right")
							var/turf/aturf = locate(src.x, src.y-1, src.z)
							var/dense = 0
							if(aturf)
								for(var/atom/A in aturf)
									if(A.density == 1) dense = 1;break
								if(aturf.density == 1) dense = 1
							if(!aturf) dense = 1
							if(dense == 1)
								src.Dashing = 1
								sleep(1.5)
								flick("dashright",src)
								for(var/i=0 to 4)
									sleep(1)
									step(src,EAST)
								src.Dashing = 0
							src.lock=0
							return
				if("X", "GAX", "ModelBD")
					switch( src.icon_state )
						if("left")
							src.Dashing = 1
							sleep(1.5)
							flick("dashleft",src)
							for(var/i=0 to 4)
								sleep(1)
								step(src,WEST)
							src.Dashing = 0
							src.lock=0
							return
						if("right")
							src.Dashing = 1
							sleep(1.5)
							flick("dashright",src)
							for(var/i=0 to 4)
								sleep(1)
								step(src,EAST)
							src.Dashing = 0
							src.lock=0
							return
				if("Zero")
					switch( src.icon_state )
						if("left")
							src.Dashing = 1
							sleep(1.5)
							flick("leftdash",src)
							for(var/i=0 to 4)
								sleep(1)
								step(src,WEST)
							src.Dashing = 0
							src.lock=0
							return
						if("right")
							src.Dashing = 1
							sleep(1.5)
							flick("rightdash",src)
							for(var/i=0 to 4)
								sleep(1)
								step(src,EAST)
							src.Dashing = 0
							src.lock=0
							return
				if("MG400")
					switch( src.icon_state )
						if("left")
							src.Dashing = 1
							sleep(1.5)
							flick("dashleft",src)
							for(var/i=0 to 4)
								sleep(1)
								step(src,WEST)
							src.Dashing = 0
							src.lock=0
							return
						if("right")
							src.Dashing = 1
							sleep(1.5)
							flick("dashright",src)
							for(var/i=0 to 4)
								sleep(1)
								step(src,EAST)
							src.Dashing = 0
							src.lock=0
							return
				if("ModelS")
					switch( src.icon_state )
						if("left")
							src.Dashing = 1
							sleep(1.5)
							flick("dashleft",src)
							for(var/i=0 to 3)
								sleep(1)
								step(src,WEST)
								step(src,WEST)
							src.Dashing = 0
							src.lock=0
							return
						if("right")
							src.Dashing = 1
							sleep(1.5)
							flick("dashright",src)
							for(var/i=0 to 3)
								sleep(1)
								step(src,EAST)
								step(src,EAST)
							src.Dashing = 0
							src.lock=0
							return
				if("Harp")
					switch( src.icon_state )
						if("left")
							src.Dashing = 1
							for(var/i=0 to 3)
								step(src,WEST)
							src.Dashing = 0
							src.lock=0
							return
						if("right")
							src.Dashing = 1
							for(var/i=0 to 3)
								step(src,EAST)
							src.Dashing = 0
							src.lock=0
							return
				if("Xeron" ,"Valnaire", "Athena", "AthenaII")
					switch( src.icon_state )
						if("left")
							src.Dashing = 1
							sleep(1)
							flick("dashleft",src)
							for(var/i=0 to 3)
								sleep(1)
								step(src,WEST)
								step(src,WEST)
							src.Dashing = 0
							src.lock=0
							return
						if("right")
							src.Dashing = 1
							sleep(1)
							flick("dashright",src)
							for(var/i=0 to 3)
								sleep(1)
								step(src,EAST)
								step(src,EAST)
							src.Dashing = 0;src.lock=0
							return
				if("XeronII")
					energyDrain = 0
					switch( src.icon_state )
						if("left")
							src.Dashing = 1
							sleep(1)
							flick("dashleft",src)
							for(var/i=0 to 3)
								sleep(1)
								step(src,WEST)
								step(src,WEST)
							src.Dashing = 0
							src.lock=0
							return
						if("right")
							src.Dashing = 1
							sleep(1)
							flick("dashright",src)
							for(var/i=0 to 3)
								sleep(1)
								step(src,EAST)
								step(src,EAST)
							src.Dashing = 0;src.lock=0
							return
				if("Plague")
					if( !isSAdmin( src ) )
						if( src.icon_state != "wallstickleft" && src.icon_state != "wallstickright" && src.density == 0 )
							src.density = 1
					switch( src.icon_state )
						if("left")
							src.Dashing = 1
							flick("dashleft",src)
							for(var/i=0 to 3)
								sleep(1)
								if( !isSAdmin( src ) )
									if( src.icon_state != "wallstickleft" && src.icon_state != "wallstickright" && src.density == 0 )
										src.density = 1
								step(src,WEST)
								step(src,WEST)
								step(src,WEST)
							sleep(2)
							src.Dashing = 0
							src.lock=0
							return
						if("right")
							src.Dashing = 1
							flick("dashright",src)
							for(var/i=0 to 3)
								sleep(1)
								if( !isSAdmin( src ) )
									if( src.icon_state != "wallstickleft" && src.icon_state != "wallstickright" && src.density == 0 )
										src.density = 1
								step(src,EAST)
								step(src,EAST)
								step(src,EAST)
							sleep(2)
							src.Dashing = 0
							src.lock=0
							return

			if(Drain_fromUse(energyDrain, src) == 0) return