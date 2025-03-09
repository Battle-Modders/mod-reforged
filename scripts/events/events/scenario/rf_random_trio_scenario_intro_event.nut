this.rf_random_trio_scenario_intro_event <- ::inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.rf_random_trio_scenario_intro";
		this.m.IsSpecial = true;
		this.m.Title = "A Company of Three";
		this.m.Screens.push({
			ID = "A",
			// Text generated and edited by LordMidas using ChatGPT
        	Text = "[img]gfx/ui/events/event_80.png[/img]The wind howls through the ruins of a nameless roadside inn, the embers of last night’s fire still glowing faintly in the pit. The three of you sit in the morning chill, nursing sore bodies and weary minds. It wasn't long ago that you were strangers—brought together by fate, circumstance, and perhaps a bit of bad luck.\n\nA few days prior, the roads had been safe enough, or so you thought. But whether it was bandits, beasts, or something worse, disaster struck. Maybe your caravan was ambushed, your lord betrayed, your farm burned, or your previous company torn apart. One way or another, you found yourselves alone in the world, desperate, and armed with little more than your wits and whatever steel you could scavenge.\n\nIt was necessity, not trust, that saw you standing back-to-back in the thick of it. But when the dust settled, you were still standing—and there was something to that.\n\nThe silence is broken as %bro1% lets out a long breath.%SPEECH_ON%Road’s not gonna get any shorter staring at the fire.%SPEECH_OFF%He tightens the last strap on his armor. %bro2%, sharpening a blade, smirks.%SPEECH_ON%Not much of a road to begin with. Just a lot of dirt and a promise that the next town might be better than the last.%SPEECH_OFF%%bro3%, older or perhaps just wearier, gestures at the remains of the inn.%SPEECH_ON%Well, this place is proof that promises don’t mean much. But coin does. We know how to fight, and there’s always someone willing to pay.%SPEECH_OFF%It is a simple truth. No homes to return to, no masters left to serve. Just the three of you, a handful of weapons, and the open road. If there is a future, it must be carved with steel and bought with blood. A decision must be made.%SPEECH_ON%Then it’s settled. We fight for coin, we fight for each other, and we make something of this mess.%SPEECH_OFF%There is no fanfare, no grand proclamation. Just three souls bound by fate, stepping onto the path of war. Whatever you were before no longer matters. From this day forward, you are mercenaries. Brothers in battle. And the world will come to know your name.",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "For coin and glory!",
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

	function onPrepareVariables( _vars )
	{
		foreach (i, bro in ::World.getPlayerRoster().getAll())
		{
			_vars.push([
				"bro" + i,
				bro.getNameOnly()
			]);
		}
	}
});
