::Reforged.HooksMod.hook("scripts/skills/actives/throw_golem_skill", function(q) {
	q.create = @(__original) function()
	{
		__original();
		// Vanilla is missing a description for this skill
		this.m.Description = "Throw a boulder of your sand and stone at a target, splitting yourself into smaller living bits!";
	}

	// Vanilla doesn't have a getTooltip function defined for this skill
	q.getTooltip = @() function()
	{
		local ret = this.getDefaultTooltip();
		local entityType = ::MSU.isEqual(this.getContainer().getActor(), ::MSU.getDummyPlayer()) ? ::Const.EntityType.SandGolem : this.getContainer().getActor().getType();
		ret.extend([
			{
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = format("Will spawn %s%s adjacent to the target", ::Const.Strings.getArticle(::Const.Strings.EntityName[entityType]), ::Const.Strings.EntityName[entityType])
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Reforged.Mod.Tooltips.parseString("Will reduce your size and spawn two " + ::Const.Strings.EntityNamePlural[entityType] + " of this size adjacent to you")
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "Has a range of " + ::MSU.Text.colorizeValue(this.getMaxRange()) + " tiles"
			}
		]);
		return ret;
	}
});
