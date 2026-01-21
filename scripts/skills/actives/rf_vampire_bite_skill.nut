this.rf_vampire_bite_skill <- ::inherit("scripts/skills/actives/skill", {
	m = {
		ChanceToHitHeadAdd = 35,
		MeleeSkillAdd = 15
	},
	function create()
	{
		this.m.ID = "actives.rf_vampire_bite";
		this.m.Name = "Bite";
		this.m.Description = "Use your fangs to bite into and feed on your target."
		this.m.KilledString = "Bitten";
		this.m.Icon = "skills/rf_vampire_bite_skill.png";
		this.m.IconDisabled = "skills/rf_vampire_bite_skill_sw.png";
		this.m.Overlay = "rf_vampire_bite_skill";
		this.m.SoundOnUse = [
			"sounds/enemies/vampire_idle_01.wav",
			"sounds/enemies/vampire_idle_02.wav",
			"sounds/enemies/vampire_idle_03.wav",
			"sounds/enemies/vampire_hurt_01.wav",
			"sounds/enemies/vampire_hurt_02.wav"
		];
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsAttack = true;
		this.m.InjuriesOnBody = ::Const.Injury.CuttingAndPiercingBody;
		this.m.InjuriesOnHead = ::Const.Injury.CuttingAndPiercingHead;
		this.m.DirectDamageMult = 0.5;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 10;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.AIBehaviorID = ::Const.AI.Behavior.ID.AttackDefault;
	}

	function isUsable()
	{
		local actor = this.getContainer().getActor();
		return (actor.getMainhandItem() == null || actor.isDisarmed()) && this.skill.isUsable();
	}

	function getTooltip()
	{
		local ret = this.skill.getDefaultTooltip();

		if (this.m.ChanceToHitHeadAdd != 0)
		{
			ret.push({
				id = 10, type = "text", icon = "ui/icons/chance_to_hit_head.png",
				text = "Has " + ::MSU.Text.colorizeValue(this.m.ChanceToHitHeadAdd, {AddSign = true}) + " chance to hit the head"
			});
		}

		return ret;
	}

	function onUse( _user, _targetTile )
	{
		return this.attackEntity(_user, _targetTile.getEntity());
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			// Remove the effect on damage from equipped weapon
			// We basically revert the changes that the weapon applies inside weapon.onUpdateProperties.
			local weapon = this.getContainer().getActor().getMainhandItem();
			if (weapon != null)
			{
				_properties.DamageRegularMin -= weapon.m.RegularDamage;
				_properties.DamageRegularMax -= weapon.m.RegularDamageMax;
				_properties.DamageArmorMult /= weapon.m.ArmorDamageMult;
				_properties.DamageDirectAdd -= weapon.m.DirectDamageAdd;
				_properties.HitChance[::Const.BodyPart.Head] -= weapon.m.ChanceToHitHead;
			}

			// Then add the damage of this skill.
			_properties.DamageRegularMin += 20;
			_properties.DamageRegularMax += 35;
			_properties.DamageArmorMult *= 0.5;
			_properties.HitChance[::Const.BodyPart.Head] += this.m.ChanceToHitHeadAdd;
			_properties.MeleeSkill += this.m.MeleeSkillAdd;
			this.m.HitChanceBonus += MeleeSkillAdd;
		}
	}
});
