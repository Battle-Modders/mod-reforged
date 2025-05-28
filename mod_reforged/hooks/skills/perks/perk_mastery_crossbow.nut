::Reforged.HooksMod.hook("scripts/skills/perks/perk_mastery_crossbow", function(q) {
	q.onAdded = @(__original) { function onAdded()
	{
		__original();
		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon != null)
		{
			this.onEquip(weapon);
		}
	}}.onAdded;

	q.onEquip = @(__original) { function onEquip( _item )
	{
		__original(_item);
		if (_item.isItemType(::Const.Items.ItemType.Weapon) && (_item.isWeaponType(::Const.Items.WeaponType.Crossbow) || _item.isWeaponType(::Const.Items.WeaponType.Firearm)))
		{
			// This check is a way to ensure that we are equipping a crossbow/handgonne and not a firearm like Firelance
			if (::MSU.isIn("isLoaded", _item, true))
			{
				_item.addSkill(::new("scripts/skills/actives/rf_take_aim_skill"));
			}
		}
	}}.onEquip;

	q.onAfterUpdate = @() { function onAfterUpdate( _properties )
	{
		local reload = this.getContainer().getSkillByID("actives.reload_bolt");
		if (reload != null && reload.m.ActionPointCost > 4 && reload.getBaseValue("ActionPointCost") > 4)
			reload.m.ActionPointCost -= 1;
	}}.onAfterUpdate;
});
