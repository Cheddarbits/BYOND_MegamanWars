proc
	Flag_Respawn()
		switch(get_WorldStatus(c_Map))
			if(UNDERGROUND_LABS) // Underground Lab
				switch(rand(1,3))
					if(1) new /obj/Flags/Neutral(locate(41,45,3))
					if(2) new /obj/Flags/Neutral(locate(35,8,3))
					if(3) new /obj/Flags/Neutral(locate(46,19,3))
			if(COMBAT_FACILITY) // Combat Facility
				switch(rand(1,3))
					if(1) new /obj/Flags/Neutral(locate(50,22,2))
					if(2) new /obj/Flags/Neutral(locate(50,75,2))
					if(3) new /obj/Flags/Neutral(locate(51,50,2))
			#ifdef TWINTOWERS_MAP
			if(TWIN_TOWERS) // Twin Towers
				switch(rand(1,4))
					if(1) new /obj/Flags/Neutral(locate(64,69,4))
					if(2) new /obj/Flags/Neutral(locate(29,31,4))
					if(3) new /obj/Flags/Neutral(locate(29,53,4))
					if(4) new /obj/Flags/Neutral(locate(72,8,4))
			#endif
			if(LAVA_CAVES) // Lava Caves
				switch(rand(1,3))
					if(1) new /obj/Flags/Neutral(locate(22,43,5))
					if(2) new /obj/Flags/Neutral(locate(79,43,5))
					if(3) new /obj/Flags/Neutral(locate(51,51,5))
			if(FROZEN_TUNDRA) // Frozen Tundra
				switch(rand(1,3))
					if(1) new /obj/Flags/Neutral(locate(50,22,6))
					if(2) new /obj/Flags/Neutral(locate(51,29,6))
					if(3) new /obj/Flags/Neutral(locate(51,8,6))
			if(NEO_ARCADIA) // Neo Arcadia
				switch(rand(1,3))
					if(1) new /obj/Flags/Neutral(locate(48,61,7))
					if(2) new /obj/Flags/Neutral(locate(50,6,7))
					if(3) new /obj/Flags/Neutral(locate(47,27,7))
			if(DESERT_TEMPLE) // Desert Temple
				switch(rand(1,3))
					if(1) new /obj/Flags/Neutral(locate(25,4,8))
					if(2) new /obj/Flags/Neutral(locate(52,90,8))
					if(3) new /obj/Flags/Neutral(locate(91,55,8))
			if(SLEEPING_FOREST) // Sleeping Forest
				switch(rand(1,3))
					if(1) new /obj/Flags/Neutral(locate(98,5,9))
					if(2) new /obj/Flags/Neutral(locate(3,5,9))
					if(3) new /obj/Flags/Neutral(locate(44,5,9))
			if(WARZONE) // Warzone
				switch(rand(1,3))
					if(1) new /obj/Flags/Neutral(locate(2,2,10))
					if(2) new /obj/Flags/Neutral(locate(50,33,10))
					if(3) new /obj/Flags/Neutral(locate(50,2,10))
					if(4) new /obj/Flags/Neutral(locate(99,2,10))
			if(GROUND_ZERO) // Ground Zero
				switch(rand(1,3))
					if(1) new /obj/Flags/Neutral(locate(78,62,11))
					if(2) new /obj/Flags/Neutral(locate(24,62,11))
					if(3) new /obj/Flags/Neutral(locate(50,14,11))
			if(ABANDONED_WAREHOUSE)
				switch(rand(1,3))
					if(1) new /obj/Flags/Neutral(locate(47,7,12))
					if(2) new /obj/Flags/Neutral(locate(47,42,12))
					if(3) new /obj/Flags/Neutral(locate(47,90,12))
#ifdef ASTRO_GRID_MAP
			if(ASTRO_GRID)
				switch(rand(1,4))
					if(1) new /obj/Flags/Neutral(locate(26,54,13))
					if(2) new /obj/Flags/Neutral(locate(50,71,13))
					if(3) new /obj/Flags/Neutral(locate(75,54,13))
					if(4) new /obj/Flags/Neutral(locate(51,22,13))
