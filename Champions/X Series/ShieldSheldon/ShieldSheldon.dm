#ifndef INCLUDED_SHELLDON_DM
#define INCLUDED_SHELLDON_DM
obj/Characters
	layer=MOB_LAYER+1
	Shelldon
		center
			icon='Sheldon.dmi'
		left
			icon='SheldonLeft.dmi'
			pixel_x=-32
		right
			icon='SheldonRight.dmi'
			pixel_x=32
		top
			icon='SheldonTop.dmi'
			pixel_y=32
		topleft
			icon='SheldonTopLeft.dmi'
			pixel_y=32
			pixel_x=-32
		topright
			icon='SheldonTopRight.dmi'
			pixel_y=32
			pixel_x=32
obj/Projectiles
	ShellShot
		top
			icon='ShelldonShot2.dmi'
			pixel_y=32
		topleft
			icon='ShelldonShot4.dmi'
			pixel_y=32
			pixel_x=-32
		left
			icon='ShelldonShot3.dmi'
			pixel_x=-32
#endif
/*Shield Sheldon has 3 abilities(FINALLY SOMEONE WITH MORE THAN TWO!)
He can throw his shell(it has the same attribute as a guard, but it's a projectile),
a guard ability(defensive on BOTH sides), and a disappear ability.  He's not restricted to
gravity in any way, so he's a pretty much, fly, shoot, and disappear guy.*/