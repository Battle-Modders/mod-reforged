::Reforged.HooksMod.hook("scripts/items/shields/special/craftable_kraken_shield", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.Condition = 220;
		this.m.ConditionMax = 220;
		this.m.ReachIgnore = 3;
	}

	q.getTooltip = @(__original) function()
	{
		local ret = __original();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("Reduces the [Resolve|Concept.Bravery] of any opponent engaged in melee by " + ::MSU.Text.colorNegative(10))
		});
		return ret;
	}

	q.onUpdateProperties = @(__original) function( _properties )
	{
		__original(_properties);
		_properties.Threat += 10;
	}
});
