//mob/var/CanShoot=0
/*Action Use Definitions

Area Effects 	ActionUse[AOE]
Melee 			ActionUse[MEL]
Invisible 		ActionUse[INV]
Guns 			ActionUse[GUN]
Dash 			ActionUse[DSH]
Guard 			ActionUse[GRD]
Heal 			ActionUse[HEL]
*/

client
	Stat()
		..()
		sleep(10)
	script = "<STYLE>BODY {background: black; color: white}  IMG.icon{width:16;height:16}</STYLE>"
//	preload_rsc="http://holydoom.hostse.com/XVsZerorsc.zip"
//	preload_rsc="http://byondgamers.ucoz.com/XVsZerorsc.zip"

/*	DblClick(T)
		if(isSAdmin(usr))
			if(istype(T, /turf))
				var/mob/AW/Part2/P1 = new
				P1.Owner=usr.key
				P1.loc=locate(T:x,T:y,T:z)
				P1.pixel_x=0
			if(istype(T, /mob/AW)) del T
			if(istype(T, /obj/Blasts)) del T*/
	DblClick(turf/T in oview(8))
		if(isSAdmin(usr))
			//if(T.density == 0)
			if(usr.Alternative==0)
				if(istype(T, /turf))
					usr.Update()
					usr.loc=locate(T.x,T.y,T.z)
			if(usr.Alternative==1)
				if(istype(T, /turf))
					var/mob/AW2/Part1/P1 = new
					var/mob/AW2/Part2/P2 = new
					var/mob/AW2/Part3/P3 = new
					var/mob/AW2/Part1/P4 = new
					var/mob/AW2/Part2/P5 = new
					var/mob/AW2/Part3/P6 = new
					var/mob/AW2/Part1/P7 = new
					var/mob/AW2/Part2/P8 = new
					var/mob/AW2/Part3/P9 = new
					P1.Owner =usr.key
					P2.Owner =usr.key
					P3.Owner =usr.key
					P4.Owner =usr.key
					P5.Owner =usr.key
					P6.Owner =usr.key
					P7.Owner =usr.key
					P8.Owner =usr.key
					P9.Owner =usr.key

					P1.loc=locate(T.x,T.y,T.z)
					P2.loc=get_step( T, NORTH )
					P3.loc=locate(T.x,T.y+2,T.z)
					P4.loc=get_step( T, EAST )
					P5.loc=get_step( T, NORTHEAST )
					P6.loc=locate(T.x+1,T.y+2,T.z)
					P7.loc=get_step( T, WEST )
					P8.loc=get_step( T, NORTHWEST )
					P9.loc=locate(T.x-1,T.y+2,T.z)

					P1.pixel_x=0
					P2.pixel_x=0
					P3.pixel_x=0
					P4.pixel_x=0
					P5.pixel_x=0
					P6.pixel_x=0
					P7.pixel_x=0
					P8.pixel_x=0
					P9.pixel_x=0

					P1.Guard=3
					P2.Guard=3
					P3.Guard=3
					P4.Guard=3
					P5.Guard=3
					P6.Guard=3
					P7.Guard=3
					P8.Guard=3
					P9.Guard=3

				if(istype(T, /mob/AW2)) del T
	MouseDrop(src_object, over_object, src_location, over_location)
		if(isSAdmin(usr))
			var/atom/movable/A = src_object
			var/turf/T = over_location
			if(ismob( A ))
				A.loc = T
	North()
		if(usr.nojump==1||usr.inscene==1||usr.Dead==1||usr.icon_state=="hide"||usr.islocked>=1) return
		switch(usr.Class)
			#ifdef INCLUDED_RANDOMNESS_DM
			if("Randomness")
				usr.direction=NORTH
				usr.UpLoop()
			#endif
			if("LWX")
				if(usr.Slashing==1)
					usr.LWXUpThrow()
					return
				switch( usr.icon_state )
					if("grabbedright")
						usr.icon_state="right"
					if("grabbedleft")
						usr.icon_state="left"
		if(usr.Flight==1)
			step(usr, NORTH)
			if(usr.Class=="AdminMode")
				for(var/mob/Entities/Player/M in view(7,usr.loc))
					NULL_C(M)
					NULL_B(usr)
					if(M.key == usr.hasLocked)
						step(M, usr.dir)
						if(get_dist(M, usr) > 3)
							M.isLockedBy = null
							usr.hasLocked = null
							usr.Slashing = 0
			return
		usr.jump()
	South()
		if(usr.nojump==1 || usr.islocked>=1)
			return
		switch(usr.icon_state)
			if("guard", "guardleft", "guardright", "sandleft", "sandright", "hide")
				return
		switch(usr.Class)
			if("AdminMode")
				for(var/mob/Entities/Player/M in view(7,usr.loc))
					NULL_C(M)
					NULL_B(usr)
					if(M.key == usr.hasLocked)
						step(M, usr.dir)
						if(get_dist(M, usr) > 3)
							M.isLockedBy = null
							usr.hasLocked = null
							usr.Slashing = 0
			#ifdef INCLUDED_RANDOMNESS_DM
			if("Randomness")
				usr.direction=SOUTH
				usr.DownLoop()
				return
			#endif
		if(usr.climbing==1)
			if(usr.Class=="AthenaII") return
			switch( usr.icon_state )
				if("clingleft", "wallclingleft") usr.icon_state="left"
				if("clingright", "wallclingright") usr.icon_state="right"
			usr.climbing=0

		step(usr, SOUTH)
	East()
		for(var/turf/F in view(2,usr.loc))
			if(istype(F, /turf/FlagPoint))
				switch(get_WorldStatus(c_Mode))
					if("Capture The Flag", "Neutral Flag")
						break
			if(istype(F, /turf/FlagPoint)|| istype(F, /turf/SpawnPoints))
				if(usr.KilledBy != usr.key)
					++usr.spawnRan
					if(usr.spawnRan>2)
						usr.spawnRan = 0
						if(usr.x < F.x && usr.icon_state == "right")
							for(var/i = 1 to 3)
								step(usr, WEST)
							usr.icon_state="left"
							usr.lock = 0

		switch(usr.Class)
			if("Vile")
				if(usr.Flight == 1)
					switch( usr.icon_state )
						if("left", "right" )
							usr.Flight = 0
			if("Plague")
				if( !isSAdmin( usr ) )
					if( usr.icon_state != "wallstickleft" && usr.icon_state != "wallstickright" && usr.density == 0 )
						usr.density = 1
			if("Zombie")
				if(usr.Teleporting==1&&usr.Shooting==0)
					switch( usr.icon_state )
						if("armright", "armleft", "armpeirceleft", "armpeirceright", "brokenarmleft", "brokenarmright") return
						if("sandleft")
							usr.icon_state="sandright"
							usr.dir=EAST
					var/turf/aturf = get_step( usr, SOUTHEAST )  // Get the turf directly below you.
					var/turf/aturf1 = get_step( usr, EAST )  // Get the turf directly below you.
					if(aturf&&aturf.density == 1&&aturf1&&aturf1.density == 0)
						step(usr,EAST)
						return
			if("LWX")
				if(usr.Slashing==1)
					if(usr.icon_state=="grabbedleft")
						usr.icon_state="grabbedright"
						usr.dir=EAST
					usr.LWXThrow()
					return
			if("MMXZero")
				if(usr.Teleporting==1)
					return
			#ifdef INCLUDED_RANDOMNESS_DM
			if("Randomness")
				usr.icon_state="right"
				usr.direction=EAST
				usr.RightLoop()
			#endif
		if(usr.Teleporting==1&&usr.icon_state=="")
			step(usr,EAST)
			return


		if(usr.lock == 1||usr.inscene==1||usr.icon_state=="hide"||usr.islocked>=1)    // The reason for the lock var is to prevent what some call "drunk movement" in delayed movement.
			return

		usr.lock = 1
		switch( usr.Class )
			if("AdminMode")
				for(var/mob/Entities/Player/M in view(7,usr.loc))
					NULL_C(M)
					NULL_B(usr)
					if(M.key == usr.hasLocked)
						step(M, usr.dir)
						if(get_dist(M, usr) > 3)
							M.isLockedBy = null
							usr.hasLocked = null
							usr.Slashing = 0
			if("XeronII","Solcloud")
				if(usr.icon_state=="right")
			//	usr.lock=0
					if(usr.Class=="XeronII") usr.Dash()
					if(usr.Class=="Solcloud") usr.SolMDash()
			if("XeronII","Solcloud")
				if(usr.lock!=2)
					usr.lock=2
					usr.icon_state="right"
					usr.dir=EAST
					return
		switch( usr.icon_state )
			if("clingright", "clingleft", "wallclingright", "wallclingleft")
				if(usr.Class=="AthenaII") return
				usr.climbing=0
				usr.icon_state="left"
			if("right")  // If they're already faced right, move right.
				switch(usr.Class)
					if("Wolfang")
						var/turf/aturf = get_step( usr, EAST )  // Get the turf directly below you.
						if(aturf&&aturf.density == 1)
							usr.icon_state = "clingleft"
							usr.climbing=1
					if("Athena", "AthenaII")
						var/turf/aturf = get_step( usr, EAST )  // Get the turf directly below you.
						if(aturf&&aturf.density == 1)
							usr.icon_state = "wallclingleft"
							usr.climbing=1
				step(usr,EAST)
				usr.dir = EAST

				if(usr.inSpawn == 1)
					usr.inSpawn = 0
					usr.Guard = 0

				Recover_Energy(usr)
				if(usr.MoveDelay != 0)

					sleep(usr.MoveDelay)
			if("left")   // If they're not faced right, face right.
				usr.icon_state = "right"
				usr.dir = EAST
		usr.lock = 0
		return
	West()

		for(var/turf/F in view(2,usr.loc))
			if(istype(F, /turf/FlagPoint))
				switch(get_WorldStatus(c_Mode))
					if("Capture The Flag", "Neutral Flag")
						break
			if(istype(F, /turf/FlagPoint)|| istype(F, /turf/SpawnPoints))
				if(usr.KilledBy != usr.key)
					++usr.spawnRan
					if(usr.spawnRan>2)
						usr.spawnRan = 0
						if(usr.x > F.x && usr.icon_state == "left")
							for(var/i = 1 to 3)
								step(usr, EAST)
							usr.icon_state="right"
							usr.lock=0

		switch(usr.Class)
			if("Vile")
				if( usr.Flight == 1 )
					switch( usr.icon_state )
						if("left", "right" )
							usr.Flight = 0
			if("Plague")
				if(!isSAdmin( usr ) )
					if( usr.icon_state != "wallstickleft" && usr.icon_state != "wallstickright" && usr.density == 0 )
						usr.density = 1
			if("Zombie")
				if(usr.Teleporting==1&&usr.Shooting==0)
					switch( usr.icon_state )
						if("armright", "armleft", "armpeirceleft", "armpeirceright", "brokenarmleft", "brokenarmright") return
						if("sandright")
							usr.icon_state="sandleft"
							usr.dir=WEST
					var/turf/aturf = get_step( usr, SOUTHWEST )   // Get the turf directly below you.
					var/turf/aturf1 = get_step( usr, WEST )   // Get the turf directly below you.
					if(aturf&&aturf.density == 1&&aturf1&&aturf1.density == 0)
						step(usr,WEST)
						return
			if("LWX")
				if(usr.Slashing==1)
					if(usr.icon_state=="grabbedright")
						usr.icon_state="grabbedleft"
						usr.dir=WEST
					usr.LWXThrow()
					return
			if("MMXZero")
				if(usr.Teleporting==1)
					return
			#ifdef INCLUDED_RANDOMNESS_DM
			if("Randomness")
				usr.icon_state="left"
				usr.direction=WEST
				usr.LeftLoop()
			#endif
		if(usr.Teleporting==1&&usr.icon_state=="")
			step(usr,WEST)
			return

		if(usr.lock == 1||usr.inscene==1||usr.icon_state=="hide"||usr.islocked>=1)
			return

		usr.lock = 1

		switch( usr.Class )
			if("AdminMode")
				for(var/mob/Entities/Player/M in view(7,usr.loc))
					NULL_C(M)
					NULL_B(usr)
					if(M.key == usr.hasLocked)
						step(M, usr.dir)
						if(get_dist(M, usr) > 3)
							M.isLockedBy = null
							usr.hasLocked = null
							usr.Slashing = 0
			if("XeronII","Solcloud")
				if(usr.icon_state=="left")
			//	usr.lock=0
					if(usr.Class=="XeronII") usr.Dash()
					if(usr.Class=="Solcloud") usr.SolMDash()
			if("XeronII","Solcloud")
				if(usr.lock!=2)
					usr.lock=2
					usr.icon_state="left"
					usr.dir=WEST
					return
		switch( usr.icon_state )
			if("clingright", "clingleft", "wallclingright", "wallclingleft")
				if(usr.Class=="AthenaII") return
				usr.climbing=0
				usr.icon_state="right"
			if("left")   // If they're already faced left, move left.
				switch(usr.Class)
					if("Wolfang")
						var/turf/aturf = get_step( usr, WEST )   // Get the turf directly below you.
						if(aturf&&aturf.density == 1)
							usr.icon_state = "clingright"
							usr.climbing=1
					if("Athena", "AthenaII")
						var/turf/aturf = get_step( usr, WEST )  // Get the turf directly below you.
						if(aturf&&aturf.density == 1)
							usr.icon_state = "wallclingright"
							usr.climbing=1
				step(usr,WEST)
				usr.dir = WEST

				if(usr.inSpawn == 1)
					usr.inSpawn = 0
					usr.Guard = 0
				Recover_Energy(usr)
				if(usr.MoveDelay != 0)
					sleep(usr.MoveDelay)
			if("right")  // If they're not faced left, face left.
				usr.icon_state = "left"
				usr.dir = WEST

		usr.lock = 0
		return
	Northeast()
		if(ActionLockList.Find("[usr.key]")||ActionLockList.Find("[usr.client.computer_id]")||usr.inSpawn == 1) return
		for(var/turf/misc/NoAction/T in view(NOACTIONRNG,usr.loc))
			return
		if(usr.Dead==1||usr.Shooting==1||usr.inscene == 1||usr.icon_state=="hide"||usr.islocked>=1)
			return
		if(NewPlayer.Find(usr.key))

			NewPlayer -= usr.key
			sleep(1)
			usr.GotoBattle()
		if(usr.climbing==1)
			if(usr.Class=="AthenaII")
				switch( usr.icon_state )
					if("wallclingleft") usr.icon_state="left"
					if("wallclingright") usr.icon_state="right"
				usr.climbing=0
				usr.lock=0
				return
		switch( usr.Class )
			if("Weil")
				if(usr.inscene == 1){return}
				usr.Heal()
				return

			if("AdminMode")
				usr.Vanish()
			if("Zombie")
				usr.ZombieLunge()
