#ifndef INCLUDED_ATHENA_DM
#define INCLUDED_ATHENA_DM
obj/Characters
	name=""
	layer = MOB_LAYER+2
	Athena
		V2
			icon = 'Athena/AthenaT.dmi'
			pixel_y = 32
		V3
			icon = 'Athena/AthenaR.dmi'
			pixel_x = 32
		V4
			icon = 'Athena/AthenaL.dmi'
			pixel_x = -32
		V5
			icon = 'Athena/AthenaTL.dmi'
			pixel_x = -32//icon top left of base
			pixel_y = 32
		V6
			icon = 'Athena/AthenaTR.dmi'
			pixel_x = 32//icon top right of base
			pixel_y = 32
obj/Projectiles
	AthenaShot1
		part2{icon='Athena Shot1.dmi';pixel_x=-64}
		part3{icon='Athena Shot2.dmi';pixel_x=-32}
		part4{icon='Athena Shot4.dmi';pixel_x=-32;pixel_y=32}
	AthenaWaveShot
		part2{icon='Athena Shot2.dmi';pixel_y=32}
		part3{icon='Athena Shot3.dmi';pixel_y=64}
#endif