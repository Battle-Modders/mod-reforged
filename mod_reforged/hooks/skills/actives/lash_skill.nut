::Reforged.HooksMod.hook("scripts/skills/actives/lash_skill", function(q) {
	q.getTooltip = @() function()
	{
		local ret = this.getDefaultTooltip();
		ret.extend([
			{
				id = 9,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Has a " + ::MSU.Text.colorGreen("100%") + " chance to hit the head"
			}
		]);

		if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInFlails)
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Reforged.Mod.Tooltips.parseString("Ignores the bonus to [Melee Defense|Concept.MeleeDefense] granted by shields but not by [Shieldwall|Skill+shieldwall_effect]")
			});
		}

		return ret;
	}
});