//=================
// MEL - NEMEL
//=================

			if("AthenaII")
				usr.AthenaII_Slash()
			if("Solcloud")
				usr.UpSlash()
			if("Burnerman", "Double")
				usr.Double_Attack()
			if("Dynamo", "Swordman")
				usr.Swordman_Slash()
			if("Tenguman")
				usr.Tengu_Slash()
			if("Beat")
				usr.BeatCharge()
			if("Clownman")
				if(solidBeneath(usr) == 1)
					usr.ClownGrab()
			if("King", "Zero", "Harp", "Medic", "Elpizo", "Colonel", "Fauclaw", "ZV")
				usr.Slash()
			if("PureZero")usr.PureZero_Slash()
			if("Zanzibar")
				if(usr.inscene == 1){return}
				if(solidBeneath(usr) == 1)
					usr.ZanzibarSlash()
			if("Darkguise")
				usr.DG_Slash()
			if("Sigma")
				usr.Sigma_Double()
//=================
// GUARD - NEGRDasdc zujk ,f. lfv,
//=================
			if("Gate")
				for(var/turf/T in view(3,usr.loc))
					if(istype(T, /turf/Capsules)||istype(T, /turf/misc/NoBarrier)||istype(T, /turf/misc/Teleporter))
						usr<<"<B>Cannot create a barrier here."
						return
				flick("slash[usr.icon_state]",usr)
				usr.Barrier()
