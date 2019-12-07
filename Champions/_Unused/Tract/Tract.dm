/*
Name: Tract

Attacks
-Melee
=Time Blade
+Numpad 7
:Hits below, bottom-front, in front, top-front, top
:3 strikes per second.
:Breaks Guards and Anubis Walls.
:7 DMG

-Shot
=Temporal Slash
+Numpad 9
:Stabs into ground and sends piercing shockwave across ground, walls and ceilings.
:Pierces guard, Anubis walls, and Gate walls.
:In air, launches it diagonaly. When it hits ground, it continues like normal shot.
:On ground - Damages the person directly in front of him with the stab attack - 7 DMG
:2 strikes per second.
:Breaks Guards, Anubis Walls, and Gates.
:7 DMG

-AoE
=Temporal Flash
+Numpad 3
:Freezes everyone in the area for 3 seconds.
:Area - 3x3 square around.
:3 second cooldown.
:No DMG

-Uber AoE
=Temporal Fissure
+Numpad 1
:Press once to charge.
:Recieves 1/4 damage when charging.
:Charge time - 120 seconds.
:Immune to AoE while charging.
:Damage charges faster.
:When maxed, overlay is added.
:Unleashed with same key to charge it. Can only be released when charged fully.
:3x3 (3 all directions) area, 27 DMG.
:Heals self 14 pts.
:Deals no damage to teammates or people in spawn.
:Recieves 2x damage for 5 seconds after.
:Can begin charging after 2x duration ends.

-Passive
:Stun Time - Reduced by 1/2

*/
#ifndef INCLUDED_TRACT_DM
#define INCLUDED_TRACT_DM
obj/Characters/Tract
	layer=MOB_LAYER+1
	left
		icon='Tract_Left.dmi'
		pixel_x=-32
	left2
		icon='Tract_Left_Left.dmi'
		pixel_x=-64
	right
		icon='Tract_Right.dmi'
		pixel_x=32
	right2
		icon='Tract_Right_Right.dmi'
		pixel_x=64
	top
		icon='Tract_Top.dmi'
		pixel_y=32
	topleft
		icon='Tract_Left_Top.dmi'
		pixel_x=-32
		pixel_y=32
	topright
		icon='Tract_Right_Top.dmi'
		pixel_x=32
		pixel_y=32
	bottomleft
		icon='Tract_Left_Bottom.dmi'
		pixel_x=-32
		pixel_y=-32
	bottomright
		icon='Tract_Right_Bottom.dmi'
		pixel_x=32
		pixel_y=-32
#endif