#endif
			if(BATTLEFIELD)
				switch(rand(1,4))
					if(1) new /obj/Flags/Neutral(locate(51,83,14))
					if(2) new /obj/Flags/Neutral(locate(50,43,14))
					if(3) new /obj/Flags/Neutral(locate(24,8,14))
					if(4) new /obj/Flags/Neutral(locate(77,8,14))
	Announce(var/A)
		world <<"<B><U><font color = red>WORLD ANNOUNCEMENT:</U><I><font color = white>[A]"

/*
		else
			if(TeamLocked[c_RED]==1&&TeamLocked[c_BLUE]==1&&TeamLocked[c_YELLOW]==1&&TeamLocked[c_GREEN]==1&&TeamLocked[c_NEUTRAL]==1)
				for(var/I = 1 to 7)
					TeamLocked[I]=0
				Announce("All Teams Enabled")
			else
				var/list/pickList = list("Red", "Blue", "Yellow", "Green", "N/A")
				if(M.client.IsByondMember())
					pickList+="Silver"
				if(isOwner(M)||isAdmin(M)||isModerator(M))
					pickList+="Purple"
				if(TeamLocked[c_RED] == 1) pickList-="Red"
				if(TeamLocked[c_BLUE] == 1) pickList-="Blue"
				if(TeamLocked[c_YELLOW] == 1) pickList-="Yellow"
				if(TeamLocked[c_GREEN] == 1) pickList-="Green"
				if(TeamLocked[c_NEUTRAL] == 1) pickList-="N/A"
				if(TeamLocked[c_SILVER] == 1) pickList-="Silver"
				if(TeamLocked[c_PURPLE] == 1) pickList-="Purple"
				var/randPick = rand(1, pickList.len)
				M.Stats[c_Team] = pickList[randPick]
*/