//=================
// AOE - NEAOE
//=================
		if(ActionUse[AOE]!=1)
			switch(usr.Class)
				if("Omega", "Duo")
					usr.Smash()


//==================
// Shoot - NESHOOT
//==================

		for(var/turf/Capsules/F in view(NOACTIONRNG,usr.loc))
			usr<<"<b>You cannot shoot from here."
			return
		for(var/turf/misc/NoShots/T in view(NOACTIONRNG,usr.loc))
			usr<<"<b>You cannot shoot from here."
			return
		usr.Shooting=1
		switch( usr.Class )
			if("MG400", "SJX", "Met", "Axl", "Heatnix", "Foxtar", "MMXZero", \
			"Woodman",  "Eddie", "Cliff", "Knightman", "DrWily", "SaX", "HDK", \
			"Megaman", "Protoman", "Bass", "X", "Cutman", "Xeron", "CX", "CZero", \
			#ifdef INCLUDED_MAGMA_DM
			"Magma",
			#endif
			"Fefnir", "Valnaire", "Shadowman", \
			#ifdef INCLUDED_SHADOWMANEXE_DM
			"ShadowmanEXE",
			#endif
			"Phantom", "Shelldon", \
			"ModelS", "Ragnarok", "Mijinion", "Leviathen", "ModelC", "PSX","CMX", "Plague", "LWX", \
			"FAX", "GBD", "Anubis", "Grenademan", "Wolfang", "GAX", "Magicman", "HanuMachine", "AirPantheon", \
			"ModelBD", "ModelGate" )

				if(usr.Class=="Plague")
					if(usr.Teleporting==1||usr.Slashing==1)
						usr.Shooting=0
						return
				if(usr.Class=="LWX"&&usr.Slashing==1)
					usr.Shooting = 0
					return
				if(usr.Class=="FAX"&&usr.Teleporting==1)
					usr.Shooting = 0
					return
				if(usr.Class=="Foxtar") usr.delay=5
				if(usr.Class=="MG400") sleep(2.5)
				if(usr.Class=="HDK"&&usr.CharMode==3)
					for(var/mob/M in world)
						if(M.z==usr.z&&!isSAdmin(M))
							M.Move( locate( M.x, M.y-2, M.z ) )
					return
				var/flickState = "shoot[usr.icon_state]"
				if(usr.Class == "Wolfang")
					if(usr.climbing == 1)
						flickState = null
				if(usr.Class == "Phantom" || usr.Class == "Shelldon")
					flickState = "throw[usr.icon_state]"
				if(usr.Class == "GBD" || usr.Class == "Anubis")
					flickState = null
				if( usr.Shooting == 1 )
					flick(flickState,usr)
					usr.Shoot()
			if("Chilldre", "Athena")

				if(usr.Class == "Chilldre")

					sleep(1)
					usr.Chilldre_Slash()
				else

					if(usr.climbing==1)
						flick("[usr.icon_state]shoot",usr)
					else flick("shoot[usr.icon_state]",usr)
					usr.Shoot()
			if("XeronII" )

				usr.XeronFling=1
				if( usr.Class == "XeronII" ) flick("shootup[usr.icon_state]",usr)
				usr.Shoot()
				sleep(1)
				usr.XeronFling=0
				usr.Shooting=0
			if( "Kraft")

				if(usr.Slashing!=1)
					var/turf/aturf = get_step( usr, SOUTH )   // Get the turf directly below you.
					var/dense = 0
					if(aturf)
						for(var/atom/A in aturf)
							if(A.density == 1)
								dense = 1
								break
						if(aturf.density == 1)
							dense = 1
					if(!aturf)
						dense = 1
					switch( dense )
						if( 1 )
							sleep(1)
							flick("shoot[usr.icon_state]",usr)
							usr.Shoot()
						if( 0 )
							sleep(1)
							flick("shoot[usr.icon_state]2",usr)
							usr.Shoot()
			if( "Vile")
				if(usr.Flight==1)
					usr.Shoot()
				else
					var/turf/aturf = get_step( usr, SOUTH )  // Get the turf directly below you.
					var/dense = 0
					if(aturf)
						for(var/atom/A in aturf)
							if(A.density == 1)
								dense = 1
								break
						if(aturf.density == 1)
							dense = 1
					if(!aturf)
						dense = 1
					if(dense == 1)
						flick("shoot[usr.icon_state]",usr)
						usr.Shoot()
		sleep(2)
		usr.Shooting=0

	Southeast()
		if(ActionLockList.Find("[usr.key]")||ActionLockList.Find("[usr.client.computer_id]")||usr.inSpawn == 1) return
		for(var/turf/misc/NoAction/T in view(NOACTIONRNG,usr.loc))
			return

		if(usr.Dead==1||usr.Shooting==1||usr.icon_state=="hide"||usr.islocked>=1||isnull(usr))
			return
		if(NewPlayer.Find(usr.key))

			NewPlayer -= usr.key
			sleep(1)
			usr.GotoBattle()
		switch( usr.Class )
			if("Cliff")
				usr.Heal()
			if("Medic")
				if(Bosses.Find(usr.key)) return
				var/turf/aturf = get_step( usr, SOUTH )  // Get the turf directly below you.
				var/dense = 0
				if(aturf)
					for(var/atom/A in aturf)
						if(A.density == 1)
							dense = 1
							break
					if(aturf.density == 1)
						dense = 1
				if(!aturf)
					dense = 1
				if(dense == 1)
					usr.Heal()
			if("MG400")
				usr.Double_Attack()
			if("Athena")
				if(usr.climbing==1) return
				usr.Slash()
			if("MMXZero")
				if(usr.Teleporting==1) return
				usr.RushCharge()
			if("ModelC")
				usr.RushingStrike()
			if("FAX")
				if(usr.Teleporting==1) return
				usr.RushCharge1()
			if("SJX")
				usr.SJXDouble()
			if("Plague")
				usr.PlagueWallStick()
			if("XeronII")
				if(ActionUse[AOE]==1) return
				usr.BusterFlare()
			if("Woodman")
				if(ActionUse[AOE] == 1) return
				usr.Smash()
			if("LWX")
				usr.LWXUpDash()
			if("Valnaire", "GAX")
				usr.Shield()
			if("ModelBD")
				usr.ModelBD_Push()
			#ifdef INCLUDED_HDK_DM
			if("HDK")
				switch(usr.CharMode)
					if(1)
						usr.RepelBeam()
					if(2)
						for(var/obj/Blasts/O)
							O.icon_state=usr.icon_state
							if(O.Owner!=usr.key) O.Owner="You"
					if(3)
						if(isSAdmin(usr))
							for(var/mob/Entities/M)
								if(M.z!=1&&!isSAdmin(M))
									M.Move( locate( M.x+2, M.y, M.z ) )
			#endif
		if(ActionUse[INV]!=1)
			switch( usr.Class )
				if("ModelS", "Sigma", "ZV","Shelldon", "Shadowman", "Phantom","SaX","Mijinion")
					usr.Vanish()

