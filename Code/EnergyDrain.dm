proc/Recover_Energy(var/mob/user)
	if(isnull(user)) return 0
	var/EnergyRecovery = 1
	switch(rand(1,3))
		if(1)
			if(Bosses.Find(user.key)) ++EnergyRecovery
			user.Energy+=EnergyRecovery
			if(user.Energy > user.mEnergy) user.Energy = user.mEnergy
			user.Update()
	return 1
proc/ShieldDrain_fromHit(var/Damage, var/mob/Def)
	if(isnull(Damage) || isnull(Def)) return 0
	if(isStatLocked(Def)) return 0
	Def.Energy -= round(Damage * 0.5)

	if(Def.Energy <= 0) Def.Energy = 0
	Def.Update()

	return 1
proc/Drain_fromUse(var/Amount, var/mob/user)
	if(isnull(Amount) || isnull(user) || user.Energy <= 0) return 0
	if(Bosses.Find(user.key)) Amount--;
	user.Energy -= round(Amount)

	if(user.Energy <= 0) user.Energy = 0
	user.Update()

	return 1