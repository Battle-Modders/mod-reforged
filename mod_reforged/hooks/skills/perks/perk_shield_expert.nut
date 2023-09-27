::Reforged.HooksMod.hook("scripts/skills/perks/perk_shield_expert", function(q) {
	q.onAdded = @(__original) function()
	{
		__original();
		local shield = this.getContainer().getActor().getOffhandItem();
		if (shield != null) this.onEquip(shield);
	}

	q.onEquip <- function( _item )
	{
		if (_item.isItemType(::Const.Items.ItemType.Shield) && _item.getID().find("buckler") == null)
		{
			_item.addSkill(::new("scripts/skills/actives/rf_cover_ally_skill"));
		}
	}

	q.onUpdate = @(__original) function( _properties )
	{
		__original(_properties);
		if (this.getContainer().getActor().isArmedWithShield()) _properties.FatigueLossOnAnyAttackMult = 0.0;
	}
});
