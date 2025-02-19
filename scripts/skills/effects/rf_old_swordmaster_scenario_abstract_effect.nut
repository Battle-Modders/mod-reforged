this.rf_old_swordmaster_scenario_abstract_effect <- ::inherit("scripts/skills/skill", {
	m = {
		WrongWeaponName = null
	},
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

	function isWeaponAllowed( _weapon )
	{
		return !_weapon.isItemType(::Const.Items.ItemType.MeleeWeapon) || _weapon.isWeaponType(::Const.Items.WeaponType.Sword) || _weapon.getID() == "weapon.player_banner";
	}

	function onEquip( _item )
	{
		if (_item.getSlotType() != ::Const.ItemSlot.Mainhand || !_item.isItemType(::Const.Items.ItemType.MeleeWeapon) || this.getContainer().getActor().isPlacedOnMap())
			return;

		if (!this.isWeaponAllowed(_item))
		{
			this.m.WrongWeaponName = _item.getName();
		}
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		if (this.m.WrongWeaponName != null)
		{
			foreach (bro in ::World.getPlayerRoster().getAll())
			{
				bro.worsenMood(99.0, "Made someone use " + this.m.WrongWeaponName + " instead of Sword!");
			}
			this.m.WrongWeaponName = null;
		}
	}
});
