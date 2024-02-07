::Reforged.HooksMod.hook("scripts/items/weapons/weapon", function(q) {
	q.m.Reach <- 1;
	q.m.RequiredAmmoType <- ::Const.Items.AmmoType.None;
	q.m.PoiseDamage <- 0;

	q.getTooltip = @(__original) function()
	{
		local tooltip = __original();

		if (this.isItemType(::Const.Items.ItemType.MeleeWeapon))
		{
			tooltip.push({
				id = 20,
				type = "text",
				icon = "ui/icons/reach.png",
				text = "Has a reach of " + this.m.Reach
			});
		}

		local skillsString = "";
		if (::MSU.isNull(this.getContainer()))
		{
			local lastEquippedByFaction = this.m.LastEquippedByFaction;
			::MSU.getDummyPlayer().getItems().equip(this);
			foreach (skill in this.getSkills())
			{
				::MSU.NestedTooltips.setNestedSkillItem(this);
				local name = ::Reforged.Mod.Tooltips.parseString(format("[%s|Skill+%s]", skill.getName(), split(::IO.scriptFilenameByHash(skill.ClassNameHash), "/").top()));
				skillsString += format("- %s (%s, %s)\n", name, ::MSU.Text.colorGreen(skill.m.ActionPointCost), ::MSU.Text.colorRed(skill.m.FatigueCost));
			}
			::MSU.getDummyPlayer().getItems().unequip(this);

			this.m.LastEquippedByFaction = lastEquippedByFaction;
		}

		if (skillsString != "")
		{
			tooltip.push({
				id = 20,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Skills: (" + ::MSU.Text.colorGreen("AP") + ", " + ::MSU.Text.colorRed("Fatigue") + ")\n" + skillsString
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
			_properties.PoiseDamage += this.getPoiseDamage();
		}
	}

// New Functions
	q.getReach <- function()
	{
		return this.m.Reach;
	}

	q.getPoiseDamage <- function()
	{
		return this.m.PoiseDamage;
	}

	q.getRequiredAmmoType <- function()
	{
		if (this.m.RequiredAmmoType == ::Const.Items.AmmoType.None) return this.getAmmoID();
		return this.m.RequiredAmmoType;
	}

});

::Reforged.HooksMod.hookTree("scripts/items/weapons/weapon", function(q) {
	// We change getAmmoID to return an unsigned enum instead of an ID-String. This could break mod compatibility but it isn't worth it to support the flawed vanilla ammoType mechanic.
	// This will correct all current and most future Vanilla items and those coming from random mods
	q.getAmmoID = @(__original) function()
	{
		local ret = __original();
		if (ret == "ammo.arrows")
		{
			return ::Const.Items.AmmoType.Arrows;
		}
		if (ret == "ammo.bolts")
		{
			return ::Const.Items.AmmoType.Bolts;
		}
		if (ret == "ammo.powder")
		{
			return ::Const.Items.AmmoType.Powder;
		}
		return ret;
	}
});
