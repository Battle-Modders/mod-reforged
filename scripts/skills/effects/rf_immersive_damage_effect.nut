this.rf_immersive_damage_effect <- this.inherit("scripts/skills/skill", {
	m = {
		DamageMult = 1.0,
		Roll = 0,		
		IsUpdating = false
	},
	function create()
	{
		this.m.ID = "effects.rf_immersive_damage";
		this.m.Name = "";
		this.m.Description = "";
		this.m.Icon = "";		
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = true;		
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null || !_skill.isAttack() || this.m.IsUpdating)
		{
			return;
		}

		this.m.DamageMult = ::Reforged.ImmersiveDamage.MaxDamageMult;

		this.m.Roll = ::Math.rand(1, 100);
		if (this.m.Roll > 100 - ::Reforged.ImmersiveDamage.ChanceCriticalFailure)
		{
			this.m.DamageMult = ::Reforged.ImmersiveDamage.MinDamageMult;
		}
		else
		{	
			local half = ::Reforged.ImmersiveDamage.ChanceFullDamage / 2.0;
			if (this.m.Roll < 50 - half || this.m.Roll > 50 + half)
			{
				this.m.IsUpdating = true;
				local stdev = ::Math.min(::Reforged.ImmersiveDamage.MaxHitChance, ::Math.max(::Reforged.ImmersiveDamage.MinHitChance, _skill.getHitchance(_targetEntity)));
				this.m.IsUpdating = false;

				this.m.DamageMult = ::Math.maxf(::Reforged.ImmersiveDamage.MinDamageMult, ::MSU.Math.normalDistNorm(this.m.Roll, 50, stdev));
			}
		}

		_properties.DamageTotalMult *= this.m.DamageMult;
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (!_targetEntity.isAlive() || _targetEntity.isDying() || this.getContainer().getActor().isHiddenToPlayer() || !_targetEntity.getTile().IsVisibleForPlayer || (_damageInflictedHitpoints == 0 && _damageInflictedArmor == 0))
		{
			return;
		}

		local goodness = (this.m.DamageMult - ::Reforged.ImmersiveDamage.MinDamageMult) / (::Reforged.ImmersiveDamage.MaxDamageMult - ::Reforged.ImmersiveDamage.MinDamageMult);

		local fluff = "";
		foreach (threshold in ::Reforged.ImmersiveDamage.GoodnessThresholds)
		{
			if (goodness >= threshold.Threshold)
			{
				fluff = _skill.isRanged() ? threshold.FluffRanged : threshold.FluffMelee;
				break;
			}
		}

		local fluffString = fluff.len() > 0 ? fluff[::Math.rand(0, fluff.len() - 1)] : "";

		fluffString += this.m.DamageMult < 1.0 ? " dealing [color=" + ::Const.UI.Color.NegativeValue + "]" + ::Math.floor((1.0 - this.m.DamageMult) * 100) + "%[/color] reduced damage!" : " dealing [color=" + ::Const.UI.Color.PositiveValue + "]no[/color] reduced damage!"

		fluffString = ::MSU.String.replace(fluffString, "targetName", _targetEntity.getName());
		
		::Tactical.EventLog.logEx(::Const.UI.getColorizedEntityName(this.getContainer().getActor()) + fluffString);
	}
});
