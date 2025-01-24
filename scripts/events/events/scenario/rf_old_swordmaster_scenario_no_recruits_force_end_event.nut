this.rf_old_swordmaster_scenario_no_recruits_force_end_event <- ::inherit("scripts/events/event", {
	m = {
		Swordmaster = null	
	},
	function create()
	{
		this.m.ID = "event.rf_old_swordmaster_scenario_no_recruits_force_end";
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
        	Text = "[img]gfx/ui/events/event_17.png[/img]Age seems to follow you like a constant spectre, watching and waiting with every step. You set out upon this journey %OOC%because%OOC_OFF% of such feelings, not wanting to waste the knowledge handed down to you by your own instructors. At night, though, you have found yourself without any novices to shape into warriors of the future. Scions of your new \'school\' to carry on and gain renown for their masterful bladesmanship. What is this all for, if not to teach others..?\n\nRealizing your failures, you set aside your blade once more, turning about and heading back to your meager estate. Perhaps this was all a waste of time, a lesson in loneliness and foolhardy wanderlust. If only you had some students to guide, to carry on your legacy… alas, that has now passed you by. You will die a weak old man, and will take your knowledge to your grave.",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [				
				{
					Text = "Why did I even start... (End Campaign)",
					function getResult( _event )
					{
						this.World.State.getMenuStack().pop(true);
						this.World.State.showGameFinishScreen(true);
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Combat.abortAll();
				this.Characters.push(_event.m.Swordmaster.getImagePath());
				this.List = [
					{
						id = 16,
						icon = "ui/backgrounds/rf_old_swordmaster_background.png",
						text = _event.m.Swordmaster.getName() + " gives up on his dream to pass along his knowledge"
					}
				];
			}
		});
	}

	function onPrepare()
	{
		this.m.Title = "Failure";
		foreach (bro in this.World.getPlayerRoster().getAll())
		{
			if (bro.getSkills().hasSkill("effects.rf_old_swordmaster_scenario_avatar"))
			{
				this.m.Swordmaster = bro;
				break;
			}
		}
	}
});
