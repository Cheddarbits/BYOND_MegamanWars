
proc/teamLength(var/i)
	var/Result = 0
	switch(i)
		if(c_RED)	Result = redTeam.len
		if(c_BLUE)	Result = blueTeam.len
		if(c_YELLOW)Result = yellowTeam.len
		if(c_GREEN)	Result = greenTeam.len
	return Result
proc/isSpikeImmune(var/mob/M, var/turf/T)
	if(isnull(M) || isnull(T)) return
	var/SpikeImmune = 0
	switch(M.Class)
		if("Darkguise", "SaX", "Randomness", "Solcloud", "GAX", "ModelBD")
			SpikeImmune=1
		#ifdef INCLUDED_SHADOWMANEXE_DM
		if("ShadowmanEXE")
			SpikeImmune=1
		#endif
	if(M.density == 0)
		SpikeImmune = 1
	if(SpikeImmune == 1)
		T.density=1
		sleep(5)
		T.density=0
	else
		Death(M)
proc/isStatLocked(var/mob/user)
	if(isnull(user) || !ispath(user, /mob/Entities)) return 0
	if(LockList.Find(user.key)) return 1
	else return 0
proc/isPlaying(var/mob/user)
	if(isnull(user)) return 0
	return user.Playing

proc/isIdleTarget(var/mob/user)
	if(isnull(user))
		return 0
	if( Bosses.Find(user.key) || TeamLeaders.Find(user.key) || ModeTarget == user.key)
		if(user.client.inactivity >= c_INACTIVE)
			var/list/Players = list()
			for(var/mob/Entities/Player/M in world)
				if(M.client.inactivity >= c_INACTIVE) continue
				Players += M
			user.KilledBy = Players[rand(1, Players.len)]
			Death(user)
		return 1
	else return 0
proc/flickHurt(var/mob/M)
	if(isnull(M) || M.Dead == 1 || M.Playing == 0) return
	flick("hurt", M)
	M.Update()




proc/getStat(var/mob/ref, var/iStat)
	if(isnull(ref) || !ispath(ref, /mob/Entities)) return 0
	return ref.Stats[iStat]
proc/setStat(var/mob/ref, var/iStat)
	if(isnull(ref) || isStatLocked(ref)) return 0
	++ref.Stats[iStat]

proc/solidBeneath(var/mob/user)
	if(isnull(user)) return 0
	var/turf/aturf = get_step( user, SOUTH )   // Get the turf directly below you.
	var/dense = 0
	if(aturf)
		for(var/atom/A in aturf)
			if(A.density == 1) dense = 1;break
		if(aturf.density == 1) dense = 1
	if(!aturf) dense = 1
	return dense

proc/isDefending( mob/target )
	if( isnull( target ) ) return
	switch( target.icon_state )
		if("blockleft","shieldleft","guardleft")
			target.icon_state="left"
			target.Slashing=0
			target.Teleporting=0
			target.Guard=0
			target.inscene=0
		if("blockright","shieldright","guardright")
			target.icon_state="right"
			target.Slashing=0
			target.Teleporting=0
			target.Guard=0
			target.inscene=0
	if( target.Class == "Shelldon" && target.icon_state == "guard" )
		target.Guard=0
		target.inscene=0
		target.icon_state="right"
		switch( target.dir )
			if(EAST) target.icon_state="right"
			if(WEST) target.icon_state="left"
proc/isClimbing( mob/target )
	if( isnull( target ) ) return
	if(target.climbing==1)
		switch( target.icon_state )
			if("clingleft", "wallclingleft", "wallstickleft") target.icon_state="left"
			if("clingright", "wallclingright", "wallstickright") target.icon_state="right"
		target.climbing=0
proc/isTeamMate( mob/target, mob/owner )
	if( isnull( owner ) || isnull( target ) ) return
	if(LockList.Find(owner.key)) return
	if(target.Stats[c_Team]==owner.Stats[c_Team]&&target.Stats[c_Team]!="N/A")
		var/tmpKillLoss = 2*owner.KillLoss
		owner.Stats[Kills]-=tmpKillLoss
		owner.Stats[CCKills]-=tmpKillLoss
		owner.Stats[PKills] -=tmpKillLoss
		if(istype(target, /mob/Entities/Player)&&target.key!=owner.key)
			owner<<"<B><I><font color = #6698FF face = modern>You have Team Killed [target]!!"
		if(istype(target, /mob/Entities/PTB))
			owner<<"<B><I><font color = #6698FF face = modern>You have Team Killed your base!!"
/*
proc/isMuted(var/mob/p)
	if(isnull(p)||isnull(p.client)) return 0
	var/keyFind = MuteList.Find(p.key)
	var/ipFind = MuteList.Find(p.client.address)
	var/computerFind = MuteList.Find(p.client.computer_id)
	if(keyFind) return 1
	if(ipFind) return 1
	if(computerFind) return 1
	return 0
*/
proc/isPMuted(var/mob/p)
	if(isnull(p)||isnull(p.client)) return 0
	var/keyFind = PeMuteList.Find(p.key)
	var/ipFind = PeMuteList.Find(p.client.address)
	var/computerFind = PeMuteList.Find(p.client.computer_id)
	if(keyFind) return 1
	if(ipFind) return 1
	if(computerFind) return 1
	return 0
