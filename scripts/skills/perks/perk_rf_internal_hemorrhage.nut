this.perk_rf_internal_hemorrhage <- ::inherit("scripts/skills/skill", {
	m = {
		IsForceEnabled = false,
		PercentageOfDamage = 20
	},
	function create()
	{
		this.m.ID = "perk.rf_internal_hemorrhage";
		this.m.Name = ::Const.Strings.PerkName.RF_InternalHemorrhage;
		this.m.Description = ::Const.Strings.PerkDescription.RF_InternalHemorrhage;
		this.m.Icon = "ui/perks/rf_internal_hemorrhage.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (!_targetEntity.isAlive() || _targetEntity.isDying() || !_skill.isAttack() || (!_skill.getDamageType().contains(::Const.Damage.DamageType.Blunt) && !this.m.IsForceEnabled))
		{
			return;
		}

		if (!_targetEntity.getCurrentProperties().IsImmuneToBleeding && _damageInflictedHitpoints >= ::Const.Combat.MinDamageToApplyBleeding)
		{
			local hemorrhageDamage = ::Math.floor(_damageInflictedHitpoints * this.m.PercentageOfDamage * 0.01);
			if (hemorrhageDamage >= 1)
			{
				local actor = this.getContainer().getActor();
				local effect = ::new("scripts/skills/effects/rf_internal_hemorrhage_effect");
				if (actor.getFaction() == ::Const.Faction.Player || actor.getFaction() == ::Const.Faction.PlayerAnimals)
				{
					effect.setAttacker(actor);
				}
				effect.setDamage(hemorrhageDamage);
				_targetEntity.getSkills().add(effect);
			}
		}
	}

	function onQueryTooltip( _skill, _tooltip )
	{
		if (_skill.isAttack() && (_skill.getDamageType().contains(::Const.Damage.DamageType.Blunt) || this.m.IsForceEnabled))
		{
			_tooltip.push({
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Inflicts internal hemorrhage for [color=" + ::Const.UI.Color.DamageValue + "]" + this.m.PercentageOfDamage + "%[/color] of the damage dealt to Hitpoints"
			});
		}
	}
});