#if DUEL_MODE
	eMap_Location(mob/M)
		switch(eMap)
			if(UNDERGROUND_LABS)
				switch(M.Class)
					if("ModelGate", "ModelBD")
						M.pixel_y = -4
				switch(rand(1,5))
					if(1) M.loc=locate(/turf/SpawnPoints/UndergroundLab/Spawn00)
					if(2) M.loc=locate(/turf/SpawnPoints/UndergroundLab/Spawn01)
					if(3) M.loc=locate(/turf/SpawnPoints/UndergroundLab/Spawn02)
					if(4) M.loc=locate(/turf/SpawnPoints/UndergroundLab/Spawn03)
					if(5) M.loc=locate(/turf/SpawnPoints/UndergroundLab/Spawn04)
			if(COMBAT_FACILITY)
				switch(M.Class)
					if("ModelGate", "ModelBD")
						M.pixel_y = -4
				switch(rand(1,5))
					if(1) M.loc=locate(50,41,2)
					if(2) M.loc=locate(14,15,2)
					if(3) M.loc=locate(14,84,2)
					if(4) M.loc=locate(87,84,2)
					if(5) M.loc=locate(87,15,2)
			if(TWIN_TOWERS)
				switch(M.Class)
					if("ModelGate", "ModelBD")
						M.pixel_y = -4
				switch(rand(1,4))
					if(1) M.loc=locate(/turf/SpawnPoints/TwinTowers/Spawn00)
					if(2) M.loc=locate(/turf/SpawnPoints/TwinTowers/Spawn01)
					if(3) M.loc=locate(/turf/SpawnPoints/TwinTowers/Spawn02)
					if(4) M.loc=locate(/turf/SpawnPoints/TwinTowers/Spawn03)
			if(LAVA_CAVES)
				switch(M.Class)
					if("ModelGate", "ModelBD")
						M.pixel_y = -4
				switch(rand(1,4))


					if(1) M.loc=locate(15,85,5)
					if(2) M.loc=locate(86,17,5)
					if(3) M.loc=locate(15,17,5)
					if(4) M.loc=locate(86,85,5)

			if(FROZEN_TUNDRA)
				switch(M.Class)
					if("ModelGate", "ModelBD")
						M.pixel_y = -4

				switch(rand(1,4))
					if(1) M.loc=locate(/turf/SpawnPoints/FrozenTundra/SpawnBL)
					if(2) M.loc=locate(/turf/SpawnPoints/FrozenTundra/SpawnBR)
					if(3) M.loc=locate(/turf/SpawnPoints/FrozenTundra/SpawnTL)
					if(4) M.loc=locate(/turf/SpawnPoints/FrozenTundra/SpawnTR)
				/*
					if(1) M.loc=locate(10,24,6)
					if(2) M.loc=locate(10,12,6)
					if(3) M.loc=locate(91,24,6)
					if(4) M.loc=locate(91,12,6)
					*/
			if(NEO_ARCADIA)
				switch(M.Class)
					if("ModelGate", "ModelBD")
						M.pixel_y = -4
				switch(rand(1,4))
					if(1) M.loc=locate(48,95,7)
					if(2) M.loc=locate(48,46,7)
					if(3) M.loc=locate(7,32,7)
					if(4) M.loc=locate(94,32,7)
			if(DESERT_TEMPLE)
				M.pixel_y=-3

				switch(rand(1,6))
					if(1) M.loc=locate(3,9,8)
					if(2) M.loc=locate(98,7,8)
					if(3) M.loc=locate(54,27,8)
					if(4) M.loc=locate(42,53,8)
					if(5) M.loc=locate(42,79,8)
					if(6) M.loc=locate(8,78,8)
			if(SLEEPING_FOREST)
				M.pixel_y=-4

				switch(rand(1,4))
					if(1) M.loc=locate(4,13,9)
					if(2) M.loc=locate(45,27,9)
					if(3) M.loc=locate(75,32,9)
					if(4) M.loc=locate(97,21,9)
			if(WARZONE)
				M.pixel_y=-4

				switch(rand(1,6))
					if(1) M.loc=locate(2,34,10)
					if(2) M.loc=locate(4,15,10)
					if(3) M.loc=locate(41,11,10)
					if(4) M.loc=locate(99,34,10)
					if(5) M.loc=locate(97,15,10)
					if(6) M.loc=locate(59,11,10)
			if(GROUND_ZERO)
				M.pixel_y=-14

				switch(rand(1,6))
					if(1) M.loc=locate(2,22,11)
					if(2) M.loc=locate(16,72,11)
					if(3) M.loc=locate(32,72,11)
					if(4) M.loc=locate(70,72,11)
					if(5) M.loc=locate(86,72,11)
					if(6) M.loc=locate(99,22,11)
			if(ABANDONED_WAREHOUSE)
				M.pixel_y=-14

				switch(rand(1,6))
					if(1) M.loc=locate(2,16,12)
					if(2) M.loc=locate(98,11,12)
					if(3) M.loc=locate(88,45,12)
					if(4) M.loc=locate(6,47,12)
					if(5) M.loc=locate(3,79,12)
					if(6) M.loc=locate(98,84,12)
			if(ASTRO_GRID)
				switch(M.Class)
					if("ModelGate", "ModelBD")
						M.pixel_y = 0
				switch(rand(1,8))
					if(1) M.loc=locate(/turf/Theme/MaB/Astroman/spawns/one)
					if(2) M.loc=locate(/turf/Theme/MaB/Astroman/spawns/two)
					if(3) M.loc=locate(/turf/Theme/MaB/Astroman/spawns/three)
					if(4) M.loc=locate(/turf/Theme/MaB/Astroman/spawns/four)
					if(5) M.loc=locate(/turf/Theme/MaB/Astroman/spawns/five)
					if(6) M.loc=locate(/turf/Theme/MaB/Astroman/spawns/six)
					if(7) M.loc=locate(/turf/Theme/MaB/Astroman/spawns/seven)
					if(8) M.loc=locate(/turf/Theme/MaB/Astroman/spawns/eight)
			if(BATTLEFIELD)
				M.pixel_y = -4
				switch(rand(1,4))
					if(1) M.loc=locate(/turf/Theme/MaB/Burnerman/spawns/one)
					if(2) M.loc=locate(/turf/Theme/MaB/Burnerman/spawns/two)
					if(3) M.loc=locate(/turf/Theme/MaB/Burnerman/spawns/three)
					if(4) M.loc=locate(/turf/Theme/MaB/Burnerman/spawns/four)
