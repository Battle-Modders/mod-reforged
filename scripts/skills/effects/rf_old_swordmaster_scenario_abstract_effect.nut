this.rf_old_swordmaster_scenario_abstract_effect <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.rf_old_swordmaster_scenario_abstract";
		this.m.Type = ::Const.SkillType.StatusEffect;
	}

	function isEnabled()
	{
		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon != null && weapon.isWeaponType(::Const.Items.WeaponType.Sword) && this.isWeaponAllowed(weapon))
		{
			return true;
		}

		return false;
	}

	// Is used in a hook on `item_container.equip` to disallow equipping invalid weapons
	function isWeaponAllowed( _weapon )
	{
		return !_weapon.isItemType(::Const.Items.ItemType.MeleeWeapon) || _weapon.isWeaponType(::Const.Items.WeaponType.Sword) || _weapon.getID() == "weapon.player_banner";
	}
});
