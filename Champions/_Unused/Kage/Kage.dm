/*
Name: Kage
Type: Custom
Defense: High
Immune: AOE
Speed: Fast

Techniques:

Quick Release(Projectile/Melee): Quick releasing of the blade, sending forth a powerful wave of energy and power towards opponents, which eats through sheilds, or damages guarded foes.
Blade Attack: 12
Energy Attack: 12
Speed: Quick

Melee Storm(Melee/AOE): Rapid Rotation of the blade from all directions damaging those around him.
Attack: 14
Speed: Slow

Camoflague(Invisible): Blending in with the surroundings so one cannot be seen.

Vampire(AOE/Regain): Absorbing the life force of those around oneself to regain health.
Attack: 12
Regain: 6
Speed: Quick
*/
#ifndef INCLUDED_KAGE_DM
#define INCLUDED_KAGE_DM
obj/Characters
	name=""
	Kage
		layer = MOB_LAYER+2
		V1
			icon = 'Kage.dmi'
		V2
			icon = 'KageTop.dmi'
			pixel_y = 32
		V3
			icon = 'KageLeft.dmi'
			pixel_x = -32
		V4
			icon = 'KageRight.dmi'
			pixel_x = 32
		V5
			icon = 'KageTopRight.dmi'
			pixel_x = 32
			pixel_y = 32
		V6
			icon = 'KageTopLeft.dmi'
			pixel_x = -32
			pixel_y = 32
		V7
			icon = 'KageTopTop.dmi'
			pixel_y = 64
		V8
			icon = 'KageTopTopLeft.dmi'
			pixel_y = 64
			pixel_x = -32
		V9
			icon = 'KageTopTopRight.dmi'
			pixel_y = 64
			pixel_x = 32
		V10
			icon = 'KageBottom.dmi'
			pixel_y = -32
		V11
			icon = 'KageBottomRight.dmi'
			pixel_y = -32
			pixel_x = 32
		V12
			icon = 'KageBottomLeft.dmi'
			pixel_y = -32
			pixel_x = -32
		V13
			icon = 'KageFarRight.dmi'
			pixel_x = 64
		V14
			icon = 'KageFarLeft.dmi'
			pixel_x = -64
		V15
			icon = 'KageFarTopLeft.dmi'
			pixel_y = 32
			pixel_x = -64
		V16
			icon = 'KageFarTopRight.dmi'
			pixel_y = 32
			pixel_x = 64
#endif