#endif
	Map_Location(var/mob/M)
		if(M.SpawnLoc==1) return
		if(playerEvent.Find(M.key))
			switch(get_WorldStatus(c_vMap))
				if(UNDERGROUND_LABS)
					switch(M.Class)
						if("ModelGate", "ModelBD")
							M.pixel_y = 0
					switch(rand(1,5))
						if(1) M.loc=locate(/turf/SpawnPoints/UndergroundLab/Spawn00)
						if(2) M.loc=locate(/turf/SpawnPoints/UndergroundLab/Spawn01)
						if(3) M.loc=locate(/turf/SpawnPoints/UndergroundLab/Spawn02)
						if(4) M.loc=locate(/turf/SpawnPoints/UndergroundLab/Spawn03)
						if(5) M.loc=locate(/turf/SpawnPoints/UndergroundLab/Spawn04)
				if(COMBAT_FACILITY)
					switch(M.Class)
						if("ModelGate", "ModelBD")
							M.pixel_y = 0
					switch(rand(1,5))
						if(1) M.loc=locate(50,41,2)
						if(2) M.loc=locate(14,15,2)
						if(3) M.loc=locate(14,84,2)
						if(4) M.loc=locate(87,84,2)
						if(5) M.loc=locate(87,15,2)
				#ifdef TWINTOWERS_MAP
				if(TWIN_TOWERS)
					switch(M.Class)
						if("ModelGate", "ModelBD")
							M.pixel_y = 0
					switch(rand(1,4))
						if(1) M.loc=locate(/turf/SpawnPoints/TwinTowers/Spawn00)
						if(2) M.loc=locate(/turf/SpawnPoints/TwinTowers/Spawn01)
						if(3) M.loc=locate(/turf/SpawnPoints/TwinTowers/Spawn02)
						if(4) M.loc=locate(/turf/SpawnPoints/TwinTowers/Spawn03)
				#endif
				if(LAVA_CAVES)
					switch(M.Class)
						if("ModelGate", "ModelBD")
							M.pixel_y = -4
					switch(rand(1,4))
						if(1) M.loc=locate(15,85,5)
						if(2) M.loc=locate(86,17,5)
						if(3) M.loc=locate(15,17,5)
						if(4) M.loc=locate(86,85,5)
				if(FROZEN_TUNDRA)
					switch(M.Class)
						if("ModelGate", "ModelBD")
							M.pixel_y = 0
					switch(rand(1,4))
						if(1) M.loc=locate(/turf/SpawnPoints/FrozenTundra/Spawn00)
						if(2) M.loc=locate(/turf/SpawnPoints/FrozenTundra/Spawn01)
						if(3) M.loc=locate(/turf/SpawnPoints/FrozenTundra/Spawn02)
						if(4) M.loc=locate(/turf/SpawnPoints/FrozenTundra/Spawn03)
						/*
						if(1) M.loc=locate(10,24,6)
						if(2) M.loc=locate(10,12,6)
						if(3) M.loc=locate(91,24,6)
						if(4) M.loc=locate(91,12,6)
						*/
				if(NEO_ARCADIA)
					switch(M.Class)
						if("ModelGate", "ModelBD")
							M.pixel_y = 0
					switch(rand(1,4))
						if(1) M.loc=locate(48,95,7)
						if(2) M.loc=locate(48,46,7)
						if(3) M.loc=locate(7,32,7)
						if(4) M.loc=locate(94,32,7)
				if(DESERT_TEMPLE)
					M.pixel_y=-3
					switch(rand(1,6))
						if(1) M.loc=locate(3,9,8)
						if(2) M.loc=locate(98,7,8)
						if(3) M.loc=locate(54,27,8)
						if(4) M.loc=locate(42,53,8)
						if(5) M.loc=locate(42,79,8)
						if(6) M.loc=locate(8,78,8)
				if(SLEEPING_FOREST)
					M.pixel_y=-4
					switch(rand(1,4))
						if(1) M.loc=locate(4,13,9)
						if(2) M.loc=locate(45,27,9)
						if(3) M.loc=locate(75,32,9)
						if(4) M.loc=locate(97,21,9)
				if(WARZONE)
					M.pixel_y=-4

					switch(rand(1,6))
						if(1)
							M.loc=locate(2,34,10)
						if(2)
							M.loc=locate(4,15,10)
						if(3)
							M.loc=locate(41,11,10)
						if(4)
							M.loc=locate(99,34,10)
						if(5)
							M.loc=locate(97,15,10)
						if(6)
							M.loc=locate(59,11,10)
				if(GROUND_ZERO)
					M.pixel_y=-14
					switch(rand(1,6))
						if(1) M.loc=locate(2,22,11)
						if(2) M.loc=locate(16,72,11)
						if(3) M.loc=locate(32,72,11)
						if(4) M.loc=locate(70,72,11)
						if(5) M.loc=locate(86,72,11)
						if(6) M.loc=locate(99,22,11)
				if(ABANDONED_WAREHOUSE)
					M.pixel_y=-4
					switch(rand(1,6))
						if(1) M.loc=locate(2,16,12)
						if(2) M.loc=locate(98,11,12)
						if(3) M.loc=locate(88,45,12)
						if(4) M.loc=locate(6,47,12)
						if(5) M.loc=locate(3,79,12)
						if(6) M.loc=locate(98,84,12)
