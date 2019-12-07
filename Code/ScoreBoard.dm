#ifndef INCLUDED_RANKINGS_DM
#define INCLUDED_RANKINGS_DM
var/ScoreboardLimit = 10000
/var/const/
	scoreboard={""}
	scoreboardtitle={"<STYLE>BODY {background: black;  color: silver}</STYLE><head><title>Rankings</title></head></body>"}
/Rank_Entry/
	var
		Name;
		Key;
		SKills;
		SDeaths
	New(mob/person)
		if(!person)return
		Key=(person.key)
		SKills=(person.Kills)
		SDeaths=(person.Deaths)
	//	SBossKills=(person.BBKills)
/proc/
	Ranks(var/mob/person)
		var/list/sckills=new()
		var/savefile/F=new("scoreboard.sav")
		F[("stuff")]>>(sckills)
		var/html="<center><TABLE BORDER=1><TR><TH><html><BODY><center><U><font color=#0000CC face = verdana size = +1>Rankings</font><font color=white></u><TABLE CELLSPACING=10>"
		if(!sckills)html+="<TR><TD>No valid rankings to display.</TD></TR>\n"
		else
			html+="<tr><th><B>#</th><th>Name </th><th>Kills</th><th>Deaths</th></tr>\n<br>"
			for(var/number in 1 to sckills.len)
				var{character=(sckills[(number)]);Rank_Entry/player=(sckills[(character)])}
				html+="<tr><td><u>[(number)]\th</td><td><I>[(player.Key)]</I></td><td>[num2text(round(player.SKills),10)]</td><td>[num2text(round(player.SDeaths),10)]</td></tr>\n"
		person<<browse("[scoreboardtitle][html]","window=scoreboard;can_resize=0;can_minimize=0;size=344x344")
	Ranking(var/mob/player)
		if(!player||!player.client)return
		var/savefile/F=new("scoreboard.sav")
		var/list/sckill=new()
		F[("stuff")]>>(sckill)
		if(!sckill)sckill=new()
		var{character="[(player.client.ckey)]"
			score=sckill.Find(character)
			Rank_Entry/newest=new(player)
			Rank_Entry/last}
		if(score)
			var/Rank_Entry/old=(sckill[(character)])
			if(old.SKills>=player.Kills)return score
			while(score>1)
				last=sckill[(sckill[(score-1)])]
				if(last.SKills>=player.Kills)break
				sckill[(score)]=(sckill[(score-1)])
				sckill[(--score)]=(character)
				sckill[(sckill[(score+1)])]=(last)
			sckill[(character)]=(newest)
			F[("stuff")]<<(sckill)
			return score
		score=(sckill.len)
		if(score>=ScoreboardLimit)
			last=(sckill[(sckill[(score)])])
			if(last.SKills>=player.Kills)return ScoreboardLimit+1
			sckill[(score)]=(character)
		else score=(sckill.len+1),sckill+=(character)
		while(score>1)
			last=(sckill[(sckill[(score-1)])])
			if(last.SKills>=player.Kills)break
			sckill[(score)]=(sckill[(score-1)])
			sckill[(--score)]=(character)
			sckill[(sckill[(score+1)])]=(last)
		sckill[(character)]=(newest)
		F[("stuff")]<<(sckill)
		return score
#endif