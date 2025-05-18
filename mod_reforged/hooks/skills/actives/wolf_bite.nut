::Reforged.HooksMod.hook("scripts/skills/actives/wolf_bite", function(q) {
	q.create = @(__original) function()
	{
		__original();
		// Vanilla is missing a description for this skill
		this.m.Description = "Lash at them with your muzzle, biting and tearing apart flesh.";
	}

	// Vanilla doesn't have a getTooltip function defined for this skill
	q.getTooltip = @() function()
	{
		return this.getDefaultTooltip();
	}

	// VanillaFix: Overwrite vanilla function to prevent passive damage modification
	q.onUpdate = @() function( _properties )
	{
	}

	// VanillaFix: Overwrite vanilla function to apply the damage modification to this skill
	q.onAnySkillUsed = @() function( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			// Remove the effect on damage from equipped weapon (relevant for goblin wolfriders)
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

			// Then add the damage of this skill. This is copied from what vanilla does in onUpdate of this skill
			_properties.DamageRegularMin += 20;
			_properties.DamageRegularMax += 40;
			_properties.DamageArmorMult *= 0.4;
		}
	}
});
