
/mob/living/Login()
	..()
	//Mind updates
	mind_initialize()	//updates the mind (or creates and initializes one if one doesn't exist)
	mind.active = 1		//indicates that the mind is currently synced with a client

	//Round specific stuff like hud updates
	if(ticker && ticker.mode)
		switch(ticker.mode.name)
			if("revolution")
				if((mind in ticker.mode.revolutionaries) || (src.mind in ticker.mode:head_revolutionaries))
					ticker.mode.update_rev_icons_added(src.mind)
			if("cult")
				if(mind in ticker.mode:cult)
					ticker.mode.update_cult_icons_added(src.mind)
			if("nuclear emergency")
				if(mind in ticker.mode:syndicates)
					ticker.mode.update_all_synd_icons()
			if("mutiny")
				var/datum/game_mode/mutiny/mode = get_mutiny_mode()
				if(mode)
					mode.update_all_icons()
			if("shadowlings")
				if((mind in ticker.mode.thralls) || (src.mind in ticker.mode:shadows))
					ticker.mode.update_all_shadows_icons()
	//Vents
	if(ventcrawler)
		src << "<span class='notice'>You can ventcrawl! Use alt+click on vents to quickly travel about the station.</span>"
	//Should update regardless of if we can ventcrawl, since we can end up in pipes in other ways.
	update_pipe_vision()

	return .
