
obj
	var/restoreValue = 0
	Drops
		name = ""
		icon = 'Drops.dmi'
		density = 1
		Energy
			Small {icon_state = "ammos"; restoreValue = 3}
			Large {icon_state = "ammob"; restoreValue = 7}
		Health
			Small {icon_state = "hps"; restoreValue = 3}
			Large {icon_state = "hpb"; restoreValue = 7}