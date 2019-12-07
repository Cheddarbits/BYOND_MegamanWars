


proc/Characters(var/mob/Entities/Player/M)
	spawn()
	if(isnull(M) || isnull(M.client) || M.Playing == 0 )
		return

	#ifdef INCLUDED_MEGAMAN_DM
	M.client.screen += new/obj/Panel/MegamanSeries/Megaman
	#endif
	#ifdef INCLUDED_PROTOMAN_DM
	M.client.screen += new/obj/Panel/MegamanSeries/Protoman
	#endif
	#ifdef INCLUDED_BASS_DM
	M.client.screen += new/obj/Panel/MegamanSeries/Bass
	#endif
	#ifdef INCLUDED_ZERO_DM
	M.client.screen += new/obj/Panel/ZeroSeries/Zero
	#endif
	M.client.screen += new/obj/Panel/Teams/Nuetral
	M.client.screen += new/obj/Panel/Teams/Red_Team
	M.client.screen += new/obj/Panel/Teams/Blue_Team
	M.client.screen += new/obj/Panel/Teams/Yellow_Team
	M.client.screen += new/obj/Panel/Teams/Green_Team
	if(M.client.IsByondMember())
		M.client.screen += new/obj/Panel/Teams/Silver_Team
	if(isOwner(M)||isAdmin(M)||isModerator(M))
		M.client.screen += new/obj/Panel/Teams/Silver_Team
		M.client.screen += new/obj/Panel/Teams/Purple_Team
#ifdef INCLUDED_RANKINGS_DM
	M.client.screen += new/obj/Panel/RankP1
	M.client.screen += new/obj/Panel/RankP

