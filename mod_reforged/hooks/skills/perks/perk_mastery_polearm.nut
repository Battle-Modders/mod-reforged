::Reforged.HooksMod.hook("scripts/skills/perks/perk_mastery_polearm", function(q) {
	q.onAdded = @(__original) function()
	{
		__original();
		this.getContainer().add(::MSU.new("scripts/skills/perks/perk_rf_bolster", function(o) {
			o.m.IsRefundable = false;
			o.m.IsSerialized = false;
		}));
	}

	q.onRemoved = @(__original) function()
	{
		__original();
		this.getContainer().removeByID("perk.rf_bolster");
	}

	q.onAfterUpdate = @(__original) function( _properties )
	{
		__original(_properties);
		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon != null && weapon.isItemType(::Const.Items.ItemType.TwoHanded) && weapon.isItemType(::Const.Items.ItemType.MeleeWeapon))
		{
			foreach (skill in weapon.getSkills())
			{
				 if (skill.m.MaxRange == 2 && skill.m.ActionPointCost > 5)
				 {
					 skill.m.ActionPointCost -= 1;
				 }
			}
		}
	}
});

