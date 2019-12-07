client
	New()
		..()
		new/obj/EP/top(src)
		new/obj/EP/bottom(src)
	East()
		if(usr.invincible==1)
			return
		if(usr.dir==WEST)
			switch(usr.icon_state)
				if("left")
					usr.icon_state="right"
					usr.dir=EAST
				if("stillhover")
					flick("backhover",usr)
					step(usr,EAST)
					usr.dir=WEST


		else
			switch(usr.icon_state)
				if("right")
					step(usr,EAST)
				if("stillhover")
					flick("forwardhover",usr)
					step(usr,EAST)
	West()
		if(usr.invincible==1)
			return
		if(usr.dir==EAST)
			switch(usr.icon_state)
				if("right")
					usr.icon_state="left"
					usr.dir=WEST
				if("stillhover")
					flick("backhover",usr)
					step(usr,WEST)
					usr.dir=EAST


		else
			switch(usr.icon_state)
				if("left")
					step(usr,WEST)
				if("stillhover")
					flick("forwardhover",usr)
					step(usr,WEST)
	North()
		if(usr.invincible==1||usr.hover==1)
			return
		//Do normal north stuff otherwise.
	South()
		if(usr.invincible==1||usr.hover==1)
			return
		//Do normal south stuff otherwise.

	Northwest()
		if(usr.body=="Ultimate Armor X")
			if(usr.gdash==1||usr.EP<5||usr.changing==1)
				return
			usr.EP-=5
			switch(usr.icon_state)
				if("right")
					if(usr.gdash==0)
						flick("novastrikeright",usr)
						usr.BCA(EAST)
				if("left")
					if(usr.gdash==0)
						flick("novastrikeleft",usr)
						usr.BCA(WEST)
			usr.ShowEP()
		else if(usr.body=="Black Zero")
			if(usr.slashing==1||usr.changing==1)
				return
			flick("kuuenbu[usr.icon_state]",usr)
			usr.Kuuenbu()
			usr.ShowEP()
	Northeast()
		if(usr.body=="Ultimate Armor X")
			if(usr.shooting==1||usr.changing==1)
				return
			switch(usr.hover)
				if(0)
					flick("shoot[usr.icon_state]",usr)
				if(1)
					if(usr.dir==EAST)
						flick("hovershootright",usr)
					else if(usr.dir==WEST)
						flick("hovershootleft",usr)
			usr.UAXShoot()
			usr.shooting=1
			usr.ShowEP()
			spawn(40)
				usr.shooting=0
		else if(usr.body=="Black Zero")
			if(usr.slashing==1||usr.changing==1)
				return
			flick("slash[usr.icon_state]",usr)
			usr.slashing=1
			spawn(5)
				usr.slashing=0
			usr.ShowEP()

	Southwest()
		if(usr.changing==1)
			return
		usr.changing=1
		usr.invincible=1
		usr.sbcounter=0
		if(usr.body=="Ultimate Armor X")
			usr.icon_state="null"
			flick("teleout",usr)
			usr.body="Black Zero"
			usr.AddOL()
			sleep(10)
			flick("warp",usr)
			usr.icon_state="right"
			usr.dir=EAST
		else if(usr.body=="Black Zero")
			usr.icon_state="null"
			flick("teleout",usr)
			usr.body="Ultimate Armor X"
			usr.AddOL()
			sleep(10)
			flick("warp",usr)
			usr.icon_state="right"
			usr.dir=EAST
		switch(usr.body)
			if("Black Zero")
				spawn(10)
					usr.invincible=0
					usr.changing=0
			if("Ultimate Armor X")
				spawn(25)
					usr.invincible=0
					usr.changing=0
		usr.ShowEP()
	Southeast()
		if(usr.body=="Ultimate Armor X")
			if(usr.giga==1||usr.EP<10||usr.changing==1)
				return
			usr.EP-=10
			flick("SB[usr.icon_state]",usr)
			usr.sbcounter=15
			spawn while(usr.sbcounter>0)
				usr.sbcounter--
				usr.SB()
				sleep(10)
			spawn(200)
				usr.giga=0
			usr.ShowEP()
		else if(usr.body=="Black Zero")
			if(usr.giga==1||usr.EP<5||usr.changing==1)
				return
			usr.EP-=5
			usr.Rakuhouha(NORTH,0,-32)
			usr.Rakuhouha(EAST,-32,0)
			usr.Rakuhouha(WEST,32,0)
			usr.Rakuhouha(NORTHWEST,0,-32)
			usr.Rakuhouha(NORTHEAST,0,-32)
			flick("rakuhouha",usr)
			usr.giga=1
			spawn(8)
				usr.giga=0
			usr.ShowEP()

