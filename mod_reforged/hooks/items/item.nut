::Reforged.HooksMod.hookTree("scripts/items/item", function(q) {
	q.getTooltip = @(__original) { function getTooltip()
	{
		local ret = __original();

		// Add which craftables can be crafted using this item. We only show the craftable, not the entire recipe.
		if (this.isItemType(::Const.Items.ItemType.Crafting) && "State" in ::World && !::MSU.isNull(::World.State))
		{
			local names = [];
			local blueprints = [];
			foreach (b in ::World.State.m.Crafting.m.Blueprints)
			{
				// Don't add duplicates e.g. Snake Oil which is crafted from various recipes
				if (names.find(b.getName()) != null)
					continue;

				foreach (item in b.m.PreviewComponents)
				{
					if (item.Instance.getID() == this.getID())
					{
						blueprints.push(b);
						names.push(b.getName());
						break;
					}
				}
			}
			if (blueprints.len() != 0)
			{
				blueprints.sort(@(_a, _b) _a.getName() <=> _b.getName());
				ret.push({
					id = 10,	type = "text",	icon = "ui/icons/special.png",
					text = "Used in the crafting of: "
					children = blueprints.map(@(_b) {
						id = 10,	type = "text",	icon = ::Reforged.Mod.Tooltips.parseString(::Reforged.NestedTooltips.getNestedItemImage(_b.m.PreviewCraftable)),
						text = ::Reforged.Mod.Tooltips.parseString(format("[%s|Item+%s]", _b.getName(), _b.m.PreviewCraftable.ClassName))
					})
				});
			}
		}

		if (this.getSlotType() == ::Const.ItemSlot.None)
			return ret;

		// Add skills of the item to its tooltip

		local skillsString = "";
		local itemID = this.getInstanceID();
		foreach (skill in ::Reforged.Items.getSkills(this))
		{
			if (skill.isHidden() && !skill.isType(::Const.SkillType.Perk))
				continue;

			local identifier = skill.isType(::Const.SkillType.Perk) && !skill.isType(::Const.SkillType.StatusEffect) ? "Perk" : "Skill";
			local suffix = skill.isType(::Const.SkillType.Active) ? format(" (%s, %s)", ::MSU.Text.colorPositive(skill.m.ActionPointCost), ::MSU.Text.colorNegative(skill.m.FatigueCost)) : "";
			skillsString += format("- [%s|%s+%s,itemId:%s,entityId:default]%s\n", skill.getName(), identifier, ::IO.scriptFilenameByHash(skill.ClassNameHash), itemID, suffix);
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
	}}.getTooltip;
});
