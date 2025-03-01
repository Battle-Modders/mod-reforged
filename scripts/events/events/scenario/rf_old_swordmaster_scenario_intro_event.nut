this.rf_old_swordmaster_scenario_intro_event <- ::inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.rf_old_swordmaster_scenario_intro";
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			// Text generated and edited by LordMidas using ChatGPT
        	Text = "[img]gfx/ui/events/event_17.png[/img]The candle’s flame wavered in the draft, casting long shadows against the rough-hewn walls of your cabin. This place, nestled on the edge of the wild forest, has been your sanctuary for decades. Here, you honed your craft, shaping your body into a weapon and your mind into a whetstone. The sword has been your sole companion—a silent partner in battles fought and victories claimed. Yet now, as the twilight of your life closes in, you find yourself not thinking of wars or triumphs, but of silence—the silence that will follow you when you are gone.\n\nIt’s a peculiar thing, the passage of time. The strength in your arms, once unyielding, now falters. Your once-steady hands quiver, though the spirit within them still burns. And with every creak of these old bones, you feel the weight of a lifetime of knowledge—knowledge that will vanish like morning mist if left unshared. The art of the sword is not merely a dance of steel; it is a philosophy, a discipline, a way of seeing the world. It is the rhythm of breath in chaos, the calm at the heart of the storm. It has shaped you, but what worth is it if it shapes no one else?\n\nThere must be someone out there—a seeker, a wanderer, perhaps even a fool—worthy of this craft. You think back to the wonder and excitement you felt when you first took up the sword, the thrill of discovery in every lesson, and the awe of realizing how much there was to learn. That same spark must exist in someone now, someone who can take what you’ve spent a lifetime mastering and carry it forward, refining it, living it, teaching it.\n\nAnd so, you resolve to teach. Not to preserve your name, for names are fleeting, but to give this knowledge a life beyond your own. The way of the sword is not yours to keep; it is a river, flowing from one hand to the next. You will seek those who are willing to learn. The silence you shall leave behind will not be empty, but filled with the echoes of steel meeting steel, of wisdom passed from master to student.\n\nThe candle burns low, yet its light is enough to guide you. And as you rise, your sword resting against the wall like an old friend, you feel a strange sense of hope. Your life is no longer just your own; it is a bridge to those who will come after. Let them come. You will teach them all you know.",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "It is time...",
					function getResult( _event )
					{
						return "B";
					}

				}
			],
			function start( _event )
			{
				foreach (l in ::World.EntityManager.getLocations())
				{
					if (l.getTypeID() == "location.fountain_of_youth")
					{
						::logInfo("Removing the Fountain of Youth (Grotesque Tree) location");
						::World.EntityManager.removeLocation(l);
						break;
					}
				}
			}
		});

		local avatarEffect = ::new("scripts/skills/effects/rf_old_swordmaster_scenario_avatar_effect");
		local recruitEffect = ::new("scripts/skills/effects/rf_old_swordmaster_scenario_recruit_effect");

		this.m.Screens.push({
			ID = "B",
        	Text = "%OOC%How this origin works:%OOC_OFF%\n- It\'s all about teaching your students. The game will end if you spend " + avatarEffect.m.DaysWithoutRecruitsMax + " days in total without at least " + (avatarEffect.m.NumRecruitsRequired - 1) + " other recruits.\n- Recruits gain the \'Swordmaster\'s Training\' effect which grants special bonuses when using swords and gets stronger with every level.\n- Recruits with access to the Sword perk group have a " + recruitEffect.m.FreePerkChancePerLevel + "% chance to gain a free sword perk upon leveling up.\n- Recruits who come with access to the Sword perk group lose all other weapon perk groups and gain access to the Swordmaster perk group with special perks related to swordfighting to allow for a variety of different specializations and fighting styles.\n- If any recruit uses a weapon in combat other than swords, a banner, or a ranged weapon, it will anger your entire company.\n- Remember to check the tooltip of the \'Swordmaster\'s Training\' or \'Swordmaster\'s Finesse\' effects on your characters for important information regarding their bonuses (and penalties if applicable).\n- Cannot hire Swordmasters and Retired Soldiers.\n- Limited to 12 total characters and maximum 10 in battle.\n- The main character will get older over time and get various penalties.\n- Highly talented recruits can challenge swordmasters at settlements, and if successful, gain strong bonuses.\n- The Fountain of Youth (Grotesque Tree) location does not exist in this origin.",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Ok",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				_event.m.Title = "Origin Description";
			}
		});
	}

	function onUpdateScore()
	{
		return;
	}

	function onPrepare()
	{
		this.m.Title = "The Last Lesson";
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"home",
			::World.Flags.get("HomeVillage")
		]);
	}

	function onClear()
	{
	}
});
