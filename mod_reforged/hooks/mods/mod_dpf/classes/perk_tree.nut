::Reforged.HooksMod.hook(::DynamicPerks.Class.PerkTree, function(q) {
	q.m.ProjectedAttributesAvg <- null;

	q.setupProjectedAttributesAvg <- function()
	{
		this.m.ProjectedAttributesAvg = this.getActor().getProjectedAttributes();
		::MSU.Table.apply(this.m.ProjectedAttributesAvg, @(_, _entry) (_entry[0] + _entry[1]) * 0.5);
	}

	q.buildFromDynamicMap = @(__original) function()
	{
		if (!::MSU.isNull(this.getActor()))
		{
			this.setupProjectedAttributesAvg();
		}
		__original();
		this.m.ProjectedAttributesAvg = null;
	}

	q.getProjectedAttributesAvg <- function()
	{
		if (this.m.ProjectedAttributesAvg == null)
			this.setupProjectedAttributesAvg();
		return this.m.ProjectedAttributesAvg;
	}

	q.getPerkGroupMultiplierSources_All = @(__original) function()
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
	}
});
