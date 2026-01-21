this.rf_hollenhund <- ::inherit("scripts/entity/tactical/actor", {
	m = {
		BodyAlphaMin = 145,
		BodyAlphaMax = 255,
		BodyFadeSpeed = 2 // larger number is SLOWER

		// Private
		DistortTargetA = null,
		DistortTargetPrevA = ::createVec(0, 0),
		DistortAnimationStartTimeA = 0,
		DistortTargetB = null,
		DistortTargetPrevB = ::createVec(0, 0),
		DistortAnimationStartTimeB = 0,
		DistortTargetC = null,
		DistortTargetPrevC = ::createVec(0, 0),
		DistortAnimationStartTimeC = 0,
		BodyBlurAlpha = 80,
		AlphaBeforeMove = 255,
		NextAlphaTime = 0,
		AlphaChange = 1,
		Variant = 1
	},
	function create()
	{
		this.m.Type = ::Const.EntityType.RF_Hollenhund;
		this.m.BloodType = ::Const.BloodType.None;
		this.m.MoraleState = ::Const.MoraleState.Ignore;
		this.m.XP = ::Const.Tactical.Actor.RF_Hollenhund.XP;
		this.actor.create();
		this.m.Sound[::Const.Sound.ActorEvent.Death] = [
			"sounds/enemies/rf_hollenhund_death_01.wav",
			"sounds/enemies/rf_hollenhund_death_02.wav"
		];
		this.m.Sound[::Const.Sound.ActorEvent.DamageReceived] = [
			"sounds/enemies/rf_hollenhund_hurt_01.wav",
			"sounds/enemies/rf_hollenhund_hurt_02.wav",
			"sounds/enemies/rf_hollenhund_hurt_03.wav"
		];
		this.m.Sound[::Const.Sound.ActorEvent.Idle] = [
			"sounds/enemies/rf_hollenhund_idle_01.wav",
			"sounds/enemies/rf_hollenhund_idle_02.wav"
		];
		this.m.Sound[::Const.Sound.ActorEvent.Move] = [
			"sounds/enemies/rf_hollenhund_move_01.wav",
			"sounds/enemies/rf_hollenhund_move_02.wav",
			"sounds/enemies/rf_hollenhund_move_03.wav",
			"sounds/enemies/rf_hollenhund_move_04.wav",
			"sounds/enemies/rf_hollenhund_move_05.wav"
		];
		this.m.SoundPitch = ::Math.rand(90, 110) * 0.01;
		this.getFlags().add("undead");
		this.getFlags().add("ghost");
		this.m.AIAgent = ::new("scripts/ai/tactical/agents/rf_hollenhund_agent");
		this.m.AIAgent.setActor(this);

		this.m.Variant = ::Math.rand(1, 3);
	}

	function onInit()
	{
		this.actor.onInit();
		this.setRenderCallbackEnabled(true);
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.RF_Hollenhund);

		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = ::Const.SameMovementAPCost;
		this.m.FatigueCosts = ::Const.DefaultMovementFatigueCost;
		this.m.MaxTraversibleLevels = 3;

		local bodyBrushName = "bust_rf_hollenhund_0" + this.m.Variant;

		this.m.Items.getAppearance().Body = bodyBrushName;
		this.addSprite("socket").setBrush("bust_base_undead");
		this.addSprite("fog").setBrush("bust_ghost_fog_02");

		local blur_1 = this.addSprite("blur_1");
		blur_1.setBrush(bodyBrushName);
		blur_1.Alpha = this.m.BodyBlurAlpha;

		local body = this.addSprite("body");
		body.setBrush(bodyBrushName);
		body.varySaturation(0.25);
		body.varyColor(0.2, 0.2, 0.2);
		body.Alpha = ::Math.rand(this.m.BodyAlphaMin, this.m.BodyAlphaMax);

		blur_1.Saturation = body.Saturation;
		blur_1.Color = body.Color;

		local injury = this.addSprite("injury");
		injury.setBrush("bust_rf_hollenhund_01_injured");
		injury.Alpha = body.Alpha;
		injury.Visible = false;

		local head = this.addSprite("head");
		head.setBrush(bodyBrushName);
		head.varySaturation(0.25);
		head.varyColor(0.2, 0.2, 0.2);
		head.Visible = false;

		local blur = [
			"bust_rf_hollenhund_spirit_01",
			"bust_rf_hollenhund_spirit_02",
			"bust_rf_hollenhund_spirit_03"
		];

		local blur_2 = this.addSprite("blur_2");
		blur_2.setBrush(blur.remove(::Math.rand(0, blur.len() - 1)));
		blur_2.varySaturation(0.25);
		blur_2.varyColor(0.2, 0.2, 0.2);

		local blur_3 = this.addSprite("blur_3");
		blur_3.setBrush(blur.remove(::Math.rand(0, blur.len() - 1)));
		blur_2.varySaturation(0.25);
		blur_2.varyColor(0.2, 0.2, 0.2);

		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.55;
		this.setSpriteOffset("status_rooted", ::createVec(-5, -5));

		this.m.BaseProperties.Reach = ::Reforged.Reach.Default.BeastMedium;
		this.m.Skills.add(::new("scripts/skills/perks/perk_fearsome"));
		this.m.Skills.add(::new("scripts/skills/racial/ghost_racial"));
		this.m.Skills.add(::new("scripts/skills/racial/skeleton_racial"));
		this.m.Skills.add(::new("scripts/skills/actives/rf_ethereal_bite_skill"));
		this.m.Skills.add(::new("scripts/skills/effects/rf_ethereal_flame_effect"));
	}

	function onDeath( _killer, _skill, _tile, _fatalityType )
	{
		local isGeneratingCorpse = ::Math.rand(1, 100) <= 50;

		if (_tile != null)
		{
			if (isGeneratingCorpse)
			{
				local flip = ::Math.rand(1, 100) <= 50;

				local body = this.getSprite("body");
				local decal = _tile.spawnDetail("bust_rf_hollenhund_01_body_dead", ::Const.Tactical.DetailFlag.Corpse, flip);
				decal.Color = body.Color;
				decal.Saturation = body.Saturation;
				decal.Scale = 0.95;

				if (_fatalityType == ::Const.FatalityType.Decapitated)
				{
					local layers = [
						"bust_rf_hollenhund_01_head_dead"
					];

					local decap = ::Tactical.spawnHeadEffect(this.getTile(), layers, ::createVec(-10, 15),  ::Math.rand(-180, 180), "");
					decap[0].Color = body.Color;
					decap[0].Saturation = body.Saturation;
					decap[0].Scale = 0.95;
				}
				else
				{
					decal = _tile.spawnDetail("bust_rf_hollenhund_01_head_dead", ::Const.Tactical.DetailFlag.Corpse, flip);
					decal.Color = body.Color;
					decal.Saturation = body.Saturation;
					decal.Scale = 0.95;
				}
			}

			local deathLoot = this.getItems().getDroppableLoot(_killer);
			local tileLoot = this.getLootForTile(_killer, deathLoot);
			this.dropLoot(_tile, tileLoot, !flip);

			local effect = {
				Delay = 0,
				Quantity = 12,
				LifeTimeQuantity = 12,
				SpawnRate = 100,
				Brushes = [
					this.getSprite("blur_2").getBrush().Name,
					this.getSprite("blur_3").getBrush().Name
				],
				Stages = [
					{
						LifeTimeMin = 1.0,
						LifeTimeMax = 1.0,
						ColorMin = ::createColor("ffffff5f"),
						ColorMax = ::createColor("ffffff5f"),
						ScaleMin = 1.0,
						ScaleMax = 1.0,
						RotationMin = 0,
						RotationMax = 0,
						VelocityMin = 80,
						VelocityMax = 100,
						DirectionMin = ::createVec(-1.0, -1.0),
						DirectionMax = ::createVec(1.0, 1.0),
						SpawnOffsetMin = ::createVec(-10, -10),
						SpawnOffsetMax = ::createVec(10, 10),
						ForceMin = ::createVec(0, 0),
						ForceMax = ::createVec(0, 0)
					},
					{
						LifeTimeMin = 1.0,
						LifeTimeMax = 1.0,
						ColorMin = ::createColor("ffffff2f"),
						ColorMax = ::createColor("ffffff2f"),
						ScaleMin = 0.9,
						ScaleMax = 0.9,
						RotationMin = 0,
						RotationMax = 0,
						VelocityMin = 80,
						VelocityMax = 100,
						DirectionMin = ::createVec(-1.0, -1.0),
						DirectionMax = ::createVec(1.0, 1.0),
						ForceMin = ::createVec(0, 0),
						ForceMax = ::createVec(0, 0)
					},
					{
						LifeTimeMin = 0.1,
						LifeTimeMax = 0.1,
						ColorMin = ::createColor("ffffff00"),
						ColorMax = ::createColor("ffffff00"),
						ScaleMin = 0.1,
						ScaleMax = 0.1,
						RotationMin = 0,
						RotationMax = 0,
						VelocityMin = 80,
						VelocityMax = 100,
						DirectionMin = ::createVec(-1.0, -1.0),
						DirectionMax = ::createVec(1.0, 1.0),
						ForceMin = ::createVec(0, 0),
						ForceMax = ::createVec(0, 0)
					}
				]
			};
			::Tactical.spawnParticleEffect(false, effect.Brushes, _tile, effect.Delay, effect.Quantity, effect.LifeTimeQuantity, effect.SpawnRate, effect.Stages, ::createVec(0, 40));
		}

		if (isGeneratingCorpse)
		{
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
		}

		this.actor.onDeath(_killer, _skill, _tile, _fatalityType);
	}

	function getLootForTile( _killer, _loot )
	{
		if (_killer == null || _killer.getFaction() == ::Const.Faction.Player || _killer.getFaction() == ::Const.Faction.PlayerAnimals)
		{
			_loot.push(::new("scripts/items/loot/rf_hollenhund_bones_item"));
		}

		return this.actor.getLootForTile(_killer, _loot);
	}

	function generateCorpse( _tile, _fatalityType, _killer )
	{
		local corpse = clone ::Const.Corpse;
		corpse.Faction = this.getFaction();
		corpse.CorpseName = ::Const.Strings.getArticleCapitalized(this.getName()) + this.getName();
		corpse.IsResurrectable = false;
		corpse.IsConsumable = true;
		corpse.Items = this.getItems().prepareItemsForCorpse(_killer);
		corpse.IsHeadAttached = _fatalityType != ::Const.FatalityType.Decapitated;

		if (_tile != null)
		{
			corpse.Tile = _tile;
		}

		return corpse;
	}

	// Somehow vanilla resets the sprite Alpha after the character moves
	// so we save it and restore it onMovementFinish.
	function onMovementStart( _tile, _numTiles )
	{
		this.m.AlphaBeforeMove = this.getSprite("body").Alpha;
		this.actor.onMovementStart(_tile, _numTiles);
	}

	function onMovementFinish( _tile )
	{
		local body = this.getSprite("body");
		body.Alpha = this.m.AlphaBeforeMove;
		this.getSprite("injury").Alpha = body.Alpha;
		this.getSprite("blur_2").Alpha = body.Alpha;
		this.getSprite("blur_3").Alpha = body.Alpha;
		this.getSprite("blur_1").Alpha = this.m.BodyBlurAlpha;
		this.actor.onMovementFinish(_tile);
	}

	function onFactionChanged()
	{
		this.actor.onFactionChanged();
		local flip = this.isAlliedWithPlayer();
		this.getSprite("fog").setHorizontalFlipping(flip);
		this.getSprite("body").setHorizontalFlipping(flip);
		this.getSprite("head").setHorizontalFlipping(flip);
		this.getSprite("injury").setHorizontalFlipping(flip);
		this.getSprite("blur_1").setHorizontalFlipping(flip);
		this.getSprite("blur_2").setHorizontalFlipping(flip);
		this.getSprite("blur_3").setHorizontalFlipping(flip);
	}

	function onRender()
	{
		this.actor.onRender();

		local body = this.getSprite("body");
		if (body.Alpha >= this.m.BodyAlphaMax)
		{
			this.m.AlphaChange = -1;
		}
		else if (body.Alpha <= this.m.BodyAlphaMin)
		{
			this.m.AlphaChange = 1;
		}

		if (::Time.getVirtualTimeF() > this.m.NextAlphaTime)
		{
			this.m.NextAlphaTime = ::Time.getVirtualTimeF() + this.m.BodyFadeSpeed;
			this.m.AlphaChange *= ::Math.rand(1, 100) < 5 ? -1 : 1;
			body.Alpha = body.Alpha + this.m.AlphaChange;
			this.getSprite("injury").Alpha = body.Alpha;
			this.getSprite("blur_2").Alpha = body.Alpha;
			this.getSprite("blur_3").Alpha = body.Alpha;
		}

		if (this.m.DistortTargetA == null)
		{
			this.m.DistortTargetA = ::createVec(::Math.rand(0, 8) - 4, ::Math.rand(0, 8) - 4);
			this.m.DistortAnimationStartTimeA = ::Time.getVirtualTimeF();
		}

		if (this.moveSpriteOffset("blur_1", this.m.DistortTargetPrevA, this.m.DistortTargetA, 3.8, this.m.DistortAnimationStartTimeA))
		{
			this.m.DistortAnimationStartTimeA = ::Time.getVirtualTimeF();
			this.m.DistortTargetPrevA = this.m.DistortTargetA;
			this.m.DistortTargetA = ::createVec(::Math.rand(0, 8) - 4, ::Math.rand(0, 8) - 4);
		}

		if (this.m.DistortTargetB == null)
		{
			this.m.DistortTargetB = ::createVec(::Math.rand(0, 3) - 2, ::Math.rand(0, 3) - 2);
			this.m.DistortAnimationStartTimeB = ::Time.getVirtualTimeF();
		}

		local blur_2 = this.moveSpriteOffset("blur_2", this.m.DistortTargetPrevB, this.m.DistortTargetB, 3, this.m.DistortAnimationStartTimeB);
		local blur_3 = this.moveSpriteOffset("blur_3", this.m.DistortTargetPrevB, this.m.DistortTargetB, 3, this.m.DistortAnimationStartTimeB)

		if (blur_2 && blur_3)
		{
			this.m.DistortAnimationStartTimeB = ::Time.getVirtualTimeF();
			this.m.DistortTargetPrevB = this.m.DistortTargetB;
			this.m.DistortTargetB = ::createVec(::Math.rand(0, 3) - 2, ::Math.rand(0, 3) - 2);
		}
	}
});
