/*
  Innate: Zero has the ability to double jump.


  Numpad 1: Kuuenbu:Only usable in air. does an attack one tile all around him while in the air.Attacks about 4 times.
	2 damage per hit.(One time;2 with double jump)

  Numpad 3: Rakuhouha(Giga Attack): Shoots Projectiles(in the projectiles icon) in all directions. I have 2 possibilities for this, see below.
  	Possibility 1(The way I want it):Give UAX and BZ both an energy bar. The Giga Attacks can cost so much energy to use, and when it hits 0, can't use the attack anymore.

  	Possibility 2(If you really don't want to do that):Have a 30 second cooldown period for the giga attacks.
  	10 damage
  Numpad 7: Slash:Obvious.
  	6 damage


  Numpad 9: Call X:Switches the mob to UAX.
  	Tele out state for BZ, tele in state for UAX*/
#ifndef INCLUDED_BZERO_DM
#define INCLUDED_BZERO_DM
obj/Characters
	name = ""
	layer=MOB_LAYER+1
	BZero
		Top
			icon = 'BZeroT.dmi'
			pixel_y=32
		TTop
			icon = 'BZero2T.dmi'
			pixel_y=64
		TopLeft
			icon = 'BZeroTL.dmi'
			pixel_y=32
			pixel_x=-32
		TTopLeft
			icon = 'BZero2TL.dmi'
			pixel_y=64
			pixel_x=-32
		TopRight
			icon = 'BZeroTR.dmi'
			pixel_y=32
			pixel_x=32
		TTopRight
			icon = 'BZero2TR.dmi'
			pixel_y=64
			pixel_x=32
		Left
			icon = 'BZeroL.dmi'
			pixel_x=-32
		TopLLeft
			icon = 'BZeroT2L.dmi'
			pixel_y=32
			pixel_x=-64
		LLeft
			icon = 'BZero2L.dmi'
			pixel_x=-64
		Right
			icon = 'BZeroR.dmi'
			pixel_x=32
		TopRRight
			icon = 'BZeroT2R.dmi'
			pixel_y=32
			pixel_x=64
		RRight
			icon = 'BZero2R.dmi'
			pixel_x=64
		Bottom
			icon = 'BZeroB.dmi'
			pixel_y=-32
		BottomLeft
			icon = 'BZeroBL.dmi'
			pixel_y=-32
			pixel_x=-32
		BottomRight
			icon = 'BZeroBR.dmi'
			pixel_y=-32
			pixel_x=32
		BottomRRight
			icon = 'BZeroB2R.dmi'
			pixel_y=-32
			pixel_x=64
#endif