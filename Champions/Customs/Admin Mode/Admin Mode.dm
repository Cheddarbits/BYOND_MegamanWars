/*
Character Name: Admin

Basically to help us monitor the server a little easier.
Deals no damage at all.
Is immune to all damage.
Has no density so players can go through him.
Flies.

7 - Grabs characters reguardless of where they're at. Used mostly to drag them away from spawns and other places.

7 - Hit again to release the target.

9 - Go invisible. Used to watch the players without them knowing. Can become visible anywhere on the map.


Restrictions: To advoid abuse since people could drag people into spikes and gate sheilds depending on staff rank decides what they can do.

Moderators - No use of Grab
Managers - 4 second use of Grab. Automatically releases the target after the 4 seconds and can't be used for another 20 seconds.
Admins - No limits at all. Can Grab and Drag for as long as they please.
*/
#ifndef INCLUDED_ADMINMODE_DM
#define INCLUDED_ADMINMODE_DM
obj/Characters
	name=""
	AdminMode
		base
			icon = 'Admin Mode.dmi'//base of the icon, copy and paste into another code document
		top
			icon = 'Admin ModeT.dmi'
			pixel_y = 32//this is of course the icon above the base
			layer = MOB_LAYER+2
		V3
			icon = 'Admin ModeR.dmi'
			pixel_x = 32//the icon to the right of base
			layer = MOB_LAYER+2
		V4
			icon = 'Admin ModeL.dmi'
			pixel_x = -32//icon to the left of base
			layer = MOB_LAYER+2
		V5
			icon = 'Admin ModeTL.dmi'
			pixel_x = -32//icon top left of base
			pixel_y = 32
			layer = MOB_LAYER+2
		V6
			icon = 'Admin ModeTR.dmi'
			pixel_x = 32//icon top right of base
			pixel_y = 32
			layer = MOB_LAYER+2
#endif