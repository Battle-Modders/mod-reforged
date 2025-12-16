this.rf_zombie_orc <- ::inherit("scripts/entity/tactical/actor", {
	m = {
		InjuryType = 1,
		Surcoat = null,
		ResurrectionChance = 66,
		ResurrectionValue = 2.0,
		ResurrectWithScript = "scripts/entity/tactical/enemies/rf_zombie_orc",
		IsResurrectingOnFatality = false,
		IsCreatingAgent = true,
		IsHeadless = false
	},

	function getZombifyBrushNameHead()
	{
	}

	function getZombifyBrushNameBody()
	{
	}

	function setOrcSpecificSprites()
	{
	}

	function create()
	{
		this.m.BloodType = ::Const.BloodType.Dark;
		this.m.MoraleState = ::Const.MoraleState.Ignore;
		this.actor.create();
		this.m.Sound[::Const.Sound.ActorEvent.DamageReceived] = [
			"sounds/enemies/rf_zombie_orc_hurt_01.wav",
			"sounds/enemies/rf_zombie_orc_hurt_02.wav",
			"sounds/enemies/rf_zombie_orc_hurt_03.wav",
			"sounds/enemies/rf_zombie_orc_hurt_04.wav",
			"sounds/enemies/rf_zombie_orc_hurt_05.wav",
			"sounds/enemies/rf_zombie_orc_hurt_06.wav",
			"sounds/enemies/rf_zombie_orc_hurt_07.wav"
		];
		this.m.Sound[::Const.Sound.ActorEvent.Death] = [
			"sounds/enemies/rf_zombie_orc_death_01.wav",
			"sounds/enemies/rf_zombie_orc_death_02.wav",
			"sounds/enemies/rf_zombie_orc_death_03.wav",
			"sounds/enemies/rf_zombie_orc_death_04.wav",
			"sounds/enemies/rf_zombie_orc_death_05.wav",
			"sounds/enemies/rf_zombie_orc_death_06.wav"
		];
		this.m.Sound[::Const.Sound.ActorEvent.Resurrect] = [
			"sounds/enemies/rf_zombie_orc_rise_01.wav",
			"sounds/enemies/rf_zombie_orc_rise_02.wav",
			"sounds/enemies/rf_zombie_orc_rise_03.wav",
			"sounds/enemies/rf_zombie_orc_rise_04.wav"
		];
		this.m.Sound[::Const.Sound.ActorEvent.Idle] = [
			"sounds/enemies/rf_zombie_orc_idle_01.wav",
			"sounds/enemies/rf_zombie_orc_idle_02.wav",
			"sounds/enemies/rf_zombie_orc_idle_03.wav",
			"sounds/enemies/rf_zombie_orc_idle_04.wav",
			"sounds/enemies/rf_zombie_orc_idle_05.wav",
			"sounds/enemies/rf_zombie_orc_idle_06.wav",
			"sounds/enemies/rf_zombie_orc_idle_07.wav",
			"sounds/enemies/rf_zombie_orc_idle_08.wav",
			"sounds/enemies/rf_zombie_orc_idle_09.wav",
			"sounds/enemies/rf_zombie_orc_idle_10.wav",
			"sounds/enemies/rf_zombie_orc_idle_11.wav",
			"sounds/enemies/rf_zombie_orc_idle_12.wav",
			"sounds/enemies/rf_zombie_orc_idle_13.wav",
			"sounds/enemies/rf_zombie_orc_idle_14.wav",
			"sounds/enemies/rf_zombie_orc_idle_15.wav",
			"sounds/enemies/rf_zombie_orc_idle_16.wav"
		];
		this.m.Sound[::Const.Sound.ActorEvent.Move] = this.m.Sound[::Const.Sound.ActorEvent.Idle];
		this.m.SoundVolume[::Const.Sound.ActorEvent.Move] = 0.1;
		this.m.SoundPitch = ::Math.rand(70, 120) * 0.01;
		this.getFlags().add("undead");
		this.getFlags().add("zombie_minion");

		if (this.m.IsCreatingAgent)
		{
			this.m.AIAgent = ::new("scripts/ai/tactical/agents/zombie_agent");
			this.m.AIAgent.setActor(this);
		}

		this.m.InjuryType = ::Math.rand(1, 4);
	}

	function playSound( _type, _volume, _pitch = 1.0 )
	{
		if (_type == ::Const.Sound.ActorEvent.Move && ::Math.rand(1, 100) <= 50)
		{
			return;
		}

		this.actor.playSound(_type, _volume, _pitch);
	}

	function onDeath( _killer, _skill, _tile, _fatalityType )
	{
		local flip = ::Math.rand(0, 100) < 50;
		this.m.IsCorpseFlipped = flip;
		local appearance = this.getItems().getAppearance();
		local sprite_body = this.getSprite("body");
		local sprite_head = this.getSprite("head");
		local tattoo_body = this.getSprite("tattoo_body");
		local tattoo_head = this.getSprite("tattoo_head");

		if (_tile != null)
		{
			local decal = _tile.spawnDetail(sprite_body.getBrush().Name + "_dead", ::Const.Tactical.DetailFlag.Corpse, flip);
			decal.Color = sprite_body.Color;
			decal.Saturation = sprite_body.Saturation;
			decal.Scale = 0.9;
			decal.setBrightness(0.9);

			if (tattoo_body.HasBrush)
			{
				decal = _tile.spawnDetail(tattoo_body.getBrush().Name + "_dead", ::Const.Tactical.DetailFlag.Corpse, flip);
				decal.Color = tattoo_body.Color;
				decal.Saturation = tattoo_body.Saturation;
				decal.Scale = 0.9;
				decal.setBrightness(0.9);
			}

			if (appearance.CorpseArmor != "")
			{
				local decal = _tile.spawnDetail(appearance.CorpseArmor, ::Const.Tactical.DetailFlag.Corpse, flip);
				decal.Scale = 0.9;
				decal.setBrightness(0.9);
			}

			if (this.m.Surcoat != null)
			{
				decal = _tile.spawnDetail("surcoat_" + (this.m.Surcoat < 10 ? "0" + this.m.Surcoat : this.m.Surcoat) + "_dead", ::Const.Tactical.DetailFlag.Corpse, flip);
				decal.Scale = 0.9;
				decal.setBrightness(0.9);
			}

			if (appearance.CorpseArmorUpgradeBack != "")
			{
				decal = _tile.spawnDetail(appearance.CorpseArmorUpgradeBack, ::Const.Tactical.DetailFlag.Corpse, flip);
				decal.Scale = 0.9;
				decal.setBrightness(0.9);
			}

			if (_fatalityType != ::Const.FatalityType.Decapitated && !this.m.IsHeadless)
			{
				if (!appearance.HideCorpseHead)
				{
					local decal = _tile.spawnDetail(sprite_head.getBrush().Name + "_dead", ::Const.Tactical.DetailFlag.Corpse, flip);
					decal.Color = sprite_head.Color;
					decal.Saturation = sprite_head.Saturation;
					decal.Scale = 0.9;
					decal.setBrightness(0.9);

					if (tattoo_head.HasBrush)
					{
						local decal = _tile.spawnDetail(tattoo_head.getBrush().Name + "_dead", ::Const.Tactical.DetailFlag.Corpse, flip);
						decal.Color = tattoo_head.Color;
						decal.Saturation = tattoo_head.Saturation;
						decal.Scale = 0.9;
						decal.setBrightness(0.9);
					}
				}

				if (!appearance.HideCorpseHead)
				{
					local decal = _tile.spawnDetail(this.getZombifyBrushNameHead() + "_dead", ::Const.Tactical.DetailFlag.Corpse, flip);
					decal.Scale = 0.9;
					decal.setBrightness(0.75);
				}

				if (_fatalityType == ::Const.FatalityType.Smashed)
				{
					local decal = _tile.spawnDetail("bust_head_smashed_02", ::Const.Tactical.DetailFlag.Corpse, flip);
					decal.setBrightness(0.8);
				}
				else if (appearance.HelmetCorpse != "")
				{
					local decal = _tile.spawnDetail(appearance.HelmetCorpse, ::Const.Tactical.DetailFlag.Corpse, flip);
					decal.Scale = 0.9;
					decal.setBrightness(0.9);
				}
			}
			else if (_fatalityType == ::Const.FatalityType.Decapitated && !this.m.IsHeadless)
			{
				local layers = [];

				if (!appearance.HideCorpseHead)
				{
					layers.push(sprite_head.getBrush().Name + "_dead");
				}

				if (!appearance.HideCorpseHead && tattoo_head.HasBrush)
				{
					layers.push(sprite_head.getBrush().Name + "_dead");
				}

				if (!appearance.HideCorpseHead)
				{
					layers.push(this.getZombifyBrushNameHead() + "_dead");
				}

				if (appearance.HelmetCorpse.len() != 0)
				{
					layers.push(appearance.HelmetCorpse);
				}

				local decap = ::Tactical.spawnHeadEffect(this.getTile(), layers, this.createVec(0, 0), -90.0, "bust_head_dead_bloodpool_zombified");
				local idx = 0;

				if (!appearance.HideCorpseHead)
				{
					decap[idx].Color = sprite_head.Color;
					decap[idx].Saturation = sprite_head.Saturation;
					decap[idx].Scale = 0.9;
					decap[idx].setBrightness(0.9);
					idx = ++idx;
				}

				if (!appearance.HideCorpseHead && tattoo_head.HasBrush)
				{
					decap[idx].Color = tattoo_head.Color;
					decap[idx].Saturation = tattoo_head.Saturation;
					decap[idx].Scale = 0.9;
					decap[idx].setBrightness(0.9);
					idx = ++idx;
				}

				if (!appearance.HideCorpseHead)
				{
					decap[idx].Scale = 0.9;
					decap[idx].setBrightness(0.75);
					idx = ++idx;
				}

				if (appearance.HelmetCorpse.len() != 0)
				{
					decap[idx].Scale = 0.9;
					decap[idx].setBrightness(0.9);
					idx = ++idx;
				}
			}

			if (_skill && _skill.getProjectileType() == ::Const.ProjectileType.Arrow)
			{
				if (appearance.CorpseArmor != "")
				{
					decal = _tile.spawnDetail(appearance.CorpseArmor + "_arrows", ::Const.Tactical.DetailFlag.Corpse, flip);
				}
				else
				{
					decal = _tile.spawnDetail(appearance.Corpse + "_arrows", ::Const.Tactical.DetailFlag.Corpse, flip);
				}

				decal.Saturation = 0.85;
				decal.setBrightness(0.85);
			}
			else if (_skill && _skill.getProjectileType() == ::Const.ProjectileType.Javelin)
			{
				if (appearance.CorpseArmor != "")
				{
					decal = _tile.spawnDetail(appearance.CorpseArmor + "_javelin", ::Const.Tactical.DetailFlag.Corpse, flip);
				}
				else
				{
					decal = _tile.spawnDetail(appearance.Corpse + "_javelin", ::Const.Tactical.DetailFlag.Corpse, flip);
				}

				decal.Saturation = 0.85;
				decal.setBrightness(0.85);
			}

			if (appearance.CorpseArmorUpgradeFront != "")
			{
				decal = _tile.spawnDetail(appearance.CorpseArmorUpgradeFront, ::Const.Tactical.DetailFlag.Corpse, flip);
				decal.Scale = 0.9;
				decal.setBrightness(0.9);
			}

			this.spawnTerrainDropdownEffect(_tile);
			this.spawnFlies(_tile);
		}

		local deathLoot = this.getItems().getDroppableLoot(_killer);
		local tileLoot = this.getLootForTile(_killer, deathLoot);
		this.dropLoot(_tile, tileLoot, !flip);
		local corpse = this.generateCorpse(_tile, _fatalityType, _killer);

		if (_tile == null)
		{
			::Tactical.Entities.addUnplacedCorpse(corpse);
		}
		else
		{
			_tile.Properties.set("Corpse", corpse);
			::Tactical.Entities.addCorpse(_tile);
		}

		this.actor.onDeath(_killer, _skill, _tile, _fatalityType);
	}

	function generateCorpse( _tile, _fatalityType, _killer )
	{
		local isResurrectable = this.m.IsResurrectingOnFatality || _fatalityType != ::Const.FatalityType.Decapitated && _fatalityType != ::Const.FatalityType.Smashed;
		local sprite_body = this.getSprite("body");
		local sprite_head = this.getSprite("head");
		local tattoo_body = this.getSprite("tattoo_body");
		local tattoo_head = this.getSprite("tattoo_head");
		local custom = {
			IsZombified = true,
			InjuryType = this.m.InjuryType,
			Face = sprite_head.getBrush().Name,
			Body = sprite_body.getBrush().Name,
			TattooBody = tattoo_body.HasBrush ? tattoo_body.getBrush().Name : null,
			TattooHead = tattoo_head.HasBrush ? tattoo_head.getBrush().Name : null,
			Surcoat = this.m.Surcoat,
		};
		local corpse = clone ::Const.Corpse;
		corpse.Type = this.m.ResurrectWithScript;
		corpse.Faction = this.getFaction();
		corpse.CorpseName = "A " + this.getName();
		corpse.Value = this.m.ResurrectionValue;
		corpse.Armor = this.m.BaseProperties.Armor;
		corpse.Items = this.getItems().prepareItemsForCorpse(_killer);
		corpse.Color = sprite_body.Color;
		corpse.Saturation = sprite_body.Saturation;
		corpse.Custom = custom;
		corpse.IsHeadAttached = _fatalityType != ::Const.FatalityType.Decapitated && !this.m.IsHeadless;

		if (isResurrectable)
		{
			if (!this.m.IsResurrected && ::Math.rand(1, 100) <= this.m.ResurrectionChance)
			{
				corpse.IsConsumable = false;
				corpse.IsResurrectable = false;
				::Time.scheduleEvent(::TimeUnit.Rounds, ::Math.rand(1, 2), ::Tactical.Entities.resurrect, corpse);
			}
			else
			{
				corpse.IsResurrectable = true;
				corpse.IsConsumable = true;
			}
		}

		if (_tile != null)
		{
			corpse.Tile = _tile;
		}

		return corpse;
	}

	function onBeforeCombatResult()
	{
		if (this.getFaction() == ::Const.Faction.PlayerAnimals)
		{
			this.getItems().dropAll(null, null, false);
		}
	}

	function onResurrected( _info )
	{
		if (_info.IsPlayer)
		{
			this.updateAchievement("WelcomeBack", 1, 1);
		}

		if (_info.Custom != null)
		{
			local head = this.getSprite("head");
			local body = this.getSprite("body");
			local tattoo_body = this.getSprite("tattoo_body");
			local tattoo_head = this.getSprite("tattoo_head");
			local sprite_surcoat = this.getSprite("surcoat");

			if ("InjuryType" in _info.Custom)
			{
				this.m.InjuryType = _info.Custom.InjuryType;
			}

			head.setBrush(_info.Custom.Face);
			body.setBrush(_info.Custom.Body);

			if (!_info.Custom.IsZombified)
			{
				// TODO
				head.Saturation = 0.5;
				head.varySaturation(0.2);
				head.Color = this.createColor("#c1ddaa");
				head.varyColor(0.05, 0.05, 0.05);
			}
			else
			{
				head.Color = _info.Color;
				head.Saturation = _info.Saturation;
			}

			body.Color = head.Color;
			body.Saturation = head.Saturation;

			if (_info.Custom.TattooBody != null)
			{
				tattoo_body.setBrush(_info.Custom.TattooBody);
				tattoo_body.Visible = true;
			}

			if (_info.Custom.TattooHead != null)
			{
				tattoo_head.setBrush(_info.Custom.TattooHead);
				tattoo_head.Visible = true;
			}

			if (_info.Custom.Surcoat != null)
			{
				this.m.Surcoat = _info.Custom.Surcoat;
				sprite_surcoat.setBrush("surcoat_" + (this.m.Surcoat < 10 ? "0" + this.m.Surcoat : this.m.Surcoat) + "_damaged");
			}
		}

		this.actor.onResurrected(_info);
		this.m.IsResurrected = true;
		this.pickupMeleeWeaponAndShield(this.getTile());
		this.getSkills().update();
		this.m.XP /= 4;
		local tile = this.getTile();

		for (local i = 0; i != 6; i++)
		{
			if (!tile.hasNextTile(i))
				continue;

			local otherTile = tile.getNextTile(i);
			if (!otherTile.IsOccupiedByActor)
				continue;

			local otherActor = otherTile.getEntity();
			local numEnemies = otherTile.getZoneOfControlCountOtherThan(otherActor.getAlliedFactions());

			if (otherActor.m.MaxEnemiesThisTurn < numEnemies && !otherActor.isAlliedWith(this))
			{
				local difficulty = ::Math.maxf(10.0, 50.0 - this.getXPValue() * 0.2);
				otherActor.checkMorale(-1, difficulty);
				otherActor.m.MaxEnemiesThisTurn = numEnemies;
			}
		}
	}

	function onActorKilled( _actor, _tile, _skill )
	{
		if (!this.isKindOf(_actor, "player") && !this.isKindOf(_actor, "human"))
		{
			return;
		}

		if (_tile == null)
		{
			return;
		}

		if (_tile.IsCorpseSpawned && _tile.Properties.get("Corpse").IsResurrectable)
		{
			local corpse = _tile.Properties.get("Corpse");
			corpse.Faction = this.getFaction();
			corpse.Hitpoints = 1.0;
			corpse.Items = _actor.getItems();
			corpse.IsConsumable = false;
			corpse.IsResurrectable = false;
			::Time.scheduleEvent(::TimeUnit.Rounds, ::Math.rand(2, 3), ::Tactical.Entities.resurrect, corpse);
		}
	}

	function onUpdateInjuryLayer()
	{
		local injury = this.getSprite("injury");
		local injury_body = this.getSprite("body_injury");

		local brushName = this.getZombifyBrushNameHead();

		if (this.getHitpointsPct() > 0.5)
		{
			if (injury.getBrush().Name != brushName)
			{
				injury.setBrush(brushName);
			}
		}
		else if (injury.getBrush().Name != brushName + "_injured")
		{
			injury.setBrush(brushName + "_injured");
		}

		// TODO
		// if (p > 0.5)
		// {
		// 	injury_body.setBrush("zombify_body_01");
		// 	injury_body.Visible = true;
		// }
		// else
		// {
		// 	injury_body.setBrush("zombify_body_02");
		// 	injury_body.Visible = true;
		// }

		this.setDirty(true);
	}

	function onFactionChanged()
	{
		this.actor.onFactionChanged();
		local flip = this.isAlliedWithPlayer();
		this.getSprite("background").setHorizontalFlipping(flip);
		this.getSprite("shaft").setHorizontalFlipping(flip);
		this.getSprite("surcoat").setHorizontalFlipping(flip);
		this.getSprite("quiver").setHorizontalFlipping(flip);
		this.getSprite("body").setHorizontalFlipping(flip);
		this.getSprite("tattoo_body").setHorizontalFlipping(flip);
		this.getSprite("armor").setHorizontalFlipping(flip);
		this.getSprite("armor_upgrade_back").setHorizontalFlipping(flip);
		this.getSprite("armor_upgrade_front").setHorizontalFlipping(flip);
		this.getSprite("head").setHorizontalFlipping(flip);
		this.getSprite("tattoo_head").setHorizontalFlipping(flip);
		this.getSprite("injury").setHorizontalFlipping(flip);
		this.getSprite("helmet").setHorizontalFlipping(flip);
		this.getSprite("helmet_damage").setHorizontalFlipping(flip);
		this.getSprite("body_blood").setHorizontalFlipping(flip);
		this.getSprite("dirt").setHorizontalFlipping(flip);
		this.getSprite("status_rage").setHorizontalFlipping(flip);
	}

	function onInit()
	{
		this.actor.onInit();
		local b = this.m.BaseProperties;
		b.SurroundedBonus = 10;
		b.IsAffectedByNight = false;
		b.IsAffectedByInjuries = false;
		b.IsImmuneToBleeding = true;
		b.IsImmuneToPoison = true;

		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = ::Const.DefaultMovementAPCost;
		this.m.FatigueCosts = ::Const.DefaultMovementFatigueCost;
		// local app = this.getItems().getAppearance();
		// app.Body = "bust_naked_body_0" + ::Math.rand(0, 2);
		// app.Corpse = app.Body + "_dead";
		this.addSprite("background");
		this.addSprite("socket").setBrush("bust_base_undead");
		this.addSprite("quiver");
		local body = this.addSprite("body");
		// body.setBrush(::Const.Items.Default.PlayerNakedBody);
		body.Saturation = 0.35;
		body.varySaturation(0.1);
		// body.Color = this.createColor("#c1ddaa");
		body.varyColor(0.05, 0.05, 0.05);
		local tattoo_body = this.addSprite("tattoo_body");
		tattoo_body.Saturation = 0.9;
		tattoo_body.setBrightness(0.75);
		local body_injury = this.addSprite("body_injury");
		body_injury.Visible = true;
		body_injury.setBrightness(0.75);
		this.addSprite("armor");
		this.addSprite("surcoat");
		this.addSprite("armor_upgrade_back");
		local body_blood_always = this.addSprite("body_blood_always");
		body_blood_always.setBrush("bust_body_bloodied_01");
		this.addSprite("shaft");
		local head = this.addSprite("head");
		// head.setBrush(::Const.Faces.AllMale[::Math.rand(0, ::Const.Faces.AllMale.len() - 1)]);
		head.Saturation = body.Saturation;
		head.Color = body.Color;
		local tattoo_head = this.addSprite("tattoo_head");
		tattoo_head.Saturation = 0.9;
		tattoo_head.setBrightness(0.75);

		local injury = this.addSprite("injury");
		injury.setBrightness(0.75);

		this.addSprite("helmet");
		this.addSprite("helmet_damage");

		this.addSprite("armor_upgrade_front");
		local body_blood = this.addSprite("body_blood");
		body_blood.setBrush("bust_body_bloodied_02");
		body_blood.Visible = ::Math.rand(1, 100) <= 33;
		local body_dirt = this.addSprite("dirt");
		body_dirt.setBrush("bust_body_dirt_02");
		body_dirt.Visible = ::Math.rand(1, 100) <= 50;
		local rage = this.addSprite("status_rage");
		rage.setBrush("mind_control");
		rage.Visible = false;
		this.addDefaultStatusSprites();
		this.getSprite("arms_icon").setBrightness(0.85);
		this.getSprite("status_rooted").Scale = 0.55;

		local armor = this.getSprite("armor");
		armor.setBrightness(0.75);
		armor.Saturation = 0.7;
		armor.varySaturation(0.2);

		local helmet = this.getSprite("helmet");
		helmet.setBrightness(0.75);
		helmet.Saturation = armor.Saturation;

		local helmet_damage = this.getSprite("helmet_damage");
		helmet_damage.setBrightness(0.75);
		helmet_damage.Saturation = armor.Saturation;

		this.setOrcSpecificSprites();

		local app = this.getItems().getAppearance();
		app.Body = body.getBrush().Name;
		app.Corpse = app.Body + "_dead";

		this.getSprite("injury").setBrush(this.getZombifyBrushNameHead());
		this.getSprite("body_injury").setBrush(this.getZombifyBrushNameBody());

		this.m.Skills.add(::new("scripts/skills/special/double_grip"));
		this.m.Skills.add(::new("scripts/skills/actives/rf_zombie_orc_bite_skill"));
	}
});

