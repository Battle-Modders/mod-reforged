this.rf_undead_injury_receiver_effect <- ::inherit("scripts/skills/skill", {
	m = {
		ReceiveInjuries = true
	},
	function create()
	{
		this.m.ID = "effects.rf_undead_injury_receiver";
		this.m.Name = "";
		this.m.Description = "";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Trait;
		this.m.IsHidden = true;
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		this.m.ReceiveInjuries = false;

		if (_skill != null && _attacker != null && _attacker.getSkills().hasSkill("perk.crippling_strikes"))
		{
			this.m.ReceiveInjuries = true;
		}
	}

	function onDamageReceived( _attacker, _damageHitpoints, _damageArmor )
	{
		if (!this.m.ReceiveInjuries && _damageHitpoints <= 0 && _damageArmor >= 0)
		{
			this.m.ReceiveInjuries = true;
		}
	}

	function onAfterDamageReceived()
	{
		this.m.ReceiveInjuries = true;
	}

	function onUpdate( _properties )
	{
		if (this.m.ReceiveInjuries)
		{
			_properties.IsAffectedByInjuries = true;
			_properties.IsAffectedByFreshInjuries = true;
		}
	}
});
