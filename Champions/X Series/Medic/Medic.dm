#ifndef INCLUDED_MEDIC_DM
#define INCLUDED_MEDIC_DM
obj/Characters
	name=""
	Medic
		layer=MOB_LAYER+1
		V1
			icon = 'Medic.dmi'//base of the icon, copy and paste into another code document
		V2
			icon = 'Medic/MedicT.dmi'
			pixel_y = 32//this is of course the icon above the base
		V3
			icon = 'Medic/MedicR.dmi'
			pixel_x = 32//the icon to the right of base
		V4
			icon = 'Medic/MedicL.dmi'
			pixel_x = -32//icon to the left of base
		V5
			icon = 'Medic/MedicTL.dmi'
			pixel_x = -32//icon top left of base
			pixel_y = 32
		V6
			icon = 'Medic/MedicTR.dmi'
			pixel_x = 32//icon top right of base
			pixel_y = 32
#endif