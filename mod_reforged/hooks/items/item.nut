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
			local name = ::Reforged.Mod.Tooltips.parseString(format("[%s|Skill+%s,itemId:%s,itemOwner:null]", skill.getName(), skill.ClassName, itemID));
			skillsString += format("- %s (%s, %s)\n", name, ::MSU.Text.colorPositive(skill.m.ActionPointCost), ::MSU.Text.colorNegative(skill.m.FatigueCost));
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

		return ret;
	}
});

