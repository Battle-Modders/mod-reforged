::Reforged.HooksMod.hook("scripts/skills/actives/knock_back", function(q) {
	q.getTooltip = @(__original) function()
	{
		// Switcheroo to prevent vanilla skill from gaining hitchance from shield expert
		local p = this.getContainer().getActor().getCurrentProperties();
		local oldValue = p.IsSpecializedInShields;
		p.IsSpecializedInShields = false;

		local tooltip = __original();
		p.IsSpecializedInShields = oldValue;	// Revert Switcheroo

		if (this.getContainer().hasSkill("perk.rf_line_breaker"))
		{
			tooltip.push({
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Will stagger the target if successfully knocked back"
			});
		}

		return tooltip;
	}

	q.onAnySkillUsed = @(__original) function( _skill, _targetEntity, _properties )
	{
		// Switcheroo to prevent vanilla skill from gaining hitchance from shield expert
		local oldValue = _properties.IsSpecializedInShields;
		_properties.IsSpecializedInShields = false;

		__original(_skill, _targetEntity, _properties);

		_properties.IsSpecializedInShields = oldValue;	// Revert Switcheroo
	}
});