// SESHOOT
		for(var/turf/Capsules/F in view(NOACTIONRNG,usr.loc))
			usr<<"<b>You cannot shoot from here."
			return
		for(var/turf/misc/NoShots/T in view(NOACTIONRNG,usr.loc))
			usr<<"<b>You cannot shoot from here."
			return
		switch( usr.Class )
			if("AthenaII")

				if(usr.climbing==1)
					usr.Shooting=1;usr.XeronFling=2
					flick("[usr.icon_state]shootdown",usr)
					usr.Shoot()
					usr.Shooting=0;usr.XeronFling=0

				else
					if(Drain_fromUse(1, usr) == 0) return;
					var/turf/aturf = get_step( usr, SOUTH )  // Get the turf directly below you.
					var/dense = 0
					if(aturf)
						for(var/atom/A in aturf)
							if(A.density == 1)
								dense = 1
								break
						if(aturf.density == 1)
							dense = 1
					if(!aturf)
						dense = 1
					switch( dense )
						if( 0 )
							usr.AthenaII_SpinShot()
						if( 1 )
							usr.Athena_FireWave()
			if( "Xeron","PSX","CMX","Kraft")
				if(Drain_fromUse(1, usr) == 0) return;
				usr.Shooting=1
				usr.XeronFling=1
				if(usr.Class=="Kraft")
					if(usr.Slashing!=1)
						var/turf/aturf = get_step( usr, SOUTH )   // Get the turf directly below you.
						var/dense = 0
						if(aturf)
							for(var/atom/A in aturf)
								if(A.density == 1)
									dense = 1
									break
							if(aturf.density == 1) dense = 1
						if(!aturf) dense = 1
						switch( dense )

							if( 1) flick("upshoot[usr.icon_state]",usr)
							if( 0) flick("upshoot[usr.icon_state]2",usr)
				else flick("upshoot[usr.icon_state]",usr)
				usr.Shoot()
				sleep(2)
				usr.XeronFling=0
				usr.Shooting=0
			if("Foxtar")
				if(Drain_fromUse(1, usr) == 0) return;
				if(usr.XeronFling==1) return
				usr.delay=7
				usr.Shooting=1
				usr.XeronFling=1
				var/turf/aturf = get_step( usr, SOUTH )   // Get the turf directly below you.
				var/dense = 0
				if(aturf)
					for(var/atom/A in aturf)
						if(A.density == 1)
							dense = 1
							break
					if(aturf.density == 1)
						dense = 1
				if(!aturf) dense = 1
				if(dense == 1)
					flick("upshot[usr.icon_state]",usr)
					usr.Shoot()
				sleep(3)
				usr.delay=5
				usr.XeronFling=0
				usr.Shooting=0
	Center()
		if(usr.Playing!=0)
			#ifdef INCLUDED_HDK_DM
			if(usr.Class=="HDK")

				if(usr.CharMode==1&&usr.Called==0)
					usr.LockBeam()
				if(usr.CharMode==2)
					for(var/obj/Blasts/O)
						O.icon_state="up"
						if(O.Owner!=usr.key) O.Owner="You"
				if(usr.CharMode==3)
					for(var/mob/Entities/M)
						if(M.z!=1&&!isSAdmin(M))
							M.Move( locate( M.x, M.y+3, M.z ) )
			#endif
			#ifdef INCLUDED_RANDOMNESS_DM
			else if(usr.Class=="Randomness")
				++usr.Acceleration
			else
			#endif

			//	if(usr.Dead==1)
				if(!isGuest(usr)) Save( usr )
				else usr<<"<b>Since you are using a Guest key, save does not work for you."
				//else usr<<"<b>You have to be at character select screen for this."
	Northwest()
		if(ActionLockList.Find("[usr.key]")||ActionLockList.Find("[usr.client.computer_id]")||usr.inSpawn == 1) return
		for(var/turf/misc/NoAction/T in view(NOACTIONRNG,usr.loc))
			return

		if(isnull(usr))
			return
		if(usr.Dead==1||usr.islocked>=1) return
		if(NewPlayer.Find(usr.key))

			NewPlayer -= usr.key
			sleep(1)
			usr.GotoBattle()
		switch( usr.Class )
			if("Zombie")
				usr.ZombieDive()

			if("LWX")
				var/turf/aturf = get_step( usr, SOUTH )   // Get the turf directly below you.
				var/dense = 0
				if(aturf)
					for(var/atom/A in aturf)
						if(A.density == 1)
							dense = 1
							break
					if(aturf.density == 1) dense = 1
				if(!aturf) dense = 1
				if(dense == 1) usr.LWXGrapple()
				if(usr.Slashing==1)
					usr.LWXPunch()

			if("Weil", "Ragnarok") usr.Weil_Trans()
			if("AdminMode")
				usr.Admin_Grab()
			if("Medic")
				if(Bosses.Find(usr.key)) return
				spawn(3)
				usr.SelfHeal()
			if("AthenaII")
				var/turf/aturf = get_step( usr, SOUTH )   // Get the turf directly below you.
				var/dense = 0
				if(aturf)
					for(var/atom/A in aturf)
						if(A.density == 1)
							dense = 1
							break
					if(aturf.density == 1)
						dense = 1
				if(!aturf)
					dense = 1
				if(dense == 1)
					usr.Athena_HealingFlames()
