/*
Dr. Wily

-Has 42 life instead of 28

Shot
	-Shoots the normal left/right shot
	-Deals 15 damage
	-Shoots at a delay of 30
	-Once it hits a solid surface (Not a player), it sends out smaller blasts that deal 5 damage
*/


#ifndef INCLUDED_DRWILY_DM
#define INCLUDED_DRWILY_DM
obj/Characters/DrWily
	layer=MOB_LAYER+1
	left
		icon='WilyLeft.dmi'
		pixel_x=-32
	right
		icon='WilyRight.dmi'
		pixel_x=32
	right2
		icon='WilyRight2.dmi'
		pixel_x=64
	top
		icon='WilyTop.dmi'
		pixel_y=32
	top2
		icon='WilyTop2.dmi'
		pixel_y=64
	topleft
		icon='WilyTopLeft.dmi'
		pixel_x=-32
		pixel_y=32
	topright
		icon='WilyTopRight.dmi'
		pixel_x=32
		pixel_y=32
	topright2
		icon='WilyTopRight2.dmi'
		pixel_x=64
		pixel_y=32
	top2left
		icon='WilyTop2Left.dmi'
		pixel_x=-32
		pixel_y=64
	top2right
		icon='WilyTop2Right.dmi'
		pixel_x=32
		pixel_y=64
	top2right2
		icon='WilyTop2Right2.dmi'
		pixel_y=64
		pixel_x=64

	bottom
		icon='WilyBottom.dmi'
		pixel_y=-32
	bottomleft
		icon='WilyBottomLeft.dmi'
		pixel_x=-32
		pixel_y=-32
	bottomright
		icon='WilyBottomRight.dmi'
		pixel_x=32
		pixel_y=-32
	bottomright2
		icon='WilyBottomRight2.dmi'
		pixel_x=64
		pixel_y=-32
#endif