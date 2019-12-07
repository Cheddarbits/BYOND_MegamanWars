#ifndef ASTRO_GRID_MAP
#define ASTRO_GRID_MAP
turf/Theme
	name = ""
	MaB
		Astroman
			icon = 'Astroman_map.dmi'
			spawns
				one
				two
				three
				four
				five
				six
				seven
				eight
			bg0
				icon_state = "bg0"
			floating0
				density = 1
				icon_state = "floating0"
			platform0
				density = 1
				one
					icon_state = "platform0_1"
				two
					icon_state = "platform0_2"
				three
					icon_state = "platform0_3"
				four
					icon_state = "platform0_4"
			platform1
				density = 1
				one
					icon_state = "platform1_1"
				two
					icon_state = "platform1_2"
			platform2
				density = 1
				one
					icon_state = "platform2_1"
				two
					icon_state = "platform2_2"
			platform3
				density = 1
				one
					icon_state = "platform3_1"
				two
					icon_state = "platform3_2"
				three
					icon_state = "platform3_3"
			platform4
				density = 1
				one
					icon_state = "platform4_1"
				two
					icon_state = "platform4_2"
				three
					icon_state = "platform4_3"
				four
					icon_state = "platform4_4"
			platform5
				density = 1
				one
					icon_state = "platform5_1"
				two
					icon_state = "platform5_2"
			platform6
				density = 1
				one
					icon_state = "platform6_1"
				two
					icon_state = "platform6_2"
				three
					icon_state = "platform6_3"
			block0
				density = 1
				icon_state = "block0"
			block1
				density = 1
				icon_state = "block1"
			spikes
				density = 0
				top
					icon_state = "roofspikes"
				bottom
					icon_state = "floorspikes"
				left
					icon_state = "wallspikesl"
				right
					icon_state = "wallspikesr"
				Enter(M)
					if(isobj(M))
						del M
					isSpikeImmune(M, src)
#endif