this.rf_great_cleave_skill <- ::inherit("scripts/skills/actives/cleave", {
	m = {},
	function create()
	{
		this.cleave.create();
		this.m.ID = "actives.rf_great_cleave";
		this.m.Name = "Great Cleave";
		this.m.Description = ::Reforged.Mod.Tooltips.parseString("A large overhead cleaving attack that can inflict [bleeding|Skill+bleeding_effect] wounds if there is no armor absorbing the blow and if the target is able to bleed at all.");
		this.m.Icon = "skills/rf_great_cleave_skill.png";
		this.m.IconDisabled = "skills/rf_great_cleave_skill_sw.png";
		this.m.Overlay = "rf_great_cleave_skill";
		this.m.SoundOnUse = [
			"sounds/combat/overhead_strike_01.wav",
			"sounds/combat/overhead_strike_02.wav",
			"sounds/combat/overhead_strike_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/overhead_strike_hit_01.wav",
			"sounds/combat/overhead_strike_hit_02.wav",
			"sounds/combat/overhead_strike_hit_03.wav"
		];
		this.m.ActionPointCost = 6;
		this.m.FatigueCost = 15;
		this.m.AIBehaviorID = ::Const.AI.Behavior.ID.AttackDefault;
		this.m.ChanceDecapitate = 99;
		this.m.ChanceDisembowel = 66;
	}

	function getTooltip()
	{
		local ret = this.cleave.getTooltip();
		foreach (entry in ret)
		{
			if (entry.id == 8)
			{
				entry.text = ::Reforged.Mod.Tooltips.parseString("Inflicts 2 stacks of [Bleeding|Skill+bleeding_effect]")
				break;
			}
		}
		return ret;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this || _skill.getID() == "actives.decapitate")
		{
			_properties.DamageRegularMin += 20;
			_properties.DamageRegularMax += 20;
		}
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		// Apply 1 more stack of bleeding. The first one is applied by vanilla cleave.onUse.
		if (_skill == this && _targetEntity.isAlive() && !_targetEntity.getCurrentProperties().IsImmuneToBleeding && _damageInflictedHitpoints >= ::Const.Combat.MinDamageToApplyBleeding)
		{
			local effect = ::new("scripts/skills/effects/bleeding_effect");
			effect.setDamage(this.getContainer().getActor().getCurrentProperties().IsSpecializedInCleavers ? 10 : 5);
			_targetEntity.getSkills().add(effect);
		}
	}
});
