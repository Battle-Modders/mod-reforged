this.perk_rf_long_reach <- ::inherit("scripts/skills/skill", {
	m = {
		IsForceEnabled = false
	},
	function create()
	{
		this.m.ID = "perk.rf_long_reach";
		this.m.Name = ::Const.Strings.PerkName.RF_LongReach;
		this.m.Description = ::Const.Strings.PerkDescription.RF_LongReach;
		this.m.Icon = "ui/perks/perk_rf_long_reach.png";
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

		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon == null || !weapon.isWeaponType(::Const.Items.WeaponType.Polearm))
		{
			return false;
		}

		return true;
	}
});
