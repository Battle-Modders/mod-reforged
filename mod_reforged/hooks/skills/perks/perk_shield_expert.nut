::mods_hookExactClass("skills/perks/perk_shield_expert", function (o) {
	local onAdded = ::mods_getMember(o, "onAdded");
	::mods_override(o, "onAdded", function() {
		onAdded();
		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon != null)
		{
			this.getContainer().getActor().getItems().unequip(weapon);
			this.getContainer().getActor().getItems().equip(weapon);
		}
	});

	o.onEquip <- function( _item )
	{
		if (_item.isItemType(::Const.Items.ItemType.Shield) && _item.getID().find("buckler") == null)
		{
			_item.addSkill(::new("scripts/skills/actives/rf_cover_ally_skill"));
		}
	}
});
