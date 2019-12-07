// BEFORE SHOP SYSTEM
// NO MORE HIDDEN STATS
var/list/computeridSave = list()

proc/Load(var/mob/Entities/Player/A)
	var/savefile/F
	var/computerID = A.client.computer_id
	if(computeridSave.Find(A.key) || computeridSave.Find(computerID) )
		DebugLog("[A.key] found in computer id save list.")
		if(fexists("Players/[computerID].sav"))
			DebugLog("Loading [A.key] computer id save")
			F = new("Players/[computerID].sav")
			A<<"<b>Loading from server</b>"
	else
		if(fexists("Players/[A.ckey].sav"))
			F = new("Players/[A.ckey].sav")
	if(!isnull(F))
		if(isnull(F["Version"]))
			DebugLog("[A.key] has an null version.")
			return 0
		if(F["Version"] < 16)
			DebugLog("[A.key] save version is too old.")
			return 0
		if(isnull(F["Kills"]))
			DebugLog("Unable to find kills for [A.key]")
			return 0
		var/tmp
			tmpKills = 0
			tmpDeaths = 0
			tmpPKills = 0
			tmpCCKills = 0
		F["Kills"]>>tmpKills
		F["PKills"]>>tmpPKills
		F["CCKills"]>>tmpCCKills
		F["Deaths"]>>tmpDeaths
		F["Version"]>>A.Stats[Version]
		F["Name2"]>>A.Stats[subname]
		F["Name3"]>>A.name
		F["CKills"]>>A.Stats[CanUseKills]

		F["Ignore"]>>A.ignoreList
		if(isnull(A.ignoreList))
			A.ignoreList = new/list()
		A.Stats[Kills] = tmpKills
		A.Stats[PKills] = tmpPKills
		A.Stats[CCKills] = tmpCCKills
		A.Stats[Deaths] = tmpDeaths
		A<<"<b>LOADED!</b>"
		return 1
	return 0
proc/ServerSave(var/mob/Entities/Player/A)
	if(isnull(A)) return
	var/savefile/F
	var/computerID = A.client.computer_id
	if(computeridSave.Find(A.key) || computeridSave.Find(computerID) )
		F = new("Players/[computerID].sav")
	else
		F = new("Players/[A.ckey].sav")
	if(F)
		if(isnull(A))
			del F
			return
		F["Name"]		<<A.key
		F["Kills"]		<<A.Stats[Kills]
		F["PKills"]		<<A.Stats[PKills]
		F["CCKills"]	<<A.Stats[CCKills]
		F["Deaths"]		<<A.Stats[Deaths]
		F["Version"]	<<SAVE_VERSION
		F["Name2"]		<<A.Stats[subname]
		F["Name3"]		<<A.name
		F["CKills"]		<<A.Stats[CanUseKills]
		F["Ignore"]		<<A.ignoreList
		if(A.ispwiped!=1)
			A<<"<i>Saved!</i>"
proc/Save(var/mob/Entities/Player/A )
	if(isnull(A)) return
	if(A.Playing==1 && !isGuest(A))
	//	if(fexists("Players/[usr.ckey].sav")) fdel("Players/[usr.ckey].sav")
		if(A.Stats[Kills]>MAX_STAT)				A.Stats[Kills] = MAX_STAT
		else if(A.Stats[Kills]<-MAX_STAT)		A.Stats[Kills] = -MAX_STAT

		if(A.Stats[PKills]>MAX_STAT)			A.Stats[PKills] = MAX_STAT
		else if(A.Stats[PKills]<-MAX_STAT)		A.Stats[PKills] = -MAX_STAT

		if(A.Stats[CCKills]>MAX_STAT)			A.Stats[CCKills] = MAX_STAT
		else if(A.Stats[CCKills]<-MAX_STAT)		A.Stats[CCKills] = -MAX_STAT

		if(A.Stats[Deaths]>MAX_STAT)			A.Stats[Deaths] = MAX_STAT
		else if(A.Stats[Deaths]<-MAX_STAT)		A.Stats[Deaths] = -MAX_STAT

		for(var/i = 1 to A.Stats.len)
			if(A.Stats[i] > MAX_STAT)
				A.Stats[i] = MAX_STAT
			else if(A.Stats[i] < -MAX_STAT)
				A.Stats[i] = -MAX_STAT

		ServerSave(A)

proc/Pwiper(mob/A)
	//SaveLog("[time2text(world.realtime,"hh:mm:ss")] [A.key] has been auto save-wiped.<br></font>")
	A.Stats[Kills]=0
	A.Stats[CCKills]=0
	A.Stats[PKills]=0
	A.Stats[Deaths]=0
	Save(A)
