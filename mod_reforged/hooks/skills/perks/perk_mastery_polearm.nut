::mods_hookExactClass("skills/perks/perk_mastery_polearm", function(o) {
	local onAfterUpdate = ::mods_getMember(o, "onAfterUpdate");
	::mods_override(o, "onAfterUpdate", function( _properties ) {
		onAfterUpdate(_properties);
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
	});
});