#ifdef ASTRO_GRID_MAP
				if(ASTRO_GRID)
					switch(rand(1,8))
						if(1) M.loc=locate(/turf/Theme/MaB/Astroman/spawns/one)
						if(2) M.loc=locate(/turf/Theme/MaB/Astroman/spawns/two)
						if(3) M.loc=locate(/turf/Theme/MaB/Astroman/spawns/three)
						if(4) M.loc=locate(/turf/Theme/MaB/Astroman/spawns/four)
						if(5) M.loc=locate(/turf/Theme/MaB/Astroman/spawns/five)
						if(6) M.loc=locate(/turf/Theme/MaB/Astroman/spawns/six)
						if(7) M.loc=locate(/turf/Theme/MaB/Astroman/spawns/seven)
						if(8) M.loc=locate(/turf/Theme/MaB/Astroman/spawns/eight)
#endif
				if(BATTLEFIELD)
					M.pixel_y = -4
					switch(rand(1,4))
						if(1) M.loc=locate(/turf/SpawnPoints/Battlefield/Spawn00)
						if(2) M.loc=locate(/turf/SpawnPoints/Battlefield/Spawn01)
						if(3) M.loc=locate(/turf/SpawnPoints/Battlefield/Spawn02)
						if(4) M.loc=locate(/turf/SpawnPoints/Battlefield/Spawn03)
		else
		/*	if(istype(M,/mob/Entities/Player) && M.Stats[Kills] == 0 && M.Stats[Hits] == 0)
				switch(rand(1,2))
					if(1) M.loc = locate(5, 96, 1)
					if(2) M.loc = locate(27, 96, 1)
				NewPlayer += M.key
				return*/
			switch(get_WorldStatus(c_Map))
				if(UNDERGROUND_LABS)
					switch(M.Class)
						if("ModelGate", "ModelBD")
							M.pixel_y = -8
					switch(rand(1,5))
						if(1) M.loc=locate(/turf/SpawnPoints/UndergroundLab/Spawn00)
						if(2) M.loc=locate(/turf/SpawnPoints/UndergroundLab/Spawn01)
						if(3) M.loc=locate(/turf/SpawnPoints/UndergroundLab/Spawn02)
						if(4) M.loc=locate(/turf/SpawnPoints/UndergroundLab/Spawn03)
						if(5) M.loc=locate(/turf/SpawnPoints/UndergroundLab/Spawn04)
				if(COMBAT_FACILITY)
					switch(M.Class)
						if("ModelGate", "ModelBD")
							M.pixel_y = -8
					switch( get_WorldStatus(c_Mode) )
						if("Protect The Base")
							switch(M.Stats[c_Team])
								if("Red"){M.loc=locate(14,15,2)}
								if("Blue"){M.loc=locate(14,84,2)}
								if("Yellow"){M.loc=locate(87,84,2)}
								if("Green"){M.loc=locate(87,15,2)}
						else
							switch(rand(1,5))
								if(1) M.loc=locate(50,41,2)
								if(2) M.loc=locate(14,15,2)
								if(3) M.loc=locate(14,84,2)
								if(4) M.loc=locate(87,84,2)
								if(5) M.loc=locate(87,15,2)
				#ifdef TWINTOWERS_MAP
				if(TWIN_TOWERS)
					switch(M.Class)
						if("ModelGate", "ModelBD")
							M.pixel_y = -8
					switch(rand(1,4))
						if(1) M.loc=locate(/turf/SpawnPoints/TwinTowers/Spawn00)
						if(2) M.loc=locate(/turf/SpawnPoints/TwinTowers/Spawn01)
						if(3) M.loc=locate(/turf/SpawnPoints/TwinTowers/Spawn02)
						if(4) M.loc=locate(/turf/SpawnPoints/TwinTowers/Spawn03)
				#endif
				if(LAVA_CAVES)
					switch(M.Class)
						if("ModelGate", "ModelBD")
							M.pixel_y = -12
					switch(rand(1,4))
						if(1) M.loc=locate(15,85,5)
						if(2) M.loc=locate(86,17,5)
						if(3) M.loc=locate(15,17,5)
						if(4) M.loc=locate(86,85,5)
				if(FROZEN_TUNDRA)
					switch(M.Class)
						if("ModelGate", "ModelBD")
							M.pixel_y = -8
					switch(rand(1,4))
						if(1) M.loc=locate(/turf/SpawnPoints/FrozenTundra/Spawn00)
						if(2) M.loc=locate(/turf/SpawnPoints/FrozenTundra/Spawn01)
						if(3) M.loc=locate(/turf/SpawnPoints/FrozenTundra/Spawn02)
						if(4) M.loc=locate(/turf/SpawnPoints/FrozenTundra/Spawn03)
						/*
						if(1) M.loc=locate(10,24,6)
						if(2) M.loc=locate(10,12,6)
						if(3) M.loc=locate(91,24,6)
						if(4) M.loc=locate(91,12,6)
						*/
				if(NEO_ARCADIA)
					switch(M.Class)
						if("ModelGate", "ModelBD")
							M.pixel_y = -16
					switch(rand(1,4))
						if(1) M.loc=locate(48,95,7)
						if(2) M.loc=locate(48,46,7)
						if(3) M.loc=locate(7,32,7)
						if(4) M.loc=locate(94,32,7)
				if(DESERT_TEMPLE)
					M.pixel_y=-3

					switch(rand(1,6))
						if(1) M.loc=locate(3,9,8)
						if(2) M.loc=locate(98,7,8)
						if(3) M.loc=locate(54,27,8)
						if(4) M.loc=locate(42,53,8)
						if(5) M.loc=locate(42,79,8)
						if(6) M.loc=locate(8,78,8)
				if(SLEEPING_FOREST)
					M.pixel_y=-4

					switch(rand(1,4))
						if(1) M.loc=locate(4,13,9)
						if(2) M.loc=locate(45,27,9)
						if(3) M.loc=locate(75,32,9)
						if(4) M.loc=locate(97,21,9)
				if(WARZONE)
					M.pixel_y=-4
					switch( get_WorldStatus(c_Mode) )
						if("Warzone", "Capture The Flag")
							switch( M.Stats[c_Team] )
								if("Red")
									switch(rand(1,3))
										if(1)
											M.loc=locate(2,34,10)
										if(2)
											M.loc=locate(4,15,10)
										if(3)
											M.loc=locate(41,11,10)
								if("Blue")
									switch(rand(1,3))
										if(1)
											M.loc=locate(99,34,10)
										if(2)
											M.loc=locate(97,15,10)
										if(3)
											M.loc=locate(59,11,10)
						else
							switch(rand(1,6))
								if(1)
									M.loc=locate(2,34,10)
								if(2)
									M.loc=locate(4,15,10)
								if(3)
									M.loc=locate(41,11,10)
								if(4)
									M.loc=locate(99,34,10)
								if(5)
									M.loc=locate(97,15,10)
								if(6)
									M.loc=locate(59,11,10)
				if(GROUND_ZERO)
					M.pixel_y=-14

					switch(rand(1,6))
						if(1) M.loc=locate(2,22,11)
						if(2) M.loc=locate(16,72,11)
						if(3) M.loc=locate(32,72,11)
						if(4) M.loc=locate(70,72,11)
						if(5) M.loc=locate(86,72,11)
						if(6) M.loc=locate(99,22,11)
				if(ABANDONED_WAREHOUSE)
					M.pixel_y=-4
				//	switch( WorldMode )
					switch(rand(1,6))
						if(1) M.loc=locate(2,16,12)
						if(2) M.loc=locate(98,11,12)
						if(3) M.loc=locate(88,45,12)
						if(4) M.loc=locate(6,47,12)
						if(5) M.loc=locate(3,79,12)
						if(6) M.loc=locate(98,84,12)
