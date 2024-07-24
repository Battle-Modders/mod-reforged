::Reforged.HooksMod.hook("scripts/items/weapons/weapon", function(q) {
	q.m.Reach <- 1;

	q.getTooltip = @(__original) function()
	{
		local ret = __original();

		if (this.isItemType(::Const.Items.ItemType.MeleeWeapon))
		{
			ret.push({
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
				skillsString += format("- %s (%s, %s)\n", name, ::MSU.Text.colorPositive(skill.m.ActionPointCost), ::MSU.Text.colorNegative(skill.m.FatigueCost));
			}
			::MSU.getDummyPlayer().getItems().unequip(this);

			this.m.LastEquippedByFaction = lastEquippedByFaction;
		}

		if (skillsString != "")
		{
			ret.push({
				id = 20,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Skills: (" + ::MSU.Text.colorPositive("AP") + ", " + ::MSU.Text.colorNegative("Fatigue") + ")\n" + skillsString
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
					text = "Applicable masteries: " + masteries.slice(0, -2)
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
});