#endif
	M.client.screen += new/obj/Panel/Save1
	M.client.screen += new/obj/Panel/Save2
	M.client.screen += new/obj/Panel/Help1
	M.client.screen += new/obj/Panel/Help2
	var
		tmpMulti = 1
	if(IncreasedReqList.Find(M.key)||IncreasedReqList.Find(M.client.computer_id)) tmpMulti = 0.1
	var
		tmpReq = (1/ReqDifficult) * M.indReqDiff * tmpMulti
		tmpKills = M.Stats[Kills]*tmpReq
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
			M.client.screen += new/obj/Panel/MegamanSeries/Cutman
	#endif
	#ifdef INCLUDED_BEAT_DM
		if(tmpKills>=50)
			M.client.screen += new/obj/Panel/MegamanSeries/Beat
	#endif
	#ifdef INCLUDED_SWORDMAN_DM
		if(tmpKills>=80)
			M.client.screen += new/obj/Panel/Swordman
	#endif
	#ifdef INCLUDED_EDDIE_DM
		if( tmpKills >= 100 )
			M.client.screen += new/obj/Panel/Eddie
	#endif

	#ifdef INCLUDED_GRENADEMAN_DM
		if(tmpKills>=120)
			M.client.screen += new/obj/Panel/Grenademan
	#endif
	#ifdef INCLUDED_BURNERMAN_DM
		if(tmpKills>=250)
			M.client.screen += new/obj/Panel/MegamanSeries/Burnerman
	#endif
	#ifdef INCLUDED_WOODMAN_DM
		if(tmpKills>=350)
			M.client.screen += new/obj/Panel/Woodman
	#endif
	#ifdef INCLUDED_DUO_DM
		if(tmpKills>=500&&tmpPKills>=250)
			M.client.screen += new/obj/Panel/Duo
	#endif
	#ifdef INCLUDED_TENGUMAN_DM
		if(tmpKills>=750)
			M.client.screen += new/obj/Panel/Tenguman
	#endif
	#ifdef INCLUDED_SHADOWMAN_DM
		if(tmpKills>=1250&&tmpCCKills>=900)
			M.client.screen += new/obj/Panel/Shadowman
	#endif
	#ifdef INCLUDED_CLOWNMAN_DM
		if(tmpKills>=2500)
			M.client.screen += new/obj/Panel/MegamanSeries/Clownman
	#endif
		#ifdef INCLUDED_MAGICMAN_DM
		if(tmpKills>= 2500 && tmpPKills >= 1750 )	M.client.screen += new/obj/Panel/Magicman
		#endif
	#ifdef INCLUDED_KING_DM
		if( tmpKills >= 5000  )
			M.client.screen += new/obj/Panel/MegamanSeries/King
	#endif
	#ifdef INCLUDED_DRWILY_DM
		if( tmpKills >= 7500  )
			M.client.screen += new /obj/Panel/MegamanSeries/DrWily
	#endif
	#ifdef INCLUDED_KNIGHTMAN_DM
		if(tmpKills>=10000&&tmpPKills>=5000)
			M.client.screen += new/obj/Panel/MegamanSeries/Knightman
	#endif

	else
	#ifdef INCLUDED_KING_DM
		M.client.screen += new/obj/Panel/MegamanSeries/King
	#endif
	#ifdef INCLUDED_EDDIE_DM
		M.client.screen += new/obj/Panel/Eddie
	#endif
		#ifdef INCLUDED_CUTMAN_DM
		M.client.screen += new/obj/Panel/MegamanSeries/Cutman
		#endif
		#ifdef INCLUDED_BURNERMAN_DM
		M.client.screen += new/obj/Panel/MegamanSeries/Burnerman
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
		M.client.screen += new /obj/Panel/MegamanSeries/DrWily
		#endif
		#ifdef INCLUDED_MET_DM
		M.client.screen += new/obj/Panel/Met
		#endif
		#ifdef INCLUDED_CLOWNMAN_DM
		M.client.screen += new/obj/Panel/MegamanSeries/Clownman
		#endif
		#ifdef INCLUDED_KNIGHTMAN_DM
		M.client.screen += new/obj/Panel/MegamanSeries/Knightman
					#endif
		#ifdef INCLUDED_BEAT_DM
		M.client.screen += new/obj/Panel/MegamanSeries/Beat
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
			M.client.screen += new/obj/Panel/XSeries/X
		#endif
		if(tmpKills>=15)
		#ifdef INCLUDED_DYNAMO_DM
			M.client.screen += new/obj/Panel/Dynamo
		#endif
		#ifdef INCLUDED_GATE_DM
			M.client.screen += new/obj/Panel/Gate
		#endif
		#ifdef INCLUDED_COLONEL_DM
		if(tmpKills>=20)
			M.client.screen += new/obj/Panel/Colonel
		#endif
		#ifdef INCLUDED_MEDIC_DM
		if(tmpKills>=25)
			M.client.screen += new/obj/Panel/Medic
		#endif


		#ifdef INCLUDED_WOLFANG_DM
		if(tmpKills>=40)
			M.client.screen += new/obj/Panel/Wolfang
		#endif
		#ifdef INCLUDED_MAGMA_DM
		if(tmpKills>=30)
			M.client.screen += new/obj/Panel/Magma
		#endif
		#ifdef INCLUDED_DOUBLE_DM
		if(tmpKills>=35)
			M.client.screen += new/obj/Panel/Double
		#endif
		if(tmpKills>=500)
		#ifdef INCLUDED_AXL_DM
			M.client.screen += new/obj/Panel/XSeries/Axl
		#endif
		#ifdef INCLUDED_MMXZERO_DM
			M.client.screen += new/obj/Panel/MMXZero
		#endif
		#ifdef INCLUDED_VILE_DM
			M.client.screen += new/obj/Panel/Vile
		#endif
		if(tmpKills>=1000)
		#ifdef INCLUDED_HEATNIX_DM
			M.client.screen += new/obj/Panel/Heatnix
		#endif

		#ifdef INCLUDED_SHELLDON_DM
			M.client.screen += new/obj/Panel/Shelldon
		#endif


		#ifdef INCLUDED_MIJINION_DM
			M.client.screen += new/obj/Panel/Mijinion
		#endif
#ifdef INCLUDED_FAUCLAW_DM
		if(tmpKills>=2500&&tmpPKills>=1000) M.client.screen += new/obj/Panel/Fauclaw
