this.rf_banshee <- ::inherit("scripts/entity/tactical/actor", {
	m = {
		DistortTargetA = null,
		DistortTargetPrevA = ::createVec(0, 0),
		DistortAnimationStartTimeA = 0,
		DistortTargetB = null,
		DistortTargetPrevB = ::createVec(0, 0),
		DistortAnimationStartTimeB = 0,
		DistortTargetC = null,
		DistortTargetPrevC = ::createVec(0, 0),
		DistortAnimationStartTimeC = 0,
		DistortTargetD = null,
		DistortTargetPrevD = ::createVec(0, 0),
		DistortAnimationStartTimeD = 0
	},
	function create()
	{
		this.m.Type = ::Const.EntityType.RF_Banshee;
		this.m.BloodType = ::Const.BloodType.None;
		this.m.MoraleState = ::Const.MoraleState.Ignore;
		this.m.XP = ::Const.Tactical.Actor.RF_Banshee.XP;
		// this.m.IsEmittingMovementSounds = false;
		this.actor.create();
		this.m.Sound[::Const.Sound.ActorEvent.DamageReceived] = [
			"sounds/enemies/rf_banshee_hurt_01.wav",
			"sounds/enemies/rf_banshee_hurt_02.wav"
		];
		this.m.Sound[::Const.Sound.ActorEvent.Move] = [
			"sounds/enemies/rf_banshee_move_01.wav",
			"sounds/enemies/rf_banshee_move_02.wav",
			"sounds/enemies/rf_banshee_move_03.wav"
		];
		this.m.Sound[::Const.Sound.ActorEvent.Death] = [
			"sounds/enemies/rf_banshee_death_01.wav",
			"sounds/enemies/rf_banshee_death_02.wav",
			"sounds/enemies/rf_banshee_death_03.wav"
		];
		this.m.Sound[::Const.Sound.ActorEvent.Idle] = [
			"sounds/enemies/rf_banshee_idle_01.wav",
			"sounds/enemies/rf_banshee_idle_02.wav"
			"sounds/enemies/rf_banshee_idle_03.wav"
		];
		this.m.SoundPitch = ::Math.rand(90, 110) * 0.01;
		this.getFlags().add("undead");
		this.getFlags().add("ghost");
		this.m.AIAgent = ::new("scripts/ai/tactical/agents/ghost_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.actor.onInit();

		this.setRenderCallbackEnabled(true);
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.RF_Banshee);

		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = ::Const.SameMovementAPCost;
		this.m.FatigueCosts = ::Const.DefaultMovementFatigueCost;
		this.m.MaxTraversibleLevels = 3;
		local brushName = "bust_rf_banshee_01";
		this.m.Items.getAppearance().Body = brushName;
		this.addSprite("socket").setBrush("bust_base_undead");
		this.addSprite("fog").setBrush("bust_ghost_fog_02");
		local body = this.addSprite("body");
		body.setBrush(brushName);
		body.varySaturation(0.25);
		body.varyColor(0.2, 0.2, 0.2);
		local head = this.addSprite("head");
		head.setBrush(brushName);
		head.varySaturation(0.25);
		head.varyColor(0.2, 0.2, 0.2);
		local blur_1 = this.addSprite("blur_1");
		blur_1.setBrush(brushName);
		blur_1.varySaturation(0.25);
		blur_1.varyColor(0.2, 0.2, 0.2);
		local blur_2 = this.addSprite("blur_2");
		blur_2.setBrush(brushName);
		blur_2.varySaturation(0.25);
		blur_2.varyColor(0.2, 0.2, 0.2);
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.55;
		this.setSpriteOffset("status_rooted", ::createVec(-5, -5));
		this.m.Skills.add(::new("scripts/skills/perks/perk_fearsome"));
		this.m.Skills.add(::new("scripts/skills/racial/ghost_racial"));
		this.m.Skills.add(::new("scripts/skills/actives/ghastly_touch"));
		this.m.Skills.add(::new("scripts/skills/actives/rf_wail_skill"));
		this.m.Skills.add(::new("scripts/skills/effects/rf_whimpering_veil_effect"));
	}

	function makeMiniboss()
	{
		if (!this.actor.makeMiniboss())
			return;

		this.getSprite("miniboss").setBrush("bust_miniboss");

		this.getSkills().add(::new("scripts/skills/perks/perk_nine_lives"));
		this.getSkills().add(::new("scripts/skills/perks/perk_rf_menacing"));
	}

	function onDeath( _killer, _skill, _tile, _fatalityType )
	{
		if (!::Tactical.State.isScenarioMode() && _killer != null && _killer.isPlayerControlled())
		{
			this.updateAchievement("OvercomingFear", 1, 1);
		}

		if (_tile != null)
		{
			local effect = {
				Delay = 0,
				Quantity = 12,
				LifeTimeQuantity = 12,
				SpawnRate = 100,
				Brushes = [
					this.getSprite("body").getBrush().Name
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

		this.actor.onDeath(_killer, _skill, _tile, _fatalityType);
	}

	function onRender()
	{
		this.actor.onRender();

		if (this.m.DistortTargetA == null)
		{
			this.m.DistortTargetA = ::createVec(::Math.rand(0, 8) - 4, ::Math.rand(0, 8) - 4);
			this.m.DistortAnimationStartTimeA = ::Time.getVirtualTimeF();
		}

		if (this.moveSpriteOffset("head", this.m.DistortTargetPrevA, this.m.DistortTargetA, 3.8, this.m.DistortAnimationStartTimeA))
		{
			this.m.DistortAnimationStartTimeA = ::Time.getVirtualTimeF();
			this.m.DistortTargetPrevA = this.m.DistortTargetA;
			this.m.DistortTargetA = ::createVec(::Math.rand(0, 8) - 4, ::Math.rand(0, 8) - 4);
		}

		if (this.m.DistortTargetB == null)
		{
			this.m.DistortTargetB = ::createVec(::Math.rand(0, 8) - 4, ::Math.rand(0, 8) - 4);
			this.m.DistortAnimationStartTimeB = ::Time.getVirtualTimeF();
		}

		if (this.moveSpriteOffset("blur_1", this.m.DistortTargetPrevB, this.m.DistortTargetB, 4.9000001, this.m.DistortAnimationStartTimeB))
		{
			this.m.DistortAnimationStartTimeB = ::Time.getVirtualTimeF();
			this.m.DistortTargetPrevB = this.m.DistortTargetB;
			this.m.DistortTargetB = ::createVec(::Math.rand(0, 8) - 4, ::Math.rand(0, 8) - 4);
		}

		if (this.m.DistortTargetC == null)
		{
			this.m.DistortTargetC = ::createVec(::Math.rand(0, 8) - 4, ::Math.rand(0, 8) - 4);
			this.m.DistortAnimationStartTimeC = ::Time.getVirtualTimeF();
		}

		if (this.moveSpriteOffset("body", this.m.DistortTargetPrevC, this.m.DistortTargetC, 4.3, this.m.DistortAnimationStartTimeC))
		{
			this.m.DistortAnimationStartTimeC = ::Time.getVirtualTimeF();
			this.m.DistortTargetPrevC = this.m.DistortTargetC;
			this.m.DistortTargetC = ::createVec(::Math.rand(0, 8) - 4, ::Math.rand(0, 8) - 4);
		}

		if (this.m.DistortTargetD == null)
		{
			this.m.DistortTargetD = ::createVec(::Math.rand(0, 8) - 4, ::Math.rand(0, 8) - 4);
			this.m.DistortAnimationStartTimeD = ::Time.getVirtualTimeF();
		}

		if (this.moveSpriteOffset("blur_2", this.m.DistortTargetPrevD, this.m.DistortTargetD, 5.5999999, this.m.DistortAnimationStartTimeD))
		{
			this.m.DistortAnimationStartTimeD = ::Time.getVirtualTimeF();
			this.m.DistortTargetPrevD = this.m.DistortTargetD;
			this.m.DistortTargetD = ::createVec(::Math.rand(0, 8) - 4, ::Math.rand(0, 8) - 4);
		}
	}
});
