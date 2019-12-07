#ifndef TWINTOWERS_MAP
#define TWINTOWERS_MAP
turf
	SpawnPoints
		TwinTowers
			density = 0
			Spawn00
			Spawn01
			Spawn02
			Spawn03
turf
	TwinTowers
		name=""

		t1
			icon='Twin Towers.dmi'
			icon_state="1"
			density=0
			Enter(M)
				if(isobj(M))
					del M
				isSpikeImmune(M, src)
		t2{icon='Twin Towers.dmi';icon_state="2";density=1}
		t3{icon='Twin Towers.dmi';icon_state="3";density=1}
		t4{icon='Twin Towers.dmi';icon_state="4";density=1}
		t5{icon='Twin Towers.dmi';icon_state="5";density=1}
		t6{icon='Twin Towers.dmi';icon_state="6";density=1}
		t7{icon='Twin Towers.dmi';icon_state="7";density=1}
		t8{icon='Twin Towers.dmi';icon_state="8";density=1}
		t9{icon='Twin Towers.dmi';icon_state="9";density=1}
		t10{icon='Twin Towers.dmi';icon_state="10";density=1}
		t11{icon='Twin Towers.dmi';icon_state="11";density=1}
		t12{icon='Twin Towers.dmi';icon_state="12";density=1}
		t13{icon='Twin Towers.dmi';icon_state="13";density=1}
		t14{icon='Twin Towers.dmi';icon_state="14";density=1}
		t15{icon='Twin Towers.dmi';icon_state="15";density=1}
		t16{icon='Twin Towers.dmi';icon_state="16";density=1}
		t17{icon='Twin Towers.dmi';icon_state="17";density=1}
		t18{icon='Twin Towers.dmi';icon_state="18";density=1}
		t19{icon='Twin Towers.dmi';icon_state="19";density=1}
		t20{icon='Twin Towers.dmi';icon_state="20";density=1}
		back{icon='TTBack.png';density=0}
		back2{icon='TTBack2.png';density=0}
		ttback
			icon='TTBack.dmi'
			density = 0
			zero0
				icon_state="0,0"
			zero1
				icon_state="0,1"
			one0
				icon_state="1,0"
			one1
				icon_state="1,1"
		ttback2
			icon='TTBack2.dmi'
			density = 0
			zero0
				icon_state="0,0"
			zero1
				icon_state="0,1"
			one0
				icon_state="1,0"
			one1
				icon_state="1,1"
		ttceiling
			icon='TTCeiling.dmi'
			density = 1
			zero0
				icon_state="0,0"
			zero1
				icon_state="0,1"
			one0
				icon_state="1,0"
			one1
				icon_state="1,1"
			two0
				icon_state="2,0"
			two1
				icon_state="2,1"
			three0
				icon_state="3,0"
			three1
				icon_state="3,1"
			four0
				icon_state="4,0"
			four1
				icon_state="4,1"
		ttsky
			icon = 'TTSky.dmi'
			BG00{icon_state="0,0"}
			BG01{icon_state="0,1"}

			BG10{icon_state="1,0"}
			BG11{icon_state="1,1"}

			BG20{icon_state="2,0"}
			BG21{icon_state="2,1"}

			BG30{icon_state="3,0"}
			BG31{icon_state="3,1"}

			BG40{icon_state="4,0"}
			BG41{icon_state="4,1"}

			BG50{icon_state="5,0"}
			BG51{icon_state="5,1"}

			BG60{icon_state="6,0"}
			BG61{icon_state="6,1"}
#endif