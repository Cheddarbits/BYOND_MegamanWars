#ifndef INCLUDED_COLONEL_DM
#define INCLUDED_COLONEL_DM
obj/Characters
	Colonel
		layer=MOB_LAYER+1
		Left
			icon='ColLeft.dmi'
			pixel_x=-32
		Left2
			icon='ColLeft2.dmi'
			pixel_x=-64
		Right
			icon='ColRight.dmi'
			pixel_x=32
		Right2
			icon='ColRight2.dmi'
			pixel_x=64
		Top
			icon='ColTop.dmi'
			pixel_y=32
		Top2
			icon='ColTop2.dmi'
			pixel_y=64
		Top2Left
			icon='ColTop2Left.dmi'
			pixel_x=-32
			pixel_y=64
		Top2Right
			icon='ColTop2Right.dmi'
			pixel_x=32
			pixel_y=64
		TopLeft
			icon='ColTopLeft.dmi'
			pixel_x=-32
			pixel_y=32
		TopRight
			icon='ColTopRight.dmi'
			pixel_x=32
			pixel_y=32
#endif
/*Colonel has 3 abilities.  He can block (numpad 7) using the blockleft and blockright icon-
states, slash (numpad 9) using the slashleft and slashright iconstates, and do area damage
(numpad 1) using the rightground and leftground iconstates.*/