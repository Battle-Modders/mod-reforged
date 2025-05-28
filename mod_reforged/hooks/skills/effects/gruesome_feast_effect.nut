::Reforged.HooksMod.hook("scripts/skills/effects/gruesome_feast_effect", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		// Vanilla is missing a description for this skill
		this.m.Description = "Having feasted on a corpse, this monster has grown larger and more powerful.";
	}}.create;

	// Vanilla doesn't have a getTooltip function defined for this skill
	q.getTooltip = @() { function getTooltip()
	{
		local ret = this.skill.getTooltip();

		local size = this.getContainer().getActor().getSize();
		if (size == 2)
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/health.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorPositive("+120") + " [Hitpoints|Concept.Hitpoints]")
			});
			ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorPositive("+10") + " [Melee Skill|Concept.MeleeSkill]")
			});
			ret.push({
				id = 12,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorPositive("+5") + " [Melee Defense|Concept.MeleeDefense]")
			});
			ret.push({
				id = 13,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorNegative("-5") + " [Ranged Defense|Concept.RangeDefense]")
			});
			ret.push({
				id = 14,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorPositive("+30") + " [Resolve|Concept.Bravery]")
			});
			ret.push({
				id = 15,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorPositive("+15") + " Minimum Damage")
			});
			ret.push({
				id = 16,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorPositive("+20") + " Maximum Damage")
			});
			ret.push({
				id = 17,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorNegative("-15") + " [Initiative|Concept.Initiative]")
			});
		}
		else if (size == 3)
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/health.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorPositive("+300") + " [Hitpoints|Concept.Hitpoints]")
			});
			ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorPositive("+20") + " [Melee Skill|Concept.MeleeSkill]")
			});
			ret.push({
				id = 12,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorPositive("+10") + " [Melee Defense|Concept.MeleeDefense]")
			});
			ret.push({
				id = 13,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorNegative("-10") + " [Ranged Defense|Concept.RangeDefense]")
			});
			ret.push({
				id = 14,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorPositive("+60") + " [Resolve|Concept.Bravery]")
			});
			ret.push({
				id = 15,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorPositive("+30") + " Minimum Damage")
			});
			ret.push({
				id = 16,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorPositive("+40") + " Maximum Damage")
			});
			ret.push({
				id = 17,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorNegative("-30") + " [Initiative|Concept.Initiative]")
			});
		}

		return ret;
	}}.getTooltip;
});