// NWSMASH
		if(ActionUse[AOE]!=1)
			switch( usr.Class )
				if("Plague")

					usr.PlagueDropSlash()
				if("Chilldre")
					if(usr.Slashing==1) return
					var/turf/aturf = get_step( usr, SOUTH )   // Get the turf directly below you.
					var/dense = 0
					if(aturf)
						for(var/atom/A in aturf)
							if(A.density == 1)
								dense = 1
								break
						if(aturf.density == 1) dense = 1
					if(!aturf) dense = 1
					if(dense == 0) usr.Chilldre_Fall()
				if( "Heatnix")
					usr.Shooting=1
					sleep(2)
					flick("bomb[usr.icon_state]",usr)
					usr.Bomb()
					usr.Shooting=0
				if("Elpizo")
					if(usr.inscene == 1){return}
					var/turf/aturf = get_step( usr, SOUTH )   // Get the turf directly below you.
					var/dense = 0
					if(aturf)
						for(var/atom/A in aturf)
							if(A.density == 1)
								dense = 1
								break
						if(aturf.density == 1) dense = 1
					if(!aturf) dense = 1
					if(dense == 1)
						usr.Smash()

				if( "King")
					usr.Smash()
				if("HanuMachine")
					usr.HanuTransform()
				if("ZV")
					if(usr.Teleporting == 1||usr.inscene == 1){return}
					usr.Smash()
				if("Zanzibar")
					if(usr.inscene == 1){return}
					var/turf/aturf = get_step( usr, SOUTH )   // Get the turf directly below you.
					var/dense = 0
					if(aturf)
						for(var/atom/A in aturf)
							if(A.density == 1)
								dense = 1
								break
						if(aturf.density == 1) dense = 1
					if(!aturf) dense = 1
					if(dense == 1)
						usr.ZanzibarSpinSlash()
	// NWSLASH
		switch( usr.Class )
			if( "FAX")
				usr.FAXCharge()
			if( "Solcloud")
				usr.SolDash()
			if("X", "SaX", "MMXZero", "Valnaire", "Xeron", "Shadowman")
				if(usr.Class=="SaX"&&usr.inscene==1) return
				usr.Slash()
			#ifdef INCLUDED_SHADOWMANEXE_DM
			if("ShadowmanEXE")
				if(usr,inscene) return
				usr.Slash()
			#endif
			if("SJX")
				if(usr.inscene==1) return
				usr.SJXPoke()
			if("CMX", "ModelGate")
				if(usr.Shooting!=1&&usr.Slashing!=1&&usr.Dead!=1)
					usr.SlashState=1
					usr.Slash()
					if(usr.Shooting!=1&&usr.Slashing!=1&&usr.Dead!=1)
						usr.SlashState=2
						usr.Slash()
						if(usr.Shooting!=1&&usr.Slashing!=1&&usr.Dead!=1)
							usr.SlashState=3
							usr.Slash()
			if("ModelS")
				if(usr.Shooting!=1&&usr.Slashing!=1&&usr.Dead!=1)
					usr.SlashState=1
					usr.Slash()
					if(usr.Shooting!=1&&usr.Slashing!=1&&usr.Dead!=1)
						usr.SlashState=2
						usr.Slash()
						if(usr.Shooting!=1&&usr.Slashing!=1&&usr.Dead!=1)
							usr.ModelS_Slash()
			if("ModelBD")
				if(usr.Shooting!=1&&usr.Slashing!=1&&usr.Teleporting == 0&&usr.Dead!=1)
					usr.SlashState=1
					usr.Slash()
					if(usr.Shooting!=1&&usr.Slashing!=1&&usr.Teleporting == 0&&usr.Dead!=1)
						usr.SlashState=2
						usr.Slash()

			if("Sigma") usr.Sigma_Slash()
			if("Darkguise")
				if(usr.inscene == 1){return}
				usr.DarkG_Slash()
				return
			if("Tenguman")
				usr.THold()
			if("Kraft")
				if(usr.Slashing==1) return
				var/turf/aturf = get_step( usr, SOUTH )   // Get the turf directly below you.
				var/dense = 0
				if(aturf)
					for(var/atom/A in aturf)
						if(A.density == 1)
							dense = 1
							break
					if(aturf.density == 1) dense = 1
				if(!aturf) dense = 1
				if(dense == 1) usr.Kraft_Slash()
			#ifdef INCLUDED_HDK_DM
			if("HDK")
				switch(usr.CharMode)
					if(1) usr.ChargeBeam()
					if(2)
						for(var/obj/Blasts/O)
							O.icon_state="down"
							if(O.Owner!=usr.key) O.Owner="You"
					if(3)
						for(var/mob/M)
							if(M.z!=1&&!isSAdmin(M))
								M.Move( locate( M.x-2, M.y, M.z ) )
			#endif
			if("Met", "Shelldon", "Burnerman", "Foxtar", "Leviathen", "Dynamo")
				usr.Shield()
			if("Anubis")
				for(var/turf/T in view(3,usr.loc))
					if(istype(T, /turf/Capsules)||istype(T, /turf/misc/NoBarrier)||istype(T, /turf/misc/Teleporter))
						usr<<"<B>Cannot create a barrier here."
						return
				switch( usr.Class )
					if( "Anubis")
						if(usr.inscene == 1){return}
						var/turf/aturf = get_step( usr, SOUTH )   // Get the turf directly below you.
						var/dense = 0
						if(aturf)
							for(var/atom/A in aturf)
								if(A.density == 1)
									dense = 1
									break
							if(aturf.density == 1) dense = 1
						if(!aturf) dense = 1
						if(dense == 1) usr.Barrier()
						dense = null

