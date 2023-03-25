::mods_hookExactClass("items/weapons/weapon", function (o) {
	o.m.Reach <- 1;
	o.m.RequiredAmmoType <- ::Const.Items.AmmoType.None;

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

	local onEquip = o.onEquip;
	o.onEquip = function()
	{
		onEquip();
		if (isWeaponType(::Const.Items.WeaponType.Sling)) this.addSkill(::new("scripts/skills/actives/rf_sling_item_dummy_skill"));
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

	o.getReach <- function()
	{
		return this.m.Reach;
	}

	o.getRequiredAmmoType <- function()
	{
		if (this.m.RequiredAmmoType == ::Const.Items.AmmoType.None) return this.getAmmoID();
		return this.m.RequiredAmmoType;
	}

});

::mods_hookDescendants("items/weapons/weapon", function(o) {
	if ("getAmmoID" in o)
	{
		local getAmmoID = o.getAmmoID;
		o.getAmmoID = function()	// This will correct all current and most future Vanilla items and those coming from random mods
		{
			local ret = getAmmoID();
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
	}
})
