this.rf_whimpering_veil_effect <- ::inherit("scripts/skills/skill", {
	m = {
		LastFrameApplied = 0,
		IsBlockingDamage = false,

		MoraleStateRequired = ::Const.MoraleState.Confident
	},
	function create()
	{
		this.m.ID = "effects.rf_whimpering_veil";
		this.m.Name = "Whimpering Veil";
		this.m.Description = "Mourn with me.";
		this.m.Icon = "skills/rf_whimpering_veil_effect.png";
		this.m.Overlay = "rf_whimpering_veil_effect";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.SoundOnUse = [
			"sounds/enemies/rf_whimpering_veil_01.wav",
			"sounds/enemies/rf_whimpering_veil_02.wav",
			"sounds/enemies/rf_whimpering_veil_03.wav"
		];
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("Melee attackers must pass [morale checks|Concept.Morale] equal to the number of [morale|Concept.Morale] states they are below " + ::Const.MoraleStateName[this.m.MoraleStateRequired] " in order to do damage")
		});
		ret.push({
			id = 11,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("Melee attackers suffering from [Grieving Malaise|Skill+rf_grieving_malaise_effect] must pass an additional [morale check|Concept.Morale]")
		});
		return ret;
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		// onBeforeDamageReceived is called from bulidPropertiesForBeingHit which can be called
		// even outside an attack. Therefore, the MV_CurrentAttackInfo check here ensures that
		// we only do the subsequent logic during an actual attack.
		if (::Tactical.State.MV_getCurrentAttackInfo() == null || _attacker == null || _skill == null || !this.isSkillValid(_skill))
			return;

		if (this.m.LastFrameApplied == ::Time.getFrame())
			return;

		this.m.IsBlockingDamage = false;

		local numMoraleChecks = this.getNumMoraleChecksRequired(_attacker);
		for (local i = 0; i < numMoraleChecks; i++)
		{
			if (!_attacker.checkMorale(0, ::Const.Morale.RallyBaseDifficulty))
			{
				_properties.DamageReceivedTotalMult = 0.0;
				this.m.IsBlockingDamage = true;
				return;
			}
		}
	}

	function onDamageReceived( _attacker, _damageHitpoints, _damageArmor )
	{
		if (!this.m.IsBlockingDamage)
			return;

		this.m.IsBlockingDamage = false;
		this.m.LastFrameApplied = ::Time.getFrame();

		local actor = this.getContainer().getActor();
		if (!_attacker.isHiddenToPlayer() || !actor.isHiddenToPlayer())
		{
			::Tactical.EventLog.logEx(::Const.UI.getColorizedEntityName(_attacker) + " fails to pierce " + ::Const.UI.getColorizedEntityName(actor) + "\'s " + this.getName());
			::Sound.play(::MSU.Array.rand(this.m.SoundOnUse), ::Const.Sound.Volume.Skill * (::Math.rand(75, 100) * 0.01), actor.getPos());
		}

		if (!actor.isHiddenToPlayer() && actor.isPlacedOnMap())
		{
			this.spawnIcon(this.m.Overlay, actor.getTile());

			local effect = {
				Delay = 0,
				Quantity = 12,
				LifeTimeQuantity = 12,
				SpawnRate = 100,
				Brushes = [
					actor.getSprite("fog").getBrush().Name
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
			::Tactical.spawnParticleEffect(false, effect.Brushes, actor.getTile(), effect.Delay, effect.Quantity, effect.LifeTimeQuantity, effect.SpawnRate, effect.Stages, ::createVec(0, 40));
		}
	}

	// MSU Function
	function onGetHitFactorsAsTarget( _skill, _targetTile, _tooltip )
	{
		if (!this.isSkillValid(_skill))
			return;

		local numMoraleChecks = this.getNumMoraleChecksRequired(_skill.getContainer().getActor());
		if (numMoraleChecks != 0)
		{
			_tooltip.push({
				icon = "ui/tooltips/negative.png", // ::Reforged.Mod.Tooltips.parseString(::Reforged.NestedTooltips.getNestedPerkImage(this))
				text = ::Reforged.Mod.Tooltips.parseString(::Reforged.NestedTooltips.getNestedSkillName(this) + " x" + numMoraleChecks)
			});
		}
	}

	// New function
	function getNumMoraleChecksRequired( _attacker )
	{
		if (_attacker.getMoraleState() == ::Const.MoraleState.Ignore)
			return 0;

		local ret = ::Math.max(0, this.m.MoraleStateRequired - _attacker.getMoraleState());
		if (_attacker.getSkills().hasSkill("effects.rf_grieving_malaise"))
		{
			ret++;
		}
		return ret;
	}

	function isSkillValid( _skill )
	{
		return _skill.isAttack() && !_skill.isRanged();
	}
});