//===========================
// Shoot - NWSHOOT
//===========================
		for(var/turf/Capsules/F in view(NOACTIONRNG,usr.loc))
			usr<<"<b>You cannot shoot from here."
			return
		for(var/turf/misc/NoShots/T in view(NOACTIONRNG,usr.loc))
			usr<<"<b>You cannot shoot from here."
			return
		switch( usr.Class )
			if("Magicman")
				if(Drain_fromUse(1, usr) == 0) return;
				flick("shoot[usr.icon_state]2",usr)
				usr.Shooting=1
				usr.BulletIcon = 'MagicmanBall.dmi'
				if(!TeamLeaders.Find(usr.key) && !Bosses.Find(usr.key) && ModeTarget != usr.key) usr.Attack = 5
				usr.delay=4
				usr.Shoot()
				sleep(1)
				usr.delay=6
				if(!TeamLeaders.Find(usr.key) && !Bosses.Find(usr.key) && ModeTarget != usr.key)  usr.Attack = 3
				usr.BulletIcon = 'MagicmanMagicCards.dmi'

				usr.Shooting=0
			if("GAX")
				if(Drain_fromUse(1, usr) == 0) return;
				flick("shoot[usr.icon_state]2",usr)
				usr.Shooting=1
				usr.BulletIcon = 'GaeaX_shots2.dmi'
				if(!TeamLeaders.Find(usr.key) && !Bosses.Find(usr.key) && ModeTarget != usr.key)  usr.Attack = 3
				usr.delay=8
				usr.Shoot()
				sleep(1)
				usr.delay=5
				if(!TeamLeaders.Find(usr.key) && !Bosses.Find(usr.key) && ModeTarget != usr.key)  usr.Attack = 2
				usr.BulletIcon = 'GaeaX_shots.dmi'

				usr.Shooting=0
			if( "Eddie", "XeronII", "Axl", "MG400" )
				if(Drain_fromUse(1, usr) == 0 && usr.Class != "Eddie") return;
				flick("shoot[usr.icon_state]",usr)
				usr.Shooting=1
				if(usr.Class=="MG400")
					usr.delay=3
					usr.BulletIcon='MG400shots.dmi'
				if( usr.Class == "Eddie" )
					usr.BulletIcon = 'EddieShotBlue.dmi'
				switch( usr.Class )
					if( "Eddie", "XeronII","MG400")
						usr.Shoot()
						if( usr.Class == "MG400")
							usr.delay=6
							usr.BulletIcon='MG400Missiles.dmi'
						if( usr.Class == "Eddie" )
							usr.BulletIcon = 'EddieShotRed.dmi'
					if("Axl")
						usr.DNAShot()
				usr.Shooting=0
			if("AthenaII")
				if(usr.climbing==1)

					usr.Shooting=1;usr.XeronFling=1
					flick("[usr.icon_state]shootup",usr)
					usr.Shoot()
					usr.Shooting=0;usr.XeronFling=0
			if("AirPantheon")
				if(Drain_fromUse(1, usr) == 0) return;
				usr.Shooting = 1
				usr.XeronFling = 2
				flick("shootdown[usr.icon_state]",usr)
				usr.Shoot()
				usr.Shooting=0
				usr.XeronFling=0
			if("PSX","ModelC","Cliff","Athena")
				if(Drain_fromUse(1, usr) == 0) return;
				if( usr.Class != "Athena" ) usr.Shooting=1
				if(usr.Class=="PSX")
					if(usr.icon_state == "hide") return
					usr.XeronFling=2
					flick("downshot[usr.icon_state]",usr)
					usr.Shoot()
				if(usr.Class=="ModelC"||usr.Class=="Cliff"||usr.Class=="Athena")
					var/turf/aturf = get_step( usr, SOUTH )   // Get the turf directly below you.
					var/dense = 0
					if(aturf)
						for(var/atom/A in aturf)
							if(A.density == 1)
								dense = 1
								break
						if(aturf.density == 1) dense = 1
					if(!aturf) dense = 1
					switch( dense )
						if(1)
							if(usr.Class=="ModelC")
								usr.XeronFling=1
								flick("blast[usr.icon_state]",usr)
								usr.Shoot()
							if(usr.Class=="Cliff")
								usr.XeronFling=1
							if(usr.Class=="Athena")
								usr.Athena_Shoot()
						if(0)
							if(usr.Class=="Cliff")
								usr.XeronFling=2
							if(usr.Class=="Athena"&&usr.climbing!=1)
								usr.SpinShot()
				if(usr.Class=="Cliff")
					flick("spray[usr.icon_state]",usr)
					usr.Shoot()
					sleep(13)
				if( usr.Class != "Athena" ) usr.XeronFling=0;usr.Shooting=0
			if("Vile")
				if(Drain_fromUse(1, usr) == 0) return;
				if(usr.Flight == 1)
					usr.Flight = 0
					switch( usr.icon_state )
						if( "rainleft") usr.icon_state = "left"
						if( "rainright") usr.icon_state = "right"
				else
					usr.Flight = 1
					switch( usr.icon_state )
						if( "left") usr.icon_state = "rainleft"
						if( "right") usr.icon_state = "rainright"
	Southwest()
		if(ActionLockList.Find("[usr.key]")||ActionLockList.Find("[usr.client.computer_id]")||usr.inSpawn == 1) return
