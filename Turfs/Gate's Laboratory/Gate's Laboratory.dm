turf/FlagPoint
	name = ""
	density = 1
turf/Capsules
	name = ""
	Capsule
		icon = 'Capsule01.dmi'
	/*Capsule1
		icon = 'Capsule1.dmi'
		zero0
			icon_state="0,0"
			density=1
		zero1
			icon_state="0,1"
		zero2
			icon_state="0,2"
		zero3
			icon_state="0,3"
			density = 1
		zero4
			icon_state="0,4"
		one0
			icon_state="1,0"
			density=1
		one1
			icon_state="1,1"
			density=1
		one2
			icon_state="1,2"
		one3
			icon_state="1,3"
			density = 1
		one4
			icon_state="1,4"
		two0
			icon_state="2,0"
			density=1
		two1
			icon_state="2,1"
		two2
			icon_state="2,2"
		two3
			icon_state="2,3"
			density = 1
		two4
			icon_state="2,4"
	Capsule3
		icon = 'Capsule3.dmi'
		zero0
			icon_state="0,0"
		zero1
			icon_state="0,1"
		zero2
			icon_state="0,2"
		zero3
			icon_state="0,3"
		zero4
			icon_state="0,4"
		one0
			icon_state="1,0"
		one1
			icon_state="1,1"
		one2
			icon_state="1,2"
		one3
			icon_state="1,3"
		one4
			icon_state="1,4"
		two0
			icon_state="2,0"
		two1
			icon_state="2,1"
		two2
			icon_state="2,2"
		two3
			icon_state="2,3"
		two4
			icon_state="2,4"*/
	Capsule2
		icon = 'Capsule03.dmi'
turf
	SpawnPoints
		name=""
		UndergroundLab
			density = 0
			Spawn00
			Spawn01
			Spawn02
			Spawn03
			Spawn04
turf/UndergroundLab
	name = ""
	Background
		density = 0
		icon = 'ULBackground.dmi'
		zero0
			icon_state="0,0"
		zero1
			icon_state="0,1"
		zero2
			icon_state="0,2"
		one0
			icon_state="1,0"
		one1
			icon_state="1,1"
		one2
			icon_state="1,2"
		two0
			icon_state="2,0"
		two1
			icon_state="2,1"
		two2
			icon_state="2,2"
turf/UndergroundLab
	name = ""
	icon = 'Gates Lab.dmi'
	density = 1
	Tile1{icon_state = "1"}
	Tile2{icon_state = "2"}
	Tile3{icon_state = "3"}
	Tile4{icon_state = "4"}
	Tile5{icon_state = "5"}
	Tile6{icon_state = "6"}
	Tile7{icon_state = "7"}
	Tile8{icon_state = "8"}
	Tile9{icon_state = "9"}
	Tile10{icon_state = "10"}
	Tile11{icon_state = "11"}
	Tile12{icon_state = "12"}
	Tile13{icon_state = "13"}
	Tile13a{icon_state = "13a"}
	Tile14{icon_state = "14"}
	Tile15{icon_state = "15"}
	Tile16{icon_state = "16"}
	Tile17{icon_state = "17";density = 0}
	Tile18{icon_state = "18";density = 0}
	Tile19{icon_state = "19";density = 0}
	Tile20{icon_state = "20"}
	Tile21{icon_state = "21"}
	Tile22{icon_state = "22"}
	Tile23{icon_state = "23"}
	Tile24
		icon_state = "24"
		Enter(M)
			if(isobj(M))
				del M
			isSpikeImmune(M, src)
	Tile25
		icon_state = "25"
		Enter(M)
			if(isobj(M))
				del M
			isSpikeImmune(M, src)

