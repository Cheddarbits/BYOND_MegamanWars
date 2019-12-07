


proc/Characters(var/mob/Entities/Player/M)
	spawn()
	if(isnull(M) || isnull(M.client) || M.Playing == 0 )
		return

	#ifdef INCLUDED_MEGAMAN_DM
	M.client.screen += new/obj/Panel/Megaman
	#endif
	#ifdef INCLUDED_PROTOMAN_DM
	M.client.screen += new/obj/Panel/Protoman
	#endif
	#ifdef INCLUDED_BASS_DM
	M.client.screen += new/obj/Panel/Bass
	#endif
	#ifdef INCLUDED_ZERO_DM
	M.client.screen += new/obj/Panel/Zero
	#endif
	M.client.screen += new/obj/Panel/Nuetral
	M.client.screen += new/obj/Panel/Red_Team
	M.client.screen += new/obj/Panel/Blue_Team
	M.client.screen += new/obj/Panel/Yellow_Team
	M.client.screen += new/obj/Panel/Green_Team
	if(M.client.IsByondMember())
		M.client.screen += new/obj/Panel/Silver_Team
	if(isOwner(M)||isAdmin(M)||isModerator(M))
		M.client.screen += new/obj/Panel/Silver_Team
		M.client.screen += new/obj/Panel/Purple_Team
#ifdef INCLUDED_RANKINGS_DM
	M.client.screen += new/obj/Panel/RankP1
	M.client.screen += new/obj/Panel/RankP

#endif
	M.client.screen += new/obj/Panel/Save1
	M.client.screen += new/obj/Panel/Save2
	M.client.screen += new/obj/Panel/Help1
	M.client.screen += new/obj/Panel/Help2
	sleep(1)
	var
		tmpMulti = 1
	if(IncreasedReqList.Find(M.key)||IncreasedReqList.Find(M.client.computer_id)) tmpMulti = 0.1
	var
		tmpReq = (1/ReqDifficult) * M.indReqDiff * tmpMulti
		tmpKills = M.Stats[Kills]*tmpReq
		tmpDeaths = M.Stats[Deaths]*tmpReq
		tmpPKills = M.Stats[PKills]*tmpReq
		tmpCCKills = M.Stats[CCKills]*tmpReq
		/* NO MORE HIDDEN STATS
		tmpDeflects = M.Stats[Deflects]*tmpReq
		tmpShoots = M.Stats[Shoots]*tmpReq
		tmpSlashes = M.Stats[Slashes]*tmpReq
		tmpJumps = M.Stats[Jumps]*tmpReq
		tmpHits = M.Stats[Hits]*tmpReq
		tmpTimeshurt = M.Stats[Timeshurt]*tmpReq
		*/
	if(FreeModes[c_MMMode] == 0 && !isSAdmin(M))