//===================================
//  Return functions
//===================================
		if(isnull(usr)) return
		for(var/turf/misc/NoAction/T in view(NOACTIONRNG,usr.loc))
			return

		if(usr.Dead==1||usr.islocked>=1) return
		if(NewPlayer.Find(usr.key))
			NewPlayer -= usr.key

			sleep(1)
			usr.GotoBattle()
//===================================
// Functions that aren't disabled
//===================================
		switch(usr.Class)
			if("HDK")
				switch( usr.CharMode )
					if(1)
						usr.CharMode=2
						usr<<"<b>CharMode 2"
					if(2)
						usr.CharMode=3
						usr<<"<b>CharMode 3"
					if(3)
						usr.CharMode=1
						usr<<"<b>CharMode 1"
				return
			if("Zombie")
				usr.ZombieArmPierce()
//===================================
//  Area Effects Functions - SWAOE
//===================================
		if(ActionUse[AOE]!=1)
			switch( usr.Class )
				if( "Dynamo","Fefnir")
					var/turf/aturf = get_step( usr, SOUTH )   // Get the turf directly below you.
					var/dense = 0
					if(aturf)
						for(var/atom/A in aturf)
							if(A.density == 1) dense = 1;break
						if(aturf.density == 1) dense = 1
					if(!aturf) dense = 1
					if(dense == 1)
						if(usr.Class == "Dynamo")
							if(usr.inscene == 1){return}
							usr.Smash()
						if(usr.Class == "Fefnir")
							if(usr.inscene == 1){return}
							usr.Smash()
				if("Double", "ModelGate")
					usr.Smash()

