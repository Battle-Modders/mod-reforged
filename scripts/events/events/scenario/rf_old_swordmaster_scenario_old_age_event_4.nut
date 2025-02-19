// All event text written by ThePlahunter
this.rf_old_swordmaster_scenario_old_age_event_4 <- this.inherit("scripts/events/event", {
	m = {
		Swordmaster = null
	},
	function create()
	{
		this.m.ID = "event.rf_old_swordmaster_scenario_old_age_4";
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
        	Text = "[img]gfx/ui/events/event_17.png[/img]You slip away from the company in the early hours of dawn, while your students sleep, craving some time alone today. As you sit underneath the rising sun, lost in thought, many questions pass through your mind. Your prime has long passed you, yet here you remain. A sword in hand and sweat upon your brow as breath fills your lungs. Fighting in the midst of battle, slaying beast, man, and greenskin alike… Although, this has come at a cost. Old battle scars that were once a simple annoyance, now pulse harshly and send shocks of pain with every step you make. Every swing causing a soreness that haunts you to bed...\n\nSo many of your former comrades have already fallen, or retired peacefully. Last you heard, your sergeant from the wars, %randomname%, became knighted and was given quite a generous estate in the hinterlands of %randomtown%. His son is now taking care of the affairs in his old and infirm age. However, as you read through the letters of attempted correspondence, you find few responses. Most are of their next of kin, explaining that your old allies passed away due to disease, war, or murder. While others went completely missing, presumed dead of course.\n\nSparring partners cut down by mobs of brigands, your old instructor dying of plague, and even the young infatuation you woo\'d so many years ago finding love and passing on. Surrounded by their many children and loving spouse. Age has appeared to hit many of them… including you. You\'re not the only one who has noticed this. A few of your students, %randombrother% and %randombrother2% in particular, eye you with worry as your body becomes more fragile. You walk less with a graceful, fencer\'s step and more of a withered limp. Your hand shakes slightly while using a utensil, finding it harder and harder to eat.\n\nAlthough your skill with the sword still surprises your students, your body becomes more and more incapable of sustaining itself with every passing day. At the end of each spar, you find it harder to bring breath back into your lungs, and find it near impossible to stand upright.\n\nAs you watch the sun set, you realize that you have spent your entire day contemplating about your life, and the life of all those whose paths crossed yours. The blood red hue of the sky, the sinking sun and the mourning sounds of stranded birds finding their way back home... You heave a cold sigh, as you start to walk back towards the camp. Back towards that sweet sound of metal clanging upon metal.",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "What rises must one day set...",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Swordmaster.getImagePath());
				this.List = [
					{
						id = 16,
						icon = "ui/backgrounds/rf_old_swordmaster_background.png",
						text = _event.m.Swordmaster.getName() + " grows older"
					},
					{
						id = 16,
						icon = "ui/backgrounds/rf_old_swordmaster_background.png",
						text = _event.m.Swordmaster.getName() + " will continue to get weaker and lose Fatigue, Hitpoints and Initiative over time"
					}
				];
			}
		});
	}

	function onPrepare()
	{
		this.m.Title = "Twilight";
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
