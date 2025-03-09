this.rf_random_solo_scenario_intro_event <- ::inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.rf_random_solo_scenario_intro";
		this.m.IsSpecial = true;
		this.m.Title = "A New Dawn, A New Path";
		this.m.Screens.push({
			ID = "A",
			// Text generated and edited by LordMidas using DeepSeek
        	Text = "[img]gfx/ui/events/rf_random_solo_intro.png[/img]The sun rises over the horizon, its light spilling across the muddy road beneath your boots. You’ve been walking for hours, maybe days, your mind heavy with thoughts of the life you’ve left behind. Whether you were a farmer, a soldier, a craftsman, or something else entirely, that life is gone now. The fields, the barracks, the workshop—they’re all behind you. Ahead lies something uncertain, but it’s yours to claim.\n\nYou pause, glancing down at the weapon at your side. It’s not much but it’s enough. You’ve heard the stories: mercenaries rising from nothing, carving out fortunes with steel and grit. You don’t know if you believe them, but you’re willing to find out. The world is harsh, and survival isn’t guaranteed, but at least here, on this road, you have a chance to make your own way.\n\nThe sound of a passing cart breaks your thoughts. The driver eyes you warily before moving on. You don’t blame him. You’re just another stranger on the road, another soul trying to survive in a land torn by war and greed. But you know you’re more than that. You have to be.\n\nYou think about what lies ahead. Coin, yes, but also something deeper. A purpose. A chance to build something that’s yours. A company of your own, bound not by blood but by loyalty and shared struggle. It won’t be easy, but nothing worth doing ever is.\n\nThe wind carries the faint scent of smoke and the distant clang of steel. Somewhere out there, battles are being fought, and fortunes are being made. You tighten your grip on your weapon and take a step forward. This is your path now. No turning back.\n\nThe road stretches ahead, endless and full of promise. You don’t know where it will lead, but you know one thing: this is where your story begins. The past is behind you. The future is yours to seize.",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "I embrace the life of a mercenary.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Banner = "ui/banners/" + ::World.Assets.getBanner() + "s.png";
			}

		});
	}
});
