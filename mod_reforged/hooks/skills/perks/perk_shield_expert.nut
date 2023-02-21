::mods_hookExactClass("skills/perks/perk_shield_expert", function (o) {
	local onAdded = ::mods_getMember(o, "onAdded");
	::mods_override(o, "onAdded", function() {
		onAdded();
		local shield = this.getContainer().getActor().getOffhandItem();
		if (shield != null) this.onEquip(shield);
	});

	o.onEquip <- function( _item )
	{
		if (_item.isItemType(::Const.Items.ItemType.Shield) && _item.getID().find("buckler") == null)
		{
			_item.addSkill(::new("scripts/skills/actives/rf_cover_ally_skill"));
		}
	}

	local onUpdate = o.onUpdate;
	o.onUpdate = function( _properties )
	{
		onUpdate(_properties);
		if (this.getContainer().getActor().isArmedWithShield()) _properties.FatigueLossOnAnyAttackMult = 0.0;
	}
});
