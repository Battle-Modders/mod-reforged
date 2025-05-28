::Reforged.HooksMod.hook("scripts/skills/perks/perk_mastery_bow", function(q) {
	q.onAdded = @(__original) { function onAdded()
	{
		__original();
		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon != null) this.onEquip(weapon);
	}}.onAdded;

	q.onEquip = @() { function onEquip( _item )
	{
		if (_item.isItemType(::Const.Items.ItemType.Weapon) && _item.isWeaponType(::Const.Items.WeaponType.Bow))
		{
			_item.addSkill(::new("scripts/skills/actives/rf_arrow_to_the_knee_skill"));
		}
	}}.onEquip;
});
