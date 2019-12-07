#ifndef INCLUDED_GAX_DM
#define INCLUDED_GAX_DM
obj/Characters
	name=""
	layer = MOB_LAYER+2
	GAX
		V1
			icon = 'Gaea.dmi'
		V2
			icon = 'GaeaTop.dmi'
			pixel_y = 32
		V3
			icon = 'GaeaR.dmi'
			pixel_x = 32
		V4
			icon = 'GaeaL.dmi'
			pixel_x = -32
		V5
			icon = 'GaeaTL.dmi'
			pixel_x = -32
			pixel_y = 32
		V6
			icon = 'GaeaTR.dmi'
			pixel_y = 32
			pixel_x = 32
#endif
/*
Page up/9 - Shoot, weaker, normal shot delay, 4-5 damage per shot. Smaller shots used.

Home/7 - Shoot2, stronger, slower and higher delay, 6-7 damage per shot. Larger shots used, AoE damage when collision with wall.

Page down/3 - Guard. Same as SaX's. Heal when absorb shots.

End/1 - Dash, dashes 3 squares per use, normal dash delay.

The character has higher defense against every type of attack, longrange, melee and AoE.
Because of that, he is also slower than the other chars. He is also spike immune, just like in the game.
*/