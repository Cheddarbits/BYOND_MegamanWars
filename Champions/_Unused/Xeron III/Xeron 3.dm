#ifndef INCLUDED_XERONIII_DM
#define INCLUDED_XERONIII_DM
/*
Xeron 3
	-Will replace Xeron 2
	-Takes x2 damage -done
	-Moves at no delay -done
	-Jumps 7 tiles -done

Shoot (Numpad 7) - done
	-Shoots the blast Xeron 2 does
	-Blast does 3 more damage
	-Shoots at a delay of 4 forward
Up Shot (Numpad 9) - done
	-Shoots the blast Xeron 2 does
	-Blast does 3 more damage
	-Shoots at a delay of 4 upward
Down Shot (Numpad 3) - done
	-Shoots the blast Xeron 2 does
	-Blast does 3 more damage
	-Shoots at a delay of 9 downward
	-Works as a mid-air jump, can be used consecutively, 3 tile boost
	-Only works in mid-air
Slash (Numpad 3) - done?
	-Only works on the ground
	-Hits a target directly in front of Xeron
	-Deals 50 damage
	-Hits only on frame 6 of the attack
	-Delay of 13
Dash (Numpad 1) - done
	-Dashes at the speed of Solcloud's custom
	-Completely invulnerable during this time
*/

obj/Characters/XeronIII
	layer=MOB_LAYER+1
	left
		icon='Xeron3Left.dmi'
		pixel_x=-32
	right
		icon='Xeron3Right.dmi'
		pixel_x=32
	top
		icon='Xeron3Top.dmi'
		pixel_y=32
	topleft
		icon='Xeron3TopLeft.dmi'
		pixel_x=-32
		pixel_y=32
	topright
		icon='Xeron3TopRight.dmi'
		pixel_x=32
		pixel_y=32
#endif