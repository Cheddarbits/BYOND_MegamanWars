#ifndef INCLUDED_ATHENAII_DM
#define INCLUDED_ATHENAII_DM
obj/Characters
	name=""
	layer = MOB_LAYER+2
	AthenaII
		V2
			icon = 'AthenaII/AthenaT.dmi'
			pixel_y = 32
		V3
			icon = 'AthenaII/AthenaR.dmi'
			pixel_x = 32
		V4
			icon = 'AthenaII/AthenaL.dmi'
			pixel_x = -32
		V5
			icon = 'AthenaII/AthenaTL.dmi'
			pixel_x = -32//icon top left of base
			pixel_y = 32
		V6
			icon = 'AthenaII/AthenaTR.dmi'
			pixel_x = 32//icon top right of base
			pixel_y = 32
		V7
			icon = 'AthenaII/AthenaTTL.dmi'
			pixel_x = -32
			pixel_y = 64
		V8
			icon = 'AthenaII/AthenaTTR.dmi'
			pixel_x = 32
			pixel_y = 64
		V9
			icon = 'AthenaII/AthenaTT.dmi'
			pixel_y = 64
		V11
			icon = 'AthenaII/AthenaTTTR.dmi'
			pixel_x = 32
			pixel_y = 96
		V12
			icon = 'AthenaII/AthenaTTT.dmi'
			pixel_y = 96
		V13
			icon = 'AthenaII/AthenaTLL.dmi'
			pixel_x = -64
			pixel_y = 32
		V14
			icon = 'AthenaII/AthenaTRR.dmi'
			pixel_x = 64
			pixel_y = 32
		V15
			icon = 'AthenaII/AthenaLL.dmi'
			pixel_x = -64
		V16
			icon = 'AthenaII/AthenaRR.dmi'
			pixel_x = 64
		V17
			icon = 'AthenaII/AthenaTTLL.dmi'
			pixel_x = -64
			pixel_y = 64
		V18
			icon = 'AthenaII/AthenaTTRR.dmi'
			pixel_x = 64
			pixel_y = 64
obj/Projectiles
	AthenaShot2
		part2{icon='Athena II Shot1.dmi';pixel_x=-64}
		part3{icon='Athena II Shot2.dmi';pixel_x=-32}
		part4{icon='Athena II Shot4.dmi';pixel_x=-32;pixel_y=32}
	AthenaShot3
		part2{icon='Athena II Shot1.dmi';pixel_x=-32;pixel_y=-32}
		part3{icon='Athena II Shot2.dmi';pixel_y=-32}
		part4{icon='Athena II Shot4.dmi';pixel_y=-64}
	AthenaShot4
		part2{icon='Athena II Shot1.dmi';pixel_x=-32}
		part3{icon='Athena II Shot2.dmi';pixel_x=-32;pixel_y=-32}
		part4{icon='Athena II Shot4.dmi';pixel_y=-32}
#endif
