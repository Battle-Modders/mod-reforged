// All event text written by ThePlahunter
this.rf_old_swordmaster_scenario_old_age_event_3 <- this.inherit("scripts/events/event", {
	m = {
		Swordmaster = null
	},
	function create()
	{
		this.m.ID = "event.rf_old_swordmaster_scenario_old_age_3";
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
        	Text = "[img]gfx/ui/events/event_17.png[/img]You sit upon a nearby boulder as your students partake in their daily tasks and rigorous training. Practicing the same motions, steps, and attacks over and over again. Metal upon metal of clashing blades sing through the air, such a wonderful melody causing a smile to form on your cracked lips. Such displays of skill, speed, and endurance! Such that could come close to matching your own…\n\nBut, not close enough! They have so much yet to learn! Pushing off of the rock, you approach %randombrother% and %randombrother2% in the midst of their spar. Watching their weapons twirl about and strike against one another in a display of defensive footwork, parrying, and precise strikes. As you draw closer, however, you notice a handful of mistakes. Poor footing, a limp wrist, and too much ground being given away with no recourse. With a raised hand you stop the spar, looking to %randombrother% and gesturing to take his weapon. %SPEECH_START%Come, give me that…%SPEECH_OFF%With a simple grasp you take the weapon, and his place.%SPEECH_ON%You give up too much ground without recourse. If you are too defensive, your enemy will simply pick you apart. Leaving you exposed and exhausted. Unless you have lungs of iron and a heart of steel, your opponent %OOC%will%OOC_OFF% outlast you. Watch, I shall defend and strike back at the same time!%SPEECH_OFF%You adjust your grip accordingly and lead with your right foot. Blade ready as you stare down your \'opponent\'.%SPEECH_ON%Engarde!%SPEECH_OFF%You strike first with a quick lunging thrust, aiming to close the distance and get within reach. Your eyes tighten as the sudden pressure building on your back knee takes you by surprise, and a shock of pain rises up to your chest. The loss of momentum makes your attack easy to react to, and %randombrother2% knocks your blade into the air, taking a cautious step to the side. He brings up his weapon, raising it over his head, lifting his offhand close to his chest, attempting to strike down into yours. Such a blow would be easy to deflect... and so you try. However, your arms suddenly feel sluggish, and just as you try to block-\n\nHe strikes you.\n\nYour reflexes were too slow, and his wooden blade slides right under your guard and into your ribs. Pain wracks your body as a %OOC%CRACK!%OOC_OFF% emanates from your chest causing your breath to escape from your lungs as you stumble back. In an attempt to recover yourself, you brace your legs but find your knee quickly buckling once more. An old battle wound finally catching up with you, leaving the joint frail and unable to support your body. Finally, you collapse to the ground, writhing in pain as you flop about like a hooked fish.\n\nMinutes pass like hours before the pain subsides. Eventually, wind comes wheezing back into your lungs. And with the help of a few students, you rise back to your feet, groaning in pain. Giving a quick nod to %randombrother2%, you turn and stumble your way back to your tent with your arm around %randombrother%\'s shoulders.",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "How much longer do I have?",
					function getResult( _event )
					{
						_event.m.Swordmaster.getSkills().removeByID("perk.rf_swordmaster_precise");
						_event.m.Swordmaster.getSkills().removeByID("perk.rf_swordmaster_blade_dancer");
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Swordmaster.getImagePath());
				local injuries = [
					{
						ID = "injury.fractured_ribs",
						Threshold = 0.25,
						Script = "injury/fractured_ribs_injury"
					}
				];
				if (_event.m.Swordmaster.getSkills().hasSkill("injury.fractured_ribs"))
				{
					injuries = [
						{
							ID = "injury.broken_ribs",
							Threshold = 0.5,
							Script = "injury/broken_ribs_injury"
						}
					];
				}

				local injury = _event.m.Swordmaster.addInjury(injuries);

				this.List = [
					{
						id = 16,
						icon = "ui/backgrounds/rf_old_swordmaster_background.png",
						text = _event.m.Swordmaster.getName() + " grows older"
					},
					{
						id = 16,
						icon = ::Const.Perks.findById("perk.rf_swordmaster_precise").Icon,
						text = _event.m.Swordmaster.getName() + " loses the Precise perk"
					},
					{
						id = 16,
						icon = ::Const.Perks.findById("perk.rf_swordmaster_blade_dancer").Icon,
						text = _event.m.Swordmaster.getName() + " loses the Blade Dancer perk"
					},
					{
						id = 16,
						icon = "ui/backgrounds/rf_old_swordmaster_background.png",
						text = _event.m.Swordmaster.getName() + " will continue to get weaker and lose Fatigue, Hitpoints and Initiative over time"
					}
				];

				if (injury != null)
				{
					this.List.push({
						id = 16,
						icon = injury.getIcon(),
						text = _event.m.Swordmaster.getName() + " suffers " + injury.getNameOnly()
					});
				}

				_event.m.Swordmaster.addLightInjury();
				this.List.push({
					id = 16,
					icon = "ui/icons/days_wounded.png",
					text = _event.m.Swordmaster.getName() + " suffers Light Wounds"
				});
			}
		});
	}

	function onPrepare()
	{
		this.m.Title = "Like a Fish";
		foreach (bro in ::World.getPlayerRoster().getAll())
		{
			if (bro.getSkills().hasSkill("effects.rf_old_swordmaster_scenario_avatar"))
			{
				this.m.Swordmaster = bro;
				break;
			}
		}
	}

	function onClear()
	{
		this.m.Swordmaster = null;
	}
});
