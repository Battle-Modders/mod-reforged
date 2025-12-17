this.rf_draugr <- ::inherit("scripts/entity/tactical/actor", {
	m = {
		InjuryType = 1,
		Surcoat = null,
		ResurrectionChance = 66,
		ResurrectionValue = 5.0,
		ResurrectWithScript = "scripts/entity/tactical/enemies/zombie",
		IsResurrectingOnFatality = false,
		IsCreatingAgent = true,
		IsHeadless = false
	},
	function create()
	{
		this.m.BloodType = ::Const.BloodType.Dark;
		this.m.MoraleState = ::Const.MoraleState.Ignore;
		this.actor.create();
		this.m.Sound[::Const.Sound.ActorEvent.DamageReceived] = [
			"sounds/enemies/rf_draugr_hurt_01.wav",
			"sounds/enemies/rf_draugr_hurt_02.wav",
			"sounds/enemies/rf_draugr_hurt_03.wav"
		];
		this.m.Sound[::Const.Sound.ActorEvent.Death] = [
			"sounds/enemies/rf_draugr_death_01.wav",
			"sounds/enemies/rf_draugr_death_02.wav"
		];
		this.m.Sound[::Const.Sound.ActorEvent.Resurrect] = [
			"sounds/enemies/rf_draugr_idle_01.wav",
			"sounds/enemies/rf_draugr_idle_02.wav",
			"sounds/enemies/rf_draugr_idle_03.wav",
			"sounds/enemies/rf_draugr_idle_04.wav"
		];
		this.m.Sound[::Const.Sound.ActorEvent.Idle] = [
			"sounds/enemies/rf_draugr_idle_01.wav",
			"sounds/enemies/rf_draugr_idle_02.wav",
			"sounds/enemies/rf_draugr_idle_03.wav",
			"sounds/enemies/rf_draugr_idle_04.wav"
		];
		this.m.Sound[::Const.Sound.ActorEvent.Move] = this.m.Sound[::Const.Sound.ActorEvent.Idle];
		this.m.SoundVolume[::Const.Sound.ActorEvent.Move] = 0.1;
		this.m.SoundPitch = ::Math.rand(70, 120) * 0.01;
		this.getFlags().add("undead");
		// this.getFlags().add("zombie_minion");

		if (this.m.IsCreatingAgent)
		{
			this.m.AIAgent = ::new("scripts/ai/tactical/agents/rf_draugr_agent");
			this.m.AIAgent.setActor(this);
		}
	}

	function getBodyBrushName()
	{
		// 1 in 4 chance to be not skinny
		return "bust_naked_body_0" + (::Math.rand(1, 4) == 1 ? "2" : "0");
	}

	function onInit()
	{
		this.actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.RF_DraugrThrall);
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
		local app = this.getItems().getAppearance();
		local bodyBrush = this.getBodyBrushName();
		// app.Body = "bust_naked_body_0" + ::Math.rand(0, 2);
		app.Body = bodyBrush;
		app.Corpse = app.Body + "_dead";
		// this.m.InjuryType = ::Math.rand(1, 4);
		this.m.InjuryType = ::Math.rand(1, 9);
		local hairColor = ::MSU.Array.rand(::Const.HairColors.RF_Draugr);
		this.addSprite("background");
		this.addSprite("socket").setBrush("bust_base_rf_draugr_01");
		this.addSprite("quiver").setHorizontalFlipping(true);
		local body = this.addSprite("body");
		body.setHorizontalFlipping(true);
		body.setBrush(bodyBrush);
		body.setBrightness(0.85);
		body.Saturation = 0.2;
		body.varySaturation(0.1);
		body.Color = this.createColor("#f9e3ff");
		body.varyColor(0.05, 0.05, 0.05);

		local draugr_body = this.addSprite("rf_draugr_body");
		draugr_body.Visible = ::Math.rand(1, 100) <= 70;
		draugr_body.setHorizontalFlipping(true);
		draugr_body.setBrightness(0.75);
		draugr_body.setBrush("rf_draugr_body_layer_0" + ::Math.rand(1, 3));

		local tattoo_body = this.addSprite("tattoo_body");
		tattoo_body.setHorizontalFlipping(true);
		tattoo_body.Saturation = 0.9;
		tattoo_body.setBrightness(0.75);
		if (::Math.rand(1, 100) <= 50)
		{
			tattoo_body.setBrush("rf_draugr_tattoo_body_0" + ::Math.rand(1, 4));
		}

		local body_injury = this.addSprite("body_injury");
		body_injury.setBrush("zombify_body_02");
		body_injury.Saturation = body.Saturation * 2;
		body_injury.Visible = false;

		this.addSprite("armor").setHorizontalFlipping(true);
		this.addSprite("surcoat");
		// TODO Body detail should be accessory items maybe? So they have proper dead variants and damaged variants?
		local body_detail = this.addSprite("body_detail");
		body_detail.setHorizontalFlipping(true);
		if (::Math.rand(1, 100) <= 33)
		{
			body_detail.setBrush("rf_draugr_accessory_0" + ::Math.rand(1, 3));
		}

		this.addSprite("armor_upgrade_back");
		local body_blood_always = this.addSprite("body_blood_always");
		body_blood_always.setBrush("bust_body_bloodied_01");
		body_blood_always.setHorizontalFlipping(true);
		body_blood_always.Visible = ::Math.rand(1, 100) <= 33;
		body_blood_always.Saturation = body.Saturation * 2;

		this.addSprite("shaft");
		local head = this.addSprite("head");
		head.setHorizontalFlipping(true);
		head.setBrush(::Const.Faces.SmartMale[::Math.rand(0, ::Const.Faces.SmartMale.len() - 1)]);
		head.Saturation = body.Saturation;
		head.Color = body.Color;

		local draugr_head = this.addSprite("rf_draugr_head");
		draugr_head.setHorizontalFlipping(true);
		draugr_head.setBrush("rf_draugr_head_layer_0" + this.m.InjuryType);
		draugr_head.setBrightness(0.75);

		local tattoo_head = this.addSprite("tattoo_head");
		tattoo_head.setHorizontalFlipping(true);
		tattoo_head.Saturation = 0.9;
		tattoo_head.setBrightness(0.75);
		if (::Math.rand(1, 100) <= 50)
		{
			tattoo_head.setBrush("rf_draugr_tattoo_head_0" + ::Math.rand(1,5));
		}

		local beard = this.addSprite("beard");
		beard.setHorizontalFlipping(true);
		beard.varyColor(0.02, 0.02, 0.02);

		if (::Math.rand(1, 100) <= 50)
		{
			beard.setBrush("beard_" + hairColor + "_" + ::Const.Beards.ZombieOnly[::Math.rand(0, ::Const.Beards.ZombieOnly.len() - 1)]);
		}

		local injury = this.addSprite("injury");
		injury.setHorizontalFlipping(true);
		injury.setBrightness(0.75);
		injury.Saturation = body.Saturation * 2;
		injury.Visible = false;

		local hair = this.addSprite("hair");
		hair.setHorizontalFlipping(true);
		hair.Color = beard.Color;

		if (::Math.rand(1, 100) <= 50)
		{
			hair.setBrush("hair_" + hairColor + "_" + ::Const.Hair.Vampire[::Math.rand(0, ::Const.Hair.Vampire.len() - 1)]);
		}

		this.addSprite("helmet").setHorizontalFlipping(true);
		this.addSprite("helmet_damage").setHorizontalFlipping(true);
		local beard_top = this.addSprite("beard_top");
		beard_top.setHorizontalFlipping(true);

		if (beard.HasBrush && this.doesBrushExist(beard.getBrush().Name + "_top"))
		{
			beard_top.setBrush(beard.getBrush().Name + "_top");
			beard_top.Color = beard.Color;
		}

		this.addSprite("armor_upgrade_front");
		local body_blood = this.addSprite("body_blood");
		// body_blood.setBrush("bust_body_bloodied_01");
		// body_blood.setHorizontalFlipping(true);
		// body_blood.Visible = ::Math.rand(1, 100) <= 33;
		local body_dirt = this.addSprite("dirt");
		body_dirt.setBrush("bust_body_dirt_02");
		body_dirt.setHorizontalFlipping(true);
		body_dirt.Visible = ::Math.rand(1, 100) <= 50;
		local rage = this.addSprite("status_rage");
		rage.setHorizontalFlipping(true);
		rage.setBrush("mind_control");
		rage.Visible = false;
		this.addDefaultStatusSprites();
		this.getSprite("arms_icon").setBrightness(0.85);
		this.getSprite("status_rooted").Scale = 0.55;

		this.m.Skills.add(::new("scripts/skills/special/double_grip"));
		this.m.Skills.add(::new("scripts/skills/actives/hand_to_hand"));
		this.m.Skills.add(::new("scripts/skills/racial/rf_draugr_racial"));
		this.m.Skills.add(::new("scripts/skills/effects/rf_frostbound_effect"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_menacing"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_hold_out"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_vigorous_assault"));

		this.m.ExcludedInjuries.extend(::Const.Injury.ExcludedInjuries.get(::Const.Injury.ExcludedInjuries.RF_Undead));
	}

	function makeMiniboss()
	{
		if (!this.actor.makeMiniboss())
			return false;

		this.getSprite("miniboss").setBrush("bust_miniboss");
		return true;
	}

	function onFactionChanged()
	{
		this.actor.onFactionChanged();
		local flip = !this.isAlliedWithPlayer();
		this.getSprite("background").setHorizontalFlipping(flip);
		this.getSprite("shaft").setHorizontalFlipping(flip);
		this.getSprite("surcoat").setHorizontalFlipping(flip);
		this.getSprite("quiver").setHorizontalFlipping(flip);
		this.getSprite("body").setHorizontalFlipping(flip);
		this.getSprite("tattoo_body").setHorizontalFlipping(flip);
		this.getSprite("armor").setHorizontalFlipping(flip);
		this.getSprite("body_detail").setHorizontalFlipping(flip);
		this.getSprite("armor_upgrade_back").setHorizontalFlipping(flip);
		this.getSprite("armor_upgrade_front").setHorizontalFlipping(flip);
		this.getSprite("head").setHorizontalFlipping(flip);
		this.getSprite("tattoo_head").setHorizontalFlipping(flip);
		this.getSprite("injury").setHorizontalFlipping(flip);
		this.getSprite("beard").setHorizontalFlipping(flip);
		this.getSprite("hair").setHorizontalFlipping(flip);
		this.getSprite("helmet").setHorizontalFlipping(flip);
		this.getSprite("helmet_damage").setHorizontalFlipping(flip);
		this.getSprite("beard_top").setHorizontalFlipping(flip);
		this.getSprite("body_blood").setHorizontalFlipping(flip);
		this.getSprite("dirt").setHorizontalFlipping(flip);
		this.getSprite("status_rage").setHorizontalFlipping(flip);
		this.getSprite("rf_draugr_body").setHorizontalFlipping(flip);
		this.getSprite("rf_draugr_head").setHorizontalFlipping(flip);
	}

	function onUpdateInjuryLayer()
	{
		local draugr_head = this.getSprite("rf_draugr_head");
		local p = this.getHitpointsPct();

		if (p > 0.5)
		{
			if (draugr_head.getBrush().Name != "rf_draugr_head_layer_0" + this.m.InjuryType)
			{
				draugr_head.setBrush("rf_draugr_head_layer_0" + this.m.InjuryType);
			}
			this.getSprite("body_injury").Visible = false;
		}
		else
		{
			if (draugr_head.getBrush().Name != "rf_draugr_head_layer_0" + this.m.InjuryType + "_injured")
			{
				draugr_head.setBrush("rf_draugr_head_layer_0" + this.m.InjuryType + "_injured");
			}
			this.getSprite("body_injury").Visible = true;
		}

		this.setDirty(true);
	}

	function assignRandomEquipment()
	{
	}

	function onDeath( _killer, _skill, _tile, _fatalityType )
	{
		local flip = ::Math.rand(0, 100) < 50;
		this.m.IsCorpseFlipped = flip;

		this.spawnTileDetail(_tile, _skill, _fatalityType, flip);

		local deathLoot = this.getItems().getDroppableLoot(_killer);
		local tileLoot = this.getLootForTile(_killer, deathLoot);
		this.dropLoot(_tile, tileLoot, !flip);
		local corpse = this.generateCorpse(_tile, _fatalityType, _killer);

		if (_tile == null)
		{
			this.Tactical.Entities.addUnplacedCorpse(corpse);
		}
		else
		{
			_tile.Properties.set("Corpse", corpse);
			this.Tactical.Entities.addCorpse(_tile);
		}

		this.actor.onDeath(_killer, _skill, _tile, _fatalityType);
	}

	function spawnTileDetail( _tile, _skill, _fatalityType, _flip = false )
	{
		if (_tile == null)
			return;

		local appearance = this.getItems().getAppearance();
		local sprite_body = this.getSprite("body");
		local body_injury = this.getSprite("body_injury");
		local sprite_head = this.getSprite("head");
		local sprite_hair = this.getSprite("hair");
		local sprite_beard = this.getSprite("beard");
		local sprite_beard_top = this.getSprite("beard_top");
		local tattoo_body = this.getSprite("tattoo_body");
		local tattoo_head = this.getSprite("tattoo_head");

		local rf_draugr_head = this.getSprite("rf_draugr_head");
		local rf_draugr_body = this.getSprite("rf_draugr_body");
		local offset = ::Const.Combat.HumanCorpseOffset;

		// local decal;

		local decal = _tile.spawnDetail(sprite_body.getBrush().Name + "_dead", ::Const.Tactical.DetailFlag.Corpse, _flip, false, offset);
		decal.Color = sprite_body.Color;
		decal.Saturation = sprite_body.Saturation;
		decal.Scale = 0.9;
		decal.setBrightness(0.9);

		if (body_injury.HasBrush)
		{
			local decal = _tile.spawnDetail(body_injury.getBrush().Name + "_dead", ::Const.Tactical.DetailFlag.Corpse, _flip, false, offset);
			decal.Color = body_injury.Color;
			decal.Saturation = body_injury.Saturation;
			decal.Scale = 0.9;
			decal.setBrightness(0.9);
		}

		if (rf_draugr_body.HasBrush)
		{
			local decal = _tile.spawnDetail(rf_draugr_body.getBrush().Name + "_dead", ::Const.Tactical.DetailFlag.Corpse, _flip, false, offset);
			decal.Color = rf_draugr_body.Color;
			decal.Saturation = rf_draugr_body.Saturation;
			decal.Scale = 0.9;
			decal.setBrightness(0.9);
		}

		if (tattoo_body.HasBrush)
		{
			decal = _tile.spawnDetail(tattoo_body.getBrush().Name + "_dead", ::Const.Tactical.DetailFlag.Corpse, _flip, false, offset);
			decal.Color = tattoo_body.Color;
			decal.Saturation = tattoo_body.Saturation;
			decal.Scale = 0.9;
			decal.setBrightness(0.9);
		}

		if (appearance.CorpseArmor != "")
		{
			local decal = _tile.spawnDetail(appearance.CorpseArmor, ::Const.Tactical.DetailFlag.Corpse, _flip, false, offset);
			decal.Scale = 0.9;
			decal.setBrightness(0.9);
		}

		if (this.m.Surcoat != null)
		{
			decal = _tile.spawnDetail("surcoat_" + (this.m.Surcoat < 10 ? "0" + this.m.Surcoat : this.m.Surcoat) + "_dead", ::Const.Tactical.DetailFlag.Corpse, _flip, false, offset);
			decal.Scale = 0.9;
			decal.setBrightness(0.9);
		}

		if (appearance.CorpseArmorUpgradeBack != "")
		{
			decal = _tile.spawnDetail(appearance.CorpseArmorUpgradeBack, ::Const.Tactical.DetailFlag.Corpse, _flip, false, offset);
			decal.Scale = 0.9;
			decal.setBrightness(0.9);
		}

		if (_fatalityType != ::Const.FatalityType.Decapitated && !this.m.IsHeadless)
		{
			if (!appearance.HideCorpseHead)
			{
				local decal = _tile.spawnDetail(sprite_head.getBrush().Name + "_dead", ::Const.Tactical.DetailFlag.Corpse, _flip, false, offset);
				decal.Color = sprite_head.Color;
				decal.Saturation = sprite_head.Saturation;
				decal.Scale = 0.9;
				decal.setBrightness(0.9);

				if (tattoo_head.HasBrush)
				{
					local decal = _tile.spawnDetail(tattoo_head.getBrush().Name + "_dead", ::Const.Tactical.DetailFlag.Corpse, _flip, false, offset);
					decal.Color = tattoo_head.Color;
					decal.Saturation = tattoo_head.Saturation;
					decal.Scale = 0.9;
					decal.setBrightness(0.9);
				}
			}

			if (!appearance.HideBeard && !appearance.HideCorpseHead && sprite_beard.HasBrush)
			{
				local decal = _tile.spawnDetail(sprite_beard.getBrush().Name + "_dead", ::Const.Tactical.DetailFlag.Corpse, _flip, false, offset);
				decal.Color = sprite_beard.Color;
				decal.Saturation = sprite_beard.Saturation;
				decal.Scale = 0.9;
				decal.setBrightness(0.9);

				if (sprite_beard_top.HasBrush)
				{
					local decal = _tile.spawnDetail(sprite_beard_top.getBrush().Name + "_dead", ::Const.Tactical.DetailFlag.Corpse, _flip, false, offset);
					decal.Color = sprite_beard.Color;
					decal.Saturation = sprite_beard.Saturation;
					decal.Scale = 0.9;
					decal.setBrightness(0.9);
				}
			}

			if (!appearance.HideCorpseHead)
			{
				local brushName = rf_draugr_head.getBrush().Name;
				local decal = _tile.spawnDetail(::String.replace(brushName, "_injured", "") + "_dead", ::Const.Tactical.DetailFlag.Corpse, _flip, false, offset);
				decal.Scale = 0.9;
				decal.setBrightness(0.75);
			}

			if (!appearance.HideHair && !appearance.HideCorpseHead && sprite_hair.HasBrush)
			{
				local decal = _tile.spawnDetail(sprite_hair.getBrush().Name + "_dead", ::Const.Tactical.DetailFlag.Corpse, _flip, false, offset);
				decal.Color = sprite_hair.Color;
				decal.Saturation = sprite_hair.Saturation;
				decal.Scale = 0.9;
				decal.setBrightness(0.9);
			}

			if (_fatalityType == ::Const.FatalityType.Smashed)
			{
				local decal = _tile.spawnDetail("bust_head_smashed_02", ::Const.Tactical.DetailFlag.Corpse, _flip, false, offset);
				decal.setBrightness(0.8);
			}
			else if (appearance.HelmetCorpse != "")
			{
				local decal = _tile.spawnDetail(appearance.HelmetCorpse, ::Const.Tactical.DetailFlag.Corpse, _flip, false, offset);
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

			if (!appearance.HideBeard && sprite_beard.HasBrush)
			{
				layers.push(sprite_beard.getBrush().Name + "_dead");
			}

			if (!appearance.HideCorpseHead)
			{
				local brushName = rf_draugr_head.getBrush().Name;
				layers.push(::String.replace(brushName, "_injured", "") + "_dead");
			}

			if (!appearance.HideHair && sprite_hair.HasBrush)
			{
				layers.push(sprite_hair.getBrush().Name + "_dead");
			}

			if (appearance.HelmetCorpse.len() != 0)
			{
				layers.push(appearance.HelmetCorpse);
			}

			if (!appearance.HideBeard && sprite_beard_top.HasBrush)
			{
				layers.push(sprite_beard_top.getBrush().Name + "_dead");
			}

			local decap = this.Tactical.spawnHeadEffect(this.getTile(), layers, ::createVec(0, 0), -90.0, "bust_head_dead_bloodpool_zombified");
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

			if (!appearance.HideBeard && sprite_beard.HasBrush)
			{
				decap[idx].Color = sprite_beard.Color;
				decap[idx].Saturation = sprite_beard.Saturation;
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

			if (!appearance.HideHair && sprite_hair.HasBrush)
			{
				decap[idx].Color = sprite_hair.Color;
				decap[idx].Saturation = sprite_hair.Saturation;
				decap[idx].Scale = 0.9;
				decap[idx].setBrightness(0.9);
				idx = ++idx;
			}

			if (appearance.HelmetCorpse.len() != 0)
			{
				decap[idx].Scale = 0.9;
				decap[idx].setBrightness(0.9);
				idx = ++idx;
			}

			if (!appearance.HideBeard && sprite_beard_top.HasBrush)
			{
				decap[idx].Color = sprite_beard.Color;
				decap[idx].Saturation = sprite_beard.Saturation;
				decap[idx].Scale = 0.9;
				decap[idx].setBrightness(0.9);
			}
		}

		if (_skill && _skill.getProjectileType() == ::Const.ProjectileType.Arrow)
		{
			if (appearance.CorpseArmor != "")
			{
				decal = _tile.spawnDetail(appearance.CorpseArmor + "_arrows", ::Const.Tactical.DetailFlag.Corpse, _flip, false, offset);
			}
			else
			{
				decal = _tile.spawnDetail(appearance.Corpse + "_arrows", ::Const.Tactical.DetailFlag.Corpse, _flip, false, offset);
			}

			decal.Saturation = 0.85;
			decal.setBrightness(0.85);
		}
		else if (_skill && _skill.getProjectileType() == ::Const.ProjectileType.Javelin)
		{
			if (appearance.CorpseArmor != "")
			{
				decal = _tile.spawnDetail(appearance.CorpseArmor + "_javelin", ::Const.Tactical.DetailFlag.Corpse, _flip, false, offset);
			}
			else
			{
				decal = _tile.spawnDetail(appearance.Corpse + "_javelin", ::Const.Tactical.DetailFlag.Corpse, _flip, false, offset);
			}

			decal.Saturation = 0.85;
			decal.setBrightness(0.85);
		}

		if (appearance.CorpseArmorUpgradeFront != "")
		{
			decal = _tile.spawnDetail(appearance.CorpseArmorUpgradeFront, ::Const.Tactical.DetailFlag.Corpse, _flip, false, offset);
			decal.Scale = 0.9;
			decal.setBrightness(0.9);
		}

		this.spawnTerrainDropdownEffect(_tile);
		// this.spawnFlies(_tile);
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
			local hair = this.getSprite("hair");
			local beard = this.getSprite("beard");
			local beard_top = this.getSprite("beard_top");
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
				head.Saturation = 0.5;
				head.varySaturation(0.2);
				head.Color = this.createColor("#c1ddaa");
				head.varyColor(0.05, 0.05, 0.05);

				if (_info.Custom.Ethnicity == 1)
				{
					head.setBrightness(1.25);
				}
			}
			else
			{
				head.Color = _info.Color;
				head.Saturation = _info.Saturation;
			}

			body.Color = head.Color;
			body.Saturation = head.Saturation;

			if (_info.Custom.Hair != null)
			{
				hair.setBrush(_info.Custom.Hair);
				hair.Color = _info.Custom.HairColor;
				hair.Saturation = _info.Custom.HairSaturation;
			}
			else
			{
				hair.resetBrush();
			}

			if (_info.Custom.Beard != null)
			{
				beard.setBrush(_info.Custom.Beard);
				beard.Color = _info.Custom.HairColor;
				beard.Saturation = _info.Custom.HairSaturation;
				beard.setBrightness(0.9);

				if (this.doesBrushExist(_info.Custom.Beard + "_top"))
				{
					beard_top.setBrush(_info.Custom.Beard + "_top");
					beard_top.Color = _info.Custom.HairColor;
					beard_top.Saturation = _info.Custom.HairSaturation;
					beard_top.setBrightness(0.9);
				}
			}
			else
			{
				beard.resetBrush();
				beard_top.resetBrush();
			}

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
		local tile = this.getTile();
		this.pickupMeleeWeaponAndShield(tile);
		this.getSkills().update();
		this.m.XP /= 4;

		foreach (t in ::MSU.Tile.getNeighbors(tile))
		{
			local otherActor = t.getEntity();
			local numEnemies = t.getZoneOfControlCountOtherThan(otherActor.getAlliedFactions());

			if (otherActor.m.MaxEnemiesThisTurn < numEnemies && !otherActor.isAlliedWith(this))
			{
				local difficulty = ::Math.maxf(10.0, 50.0 - this.getXPValue() * 0.2);
				otherActor.checkMorale(-1, difficulty);
				otherActor.m.MaxEnemiesThisTurn = numEnemies;
			}
		}
	}
});