//	if(tmpKills>=10000&&tmpPKills >= 5000&&tmpCCKills >= 1500&&tmpShoots>=500000&&tmpHits>=50000&&tmpChallP>=100){M.client.screen += new/obj/Panel/Modelx}

	#ifdef INCLUDED_MET_DM
		if(tmpKills>=5)
			M.client.screen += new/obj/Panel/Met
	#endif

	#ifdef INCLUDED_CUTMAN_DM
		if(tmpKills>=10)
			M.client.screen += new/obj/Panel/Cutman
	#endif
	#ifdef INCLUDED_BEAT_DM
		if(tmpKills>=50&&tmpSlashes>=75)
			M.client.screen += new/obj/Panel/Beat
	#endif
	#ifdef INCLUDED_SWORDMAN_DM
		if(tmpKills>=80&&tmpHits>=400)
			M.client.screen += new/obj/Panel/Swordman
	#endif
	#ifdef INCLUDED_EDDIE_DM
		if( tmpKills >= 100 )
			M.client.screen += new/obj/Panel/Eddie
	#endif

	#ifdef INCLUDED_GRENADEMAN_DM
		if(tmpKills>=120&&tmpHits>=900)
			M.client.screen += new/obj/Panel/Grenademan
	#endif
	#ifdef INCLUDED_BURNERMAN_DM
		if(tmpKills>=250&&tmpJumps>=2000)
			M.client.screen += new/obj/Panel/Burnerman
	#endif
	#ifdef INCLUDED_WOODMAN_DM
		if(tmpKills>=350&&tmpSlashes>=4000)
			M.client.screen += new/obj/Panel/Woodman
	#endif
	#ifdef INCLUDED_DUO_DM
		if(tmpKills>=500&&tmpPKills>=250)
			M.client.screen += new/obj/Panel/Duo
	#endif
	#ifdef INCLUDED_TENGUMAN_DM
		if(tmpKills>=750&&tmpSlashes>=6000)
			M.client.screen += new/obj/Panel/Tenguman
	#endif
	#ifdef INCLUDED_SHADOWMAN_DM
		if(tmpKills>=1250&&tmpCCKills>=900)
			M.client.screen += new/obj/Panel/Shadowman
	#endif
	#ifdef INCLUDED_CLOWNMAN_DM
		if(tmpKills>=2500&&tmpHits>=12500)
			M.client.screen += new/obj/Panel/Clownman
	#endif
	#ifdef INCLUDED_KING_DM
		if( tmpKills >= 5000 && tmpSlashes >= 10000 && tmpTimeshurt >= 10000 )
			M.client.screen += new/obj/Panel/King
	#endif
	#ifdef INCLUDED_DRWILY_DM
		if( tmpKills >= 7500 && tmpShoots >= 60000 && tmpHits >= 60000 )
			M.client.screen += new /obj/Panel/DrWily
	#endif
	#ifdef INCLUDED_KNIGHTMAN_DM
		if(tmpKills>=10000&&tmpPKills>=5000&&tmpTimeshurt>=30000)
			M.client.screen += new/obj/Panel/Knightman
	#endif
		#ifdef INCLUDED_MAGICMAN_DM
		if(tmpKills>= 2500 && tmpPKills >= 1750 && tmpDeflects >= 5000)	M.client.screen += new/obj/Panel/Magicman
		#endif
	else
	#ifdef INCLUDED_KING_DM
		M.client.screen += new/obj/Panel/King
	#endif
	#ifdef INCLUDED_EDDIE_DM
		M.client.screen += new/obj/Panel/Eddie
	#endif
		#ifdef INCLUDED_CUTMAN_DM
		M.client.screen += new/obj/Panel/Cutman
		#endif
		#ifdef INCLUDED_BURNERMAN_DM
		M.client.screen += new/obj/Panel/Burnerman
		#endif
	#ifdef INCLUDED_WOODMAN_DM
		M.client.screen += new/obj/Panel/Woodman
	#endif
		#ifdef INCLUDED_DUO_DM
		M.client.screen += new/obj/Panel/Duo
		#endif
		#ifdef INCLUDED_SHADOWMAN_DM
		M.client.screen += new/obj/Panel/Shadowman
		#endif

		#ifdef INCLUDED_SWORDMAN_DM
		M.client.screen += new/obj/Panel/Swordman
		#endif
		#ifdef INCLUDED_GRENADEMAN_DM
		M.client.screen += new/obj/Panel/Grenademan
		#endif

		#ifdef INCLUDED_DRWILY_DM
		M.client.screen += new /obj/Panel/DrWily
		#endif
		#ifdef INCLUDED_MET_DM
		M.client.screen += new/obj/Panel/Met
		#endif
		#ifdef INCLUDED_CLOWNMAN_DM
		M.client.screen += new/obj/Panel/Clownman
		#endif
		#ifdef INCLUDED_KNIGHTMAN_DM
		M.client.screen += new/obj/Panel/Knightman
					#endif
		#ifdef INCLUDED_BEAT_DM
		M.client.screen += new/obj/Panel/Beat
		#endif

		#ifdef INCLUDED_TENGUMAN_DM
		M.client.screen += new/obj/Panel/Tenguman
		#endif
		#ifdef INCLUDED_MAGICMAN_DM
		M.client.screen += new/obj/Panel/Magicman
	#endif
	if(FreeModes[c_XMode] == 0 && !isSAdmin(M))
		#ifdef INCLUDED_X_DM
		if(tmpKills>=10)
			M.client.screen += new/obj/Panel/X
		#endif
			#ifdef INCLUDED_DYNAMO_DM
			if(tmpKills>=15) M.client.screen += new/obj/Panel/Dynamo
			#endif
			#ifdef INCLUDED_GATE_DM
			if(tmpKills>=15)M.client.screen += new/obj/Panel/Gate
			#endif
			#ifdef INCLUDED_MEDIC_DM
			if(tmpKills>=25&&tmpTimeshurt>=200) M.client.screen += new/obj/Panel/Medic
			#endif
			#ifdef INCLUDED_COLONEL_DM
			if(tmpKills>=20&&tmpSlashes>=180){M.client.screen += new/obj/Panel/Colonel}
			#endif

			#ifdef INCLUDED_WOLFANG_DM
			if(tmpKills>=40&&tmpTimeshurt>=300)M.client.screen += new/obj/Panel/Wolfang
			#endif
			#ifdef INCLUDED_MAGMA_DM
			if(tmpKills>=30&&tmpShoots>=250){M.client.screen += new/obj/Panel/Magma}
			#endif
			#ifdef INCLUDED_DOUBLE_DM
			if(tmpKills>=35)M.client.screen += new/obj/Panel/Double
			#endif
			#ifdef INCLUDED_AXL_DM
			if(tmpKills>=500&&tmpHits>=7000&&tmpTimeshurt>=7000&&tmpShoots>=7000){M.client.screen += new/obj/Panel/Axl}
			#endif
			#ifdef INCLUDED_MMXZERO_DM
			if(tmpKills>=500&&tmpTimeshurt>=22500){M.client.screen += new/obj/Panel/MMXZero}
			#endif
			#ifdef INCLUDED_HEATNIX_DM
			if(tmpKills>=1000&&tmpHits>=10000){M.client.screen += new/obj/Panel/Heatnix}
			#endif

			#ifdef INCLUDED_SHELLDON_DM
			if(tmpKills>=1000&&tmpDeflects>=25000&&tmpShoots>=25000){M.client.screen += new/obj/Panel/Shelldon}
			#endif

			#ifdef INCLUDED_VILE_DM
			if(tmpKills>=500)M.client.screen += new/obj/Panel/Vile
			#endif
			#ifdef INCLUDED_MIJINION_DM
			if(tmpKills>=1000&&tmpShoots>=8000){M.client.screen += new/obj/Panel/Mijinion}
			#endif
	#ifdef INCLUDED_FAUCLAW_DM
			if(tmpKills>=2500&&tmpPKills>=1000&&tmpSlashes>=7500) M.client.screen += new/obj/Panel/Fauclaw
	#endif

			#ifdef INCLUDED_PUREZERO_DM
			if(tmpKills>=2500&&tmpSlashes>=8000){M.client.screen += new/obj/Panel/PureZero}
			#endif
			#ifdef INCLUDED_SIGMA_DM
			if(tmpKills>=2500)M.client.screen += new/obj/Panel/Sigma
			#endif
			#ifdef INCLUDED_DARKGUISE_DM
			if(tmpKills>=5000&&tmpPKills>=1750){M.client.screen += new/obj/Panel/Darkguise}
			#endif


			#ifdef INCLUDED_CMX_DM
			if(tmpKills>=7000&&tmpPKills>=4000&&tmpSlashes>=20000){M.client.screen += new/obj/Panel/CMX}
			#endif

			#ifdef INCLUDED_SAX_DM
			if(tmpKills>=9000) M.client.screen += new/obj/Panel/SaX
			#endif
			#ifdef INCLUDED_GAX_DM
			if(tmpKills>=8750 && tmpShoots >= 10000 && tmpHits >= 7500) M.client.screen += new/obj/Panel/GAX
			#endif


	else
		#ifdef INCLUDED_MEDIC_DM
		M.client.screen += new/obj/Panel/Medic
		#endif
		#ifdef INCLUDED_DARKGUISE_DM
		M.client.screen += new/obj/Panel/Darkguise
		#endif
		#ifdef INCLUDED_MMXZERO_DM
		M.client.screen += new/obj/Panel/MMXZero
		#endif
