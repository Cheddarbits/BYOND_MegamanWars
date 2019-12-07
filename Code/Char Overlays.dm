obj/Characters
	layer=MOB_LAYER+1
/*	R
		part2{icon='Rush.dmi';icon_state="";layer=MOB_LAYER;New();pixel_x=32}
		part3{icon='Rush(4).dmi';icon_state="";layer=MOB_LAYER;New();pixel_y=32}
		part4{icon='Rush(3).dmi';icon_state="";layer=MOB_LAYER;New();pixel_x=32;pixel_y=32}
	G
		part2{icon='Gospel.dmi';icon_state="";layer=MOB_LAYER;New();pixel_x=32}
		part3{icon='Gospel(4).dmi';icon_state="";layer=MOB_LAYER;New();pixel_y=32}
		part4{icon='Gospel(3).dmi';icon_state="";layer=MOB_LAYER;New();pixel_x=32;pixel_y=32}
	J
		part2{icon='Jet.dmi';icon_state="";New();pixel_x=32}
		part3{icon='Jet(4).dmi';icon_state="";New();pixel_y=32}
		part4{icon='Jet(3).dmi';icon_state="";New();pixel_x=32;pixel_y=32}
	F
		part2{icon='Fuse.dmi';icon_state="";New();pixel_x=32}
		part3{icon='Fuse(4).dmi';icon_state="";New();pixel_y=32}
		part4{icon='Fuse(3).dmi';icon_state="";New();pixel_x=32;pixel_y=32}*/

//Misc Stuff//

	Team
		layer = MOB_LAYER+2
		pixel_y = 60
		icon = 'TeamStuff.dmi'
		red
			icon_state="red"
		blue
			icon_state="blue"
		yellow
			icon_state="yellow"
		green
			icon_state="green"
		purple
			icon_state="purple"
		silver
			icon_state="silver"
//Weapon Parts//
mob
	var/tmp/Type=0
	AWB
		name = ""
		density=1
		Guard=3
		Type=1
		icon = 'Athena Shot1.dmi'
		icon_state="burn"
	ZIW
		name = ""
		density=1
	GB
		name = ""
		density = 1
		Guard=1
		BarrierBlast=1
		Part1{icon = 'GateSlash.dmi'}
		Part2{icon = 'GateSlash(2).dmi'}
		Part3{icon = 'GateSlash(3).dmi'}
		Part4{icon = 'GateSlash(4).dmi'}
		Part5{icon = 'GateSlash(5).dmi'}
	AW
		name=""
		density=1
		icon='AnubisWall.dmi'
		Guard = 2
		BarrierBlast=2
		Part1{icon_state="bottom"}
		Part2{icon_state="middle"}
		Part3{icon_state="top"}
	AW2
		name=""
		density=1
		icon='AnubisWall.dmi'
		Guard = 3
		BarrierBlast=2
		Part1{icon_state="bottom"}
		Part2{icon_state="middle"}
		Part3{icon_state="top"}