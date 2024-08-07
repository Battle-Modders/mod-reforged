::Reforged.HooksMod.hookTree("scripts/items/item", function(q) {
	q.getTooltip = @(__original) function()
	{
		if (this.getSlotType() == ::Const.ItemSlot.None)
			return __original();

		// Add skills of the item to its tooltip

		local ret = __original();
		local skillsString = "";
		if (::MSU.isNull(this.getContainer()))
		{
			local lastEquippedByFaction = this.m.LastEquippedByFaction;
			::MSU.NestedTooltips.setNestedSkillItem(this);
			::MSU.getDummyPlayer().getItems().equip(this);
			foreach (skill in this.getSkills())
			{
				local name = ::Reforged.Mod.Tooltips.parseString(format("[%s|Skill+%s]", skill.getName(), skill.ClassName));
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

		return ret;
	}
});

