::mods_hookExactClass("items/weapons/weapon", function (o) {
	this.m.Reach <- 1;

	local getTooltip = o.getTooltip;
	o.getTooltip = function()
	{
		local tooltip = getTooltip();

		if (this.isItemType(::Const.Items.ItemType.MeleeWeapon))
		{
			tooltip.push({
				id = 20,
				type = "text",
				icon = "ui/icons/reach.png",
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
					masteries += ::Reforged.WMS.WeaponTypeMastery[key] + ", ";
				}
			}

			if (masteries != "")
			{
				tooltip.push({
					id = 20,
					type = "text",
					icon = "ui/icons/special.png",
					text = "Applicable masteries: " + masteries.slice(0, -2)
				});
			}
		}

		return tooltip;
	}

	local onUpdateProperties = o.onUpdateProperties;
	o.onUpdateProperties = function( _properties )
	{
		onUpdateProperties(_properties);
		if (this.isItemType(::Const.Items.ItemType.MeleeWeapon) && !this.getContainer().getActor().isDisarmed())
		{
			_properties.Reach += this.m.Reach;
		}
	}
});
