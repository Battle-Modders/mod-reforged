::Reforged.HooksMod.hook("scripts/skills/actives/knock_back", function(q) {
	q.getTooltip = @(__original) function()
	{
		// Switcheroo to prevent vanilla skill from gaining hitchance from shield expert
		local p = this.getContainer().getActor().getCurrentProperties();
		local oldValue = p.IsSpecializedInShields;
		p.IsSpecializedInShields = false;

		local ret = __original();
		p.IsSpecializedInShields = oldValue;	// Revert Switcheroo

		return ret;
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