//===================================
//  Melee Functions
//===================================
		switch( usr.Class )
			if("Cliff")
				usr.CliffDash()
			if("Solcloud")
				usr.OverDrive()
			if("MMXZero")
				if(usr.Teleporting==1) return

				if(solidBeneath(usr) == 1)
					usr.StunSlash()
			if("FAX")
				if(usr.Teleporting==1) return
				usr.RushCharge2()

//===================================
//  Dash Functions - SWDASH
//===================================
			if( "GAX", "MG400", "Plague", "ModelS", "Model X", "Megaman", \
			"Bass", "X", "Zero", "Harp", "Xeron", "Valnaire", "Athena", \
			"AthenaII", "ModelBD")
				if(usr.Class == "Plague")
					if(usr.climbing == 1 || usr.Shooting == 1) return
				if(usr.Class=="Athena"&&usr.climbing==1)
					switch( usr.icon_state )
						if("wallclingleft") usr.icon_state="left"
						if("wallclingright") usr.icon_state="right"
					usr.climbing=0
				usr.Dash()

//===================================
//  Guard Functions - SWGUARD
//===================================
			if("ZV", "SaX", "SJX", "PSX", "Colonel", "Elpizo", "Woodman", "Zanzibar")
				usr.Shield()

//===================================
//  Shoot Functions
//===================================
		for(var/turf/Capsules/F in view(NOACTIONRNG,usr.loc))
			usr<<"<b>You cannot shoot from here."
			return
		for(var/turf/misc/NoShots/T in view(NOACTIONRNG,usr.loc))
			usr<<"<b>You cannot shoot from here."
			return
		switch( usr.Class )
			if("AthenaII", "Kraft", "LWX")

				if(usr.Class == "AthenaII")
					if(usr.climbing==1)
						usr.Shooting=1
						flick("[usr.icon_state]shoot",usr)
						usr.Shoot()
						usr.Shooting=0
				else
					if(Drain_fromUse(1, usr) == 0) return;
					var/turf/aturf = get_step( usr, SOUTH )   // Get the turf directly below you.
					var/dense = 0
					if(aturf)
						for(var/atom/A in aturf)
							if(A.density == 1) dense = 1;break
						if(aturf.density == 1) dense = 1
					if(!aturf) dense = 1
					if(dense == 0&&usr.Slashing==0)
						usr.Shooting=1
						usr.XeronFling=2
						if(usr.Class == "Kraft") flick("downshoot[usr.icon_state]",usr)
						if(usr.Class == "LWX") flick("shootd[usr.icon_state]",usr)
						usr.Shoot()
						usr.Shooting=0
						usr.XeronFling=0
