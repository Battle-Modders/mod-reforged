this.perk_rf_whirling_death <- ::inherit("scripts/skills/skill", {
	m = {
		IsForceEnabled = false,
		MinBonus = 0,
		MaxBonus = 25
	},
	function create()
	{
		this.m.ID = "perk.rf_whirling_death";
		this.m.Name = ::Const.Strings.PerkName.RF_WhirlingDeath;
		this.m.Description = ::Const.Strings.PerkDescription.RF_WhirlingDeath;
		this.m.Icon = "ui/perks/rf_whirling_death.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function isEnabled()
	{
		if (this.m.IsForceEnabled)
		{
			return true;
		}

		if (this.getContainer().getActor().isDisarmed()) return false;

		local weapon = this.getContainer().getActor().getMainhandItem();		
		if (weapon == null || !weapon.isWeaponType(::Const.Items.WeaponType.Flail))
		{
			return false;
		}

		return true;
	}
	
	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (this.isEnabled() && (this.m.IsForceEnabled || (_skill.getItem() != null && _skill.getItem().getID() == this.getContainer().getActor().getMainhandItem().getID())))
		{
			_properties.DamageDirectAdd += 0.01 * (_targetEntity == null ? this.m.MaxBonus : ::Math.rand(this.m.MinBonus, this.m.MaxBonus));
		}
	}
});

