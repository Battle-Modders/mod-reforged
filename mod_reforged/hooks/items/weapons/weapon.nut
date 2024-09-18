::Reforged.HooksMod.hookTree("scripts/items/weapons/weapon", function(q) {
	q.create = @(__original) function()
	{
		__original();
		if (this.m.Reach < 0)
		{
			this.m.Reach += 999 + this.getDefaultReach();
			this.m.Reach = ::Math.max(0, this.m.Reach);
		}
	}
});

::Reforged.HooksMod.hook("scripts/items/weapons/weapon", function(q) {
	q.m.Reach <- -999;

	q.getTooltip = @(__original) function()
	{
		local ret = __original();

		if (this.isItemType(::Const.Items.ItemType.MeleeWeapon))
		{
			ret.push({
				id = 20,
				type = "text",
				icon = "ui/icons/rf_reach.png",
				text = "Has a reach of " + this.m.Reach
			});
		}

		if (this.m.WeaponType != ::Const.Items.WeaponType.None)
		{
			local masteries = "";

			foreach (key, weaponType in ::Const.Items.WeaponType)
			{
				if (key in ::Reforged.WMS.WeaponTypeAlias) key = ::Reforged.WMS.WeaponTypeAlias[key];
				if (this.isWeaponType(weaponType) && (key in ::Reforged.WMS.WeaponTypeMastery))
				{
					masteries += key + ", ";
				}
			}

			if (masteries != "")
			{
				ret.push({
					id = 20,
					type = "text",
					icon = "ui/icons/special.png",
					text = ::Reforged.Mod.Tooltips.parseString("[Applicable masteries:|Concept.ApplicableMastery] " + masteries.slice(0, -2))
				});
			}
		}

		return ret;
	}

	q.onEquip = @(__original) function()
	{
		__original();
		if (isWeaponType(::Const.Items.WeaponType.Sling)) this.addSkill(::new("scripts/skills/actives/rf_sling_item_dummy_skill"));
	}

	q.onUpdateProperties = @(__original) function( _properties )
	{
		__original(_properties);
		if (this.isItemType(::Const.Items.ItemType.MeleeWeapon) && !this.getContainer().getActor().isDisarmed())
		{
			_properties.Reach += this.m.Reach;
		}
	}

	q.getReach <- function()
	{
		return this.m.Reach;
	}

	q.getDefaultReach <- function()
	{
		local ret = 0;

		local count = 0.0;
		foreach (weaponType, reach in ::Reforged.Reach.WeaponTypeDefault)
		{
			if (this.isWeaponType(::Const.Items.WeaponType[weaponType]))
			{
				count++;
				ret += reach;
			}
		}

		// If this weapon is of a weapontype for which we don't have a default
		// reach defined, then fallback to certain hardcoded reach values
		if (count == 0)
		{
			if (this.isItemType(::Const.Items.ItemType.MeleeWeapon))
			{
				ret = this.isItemType(::Const.Items.ItemType.TwoHanded) ? 5 : 4;
			}
		}
		else
		{
			ret = ::Math.round(this.m.Reach / count);
		}

		if (this.isItemType(::Const.Items.ItemType.MeleeWeapon))
		{
			if (this.m.Reach < 5 && this.isItemType(::Const.Items.ItemType.TwoHanded))
			{
				ret = 5;
			}

			if (this.isAoE() || (this.getRangeMax() > 1 && this.m.Reach < 6))
			{
				ret += 1;
			}
		}

		return ret;
	}
});
