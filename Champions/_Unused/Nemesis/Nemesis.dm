/*
Nemesis - Darkkenezin


Controls on numpad.

same movements as xeronI and cannot be paralzyed or spiked.
Same Health function as Valnaire.



Non - element mode.

1. is to dash, same dash speed as Xeron

7. Sword slash, 3 hits one kill. Same sword speed function as Valnaire
when reflected a shot, it backfires a slash, hitting twice the
damage that was shot simular to Gate. Sword can also break a guard.

9. buster shot. kills in 6 shots, paralyzes the foe for 3seconds delay.
each 3rd shot.

3. Element mode change




Dark - element mode.

7. hard sword slash. backs the foe from from
ten tiles away. removes 1/4 of the foes health.

1. is to dash, same dash speed as Xeron

9. powers up to heal, same delay as
Athena II. Same health regain

3. Element mode change




*/
#ifndef INCLUDED_NEMESIS_DM
#define INCLUDED_NEMESIS_DM
obj/Characters
	name = ""
	layer=MOB_LAYER+1
	Nemesis
		Top
			icon='NemesisTop.dmi'
			pixel_y=32
		TopLeft
			icon='NemesisTopLeft.dmi'
			pixel_y=32
			pixel_x=-32
		TopRight
			icon='NemesisTopRight.dmi'
			pixel_y=32
			pixel_x=32
		Left
			icon='NemesisLeft.dmi'
			pixel_x=-32
		Right
			icon='NemesisRight.dmi'
			pixel_x=32
#endif