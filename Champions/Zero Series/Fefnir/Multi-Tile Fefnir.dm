#ifndef INCLUDED_FEFNIR_DM
#define INCLUDED_FEFNIR_DM
obj/Characters
	Fefnir
		layer=MOB_LAYER+1
		Left
			icon='FefnirLeft.dmi'
			pixel_x=-32
		Right
			icon='FefnirRight.dmi'
			pixel_x=32
		Top
			icon='FefnirTop.dmi'
			pixel_y=32
		TopLeft
			icon='FefnirTopLeft.dmi'
			pixel_x=-32
			pixel_y=32
		TopRight
			icon='FefnirTopRight.dmi'
			pixel_x=32
			pixel_y=32
		Base//again, you know why I put this in there.
			icon='Fefnir.dmi'

/*Fefnir has two attacks.  His normal shot, and his area damage attack.*/
obj//Yes, I might as well do the shot too so it doesnt get lost
	Projectiles
		FefnirBullet
			icon='FefnirShot.dmi'
#endif