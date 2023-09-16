this.rf_collector_wants_weapon_event <- this.inherit("scripts/events/event", {
	m = {
		// Const
		RewardPenalty = 0.5,	// The full price of a famed weapon would be too much crowns
		BaseScore = 15,

		// Temp
		Reward = 0,
		NamedWeapon = null,
		Town = null,

		// Special Choices
		Peddler = null,
		SwordMaster = null
	},
	function create()
	{
		this.m.ID = "event.rf_collector_wants_weapon";
		this.m.Title = "At %townname%";
		this.m.Cooldown = 25.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_01.png[/img]{While browsing the town\'s markets, a man in silk approaches. He\'s wearing a grin with more glitter than chomp, and each of his fingers are adorned to glint. | As you take a look at the local market\'s wares, a strange man approaches. He has baubles of strange liquids hanging from his hip and there\'s a strange wood taking the place of most of his teeth. | It\'s not a true trip to the markets without some strange fella accosting you. This time it\'s a man with a large face, his mouth a bear trap of jagged teeth, and his cheeks set high as though they were meant to be shelves. Features aside, he swings his weight around like someone of import and wealth.}%SPEECH_ON%{Ah sellsword, I see you have some an interesting weapon with ya. How about I take that %weapon% for, say, %reward% crowns? | That\'s an interesting weapon you got there, the %weapon%. I\'ll give you %reward% crowns for it, hand over fist, easy money! | Hmm, I see you are of the adventuring sort. You wouldn\'t come by that %weapon% without some guile in ya. Well I got some gold in me, and I\'ll give you %reward% of it for that weapon.}%SPEECH_OFF%You consider the man\'s offer.",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Deal.",
					function getResult( _event )
					{
						if (_event.m.Peddler != null)
						{
							return "Peddler";
						}
						else
						{
							this.World.Assets.addMoney(_event.m.Reward);
							local stash = this.World.Assets.getStash().getItems();

							foreach( i, item in stash )
							{
								if (item != null && item.getID() == _event.m.NamedWeapon.getID())
								{
									stash[i] = null;
									break;
								}
							}

							return 0;
						}
					}

				},
				{
					Text = "No deal.",
					function getResult( _event )
					{
						if (_event.m.Peddler != null)
						{
							return "Peddler";
						}
						else
						{
							return 0;
						}
					}

				}
			],
			function start( _event )
			{
				local weaponImage = _event.m.NamedWeapon.getIconLarge();
				if (weaponImage != "")
				{
					this.Characters.push(weaponImage);
				}
			}

		});
		this.m.Screens.push({
			ID = "Peddler",
			Text = "[img]gfx/ui/events/event_01.png[/img]{%peddler% steps forward and pushes you back as though you were a random customer and not the company captain. He yells at the buyer and throws a hand up and the buyer responds and it\'s like two dogs barking at one another and it\'s all so fast and with so many numbers being thrown around it may as well be another language. After a minute passes, the peddler returns.%SPEECH_ON%Alright. He\'s now offering %reward% crowns. I\'m off to look at some pots and pans, good luck.%SPEECH_OFF%He pats you on the shoulder and walks off.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Deal.",
					function getResult( _event )
					{
						this.World.Assets.addMoney(_event.m.Reward);
						local stash = this.World.Assets.getStash().getItems();

						foreach( i, item in stash )
						{
							if (item != null && item.getID() == _event.m.NamedWeapon.getID())
							{
								stash[i] = null;
								break;
							}
						}

						return 0;
					}

				},
				{
					Text = "No deal.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Peddler.getImagePath());
				_event.m.Reward = this.Math.floor(_event.m.Reward * 1.33);
			}

		});
	}

	function onUpdateScore()
	{
		if (!::World.getTime().IsDaytime) return;
		if (::World.getPlayerRoster().getAll().len() < 3) return;

		local town;

		local nearTown = false;
		foreach (settlement in ::World.EntityManager.getSettlements())
		{
			if (settlement.getTile().getDistanceTo(::World.State.getPlayer().getTile()) <= 4 && settlement.isAlliedWithPlayer())
			{
				nearTown = true;
				town = settlement;
				break;
			}
		}
		if (!nearTown) return;

		local candidates_items = [];
		foreach (item in ::World.Assets.getStash().getItems())
		{
			if (item != null && item.isItemType(::Const.Items.ItemType.Weapon | ::Const.Items.ItemType.Named))
			{
				candidates_items.push(item);
			}
		}
		if (candidates_items.len() == 0) return;

		// This Event is valid:
		this.m.Town = town;
		this.m.Score = this.m.BaseScore + candidates_items.len();
		this.m.NamedWeapon = candidates_items[::Math.rand(0, candidates_items.len() - 1)];
		this.m.Reward = ::Math.round(this.m.NamedWeapon.getValue() * this.m.RewardPenalty);

		// Try to find candidates for additional choices
		local candidates_peddler = [];
		local candidates_sword_masters = [];

		foreach (bro in ::World.getPlayerRoster().getAll())
		{
			local backgroundID = bro.getBackground().getID();
			if (backgroundID == "background.peddler")
			{
				candidates_peddler.push(bro);
			}
			else if (backgroundID == "background.swordmaster" && this.m.NamedWeapon.isWeaponType(::Const.Items.WeaponType.Sword))
			{
				candidates_sword_masters.push(bro);
			}
		}

		if (candidates_peddler.len() != 0)
		{
			this.m.Peddler = candidates_peddler[::Math.rand(0, candidates_peddler.len() - 1)];
		}
		if (candidates_sword_masters.len() != 0)
		{
			this.m.SwordMaster = candidates_sword_masters[::Math.rand(0, candidates_sword_masters.len() - 1)];
		}
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"peddler",
			this.m.Peddler != null ? this.m.Peddler.getName() : ""
		]);
		_vars.push([
			"swordmaster",
			this.m.SwordMaster != null ? this.m.SwordMaster.getName() : ""
		]);
		_vars.push([
			"reward",
			this.m.Reward
		]);
		_vars.push([
			"weapon",
			this.m.NamedWeapon.getName()
		]);
		_vars.push([
			"townname",
			this.m.Town.getName()
		]);
	}

	function onClear()
	{
		this.m.Peddler = null;
		this.m.SwordMaster = null;
		this.m.Reward = 0;
		this.m.NamedWeapon = null;
		this.m.Town = null;
	}

});

