::Reforged.HooksMod.hook("scripts/skills/effects/shieldwall_effect", function(q) {
	q.m.PoiseMult <- 1.25;

	q.getTooltip = @(__original) function()
	{
		local tooltip = __original();

		tooltip.push({
			id = 8,
			type = "text",
			icon = "ui/icons/sturdiness.png",
			text = ::Reforged.Mod.Tooltips.parseString("[Poise|Concept.Poise] is increased by " + ::MSU.Text.colorizeMult(this.m.PoiseMult))
		});

		tooltip.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("Immune against [Hook Shield|Skill+rf_hook_shield_skill]")
		});

		return tooltip;
	}

	q.onUpdate = @(__original) function( _properties )
	{
		__original(_properties);

		local item = this.getContainer().getActor().getItems().getItemAtSlot(::Const.ItemSlot.Offhand);
		if (item.isItemType(::Const.Items.ItemType.Shield) && item.getCondition() > 0)
		{
			_properties.PoiseMult *= this.m.PoiseMult;
		}
	}
});
