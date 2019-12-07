#ifndef INCLUDED_PSX_DM
#define INCLUDED_PSX_DM

obj/Projectiles
	PSXShot
		part1
			pixel_x=32
			icon='psx1.dmi'
		part2
			pixel_y=32
			icon='psx2.dmi'
obj/Characters
	PSX
		layer=MOB_LAYER+1
		right
			icon='psxr.dmi'
			pixel_x=32
		topright
			icon='psxtr.dmi'
			pixel_x=32
			pixel_y=32
		toptopright
			icon='psxttr.dmi'
			pixel_x=32
			pixel_y=64
		topleft
			icon='psxtl.dmi'
			pixel_y=32
		toptopleft
			icon='psxttl.dmi'
			pixel_y=64
#endif