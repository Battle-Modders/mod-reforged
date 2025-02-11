this.perk_rf_long_reach <- ::inherit("scripts/skills/skill", {
	m = {
		RequiredWeaponType = null,
		RequiredWeaponReach = 7
	},
	function create()
	{
		this.m.ID = "perk.rf_long_reach";
		this.m.Name = ::Const.Strings.PerkName.RF_LongReach;
		this.m.Description = ::Const.Strings.PerkDescription.RF_LongReach;
		this.m.Icon = "ui/perks/perk_rf_long_reach.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
	}

	// Is called from actor.getSurroundCount to check if the character has a valid skill to apply the surround bonus
	function isSkillValid( _skill )
	{
		if (!_skill.isAttack())
			return false;

		local weapon = _skill.getItem();
		if (::MSU.isNull(weapon) || !weapon.isItemType(::Const.Items.ItemType.Weapon))
			return false;

		return weapon.getReach() >= this.m.RequiredWeaponReach && (this.m.RequiredWeaponType == null || weapon.isWeaponType(this.m.RequiredWeaponType));
	}
});
