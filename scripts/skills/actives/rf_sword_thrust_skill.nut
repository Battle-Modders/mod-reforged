this.rf_sword_thrust_skill <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.rf_sword_thrust";
		this.m.Name = "Sword Thrust";
		this.m.Description = "A well placed thrust attack targeted at the gaps in the target\'s armor. Hard to hit, but can bypass the target\'s armor advantage.";
		this.m.KilledString = "Impaled";
		this.m.Icon = "skills/active_30.png";
		this.m.IconDisabled = "skills/active_30_sw.png";
		this.m.Overlay = "active_30";
		this.m.SoundOnUse = [
			"sounds/combat/thrust_01.wav",
			"sounds/combat/thrust_02.wav",
			"sounds/combat/thrust_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/thrust_hit_01.wav",
			"sounds/combat/thrust_hit_02.wav",
			"sounds/combat/thrust_hit_03.wav"
		];
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsAttack = true;
		this.m.IsWeaponSkill = true;
		this.m.InjuriesOnBody = ::Const.Injury.PiercingBody;
		this.m.InjuriesOnHead = ::Const.Injury.PiercingHead;
		this.m.HitChanceBonus = -20;
		this.m.DirectDamageMult = 0.25;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 10;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
	}

	function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/hitchance.png",
			text = "Has " + ::MSU.Text.colorizePercentage(this.m.HitChanceBonus) + " chance to hit"
		});
		return ret;
	}

	function onAfterUpdate( _properties )
	{
		this.m.FatigueCostMult = _properties.IsSpecializedInSwords ? ::Const.Combat.WeaponSpecFatigueMult : 1.0;
	}

	function onUse( _user, _targetTile )
	{
		this.spawnAttackEffect(_targetTile, ::Const.Tactical.AttackEffectThrust);
		return this.attackEntity(_user, _targetTile.getEntity());
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			if (!this.getContainer().getActor().isPlayerControlled()) this.m.HitChanceBonus = 0;

			_properties.MeleeSkill += this.m.HitChanceBonus;
		}
	}
});
