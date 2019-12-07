#ifndef INCLUDED_GAX_DM
#define INCLUDED_GAX_DM
obj/Characters
	name=""
	GAX
		layer = MOB_LAYER+2
		V1
			icon = 'GaeaAX.dmi'//The icon's base
		V2
			icon = 'GaeaAXT.dmi'
			pixel_y = 32//Icon above the base
		V3
			icon = 'GaeaAXR.dmi'
			pixel_x = 32//Icon right of the base
		V4
			icon = 'GaeaAXL.dmi'
			pixel_x = -32//Icon left of the base
		V5
			icon = 'GaeaAXTL.dmi' //remove the "//" before the icon if you have an icon there
			pixel_x = -32//top left of base
			pixel_y = 32
		/*V6
		//	icon = 'XTR.dmi'
			pixel_y = 64//above the top icon
		V7
		//	icon = 'XTR.dmi'
			pixel_x = 64//the other right icon
		V8
		//	icon = 'XTR.dmi'
			pixel_x = -64//the other left icon
		V9
		//	icon = 'XTR.dmi'
			pixel_x = 32//above the top right icon
			pixel_y = 64
		V10
		//	icon = 'XTR.dmi'
			pixel_x = -32//above the top left icon
			pixel_y = 64*/
		V11
			icon = 'GaeaAXTR.dmi' //remove the "//" before the icon if you have an icon there
			pixel_x = 32//top left of base
			pixel_y = 32
#endif
/*
When you are testing other sprites, copy this code, rename the X1 to the name of the icon
it's that simple.

If you were to make a character, but want to change the center point then change the pixel_y to
a negative. Basically, these pixel_x's and pixel_y's work in multiples of 32, 128 is the max if I recall.
*/