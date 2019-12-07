#ifndef INCLUDED_ZANZIBAR_DM
#define INCLUDED_ZANZIBAR_DM
obj/Characters
	name=""
	Zanzibar
		layer = MOB_LAYER+2
		V1
			icon = 'ZanzibarSword.dmi'
		V2
			icon = 'ZanzibarSwordTop.dmi'
			pixel_y = 32
		V3
			icon = 'ZanzibarSwordRight.dmi'
			pixel_x = 32
		V4
			icon = 'ZanzibarSwordLeft.dmi'
			pixel_x = -32
		V5
			icon = 'ZanzibarSwordTopLeft.dmi'
			pixel_x = -32
			pixel_y = 32
		V6
			icon = 'ZanzibarSwordTopRight.dmi'
			pixel_x = 32
			pixel_y = 32
		V7
			icon = 'ZanzibarSwordFarTop.dmi'
			pixel_y = 64
		V8
			icon = 'ZanzibarSwordFarTopRight.dmi'
			pixel_x = 32
			pixel_y = 64
		V9
			icon = 'ZanzibarSwordFarTopLeft.dmi'
			pixel_x = -32
			pixel_y = 64
#endif

/*

Zanzibar Sword

Power Slash: Causes an invisible AOE shot similar to Elipzo
Melee: 7
AOE: 5
Speed; Slow
Type: Melee/AOE

Spin Slash:  Spinning Melee
Attack: 10
Time: 30 seconds of spin
Type: Melee

Guard
Melee: x2 Damage back
Projectile: x3 Damage back, turns projectiles into AOE when hitting walls or opponents, and eats through gate sheilds.
-- 25 cck
-- 400 reflects
-- 250
*/