#ifdef INCLUDED_FAUCLAW_DM
		M.client.screen += new/obj/Panel/Fauclaw
#endif

		#ifdef INCLUDED_AXL_DM
		M.client.screen += new/obj/Panel/Axl
		#endif
		#ifdef INCLUDED_MAGMA_DM
		M.client.screen += new/obj/Panel/Magma
		#endif
		#ifdef INCLUDED_MIJINION_DM
		M.client.screen += new/obj/Panel/Mijinion
		#endif
		#ifdef INCLUDED_SHELLDON_DM
		M.client.screen += new/obj/Panel/Shelldon
		#endif

		#ifdef INCLUDED_DYNAMO_DM
		M.client.screen += new/obj/Panel/Dynamo
		#endif


		#ifdef INCLUDED_X_DM
		M.client.screen += new/obj/Panel/X
		#endif

		#ifdef INCLUDED_HEATNIX_DM
		M.client.screen += new/obj/Panel/Heatnix
		#endif

		#ifdef INCLUDED_PUREZERO_DM
		M.client.screen += new/obj/Panel/PureZero
		#endif
		#ifdef INCLUDED_CMX_DM
		M.client.screen += new/obj/Panel/CMX
		#endif
		#ifdef INCLUDED_COLONEL_DM
		M.client.screen += new/obj/Panel/Colonel
		#endif

		#ifdef INCLUDED_WOLFANG_DM
		M.client.screen += new/obj/Panel/Wolfang
		#endif
		#ifdef INCLUDED_SAX_DM
		M.client.screen += new/obj/Panel/SaX
		#endif
		#ifdef INCLUDED_SIGMA_DM
		M.client.screen += new/obj/Panel/Sigma
		#endif
		#ifdef INCLUDED_VILE_DM
		M.client.screen += new/obj/Panel/Vile
		#endif
		#ifdef INCLUDED_DOUBLE_DM
		M.client.screen += new/obj/Panel/Double
		#endif
		#ifdef INCLUDED_GATE_DM
		M.client.screen += new/obj/Panel/Gate
		#endif
		#ifdef INCLUDED_GAX_DM
		M.client.screen += new/obj/Panel/GAX
		#endif
	if(FreeModes[c_ZeroMode] == 0 && !isSAdmin(M))
		#ifdef INCLUDED_HARP_DM
		if(tmpKills>=10&&tmpDeflects>=20)
			M.client.screen += new/obj/Panel/Harpuia
		#endif
			#ifdef INCLUDED_CX_DM
			if(tmpKills>=10&&tmpJumps>=250){M.client.screen += new/obj/Panel/CX}
			#endif
			#ifdef INCLUDED_FEFNIR_DM
			if(tmpKills>=20&&tmpJumps>=500){M.client.screen += new/obj/Panel/Fefnir}
			#endif
			#ifdef INCLUDED_CZERO_DM
			if(tmpKills>=30&&tmpHits>=100){M.client.screen += new/obj/Panel/CZero}
			#endif
			#ifdef INCLUDED_ELPIZO_DM
			if(tmpKills>=100&&tmpSlashes>=200){M.client.screen += new/obj/Panel/Elpizo}
			#endif
			#ifdef INCLUDED_PHANTOM_DM
			if(tmpKills>=700&&tmpTimeshurt>=2000&&tmpShoots>=4000){M.client.screen += new/obj/Panel/Phantom}
			#endif
			#ifdef INCLUDED_LEVIATHEN_DM
			if(tmpKills>=100&&tmpDeflects>=500){M.client.screen+= new/obj/Panel/Leviathen}
			#endif
			#ifdef INCLUDED_FOXTAR_DM
			if(tmpKills>=1000&&tmpHits>=8000){M.client.screen += new/obj/Panel/Foxtar}
			#endif


			#ifdef INCLUDED_ANUBIS_DM
			if(tmpKills>=1000&&tmpJumps>=8000){M.client.screen += new/obj/Panel/Anubis}
			#endif

			#ifdef INCLUDED_CHILLDRE_DM
			if(tmpKills>=1250&&tmpJumps>=1500){M.client.screen += new/obj/Panel/Chilldre}
			#endif
			#ifdef INCLUDED_KRAFT_DM
			if(tmpKills>=2000&&tmpHits>=12500){M.client.screen += new/obj/Panel/Kraft}
			#endif
			#ifdef INCLUDED_OMEGA_DM
			if(tmpKills>=5000&&tmpPKills>=2500){M.client.screen += new/obj/Panel/Omega}
			#endif
			#ifdef INCLUDED_WEIL_DM
			if(tmpKills>=9000&&tmpShoots>=50000){M.client.screen += new/obj/Panel/Weil}
			#endif
			#ifdef INCLUDED_HANUMACHINE_DM
			if(tmpKills >= 1775 && tmpPKills >= 700 && tmpSlashes >= 2000 ) M.client.screen += new/obj/Panel/HanuMachine
			#endif
			#ifdef INCLUDED_AIRPANTHEON_DM
			if(tmpKills >= 650 && tmpShoots >= 3000) M.client.screen += new/obj/Panel/AirPantheon
			#endif
			#ifdef INCLUDED_ZANZIBAR_DM
			if(tmpKills >= 900 && tmpSlashes >= 3000) M.client.screen += new/obj/Panel/Zanzibar
			#endif

	else
		#ifdef INCLUDED_AIRPANTHEON_DM
		M.client.screen += new/obj/Panel/AirPantheon
		#endif

		#ifdef INCLUDED_KRAFT_DM
		M.client.screen += new/obj/Panel/Kraft
		#endif
		#ifdef INCLUDED_WEIL_DM
		M.client.screen += new/obj/Panel/Weil
		#endif
		#ifdef INCLUDED_ELPIZO_DM
		M.client.screen += new/obj/Panel/Elpizo
		#endif


		#ifdef INCLUDED_PHANTOM_DM
		M.client.screen += new/obj/Panel/Phantom
		#endif

		#ifdef INCLUDED_FOXTAR_DM
		M.client.screen += new/obj/Panel/Foxtar
		#endif
		#ifdef INCLUDED_LEVIATHEN_DM
		M.client.screen+= new/obj/Panel/Leviathen
		#endif
		#ifdef INCLUDED_HARP_DM
		M.client.screen += new/obj/Panel/Harpuia
		#endif
		#ifdef INCLUDED_CHILLDRE_DM
		M.client.screen += new/obj/Panel/Chilldre
		#endif
		#ifdef INCLUDED_ANUBIS_DM
		M.client.screen += new/obj/Panel/Anubis
		#endif
		#ifdef INCLUDED_FEFNIR_DM
		M.client.screen += new/obj/Panel/Fefnir
		#endif
		#ifdef INCLUDED_CX_DM
		M.client.screen += new/obj/Panel/CX
		#endif
		#ifdef INCLUDED_OMEGA_DM
		M.client.screen += new/obj/Panel/Omega
		#endif


		#ifdef INCLUDED_CZERO_DM
		M.client.screen += new/obj/Panel/CZero
		#endif
		#ifdef INCLUDED_HANUMACHINE_DM
		M.client.screen += new/obj/Panel/HanuMachine
		#endif
		#ifdef INCLUDED_ZANZIBAR_DM
		M.client.screen += new/obj/Panel/Zanzibar
		#endif
	if(FreeModes[c_CustomMode] == 0 && !isSAdmin(M))
		if(isnull(M)) return
		if(NoCustomsList.Find("[M.key]")) return
		#ifdef INCLUDED_MODELGATE_DM
		if(tmpKills >= 9000 && tmpPKills >= 1500 && tmpCCKills >= 700) M.client.screen += new/obj/Panel/ModelGate
		#endif
		#ifdef INCLUDED_MODELBD_DM
		if(tmpKills >= 8000 && tmpPKills >= 1000 && tmpCCKills >= 500) M.client.screen += new/obj/Panel/ModelBD
		#endif
		#ifdef INCLUDED_MG400_DM
		if(tmpKills>=5000&&tmpPKills>=500||M.key=="MetalGrunt400")
			M.client.screen += new/obj/Panel/MG400
		#endif
		#ifdef INCLUDED_SHADOWMANEXE_DM
		if(tmpKills>=7000||M.key=="Ryokashi") M.client.screen += new/obj/Panel/ShadowmanEXE
		#endif
		#ifdef INCLUDED_MODELS_DM
		if(tmpKills>=7000&&tmpPKills>=1250||M.key=="GokuSSJ15"){M.client.screen += new/obj/Panel/ModelS}
		#endif
		#ifdef INCLUDED_XERON_DM
		if(tmpKills>=10000||M.key=="Oondivinezin"){M.client.screen += new/obj/Panel/Xeron}
		#endif
		#ifdef INCLUDED_LWX_DM
		if(tmpKills >= 10000 && tmpShoots>=50000 && tmpHits>=10000 && tmpHits>=round(tmpShoots*0.30) ||M.key=="Amarlaxi"||M.key=="Venetiae") M.client.screen += new/obj/Panel/LWX
		#endif
		#ifdef INCLUDED_ATHENA_DM
		if(tmpKills>=10000||M.key=="Amarlaxi"||M.key=="Venetiae" ){M.client.screen += new/obj/Panel/Athena}
		#endif
		#ifdef INCLUDED_GBD_DM
		if(tmpKills>=12500||M.key=="Basik")M.client.screen += new/obj/Panel/GBD
		#endif
		#ifdef INCLUDED_MODELC_DM
		if(tmpKills >= 15000&& tmpPKills >= 15000 && tmpHits>=round(tmpShoots*0.2)||M.key=="Cliff Hatomi")M.client.screen += new/obj/Panel/ModelC
		#endif

		#ifdef INCLUDED_ZV_DM
		if(tmpKills >= 15000&& tmpPKills >= 15000 && tmpCCKills >= 5000 && tmpDeaths<=(round((tmpKills+tmpPKills+tmpCCKills)*0.25))||M.key=="ZeroVirus") M.client.screen += new/obj/Panel/ZV
		#endif
		#ifdef INCLUDED_VALNAIRE_DM
		if(tmpKills >= 15000&& tmpPKills >= 15000 && tmpPKills>=round(tmpCCKills*10)||M.key=="Lord Protector"||M.key=="BloodTerrorX") M.client.screen += new/obj/Panel/Valnaire
		#endif
		#ifdef INCLUDED_FAX_DM
		if(tmpKills >= 15000&& tmpPKills >= 15000 && tmpDeflects >(tmpHits+tmpSlashes+tmpTimeshurt) && tmpDeaths<=(round((tmpKills+tmpPKills+tmpCCKills)/3))||isSAdmin(M)||M.key=="Solcloud" || M.key == "Sokuryoku") M.client.screen += new/obj/Panel/FAX
		#endif
		#ifdef INCLUDED_PSX_DM
		if(tmpKills >= 15000&& tmpPKills >= 10000&&tmpCCKills>=5000||M.key=="Bolt Dragon") M.client.screen += new/obj/Panel/PSX
		#endif
		#ifdef INCLUDED_XERONII_DM
		if(tmpKills >= 15000&& tmpPKills >= 15000 && tmpCCKills >= 7500 && tmpSlashes > tmpTimeshurt||M.key=="Hiroyuki"||M.key=="Oondivinezin") M.client.screen += new/obj/Panel/XeronII
		#endif
		#ifdef INCLUDED_SJX_DM
		if(tmpKills >= 25000 && tmpPKills >= 10000 &&tmpShoots>=20000) M.client.screen += new/obj/Panel/SJX
		#endif
		#ifdef INCLUDED_PLAGUE_DM
		if(tmpKills >= 30000 && tmpPKills >= 10000 &&tmpSlashes>=25000) M.client.screen += new/obj/Panel/Plague
		#endif

	else
		if(isnull(M)) return
		if(NoCustomsList.Find(M.key)) return
		#ifdef INCLUDED_MODELGATE_DM
		M.client.screen += new/obj/Panel/ModelGate
		#endif

		#ifdef INCLUDED_MODELBD_DM
		M.client.screen += new/obj/Panel/ModelBD
		#endif

		#ifdef INCLUDED_SJX_DM
		M.client.screen += new/obj/Panel/SJX
		#endif
		#ifdef INCLUDED_PLAGUE_DM
		M.client.screen += new/obj/Panel/Plague
		#endif
		#ifdef INCLUDED_GBD_DM
		M.client.screen += new/obj/Panel/GBD
		#endif
		#ifdef INCLUDED_ATHENA_DM
		M.client.screen += new/obj/Panel/Athena
		#endif
		#ifdef INCLUDED_XERON_DM
		M.client.screen += new/obj/Panel/Xeron
		#endif

		#ifdef INCLUDED_SHADOWMANEXE_DM
		M.client.screen += new/obj/Panel/ShadowmanEXE
		#endif
		#ifdef INCLUDED_MODELS_DM
		M.client.screen += new/obj/Panel/ModelS
		#endif
		#ifdef INCLUDED_MG400_DM
		M.client.screen += new/obj/Panel/MG400
		#endif
		#ifdef INCLUDED_MODELC_DM
		M.client.screen += new/obj/Panel/ModelC
		#endif
		#ifdef INCLUDED_ZV_DM
		M.client.screen += new/obj/Panel/ZV
		#endif
		#ifdef INCLUDED_VALNAIRE_DM
		M.client.screen += new/obj/Panel/Valnaire
		#endif
		#ifdef INCLUDED_FAX_DM
		M.client.screen += new/obj/Panel/FAX
		#endif
		#ifdef INCLUDED_PSX_DM
		M.client.screen += new/obj/Panel/PSX
		#endif
		#ifdef INCLUDED_XERONII_DM
		M.client.screen += new/obj/Panel/XeronII
		#endif
		#ifdef INCLUDED_LWX_DM
		M.client.screen += new/obj/Panel/LWX
		#endif

	#ifdef INCLUDED_HDK_DM
	if(isSAdmin(M))
		M.client.screen += new/obj/Panel/HDK
	#endif
	#ifdef INCLUDED_ADMINMODE_DM
	if(isModerator(M) || isAdmin(M) || isOwner(M) || isSAdmin(M) )
		M.client.screen += new/obj/Panel/AdminMode
	#endif
	if(M.key=="Cliff Hatomi" || M.key=="Amarlaxi"||M.key=="Venetiae" || M.key == "Bolt Dragon" || M.key=="Solcloud" || M.key == "Sokuryoku"|| isSAdmin(M))
	#ifdef INCLUDED_CLIFF_DM
		M.client.screen += new/obj/Panel/Cliff
	#endif
	#ifdef INCLUDED_ATHENAII_DM
		M.client.screen += new/obj/Panel/AthenaII
	#endif
	#ifdef INCLUDED_SOLCLOUD_DM
		M.client.screen += new/obj/Panel/Solcloud
	#endif
