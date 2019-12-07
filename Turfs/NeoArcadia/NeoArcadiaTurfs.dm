turf
	NeoArcadia
		name=""
		icon='NeoArcadiaTurfs.dmi'
		Spikes
			icon_state="spikes"
			Enter(M)
				if(isobj(M))
					del M
				isSpikeImmune(M, src)
		Platform
			density=1
			platform1{icon_state="platform1"}
			platform2{icon_state="platform2"}
			platform3{icon_state="platform3"}
		Misc
			misc1{icon_state="misc1"}
			misc2{icon_state="misc2"}
			misc3{icon_state="misc3"}
			misc4{icon_state="misc4"}
		Background
			bg1{icon_state="bg1"}
			bg2{icon_state="bg2"}
			bg3{icon_state="bg3"}
			bg31{icon_state="bg3_1"}
			bg32{icon_state="bg3_2"}
			bg33{icon_state="bg3_3"}
			bg34{icon_state="bg3_4"}
			bg4new
				icon = 'neoBG4.dmi'
				BG00{icon_state="0,0"}
				BG10{icon_state="1,0"}
				BG01{icon_state="0,1"}
				BG11{icon_state="1,1"}
			bg5new
				icon = 'neoBG5.dmi'
				BG00{icon_state="0,0"}
				BG01{icon_state="0,1"}
				BG02{icon_state="0,2"}
				BG03{icon_state="0,3"}
				BG04{icon_state="0,4"}

				BG10{icon_state="1,0"}
				BG11{icon_state="1,1"}
				BG12{icon_state="1,2"}
				BG13{icon_state="1,3"}
				BG14{icon_state="1,4"}

				BG20{icon_state="2,0"}
				BG21{icon_state="2,1"}
				BG22{icon_state="2,2"}
				BG23{icon_state="2,3"}
				BG24{icon_state="2,4"}

				BG30{icon_state="3,0"}
				BG31{icon_state="3,1"}
				BG32{icon_state="3,2"}
				BG33{icon_state="3,3"}
				BG34{icon_state="3,4"}

				BG40{icon_state="4,0"}
				BG41{icon_state="4,1"}
				BG42{icon_state="4,2"}
				BG43{icon_state="4,3"}
				BG44{icon_state="4,4"}

				BG50{icon_state="5,0"}
				BG51{icon_state="5,1"}
				BG52{icon_state="5,2"}
				BG53{icon_state="5,3"}
				BG54{icon_state="5,4"}

				BG60{icon_state="6,0"}
				BG61{icon_state="6,1"}
				BG62{icon_state="6,2"}
				BG63{icon_state="6,3"}
				BG64{icon_state="6,4"}
		Foreground
			fg1{icon_state="fg1";density=1}
			fg2{icon_state="fg2";density=1}
			fg3new
				icon = 'FG3.dmi'
				FG00{icon_state="0,0"}
				FG01{icon_state="0,1"}
				FG02{icon_state="0,2"}
				FG03{icon_state="0,3"}
			fg4{icon_state="fg4"}
			fg5{icon_state="fg5"}
			fg6{icon_state="fg6"}
			fg7{icon_state="fg7"}
			fg8{icon_state="fg8";density=1}
		Wall
			density=1;opacity=1
			wall1{icon_state="wall1"}
			wall2{icon_state="wall2"}
		Ground
			density=1
			ground1{icon_state="ground1"}
			ground2{icon_state="ground2"}
			ground3{icon_state="ground3"}
			ground4{icon_state="ground4"}
			ground5{icon_state="ground5"}
			ground6{icon_state="ground6"}
			ground7{icon_state="ground7"}
			ground8{icon_state="ground8"}
			ground9{icon_state="ground9"}
			ground10{icon_state="ground10"}
			ground11{icon_state="ground11"}
			ground12{icon_state="ground12"}
			ground13{icon_state="ground13"}
			ground14{icon_state="ground14"}


