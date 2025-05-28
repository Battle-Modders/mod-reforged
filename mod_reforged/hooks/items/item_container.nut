::Reforged.HooksMod.hook("scripts/items/item_container", function(q) {
	q.equip = @(__original) { function equip( _item )
	{
		// Disallow equipping invalid weapons in the Old Swordmaster origin
		if ("Assets" in ::World && !::MSU.isNull(::World.Assets) && !::MSU.isNull(::World.Assets.getOrigin()) && ::World.Assets.getOrigin().getID() == "scenario.rf_old_swordmaster")
		{
			local effect;
			foreach (skill in this.getActor().getSkills().m.Skills)
			{
				if (::MSU.isKindOf(skill, "rf_old_swordmaster_scenario_abstract_effect"))
				{
					if (!skill.isWeaponAllowed(_item))
						return false;
					break;
				}
			}
		}

		return __original(_item);
	}}.equip;

	// Overwrite vanilla function completely because we use our custom checks for loot drop
	q.canDropItems = @() { function canDropItems( _killer )
	{
		return this.getActor().RF_canDropLootForPlayer(_killer);
	}}.canDropItems;
});
