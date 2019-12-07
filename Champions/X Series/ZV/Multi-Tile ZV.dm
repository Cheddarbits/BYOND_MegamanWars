#ifndef INCLUDED_ZV_DM
#define INCLUDED_ZV_DM
obj/Characters
	ZV
		layer=MOB_LAYER+1
		Base//yes, another one
			icon='ZV.dmi'
		Left
			icon='ZVLeft.dmi'
			pixel_x=-32
		Left2
			icon='ZVLeft2.dmi'
			pixel_x=-64
		Right
			icon='ZVRight.dmi'
			pixel_x=32
		Right2
			icon='ZVRight2.dmi'
			pixel_x=64
		Top
			icon='ZVTop.dmi'
			pixel_y=32
		TopLeft
			icon='ZVTopLeft.dmi'
			pixel_x=-32
			pixel_y=32
		TopLeft2
			icon='ZVTopLeft2.dmi'
			pixel_x=-64
			pixel_y=32
		TopRight
			icon='ZVTopRight.dmi'
			pixel_x=32
			pixel_y=32
		TopRight2
			icon='ZVTopRight2.dmi'
			pixel_x=64
			pixel_y=32
#endif

/*Zero Nightmare(ZV Custom) has 4 abilites.  One is basic guarding, but it guards
against all types of attacks, but he can't attack while doing so, and it won't damage
enemies that hit him with a sword while guarding.  Two is slashing.  This will do major
damage to enemies within 2 spaces of his direction, but this attack takes forever to
recover from.  Three is area damage.  Four is the ability to go invisible like Sigma*/