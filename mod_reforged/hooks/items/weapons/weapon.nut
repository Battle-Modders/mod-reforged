::Reforged.HooksMod.hookTree("scripts/items/weapons/weapon", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		if (this.m.Reach < 0)
		{
			this.m.Reach += 999 + this.getDefaultReach();
			this.m.Reach = ::Math.max(0, this.m.Reach);
		}
	}}.create;
});

::Reforged.HooksMod.hook("scripts/items/weapons/weapon", function(q) {
	// We use an arbitrary large negative number (instead of e.g. null) so that
	// arithmetic operations can be performed by mods on individual weapons.
	q.m.Reach <- -999;

	q.getTooltip = @(__original) { function getTooltip()
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

		if (this.isWeaponType(::Const.Items.WeaponType.Dagger, true, true))
		{
			ret.push({
				id = 30,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Reforged.Mod.Tooltips.parseString("The first swap every [turn|Concept.Turn] to/from this weapon costs no [Action Points|Concept.ActionPoints]")
			});
		}

		return ret;
	}}.getTooltip;

	q.getValue = @(__original) { function getValue()
	{
		if (this.m.ConditionMax == 0)	// VanillaFix: A this.m.ConditionMax of 0 causes a division by 0
		{
			return this.m.Value;
		}
		else
		{
			return __original();
		}
	}}.getValue;

	q.onEquip = @(__original) { function onEquip()
	{
		__original();
		if (isWeaponType(::Const.Items.WeaponType.Sling)) this.addSkill(::new("scripts/skills/actives/rf_sling_item_dummy_skill"));
	}}.onEquip;

	q.onUpdateProperties = @(__original) { function onUpdateProperties( _properties )
	{
		__original(_properties);
		if (this.isItemType(::Const.Items.ItemType.MeleeWeapon) && !this.getContainer().getActor().isDisarmed())
		{
			_properties.Reach += this.m.Reach;
		}
	}}.onUpdateProperties;

	q.isDroppedAsLoot = @(__original) { function isDroppedAsLoot()
	{
		if (!this.item.isDroppedAsLoot())
		{
			return false;
		}

		if (this.m.LastEquippedByFaction == ::Const.Faction.Player || !::MSU.isNull(this.getContainer()) && ::MSU.isKindOf(this.getContainer().getActor(), "player"))
		{
			return true;	// Player Weapons now always drop guaranteed
		}

		return __original();
	}}.isDroppedAsLoot;

	q.getReach <- { function getReach()
	{
		return this.m.Reach;
	}}.getReach;

	q.getDefaultReach <- { function getDefaultReach()
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
			ret = ::Math.round(ret / count);
		}

		if (this.isItemType(::Const.Items.ItemType.MeleeWeapon))
		{
			if (ret < 5 && this.isItemType(::Const.Items.ItemType.TwoHanded))
			{
				ret = 5;
			}

			if (this.isAoE() || (this.getRangeMax() > 1 && ret < 6))
			{
				ret += 1;
			}
		}

		return ret;
	}}.getDefaultReach;
});
