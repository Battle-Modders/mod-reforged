::mods_hookExactClass("skills/perks/perk_mastery_axe", function (o) {
	o.onAdded <- function()
	{
		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon != null)
		{
			this.getContainer().getActor().getItems().unequip(weapon);
			this.getContainer().getActor().getItems().equip(weapon);
		}
	}

	o.onEquip <- function( _item )
	{
		if (_item.isItemType(::Const.Items.ItemType.Weapon) && _item.isWeaponType(::Const.Items.WeaponType.Axe))
		{
			_item.addSkill(::new("scripts/skills/actives/rf_bearded_blade_skill"));
		}
	}
});
