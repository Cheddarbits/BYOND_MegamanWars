#ifndef INCLUDED_KNIGHTMAN_DM
#define INCLUDED_KNIGHTMAN_DM
obj/Characters/Knightman
	layer=MOB_LAYER+1
	base
		icon='Knightman.dmi'
	left
		icon='KnightmanLeft.dmi'
		pixel_x=-32
	right
		icon='KnightmanRight.dmi'
		pixel_x=32
	top
		icon='KnightmanTop.dmi'
		pixel_y=32
	topleft
		icon='KnightmanTopLeft.dmi'
		pixel_x=-32
		pixel_y=32
	topright
		icon='KnightmanTopRight.dmi'
		pixel_x=32
		pixel_y=32
/*Knightman has 2 abilities (yes, i did convert this sprite myself)

Attack1-KnightBall-He throws the ball on his left arm, woo
Attack2-KnightBarrier-If he's on a team, he gives his teammates a 30 second barrier
  that protects them from projectiles, but not melees.

Ability-KnightShield-Knightman automatically blocks projectiles with his shield, but not
  melees.*/

#endif