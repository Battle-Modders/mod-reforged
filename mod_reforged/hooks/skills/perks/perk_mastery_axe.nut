::Reforged.HooksMod.hook("scripts/skills/perks/perk_mastery_axe", function(q) {
	q.onAdded <- function()
	{
		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon != null) this.onEquip(weapon);
	}

	q.onEquip <- function( _item )
	{
		if (_item.isItemType(::Const.Items.ItemType.Weapon) && _item.isWeaponType(::Const.Items.WeaponType.Axe))
		{
			_item.addSkill(::new("scripts/skills/actives/rf_bearded_blade_skill"));
			_item.addSkill(::Reforged.new("scripts/skills/actives/rf_hook_shield_skill", function(o) {
				o.m.MaxRange = _item.getRangeMax();
			}));
		}
	}
});
