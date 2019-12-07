#ifndef INCLUDED_WEIL_DM
#define INCLUDED_WEIL_DM
obj/Characters
	layer=MOB_LAYER+1
	Weil
		Top
			icon='WeilTop.dmi'
			pixel_y=32
	Ragnarok
		Left
			icon='RagWeilLeft.dmi'
			pixel_x=-32
		Right
			icon='RagWeilRight.dmi'
			pixel_x=32
		Top
			icon='RagWeilTop.dmi'
			pixel_y=32
		Top2
			icon='RagWeilTop2.dmi'
			pixel_y=64
		Top2Left
			icon='RagWeilTop2Left.dmi'
			pixel_x=-32
			pixel_y=64
		Top2Right
			icon='RagWeilTop2Right.dmi'
			pixel_x=32
			pixel_y=64
		TopLeft
			icon='RagWeilTopLeft.dmi'
			pixel_x=-32
			pixel_y=32
		TopRight
			icon='RagWeilTopRight.dmi'
			pixel_x=32
			pixel_y=32
#endif
//PLEASE READ//
/*Dr. Weil's normal form has the ability to transform into Ragnarok Weil (numberpad7).
This key will change Dr. Weil back to normal once in Rangarok Form.
Dr. Weil's normal form also has an ability that heals teammates, but for this animation,
flick the same icon state he does to transform.  The healing ability gives teammates randomly
1-100 hp.  Ragnarok Weil has an attack that shoots two balls of energy in two directions, left
and right, deals 8 damage, but has an attack delay of 20!!!*/