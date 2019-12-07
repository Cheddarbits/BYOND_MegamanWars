#ifndef INCLUDED_MAGMA_DM
#define INCLUDED_MAGMA_DM
obj/Characters
	Magma
		layer=MOB_LAYER+1
		Left
			icon='MagmaLeft.dmi'
			pixel_x=-32
		Right
			icon='MagmaRight.dmi'
			pixel_x=32
		Top
			icon='MagmaTop.dmi'
			pixel_y=32
		Top2
			icon='MagmaTop2.dmi'
			pixel_y=64
		Top2Left
			icon='MagmaTop2Left.dmi'
			pixel_y=64
			pixel_x=-32
		Top2Right
			icon='MagmaTop2Right.dmi'
			pixel_y=64
			pixel_x=32
		TopLeft
			icon='MagmaTopLeft.dmi'
			pixel_x=-32
			pixel_y=32
		TopRight
			icon='MagmaTopRight.dmi'
			pixel_x=32
			pixel_y=32
		Base//you know why
			icon='Magma Dragoon.dmi'
obj/Projectiles
	MagmaShot
		part2{icon='MagmaShot(2).dmi';pixel_x=-32}
		part3{icon='MagmaShot(3).dmi';pixel_y=32}
		part4{icon='MagmaShot(4).dmi';pixel_x=-32;pixel_y=32}
#endif
/*Magma Dragoon has one attack, the Burning Hadoken.  Just use a fire ball type attack
for this shot.*/