mob/proc
	Vanish()
		if(src.Dead==1) return
		switch( src.Class )
			if( "SaX", "ZV", "Shelldon" )
				if(src.inscene==1)
					return
		if(src.Teleporting==1)
			var/turf/aturf = locate(src.x, src.y, src.z)  // Get the turf directly below you.
			var/dense=0
			if(aturf)
				for(var/atom/A in aturf)
					if( A != src && A.density == 1)
						dense = 1
				if(dense == 0&&aturf.density==0)
					switch( src.Class )
						if("Sigma")
							flick("teleport",src)
						if("ZV","Shelldon","Mijinion")
							flick("reappear",src)
						if("Shadowman")
							flick("reappearright",src)
						if("SaX")
							flick("invis",src)
						if("Phantom")
							flick("poof",src)
					src.icon_state="right"
					if(src.Class=="Shelldon"||src.Class=="AdminMode") src.Flight=1
					else src.Flight = 0
					src.density=1
					src.Teleporting=0
					for(var/Z in typesof("/obj/Characters/Team/[lowertext(src.Stats[c_Team])]")) src.overlays+=Z
					return
		else
			if(Drain_fromUse(1, src) == 0) return
			switch( src.Class )
				if("Shadowman")
					flick("disappearleft",src)
				if("SaX")
					flick("invis",src)
				if("Phantom")
					flick("poof",src)
				if("ZV","Shelldon","ModelS")
					flick("disappear",src)
					if( src.Class == "ZV" )
						sleep( 6 )
			src.icon_state=""
			src.Flight=1
			src.Teleporting=1
			src.density=1
			if(src.Class == "AdminMode")
				src.density = 0
			for(var/Z in typesof("/obj/Characters/Team/[lowertext(src.Stats[c_Team])]")) src.overlays-=Z
			if(src.Disguised==1||src.hasFlag==1) src.density=1