#ifdef ASTRO_GRID_MAP
				if(ASTRO_GRID)
					switch(M.Class)
						if("ModelGate", "ModelBD")
							M.pixel_y = -8
					switch(rand(1,8))
						if(1) M.loc=locate(/turf/Theme/MaB/Astroman/spawns/one)
						if(2) M.loc=locate(/turf/Theme/MaB/Astroman/spawns/two)
						if(3) M.loc=locate(/turf/Theme/MaB/Astroman/spawns/three)
						if(4) M.loc=locate(/turf/Theme/MaB/Astroman/spawns/four)
						if(5) M.loc=locate(/turf/Theme/MaB/Astroman/spawns/five)
						if(6) M.loc=locate(/turf/Theme/MaB/Astroman/spawns/six)
						if(7) M.loc=locate(/turf/Theme/MaB/Astroman/spawns/seven)
						if(8) M.loc=locate(/turf/Theme/MaB/Astroman/spawns/eight)
#endif
				if(BATTLEFIELD)
					M.pixel_y = -4
					switch(rand(1,4))
						if(1) M.loc=locate(/turf/SpawnPoints/Battlefield/Spawn00)
						if(2) M.loc=locate(/turf/SpawnPoints/Battlefield/Spawn01)
						if(3) M.loc=locate(/turf/SpawnPoints/Battlefield/Spawn02)
						if(4) M.loc=locate(/turf/SpawnPoints/Battlefield/Spawn03)
