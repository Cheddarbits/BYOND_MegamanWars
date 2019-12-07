mob/AIs
	density = 1
	Huntress
		name = "Huntress"
		icon = 'Huntress.dmi'
		icon_state = "left"
		life = 1200
		mlife = 1200
		delay = 3
		New()
			src.TestAI()
			src.AIDodge()
			spawn(gravity) src.GravCheck()
			..()