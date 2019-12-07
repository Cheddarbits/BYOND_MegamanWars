#ifndef INCLUDED_HEATNIX_DM
#define INCLUDED_HEATNIX_DM
obj/Characters
	layer=MOB_LAYER+1
	Heatnix
		top
			icon='HeatnixTop.dmi'
			pixel_y=32
		left
			icon='HeatnixLeft.dmi'
			pixel_x=-32
		right
			icon='HeatnixRight.dmi'
			pixel_x=32
		top2
			icon='HeatnixTop2.dmi'
			pixel_y=64
		top2left
			icon='HeatnixTop2Left.dmi'
			pixel_y=64
			pixel_x=-32
		top2right
			icon='HeatnixTop2Right.dmi'
			pixel_y=64
			pixel_x=32
		topleft
			icon='HeatnixTopLeft.dmi'
			pixel_y=32
			pixel_x=-32
		topright
			icon='HeatnixTopRight.dmi'
			pixel_y=32
			pixel_x=32
obj/Projectiles
	HeatnixShot
		top
			icon='WaveTop.dmi'
			pixel_y=32
#endif
/*Blaze Heatnix has 2 attacks.  The first one is a shot, which uses the WaveBase and WaveTop
icons.  His second is a bomb, which uses the the Bomb icon, and drops from his location to
the ground.  Upon impact on the ground, it explodes, and hits everyone within 6 tiles.*/