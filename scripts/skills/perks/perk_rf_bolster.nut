this.perk_rf_bolster <- ::inherit("scripts/skills/skill", {
	m = {
		RequiredWeaponType = null,
		RequiredWeaponReach = 6
	},
	function create()
	{
		this.m.ID = "perk.rf_bolster";
		this.m.Name = ::Const.Strings.PerkName.RF_Bolster;
		this.m.Description = ::Const.Strings.PerkDescription.RF_Bolster;
		this.m.Icon = "ui/perks/rf_bolster.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	// Given to adjacent allies on morale checks via a hook on actor.checkMorale
	function getResolveBonus()
	{
		this.getContainer().getActor().getCurrentProperties().getMeleeSkill() * 0.2;
	}

	function isEnabled()
	{
		if (this.m.RequiredWeaponType == null)
			return true;

		if (this.getContainer().getActor().isDisarmed())
			return false;

		local weapon = this.getContainer().getActor().getMainhandItem();
		return !::MSU.isNull(weapon) && weapon.isItemType(::Const.Items.ItemType.Weapon) && weapon.isWeaponType(this.m.RequiredWeaponType) && weapon.getReach() >= this.m.RequiredWeaponReach;
	}
});