mob
	players
		X
			icon='UAX/UAX.dmi'
			Bottom
				icon='UAX/UAXBottom.dmi'
				pixel_y=-32
			BottomLeft
				icon='UAX/UAXBottomLeft.dmi'
				pixel_y=-32
				pixel_x=-32
			BottomRight
				icon='UAX/UAXBottomRight.dmi'
				pixel_y=-32
				pixel_x=32
			Left
				icon='UAX/UAXLeft.dmi'
				pixel_x=-32
			Left2
				icon='UAX/UAXLeftLeft.dmi'
				pixel_x=-64
			Right
				icon='UAX/UAXRight.dmi'
				pixel_x=32
			Right2
				icon='UAX/UAXRightRight.dmi'
				pixel_x=64
			Top
				icon='UAX/UAXTop.dmi'
				pixel_y=32
			TopLeft
				icon='UAX/UAXTopLeft.dmi'
				pixel_y=32
				pixel_x=-32
			TopLeft2
				icon='UAX/UAXTopLeftLeft.dmi'
				pixel_y=32
				pixel_x=-64
			TopRight
				icon='UAX/UAXTopRight.dmi'
				pixel_y=32
				pixel_x=32
			TopRight2
				icon='UAX/UAXTopRightRight.dmi'
				pixel_y=32
				pixel_x=64
		Zero
			icon='Black Zero/BZero.dmi'
			Bottom
				icon='Black Zero/BZeroB.dmi'
				pixel_y=-32
			BottomLeft
				icon='Black Zero/BZeroBL.dmi'
				pixel_y=-32
				pixel_x=-32
			BottomRight
				icon='Black Zero/BZeroBR.dmi'
				pixel_y=-32
				pixel_x=32
			BottomRight2
				icon='Black Zero/BZeroB2R.dmi'
				pixel_y=-32
				pixel_x=64
			BottomLeft2
				icon='Black Zero/BZeroB2L.dmi'
				pixel_y=-32
				pixel_x=-64
			Left
				icon='Black Zero/BZeroL.dmi'
				pixel_x=-32
			Left2
				icon='Black Zero/BZero2L.dmi'
				pixel_x=-64
			Right
				icon='Black Zero/BZeroR.dmi'
				pixel_x=32
			Right2
				icon='Black Zero/BZero2R.dmi'
				pixel_x=64
			Top
				icon='Black Zero/BZeroT.dmi'
				pixel_y=32
			Top2
				icon='Black Zero/BZero2T.dmi'
				pixel_y=64
			TopLeft
				icon='Black Zero/BZeroTL.dmi'
				pixel_y=32
				pixel_x=-32
			Top2Left
				icon='Black Zero/BZero2TL.dmi'
				pixel_y=64
				pixel_x=-32
			TopRight
				icon='Black Zero/BZeroTR.dmi'
				pixel_y=32
				pixel_x=32
			Top2Right
				icon='Black Zero/BZero2TR.dmi'
				pixel_y=64
				pixel_x=32
			TopRight2
				icon='Black Zero/BZeroT2R.dmi'
				pixel_x=64
				pixel_y=32
			TopLeft2
				icon='Black Zero/BZeroT2L.dmi'
				pixel_x=-64
				pixel_y=32