#endif

		#ifdef INCLUDED_PUREZERO_DM
		if(tmpKills>=2500){M.client.screen += new/obj/Panel/PureZero}
		#endif
		#ifdef INCLUDED_SIGMA_DM
		if(tmpKills>=2500)M.client.screen += new/obj/Panel/Sigma
		#endif
		#ifdef INCLUDED_DARKGUISE_DM
		if(tmpKills>=5000&&tmpPKills>=1750){M.client.screen += new/obj/Panel/Darkguise}
		#endif


		#ifdef INCLUDED_CMX_DM
		if(tmpKills>=7000&&tmpPKills>=4000){M.client.screen += new/obj/Panel/CMX}
		#endif

		#ifdef INCLUDED_SAX_DM
		if(tmpKills>=9000) M.client.screen += new/obj/Panel/SaX
		#endif
		#ifdef INCLUDED_GAX_DM
		if(tmpKills>=8750) M.client.screen += new/obj/Panel/GAX
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
		M.client.screen += new/obj/Panel/XSeries/Axl
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
		M.client.screen += new/obj/Panel/XSeries/X
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
		if(tmpKills>=10)
		#ifdef INCLUDED_HARP_DM
			M.client.screen += new/obj/Panel/Harpuia
		#endif
		#ifdef INCLUDED_CX_DM
			M.client.screen += new/obj/Panel/CX
		#endif
		#ifdef INCLUDED_FEFNIR_DM
		if(tmpKills>=20){M.client.screen += new/obj/Panel/Fefnir}
		#endif
		#ifdef INCLUDED_CZERO_DM
		if(tmpKills>=30){M.client.screen += new/obj/Panel/CZero}
		#endif
		if(tmpKills>=100)
		#ifdef INCLUDED_ELPIZO_DM
			M.client.screen += new/obj/Panel/Elpizo
		#endif
		#ifdef INCLUDED_LEVIATHEN_DM
			M.client.screen+= new/obj/Panel/Leviathen
		#endif
		#ifdef INCLUDED_PHANTOM_DM
		if(tmpKills>=700){M.client.screen += new/obj/Panel/Phantom}
		#endif
		if(tmpKills>=1000)
		#ifdef INCLUDED_FOXTAR_DM
			M.client.screen += new/obj/Panel/Foxtar
		#endif


		#ifdef INCLUDED_ANUBIS_DM
			M.client.screen += new/obj/Panel/ZeroSeries/Anubis
		#endif

		#ifdef INCLUDED_CHILLDRE_DM
		if(tmpKills>=1250){M.client.screen += new/obj/Panel/ZeroSeries/Chilldre}
		#endif
		#ifdef INCLUDED_KRAFT_DM
		if(tmpKills>=2000){M.client.screen += new/obj/Panel/Kraft}
		#endif
		#ifdef INCLUDED_OMEGA_DM
		if(tmpKills>=5000&&tmpPKills>=2500){M.client.screen += new/obj/Panel/Omega}
		#endif
		#ifdef INCLUDED_WEIL_DM
		if(tmpKills>=9000){M.client.screen += new/obj/Panel/Weil}
		#endif
		#ifdef INCLUDED_HANUMACHINE_DM
		if(tmpKills >= 1775 && tmpPKills >= 700 ) M.client.screen += new/obj/Panel/HanuMachine
		#endif
		#ifdef INCLUDED_AIRPANTHEON_DM
		if(tmpKills >= 650) M.client.screen += new/obj/Panel/ZeroSeries/AirPantheon
		#endif
		#ifdef INCLUDED_ZANZIBAR_DM
		if(tmpKills >= 900 ) M.client.screen += new/obj/Panel/ZeroSeries/Zanzibar
		#endif

	else
		#ifdef INCLUDED_AIRPANTHEON_DM
		M.client.screen += new/obj/Panel/ZeroSeries/AirPantheon
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
		M.client.screen += new/obj/Panel/ZeroSeries/Chilldre
		#endif
		#ifdef INCLUDED_ANUBIS_DM
		M.client.screen += new/obj/Panel/ZeroSeries/Anubis
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
		M.client.screen += new/obj/Panel/ZeroSeries/Zanzibar
		#endif
	if(FreeModes[c_CustomMode] == 0 && !isSAdmin(M))
		if(isnull(M)) return
		if(NoCustomsList.Find(M.key)) return
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
		if(tmpKills>=10000||M.key=="Oondivinezin"){M.client.screen += new/obj/Panel/Customs/Xeron}
		#endif
		#ifdef INCLUDED_LWX_DM
		if(tmpKills >= 10000 ||M.key=="Amarlaxi"||M.key=="Venetiae") M.client.screen += new/obj/Panel/Customs/LWX
		#endif
		#ifdef INCLUDED_ATHENA_DM
		if(tmpKills>=10000||M.key=="Amarlaxi"||M.key=="Venetiae" ){M.client.screen += new/obj/Panel/Customs/Athena}
		#endif
		#ifdef INCLUDED_GBD_DM
		if(tmpKills>=12500||M.key=="Basik")M.client.screen += new/obj/Panel/GBD
		#endif
		#ifdef INCLUDED_MODELC_DM
		if(tmpKills >= 15000&& tmpPKills >= 15000||M.key=="Cliff Hatomi")M.client.screen += new/obj/Panel/Customs/ModelC
		#endif

		#ifdef INCLUDED_ZV_DM
		if(tmpKills >= 15000&& tmpPKills >= 15000 && tmpCCKills >= 5000 ||M.key=="ZeroVirus") M.client.screen += new/obj/Panel/Customs/ZV
		#endif
		#ifdef INCLUDED_VALNAIRE_DM
		if(tmpKills >= 15000&& tmpPKills >= 15000 ||M.key=="Lord Protector"||M.key=="BloodTerrorX") M.client.screen += new/obj/Panel/Customs/Valnaire
		#endif
		#ifdef INCLUDED_FAX_DM
		if(tmpKills >= 15000&& tmpPKills >= 15000 ||isSAdmin(M)||M.key=="Solcloud" || M.key == "Sokuryoku") M.client.screen += new/obj/Panel/FAX
		#endif
		#ifdef INCLUDED_PSX_DM
		if(tmpKills >= 15000&& tmpPKills >= 10000&&tmpCCKills>=5000||M.key=="Bolt Dragon") M.client.screen += new/obj/Panel/PSX
		#endif
		#ifdef INCLUDED_XERONII_DM
		if(tmpKills >= 15000&& tmpPKills >= 15000 && tmpCCKills >= 7500||M.key=="Hiroyuki"||M.key=="Oondivinezin") M.client.screen += new/obj/Panel/Customs/XeronII
		#endif
		#ifdef INCLUDED_SJX_DM
		if(tmpKills >= 25000 && tmpPKills >= 10000 ) M.client.screen += new/obj/Panel/SJX
		#endif
		#ifdef INCLUDED_PLAGUE_DM
		if(tmpKills >= 30000 && tmpPKills >= 10000) M.client.screen += new/obj/Panel/Plague
		#endif
		if(tmpKills >= 50000 || M.key=="Cliff Hatomi" || M.key=="Amarlaxi"||M.key=="Venetiae" || M.key == "Bolt Dragon" || M.key=="Solcloud" || M.key == "Sokuryoku")
		#ifdef INCLUDED_CLIFF_DM
			M.client.screen += new/obj/Panel/Customs/Cliff
		#endif
		#ifdef INCLUDED_ATHENAII_DM
			M.client.screen += new/obj/Panel/Customs/AthenaII
		#endif
		#ifdef INCLUDED_SOLCLOUD_DM
			M.client.screen += new/obj/Panel/Customs/Solcloud
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
		M.client.screen += new/obj/Panel/Customs/Athena
		#endif
		#ifdef INCLUDED_XERON_DM
		M.client.screen += new/obj/Panel/Customs/Xeron
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
		M.client.screen += new/obj/Panel/Customs/ModelC
		#endif
		#ifdef INCLUDED_ZV_DM
		M.client.screen += new/obj/Panel/Customs/ZV
		#endif
		#ifdef INCLUDED_VALNAIRE_DM
		M.client.screen += new/obj/Panel/Customs/Valnaire
		#endif
		#ifdef INCLUDED_FAX_DM
		M.client.screen += new/obj/Panel/FAX
		#endif
		#ifdef INCLUDED_PSX_DM
		M.client.screen += new/obj/Panel/PSX
		#endif
		#ifdef INCLUDED_XERONII_DM
		M.client.screen += new/obj/Panel/Customs/XeronII
		#endif
		#ifdef INCLUDED_LWX_DM
		M.client.screen += new/obj/Panel/Customs/LWX
		#endif

	#ifdef INCLUDED_HDK_DM
	if(isSAdmin(M))
		M.client.screen += new/obj/Panel/Customs/HDK
	#endif
	#ifdef INCLUDED_ADMINMODE_DM
	if(isModerator(M) || isAdmin(M) || isOwner(M) || isSAdmin(M) )
		M.client.screen += new/obj/Panel/Customs/AdminMode
	#endif