proc/isSpawnPoint(var/mob/M)
	M.inSpawn = 0
	if(M.Guard == 0)
		if(M.loc==locate(/turf/SpawnPoints/UndergroundLab/Spawn00))	M.Guard = 3
		if(M.loc==locate(/turf/SpawnPoints/UndergroundLab/Spawn01))	M.Guard = 3
		if(M.loc==locate(/turf/SpawnPoints/UndergroundLab/Spawn02))	M.Guard = 3
		if(M.loc==locate(/turf/SpawnPoints/UndergroundLab/Spawn03))	M.Guard = 3
		if(M.loc==locate(/turf/SpawnPoints/UndergroundLab/Spawn04))	M.Guard = 3
		if(M.loc==locate(50,41,2))									M.Guard = 3
		if(M.loc==locate(14,15,2))									M.Guard = 3
		if(M.loc==locate(14,84,2))									M.Guard = 3
		if(M.loc==locate(87,84,2))									M.Guard = 3
		if(M.loc==locate(87,15,2))									M.Guard = 3
#ifdef TWINTOWERS_MAP
		if(M.loc==locate(/turf/SpawnPoints/TwinTowers/Spawn00))		M.Guard = 3
		if(M.loc==locate(/turf/SpawnPoints/TwinTowers/Spawn01))		M.Guard = 3
		if(M.loc==locate(/turf/SpawnPoints/TwinTowers/Spawn02))		M.Guard = 3
		if(M.loc==locate(/turf/SpawnPoints/TwinTowers/Spawn03))		M.Guard = 3
#endif
		if(M.loc==locate(15,85,5))									M.Guard = 3
		if(M.loc==locate(86,17,5))									M.Guard = 3
		if(M.loc==locate(15,17,5))									M.Guard = 3
		if(M.loc==locate(86,85,5))									M.Guard = 3
		if(M.loc==locate(10,24,6))									M.Guard = 3
		if( M.loc==locate(10,12,6))									M.Guard = 3
		if(M.loc==locate(91,24,6))									M.Guard = 3
		if(M.loc==locate(91,12,6))									M.Guard = 3
		if(M.loc==locate(48,95,7))									M.Guard = 3
		if(M.loc==locate(48,46,7))									M.Guard = 3
		if(M.loc==locate(7,32,7))									M.Guard = 3
		if( M.loc==locate(94,32,7))									M.Guard = 3
		if( M.loc==locate(3,9,8))									M.Guard = 3
		if( M.loc==locate(98,7,8))									M.Guard = 3
		if( M.loc==locate(54,27,8))									M.Guard = 3
		if( M.loc==locate(42,53,8))									M.Guard = 3
		if( M.loc==locate(42,79,8))									M.Guard = 3
		if( M.loc==locate(8,78,8))									M.Guard = 3
		if( M.loc==locate(4,13,9))									M.Guard = 3
		if( M.loc==locate(45,27,9))									M.Guard = 3
		if( M.loc==locate(75,32,9))									M.Guard = 3
		if( M.loc==locate(97,21,9))									M.Guard = 3
		if( M.loc==locate(2,34,10))									M.Guard = 3
		if(M.loc==locate(4,15,10))									M.Guard = 3
		if(M.loc==locate(41,11,10))									M.Guard = 3
		if(M.loc==locate(99,34,10))									M.Guard = 3
		if(M.loc==locate(97,15,10))									M.Guard = 3
		if(M.loc==locate(59,11,10))									M.Guard = 3
		if(M.loc==locate(2,22,11))									M.Guard = 3
		if( M.loc==locate(16,72,11))								M.Guard = 3
		if( M.loc==locate(32,72,11))								M.Guard = 3
		if( M.loc==locate(70,72,11))								M.Guard = 3
		if( M.loc==locate(86,72,11))								M.Guard = 3
		if( M.loc==locate(99,22,11))								M.Guard = 3
		if( M.loc==locate(2,16,12))									M.Guard = 3
		if( M.loc==locate(98,11,12))								M.Guard = 3
		if( M.loc==locate(88,45,12))								M.Guard = 3
		if( M.loc==locate(6,47,12))									M.Guard = 3
		if( M.loc==locate(3,79,12))									M.Guard = 3
		if( M.loc==locate(98,84,12))								M.Guard = 3
