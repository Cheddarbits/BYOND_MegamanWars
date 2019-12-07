#ifndef INCLUDED_MAGICMAN_DM
#define INCLUDED_MAGICMAN_DM
obj/Characters
	name=""
	Magicman
		layer = MOB_LAYER+2
		V1
			icon = 'Magicman.dmi'
		V2
			icon = 'MagicmanTop.dmi'
			pixel_y = 32
		V3
			icon = 'MagicmanRight.dmi'
			pixel_x = 32
		V4
			icon = 'MagicmanLeft.dmi'
			pixel_x = -32
		V5
			icon = 'MagicmanTopLeft.dmi'
			pixel_x = -32
			pixel_y = 32
		V6
			icon = 'MagicmanTopRight.dmi'
			pixel_x = 32
			pixel_y = 32
		V7
			icon = 'MagicmanFarTop.dmi'
			pixel_y = 64
		V8
			icon = 'MagicmanFarTopRight.dmi'
			pixel_x = 32
			pixel_y = 64
		V9
			icon = 'MagicmanFarTopLeft.dmi'
			pixel_x = -32
			pixel_y = 64
#endif

/*
Magicman

Bouncey Ball: Pass through the opponent causing no damage intially, but bounces off the nearest wall, and comes back attacking from behind. Phases through Gate Sheilds, and Anubis Walls also.
Atk:9
Spd:Quick
Type:Projectile

Magic Card: Has the unique ability to penetrait through guards, and sheilds to hurt the opponents hiding in them.
Atk: 6
Spd: Medium
Type:Projectile

*/