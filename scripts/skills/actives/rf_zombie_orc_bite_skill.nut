this.rf_zombie_orc_bite_skill <- ::inherit("scripts/skills/actives/zombie_bite", {
	m = {},
	function create()
	{
		this.zombie_bite.create();
		this.m.ID = "actives.rf_zombie_orc_bite";
		this.m.SoundOnUse = [
			"sounds/enemies/rf_zombie_orc_bite_01.wav",
			"sounds/enemies/rf_zombie_orc_bite_02.wav",
			"sounds/enemies/rf_zombie_orc_bite_03.wav",
			"sounds/enemies/rf_zombie_orc_bite_04.wav"
		];
	}

	// Overwrite base class function to disable "setting" of damage how vanilla does it.
	// Instead we add the damage in onAnySkillUsed.
	function onUpdate( _properties )
	{
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			// Remove the effect on damage from equipped weapon
			// We basically revert the changes that the weapon applies inside weapon.onUpdateProperties.
			if (!this.getContainer().getActor().isDisarmed())
			{
				local weapon = this.getContainer().getActor().getMainhandItem();
				if (weapon != null)
				{
					_properties.DamageRegularMin -= weapon.m.RegularDamage;
					_properties.DamageRegularMax -= weapon.m.RegularDamageMax;
					_properties.DamageArmorMult /= weapon.m.ArmorDamageMult;
					_properties.DamageDirectAdd -= weapon.m.DirectDamageAdd;
					_properties.HitChance[::Const.BodyPart.Head] -= weapon.m.ChanceToHitHead;
				}
			}

			_properties.DamageRegularMin += 30;
			_properties.DamageRegularMax += 70;
			_properties.DamageArmorMult += 0.7;
			_properties.HitChance[::Const.BodyPart.Head] += 15;
		}
	}
});
