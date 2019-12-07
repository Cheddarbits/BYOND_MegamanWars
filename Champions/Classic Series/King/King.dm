#ifndef INCLUDED_KING_DM
#define INCLUDED_KING_DM
/*
King

-Takes 1/3 normal damage
-Moves at no delay

-Slash
	-Deals 6 damage to a single target directly in front of him
	-Knocks target back 8 tiles
	-9 delay
-Around
	-Deals 3 damage to all targets adjacent to him
	-Knocks all targets 2 tiles away from him
	-10 delay
*/

obj/Characters/King
	layer=MOB_LAYER+1
	left
		icon='KingLeft.dmi'
		pixel_x=-32
	left2
		icon='KingLeft2.dmi'
		pixel_x=-64
	right
		icon='KingRight.dmi'
		pixel_x=32
	right2
		icon='KingRight2.dmi'
		pixel_x=64
	top
		icon='KingTop.dmi'
		pixel_y=32
	top2
		icon='KingTop2.dmi'
		pixel_y=64
	topleft
		icon='KingTopLeft.dmi'
		pixel_x=-32
		pixel_y=32
	topright
		icon='KingTopRight.dmi'
		pixel_x=32
		pixel_y=32
	top2left
		icon='KingTop2Left.dmi'
		pixel_x=-32
		pixel_y=64
	top2right
		icon='KingTop2Right.dmi'
		pixel_x=32
		pixel_y=64
#endif