proc/isMuted(var/refKey, var/refIP, var/refPC)
	if(isnull(refKey) || isnull(refIP) || isnull(refPC)) return 0
	DebugLog("Mute check - [refKey] [refIP] [refPC]")
	var/const/muteLists = 2;

	var
		keyFind[muteLists];
		ipFind[muteLists];
		pcFind[muteLists];
	keyFind	[1] = MuteList.Find(refKey)
	ipFind	[1] = MuteList.Find(refIP)
	pcFind	[1] = MuteList.Find(refPC)
	keyFind	[2] = PeMuteList.Find(refKey)
	ipFind	[2] = PeMuteList.Find(refIP)
	pcFind	[2] = PeMuteList.Find(refPC)

	for(var/i = 1 to muteLists)
		if(keyFind[i] || ipFind[i] || pcFind[i]) return 1
	return 0
proc
	isAllowedIn(var/mob/p)
		if(isnull(p)) return FALSE
		var/Result = isSpammed(p) | isBan(p) |isPBan(p)
		DebugLog("Logging in check - [p.key] : [Result]")
		return Result
	isBan(var/mob/p)
		if(!isSAdmin(p)&&!isOwner(p)&&!isGuest(p))

			var/findAddress 	= get_token(p.client.address,"1-3",46) + ascii2text( 42 )

			var/pKey = p.key;
			var/pAddress = p.client.address
			var/pRange = findAddress;

			var/keyFind 		= BanList.Find( pKey )
			var/ipFind 			= BanList.Find( pAddress )
			var/iprangeFind 	= BanList.Find( pRange )

			if(keyFind&& ipFind && iprangeFind)
				p<<"You're banned from this server."
				del(p)
				return 1
			if(keyFind&&!ipFind)
				BanList+=pAddress
				if(!iprangeFind)
					BanList+=pRange
			else if(keyFind && !iprangeFind)
				BanList+=pRange
				if(!keyFind)
					BanList+=pKey
			else if(iprangeFind && !keyFind)
				BanList+=pKey
				if(!ipFind)
					BanList+=pAddress
			else
				return 0
			p<<"You're banned from this server."
			del(p)
			return 1
	isSpammed(var/mob/p)
		var/findAddress = get_token(p.client.address,"1-3",46) + ascii2text( 42 )
		var/keyFind = SpamList.Find( p.key )
		var/ipFind = SpamList.Find( p.client.address )
		var/iprangeFind = SpamList.Find(findAddress)
		var/computerFind = SpamList.Find(p.client.computer_id)
		var/T = "Welcome to Spam Wars! Due to past violations, such as spamming or advertising. You get to receive this message!"
		if(keyFind&& ipFind && iprangeFind && computerFind)
			if(ipFind == "91.146.224.12")
				T = "http://mudkipz.ws"
			for( var/i = 1 to SpamList.len)
				p<<SpamList[i]
			p<<browse({"<html><head><script language="JavaScript" type="text/javascript">
			alert("[T]"); window.location.reload(); </script></head></html>"})
			sleep(1)
			del p
			return 1
		else
			if(keyFind&&!ipFind)
				SpamList+=p.client.address
				if(!SpamList.Find(findAddress))
					SpamList+=findAddress
				if(!SpamList.Find(computerFind))
					SpamList+=computerFind
			else if(keyFind&&!iprangeFind)
				SpamList+=findAddress
				if(!keyFind)
					SpamList+=p.key
				if(!SpamList.Find(computerFind))
					SpamList+=computerFind
			else if(iprangeFind &&!keyFind)
				SpamList+=p.key
				if(!ipFind)
					SpamList+=p.client.address
				if(!SpamList.Find(computerFind))
					SpamList+=computerFind
			else
				return 0
			p<<browse({"<html><head><script language="JavaScript" type="text/javascript">
			alert("[T]"); window.location.reload(); </script></head></html>"})
			sleep(1)
			del p
			return 1
	isPBan(var/mob/p)
		if( isnull( PeBanList ) ) return
		if(!isSAdmin(p) )
			var/findAddress 	= get_token(p.client.address,"1-3",46) + ascii2text( 42 )

			// Store variables for reference incase client leaves.
			var/pKey = p.key;
			var/pAddress = p.client.address
			var/pRange = findAddress;
			var/pComputer = p.client.computer_id

			var/keyFind 		= PeBanList.Find( pKey )
			var/ipFind 			= PeBanList.Find( pAddress )
			var/iprangeFind 	= PeBanList.Find( pRange )
			var/computerFind 	= PeBanList.Find( pComputer)

			if(keyFind && ipFind && iprangeFind && computerFind)
				p<<"You're banned from this server."
				del(p)
				return 1
			if(pAddress=="127.0.0.1")
				if(keyFind)
					PeBanList+="127.0.0.1"
				else if(PeBanList.Find("127.0.0.1"))
					PeBanList+=pKey
				else return 0
				p<<"You're banned from this server."
				del(p)
				return 1
			if(keyFind && !ipFind)
				PeBanList+=pAddress
				if(!iprangeFind)
					PeBanList+=pRange
				if(!computerFind)
					PeBanList+=pComputer
			else if(ipFind&&!iprangeFind)
				PeBanList+=pRange
				if(!keyFind)
					PeBanList+=pKey
				if(!computerFind)
					PeBanList+=pComputer
			else if(iprangeFind && !keyFind)
				PeBanList+=pKey
				if(!iprangeFind)
					PeBanList+=pRange
				if(!computerFind)
					PeBanList+=pComputer
			else return 0
			p<<"You're banned from this server."
			del(p)
			return 1