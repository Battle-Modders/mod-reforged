::Reforged.HooksMod.hookTree("scripts/items/weapons/weapon", function(q) {
	q.create = @(__original) function()
	{
		__original();
		if (this.m.Reach == null)
		{
			this.assignDefaultReach();
		}
	}
});

::Reforged.HooksMod.hook("scripts/items/weapons/weapon", function(q) {
	q.m.Reach <- null;

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

// New Functions
	q.getReach <- function()
	{
		return this.m.Reach;
	}

	q.assignDefaultReach <- function()
	{
		if (this.isItemType(this.Const.Items.ItemType.MeleeWeapon))
		{
			if (this.isItemType(::Const.Items.ItemType.OneHanded))
			{
				if (this.isWeaponType(::Const.Items.WeaponType.Axe))
				{
					this.m.Reach = 3;
				}
				else if (this.isWeaponType(::Const.Items.WeaponType.Cleaver))
				{
					this.m.Reach = 4;
				}
				else if (this.isWeaponType(::Const.Items.WeaponType.Dagger))
				{
					this.m.Reach = 1;
				}
				else if (this.isWeaponType(::Const.Items.WeaponType.Flail))
				{
					this.m.Reach = 4;
				}
				else if (this.isWeaponType(::Const.Items.WeaponType.Hammer))
				{
					this.m.Reach = 3;
				}
				else if (this.isWeaponType(::Const.Items.WeaponType.Mace))
				{
					this.m.Reach = 3;
				}
				else if (this.isWeaponType(::Const.Items.WeaponType.Spear))
				{
					this.m.Reach = 5;
				}
				else if (this.isWeaponType(::Const.Items.WeaponType.Sword))
				{
					this.m.Reach = 4;
				}
			}
			else if (this.isItemType(::Const.Items.ItemType.TwoHanded))
			{
				if (this.isWeaponType(::Const.Items.WeaponType.Axe))
				{
					this.m.Reach = (this.m.RangeMax == 2) ? 6 : 5;
				}
				else if (this.isWeaponType(::Const.Items.WeaponType.Cleaver))
				{
					this.m.Reach = (this.m.RangeMax == 2) ? 6 : 4;
				}
				else if (this.isWeaponType(::Const.Items.WeaponType.Dagger))
				{
					this.m.Reach = 4;
				}
				else if (this.isWeaponType(::Const.Items.WeaponType.Flail))
				{
					this.m.Reach = (this.m.RangeMax == 2) ? 6 : 5;
				}
				else if (this.isWeaponType(::Const.Items.WeaponType.Hammer))
				{
					this.m.Reach = (this.m.RangeMax == 2) ? 6 : 4;
				}
				else if (this.isWeaponType(::Const.Items.WeaponType.Mace))
				{
					this.m.Reach = (this.m.RangeMax == 2) ? 6 : 5;
				}
				else if (this.isWeaponType(::Const.Items.WeaponType.Polearm))
				{
					this.m.Reach = 7;
				}
				else if (this.isWeaponType(::Const.Items.WeaponType.Spear))
				{
					this.m.Reach = (this.m.RangeMax == 2) ? 6 : 5;
				}
				else if (this.isWeaponType(::Const.Items.WeaponType.Sword))
				{
					this.m.Reach = (this.m.RangeMax == 2) ? 6 : 6;
				}
			}

			if (this.m.Reach == null)
			{
				this.m.Reach = 3;
			}
		}
		else
		{
			this.m.Reach = 0;	// e.g. Ranged weapons
		}
	}
});
