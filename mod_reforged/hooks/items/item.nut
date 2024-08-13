::Reforged.HooksMod.hookTree("scripts/items/item", function(q) {
	q.getTooltip = @(__original) function()
	{
		if (this.getSlotType() == ::Const.ItemSlot.None)
			return __original();

		// Add skills of the item to its tooltip

		local ret = __original();
		local skillsString = "";
		local itemID = this.getInstanceID();
		foreach (skill in ::Reforged.Items.getSkills(this))
		{
			if (skill.isHidden() && !skill.isType(::Const.SkillType.Perk))
				continue;

			local identifier = skill.isType(::Const.SkillType.Perk) && !skill.isType(::Const.SkillType.StatusEffect) ? "Perk" : "Skill";
			local suffix = skill.isType(::Const.SkillType.Active) ? format(" (%s, %s)", ::MSU.Text.colorPositive(skill.m.ActionPointCost), ::MSU.Text.colorNegative(skill.m.FatigueCost)) : "";
			skillsString += format("- [%s|%s+%s,itemId:%s]%s\n", skill.getName(), identifier, skill.ClassName, itemID, suffix);
		}

		if (skillsString != "")
		{
			ret.push({
				id = 20,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Reforged.Mod.Tooltips.parseString(format("Skills: (%s, %s)\n%s", ::MSU.Text.colorPositive("AP"), ::MSU.Text.colorNegative("Fatigue"), skillsString))
			});
		}

		return ret;
	}
});
