::Reforged.HooksMod.hook(::DynamicPerks.Class.PerkTree, function(q) {
	q.m.RF_ProjectedAttributesAvg <- null;

	q.RF_setupProjectedAttributesAvg <- { function RF_setupProjectedAttributesAvg()
	{
		this.m.RF_ProjectedAttributesAvg = this.getActor().getProjectedAttributes();
		::MSU.Table.apply(this.m.RF_ProjectedAttributesAvg, @(_, _entry) (_entry[0] + _entry[1]) * 0.5);
	}}.RF_setupProjectedAttributesAvg;

	q.RF_getProjectedAttributesAvg <- { function RF_getProjectedAttributesAvg()
	{
		if (this.m.RF_ProjectedAttributesAvg == null)
			this.RF_setupProjectedAttributesAvg();
		return this.m.RF_ProjectedAttributesAvg;
	}}.RF_getProjectedAttributesAvg;

	q.getPerkGroupMultiplierSources_All = @(__original) { function getPerkGroupMultiplierSources_All()
	{
		// Only if you have many weapon perk groups then we guarantee that you roll the perk group of the weapon you come equipped with
		if (this.getActor().getBackground().getPerkGroupCollectionMin(::DynamicPerks.PerkGroupCategories.findById("pgc.rf_weapon")) <= 3)
			return __original();

		local ret = __original();

		local weapon = this.getActor().getMainhandItem();
		if (!::MSU.isNull(weapon) && weapon.isItemType(::Const.Items.ItemType.Weapon))
		{
			local ids = ::Reforged.getWeaponPerkGroups(weapon);
			if (ids.len() != 0)
			{
				local id = ::MSU.Array.rand(ids);
				ret.push({
					function getPerkGroupMultiplier( _groupID, _perkTree )
					{
						if (_groupID == id)
							return -1;
					}
				});
			}
		}

		return ret;
	}}.getPerkGroupMultiplierSources_All;
});
