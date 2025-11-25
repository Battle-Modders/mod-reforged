this.rf_oathtakers_take_oaths_in_regular_origins_event <- ::inherit("scripts/events/event", {
	m = {
		TriggerEveryXDays = 15,
		Oathtakers = [],

		// WeightedContainer set up during create function
		__PotentialOaths = null,

	},
	function create()
	{
		this.m.__PotentialOaths = ::MSU.Class.WeightedContainer();
		foreach (path in ::IO.enumerateFiles("scripts/skills/traits"))
		{
			if (split(path, "/").top().find("oath_of") != null)
			{
				this.m.__PotentialOaths.add(path);
			}
		}

		this.m.ID = "event.rf_oathtakers_take_oaths_in_regular_origins";
		this.m.IsSpecial = true;
		this.m.Title = "The Turning of the Oaths";
		this.m.Screens.push({
			ID = "A",
        	Text = "",
        	Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					// Text set during start function of this screen.
					Text = "",
					function getResult( _event )
					{
						return 0;
					}
				}
			],
			function start( _event )
			{
				if (_event.m.Oathtakers.len() == 1)
				{
					// Text generated and edited by LordMidas using ChatGPT
					this.Text = "[img]gfx/ui/events/event_183.png[/img]{You catch sight of %bro1% before dawn, moving at the far edge of the camp where the firelight dies and the mist hangs low. A lone figure, armored and still, standing as though waiting for a judgment only he can hear.\n\nHe kneels in the dirt with slow, deliberate care. There is no prayer. No whisper. Just the rasp of his gauntlet brushing the ground as he sets down a small token. An iron charm worn thin by constant handling. You\'ve seen him touch it after skirmishes, as if checking whether it still held whatever weight he assigned it. Now he leaves it behind without hesitation, as though it has finally served its purpose.\n\nAfter a while he draws another object from a pouch at his belt. You cannot quite make it out in the dim light. A carved sliver of wood, perhaps, or a scrap of cloth knotted with twine. He ties it to his harness with a movement that is neither reverent nor careless. More like a soldier tightening a strap before battle, accepting whatever burden comes with it.\n\nWhen he finally stands, his face gives nothing away. But there is a subtle shift in his bearing, the kind that only reveals itself after you\'ve marched many days beside a man. A new tension. A new quiet. A new resolve. The Oathtaker has shed his old vow and taken a new one. Whatever he decided in the cold dark will shape the battles ahead, for him and for you.}";

					this.Options[0].Text = "I will never understand him.";
				}
				else
				{
					// Text generated and edited by LordMidas using ChatGPT
					this.Text = "[img]gfx/ui/events/event_183.png[/img]{You wake in the small hours to the low murmur of movement. Armor shifting, boots scuffing earth, the muted clatter of men who try not to wake the camp. The Oathtakers are awake... always earlier than any sane sellsword has reason to be.\n\nThey gather at the edge of the camp, forming a tight circle like men preparing for a punishment rather than a rite. Heads bowed. You\'ve seen them do this before, and you\'ve yet to decide whether it resembles a confession or a soldier\'s cold appraisal of his own kit. Perhaps with the Oathtakers there is no difference.\n\nAfter some time %bro1% draws out a token, an iron charm rubbed raw by sweat and time, and drops it to the dirt. %bro2% sets down a strip of cloth, crusted with the dried edge of blood, who knows whether his or another\'s. These are the remnants of whatever oaths they carried before. Burdens taken, tasks finished, vows broken or completed. Nothing about the way they abandon their relics tells you which.\n\nYou watch as %bro1% retrieves a different token from his person. Others carve new notches into their shields or tie lengths of cord around their wrists. %bro2% drives a nail through a piece of leather and fixes it to his harness, as though fastening a verdict to his own chest. Whatever meaning these gestures hold, it is not meant for you. You only understand that new promises have been taken.\n\nWhen the circle breaks, the men return to their places with a steadiness that borders on grim resolve. Their faces have the hollow calm of men who expect to bleed, and intend to do so with purpose. Whatever their symbols represent, they bear them with the certainty of men who believe the world itself bends around their choices.\n\nYou feel the weight of their ritual settling over the camp like the fog that crawls up from the low fields, quiet at first, then undeniable. The Oathtakers have shed old vows and taken new ones. Whatever they decided in the cold dark will shape the battles ahead, for them and for you.}";

					this.Options[0].Text = "I will never understand them.";
				}

				this.List = [];

				foreach (bro in _event.m.Oathtakers)
				{
					local currentOath;
					local currentOathScript;
					foreach (s in bro.getSkills().m.Skills)
					{
						if (s.ClassName.find("oath_of") != null)
						{
							currentOathScript = ::IO.scriptFilenameByHash(s.ClassNameHash);
							currentOath = s;
							break;
						}
					}

					if (currentOath != null)
					{
						bro.getSkills().remove(currentOath);
					}

					local newOath = ::new(_event.m.__PotentialOaths.roll(currentOathScript == null ? null : [currentOathScript]));
					bro.getSkills().add(newOath);

					this.List.push({
						id = 16,
						icon = newOath.getIcon(),
						text = format("%s%s%s",
								bro.getName(),
								currentOath != null ? " completes " + currentOath.getName() + " and" : "",
								" takes " + newOath.getName())
					});
				}
			}
		});
	}

	function isValid()
	{
		if (::World.Assets.getOrigin().getID() == "scenario.paladins")
		{
			return false;
		}

		local currentDay = ::World.getTime().Days;
		if (currentDay % this.m.TriggerEveryXDays != 0)
		{
			return false;
		}

		local flagID = this.m.ID + "_LastDay";

		if (::World.Flags.has(flagID) && currentDay == ::World.Flags.get(flagID))
		{
			return false;
		}

		foreach (bro in ::World.getPlayerRoster().getAll())
		{
			if (bro.getBackground().getID() == "background.paladin")
			{
				::World.Flags.set(flagID, currentDay);
				return true;
			}
		}

		return false;
	}

	function onPrepare()
	{
		this.m.Oathtakers = ::World.getPlayerRoster().getAll().filter(@(_, _bro) _bro.getBackground().getID() == "background.paladin");
	}

	function onPrepareVariables( _vars )
	{
		local bros = clone this.m.Oathtakers;

		_vars.push([
			"bro1",
			bros.remove(::Math.rand(0, bros.len() - 1)).getName()
		]);

		if (bros.len() != 0)
		{
			_vars.push([
				"bro2",
				bros.remove(::Math.rand(0, bros.len() - 1)).getName()
			]);
		}
	}

	function onClear()
	{
		this.m.Oathtakers.clear();
	}
});
