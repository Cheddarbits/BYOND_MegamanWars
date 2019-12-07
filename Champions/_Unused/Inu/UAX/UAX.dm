/*Numpad 1: Nova Strike(Giga Attack):Dashes(as many tiles as Xeron+1) while attacking anything in front of it. It goes through the player, with a 5 second cooldown
		10 damage.

	Possibility 1(The way I want it):Give UAX and BZ both an energy bar. The Giga Attacks can cost so much energy to use, and when it hits 0, can't use the attack anymore.

  	Possibility 2(If you really don't want to do that):Have a 30 second cooldown period for the giga attacks.

  Numpad 3: SB(Soul Body)(Giga Attack): Initiates a 15 second timer where the player can basically shoot soul bodies(In Soul Body icon) one right after the other in all frontal directions(Front, Diagonal Top, Diagonal Bottom)
  	4 damage a piece.
  		The Soul Body icon is the projectile that fires from X in the directions specified.

  Numpad 7: Shoot:Obvious.
  	6 damage

  Numpad 9: Call Zero:Switches the mob to UAX.
  	Tele out state for UAX, tele in state for BZ*/
#ifndef INCLUDED_UAX_DM
#define INCLUDED_UAX_DM
obj/Characters
	name = ""
	layer=MOB_LAYER+1
	UAX
		Top
			icon='UAXTop.dmi'
			pixel_y=32
		TopLeft
			icon='UAXTopLeft.dmi'
			pixel_y=32
			pixel_x=-32
		TopLLeft
			icon='UAXTopLeftLeft.dmi'
			pixel_y=32
			pixel_x=-64
		TopRight
			icon='UAXTopRight.dmi'
			pixel_y=32
			pixel_x=32
		TopRRight
			icon='UAXTopRightRight.dmi'
			pixel_y=32
			pixel_x=64
		Left
			icon='UAXLeft.dmi'
			pixel_x=-32
		LLeft
			icon='UAXLeftLeft.dmi'
			pixel_x=-64
		Right
			icon='UAXRight.dmi'
			pixel_x=32
		RRight
			icon='UAXRightRight.dmi'
			pixel_x=64
		Bottom
			icon='UAXBottom.dmi'
			pixel_y=-32
		BottomLeft
			icon='UAXBottomLeft.dmi'
			pixel_y=-32
			pixel_x=-32
		BottomRight
			icon='UAXBottomRight.dmi'
			pixel_y=-32
			pixel_x=32
#endif