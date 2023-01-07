::mods_hookExactClass("items/weapons/weapon", function (o) {
	o.m.Reach <- 1;

	local dummyPlayer = ::new("scripts/entity/tactical/player");
	dummyPlayer.m.BaseProperties = ::Const.CharacterProperties.getClone();
	dummyPlayer.m.CurrentProperties = clone dummyPlayer.m.BaseProperties;
	dummyPlayer.m.Items.setUnlockedBagSlots(::Const.ItemSlotSpaces[::Const.ItemSlot.Bag]);
	dummyPlayer.m.Skills.add = function( _skill, _order = 0 ) {};
	dummyPlayer.getFaction <- function() { return ::Const.Faction.Player };

	local onUpdateProperties = o.onUpdateProperties;
	o.onUpdateProperties = function( _properties )
	{
        local oldStamina = _properties.Stamina;
        onUpdateProperties(_properties);
        local staminaDifference = _properties.Stamina - oldStamina;
		_properties.Burden += (-1.0 * staminaDifference);
	}

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
			// Midas -- Use setContainer and onEquip instead of container.equip(this) because
			// somehow using equip() causes the "faction_banner" item to throw an error
			// on alternate launches of the game. More weirdly, if it works on a launch then it'll work for a campaign started
			// during that launch. If it was the launch where it errors, then it won't work for a campaign started in that launch.
			// The behavior in the campaign persists for all future launches of the game. Setting container manually and calling`
			// onEquip doesn't suffer from this issue. This should be looked into at some point.
			this.setContainer(::Reforged.getDummyPlayer().getItems());
			this.onEquip();
			foreach (skill in this.getSkills())
			{
				local name = ::Reforged.Mod.Tooltips.parseString(format("[%s|Skill+%s]", skill.getName(), split(::IO.scriptFilenameByHash(skill.ClassNameHash), "/").top()));
				skillsString += format("- %s (%s, %s)\n", name, ::MSU.Text.colorGreen(skill.m.ActionPointCost), ::MSU.Text.colorRed(skill.m.FatigueCost));
			}
			this.clearSkills();
			this.setContainer(null);

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
});
