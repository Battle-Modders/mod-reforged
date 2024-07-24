this.rf_gouge_skill <- ::inherit("scripts/skills/skill", {
	m = {
		BleedStacks = 3,
		SoundsA = [
			"sounds/combat/cleave_hit_hitpoints_01.wav",
			"sounds/combat/cleave_hit_hitpoints_02.wav",
			"sounds/combat/cleave_hit_hitpoints_03.wav"
		]
	},
	function create()
	{
		this.m.ID = "actives.rf_gouge";
		this.m.Name = "Gouge";
		this.m.Description = ::Reforged.Mod.Tooltips.parseString("A well-placed gouging attack that is likely to inflict debilitating [injuries.|Concept.InjuryTemporary]");
		this.m.KilledString = "Cut down";
		this.m.Icon = "skills/rf_gouge_skill.png";
		this.m.IconDisabled = "skills/rf_gouge_skill_sw.png";
		this.m.Overlay = "rf_gouge_skill";
		this.m.SoundOnUse = [
			"sounds/combat/strike_01.wav",
			"sounds/combat/strike_02.wav",
			"sounds/combat/strike_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/strike_hit_01.wav",
			"sounds/combat/strike_hit_02.wav",
			"sounds/combat/strike_hit_03.wav"
		];
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsAttack = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsTooCloseShown = true;
		this.m.IsWeaponSkill = true;
		this.m.InjuriesOnBody = ::Const.Injury.CuttingBody;
		this.m.InjuriesOnHead = ::Const.Injury.CuttingHead;
		this.m.DirectDamageMult = 0.3;
		this.m.ActionPointCost = 6;
		this.m.FatigueCost = 30;
		this.m.MinRange = 1;
		this.m.MaxRange = 2;
		this.m.ChanceDecapitate = 75;
		this.m.ChanceDisembowel = 50;
		this.m.ChanceSmash = 0;
		this.m.AIBehaviorID = ::Const.AI.Behavior.ID.Gash;
	}

	function getTooltip()
	{
		local ret = this.getDefaultTooltip();

		local injuryThresholdMult = this.getInjuryThresholdMult();
		if (injuryThresholdMult != 1.0)
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = ::Reforged.Mod.Tooltips.parseString("Has a " + ::MSU.Text.colorizeMult(injuryThresholdMult) + " lower [threshold|Concept.InjuryThreshold] to inflict [injuries|Concept.InjuryTemporary]")
			});
		}

		if (this.m.BleedStacks != 0)
		{
			ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Reforged.Mod.Tooltips.parseString("Inflicts " + ::MSU.Text.colorPositive(this.m.BleedStacks) + " stacks of [Bleeding|Skill+bleeding_effect] when dealing at least " + ::MSU.Text.colorNegative(::Const.Combat.MinDamageToApplyBleeding) + " damage")
			});
		}

		return ret;
	}

	function addResources()
	{
		foreach (r in this.m.SoundsA)
		{
			::Tactical.addResource(r);
		}
	}

	function onAfterUpdate( _properties )
	{
		this.m.FatigueCostMult = _properties.IsSpecializedInCleavers ? ::Const.Combat.WeaponSpecFatigueMult : 1.0;
	}

	function onUse( _user, _targetTile )
	{
		this.spawnAttackEffect(_targetTile, ::Const.Tactical.AttackEffectChop);
		return this.attackEntity(_user, _targetTile.getEntity());
	}

	function onBeforeTargetHit( _skill, _targetEntity, _hitInfo )
	{
		if (_skill == this)
		{
			_hitInfo.InjuryThresholdMult *= this.getInjuryThresholdMult();

			if (!_targetEntity.getCurrentProperties().IsImmuneToBleeding)
				::Sound.play(this.m.SoundsA[::Math.rand(0, this.m.SoundsA.len() - 1)], ::Const.Sound.Volume.Skill, this.getContainer().getActor().getPos());
		}
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (_skill == this && _targetEntity.isAlive() && _damageInflictedHitpoints >= ::Const.Combat.MinDamageToApplyBleeding && !_targetEntity.getCurrentProperties().IsImmuneToBleeding && this.m.BleedStacks != 0)
		{
			for (local i = 0; i < this.m.BleedStacks; i++)
			{
				_targetEntity.getSkills().add(::new("scripts/skills/effects/bleeding_effect"));
			}
		}
	}

	function getInjuryThresholdMult()
	{
		return this.getContainer().getActor().getCurrentProperties().IsSpecializedInCleavers ? 0.5 : 0.66;
	}
});