#ifdef ASTRO_GRID_MAP
		if( M.loc==locate(/turf/Theme/MaB/Astroman/spawns/one))		M.Guard = 3
		if( M.loc==locate(/turf/Theme/MaB/Astroman/spawns/two))		M.Guard = 3
		if( M.loc==locate(/turf/Theme/MaB/Astroman/spawns/three))	M.Guard = 3
		if( M.loc==locate(/turf/Theme/MaB/Astroman/spawns/four))	M.Guard = 3
		if( M.loc==locate(/turf/Theme/MaB/Astroman/spawns/five))	M.Guard = 3
		if( M.loc==locate(/turf/Theme/MaB/Astroman/spawns/six))		M.Guard = 3
		if( M.loc==locate(/turf/Theme/MaB/Astroman/spawns/seven))	M.Guard = 3
		if( M.loc==locate(/turf/Theme/MaB/Astroman/spawns/eight))	M.Guard = 3
#endif
		if( M.loc==locate(/turf/SpawnPoints/Battlefield/Spawn00))	M.Guard = 3
		if( M.loc==locate(/turf/SpawnPoints/Battlefield/Spawn01)) 	M.Guard = 3
		if( M.loc==locate(/turf/SpawnPoints/Battlefield/Spawn02)) 	M.Guard = 3
		if( M.loc==locate(/turf/SpawnPoints/Battlefield/Spawn03)) 	M.Guard = 3

		if(M.Guard == 3) M.inSpawn = 1
mob/Entities
	PTB
		icon = 'Spinners.dmi';density=1;pixel_x=8
		mlife=10000;life=10000
		Red
			icon_state="Red"
			New()
				Stats[c_Team]="Red"
		Blue
			icon_state="Blue"
			New()
				Stats[c_Team]="Blue"
		Yellow
			icon_state="Yellow"
			New()
				Stats[c_Team]="Yellow"
		Green
			icon_state="Green"
			New()
				Stats[c_Team]="Green"
		mini
			mlife=5000;life=5000
			Red
				icon_state="Red"
				New()
					Stats[c_Team]="Red"
			Blue
				icon_state="Blue"
				New()
					Stats[c_Team]="Blue"
			Yellow
				icon_state="Yellow"
				New()
					Stats[c_Team]="Yellow"
			Green
				icon_state="Green"
				New()
					Stats[c_Team]="Green"
obj
	Flags
		icon = 'flag.dmi';density=1;pixel_y=4;pixel_x=8
		Neutral{icon_state="n";name="Neutral"}
		Red{icon_state="r";name="Red"}
		Blue{icon_state="b";name="Blue"}
		Yellow{icon_state="y";name="Yellow"}
		Green{icon_state="g";;name="Green"}
		Silver{icon_state="s";name="Silver"}
		Purple{icon_state="p";name="Purple"}
	oFlags
		icon = 'flag.dmi';layer=MOB_LAYER+2;pixel_y=40;pixel_x=8
		Neutral{icon_state="n";name="Neutral"}
		Red{icon_state="r";name="Red"}
		Blue{icon_state="b";name="Blue"}
		Yellow{icon_state="y";name="Yellow"}
		Green{icon_state="g";name="Green"}
		Silver{icon_state="s";name="Silver"}
		Purple{icon_state="p";name="Purple"}













