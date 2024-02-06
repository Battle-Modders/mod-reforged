::Reforged.HooksMod.hook("scripts/skills/actives/knock_back", function(q) {
	q.getTooltip = @(__original) function()
	{
		// Switcheroo
		local properties = this.getContainer().getActor().getCurrentProperties();
		local oldIsSpecializedInShields = properties.IsSpecializedInShields;
		properties.IsSpecializedInShields = false;
		local tooltip = __original();
		properties.IsSpecializedInShields = oldIsSpecializedInShields;

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

	q.onUse = @(__original) function( _user, _targetTile )
	{
		local targetEntity = _targetTile.getEntity();
		local ret = __original( _user, _targetTile );

		if (ret && targetEntity != null && targetEntity.isAlive() && !targetEntity.isDying() && this.getContainer().hasSkill("perk.rf_line_breaker"))
		{
			local effect = this.new("scripts/skills/effects/staggered_effect");
			targetEntity.getSkills().add(effect);
			if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
			{
				::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_user) + " has staggered " + ::Const.UI.getColorizedEntityName(targetEntity) + " for " + effect.m.TurnsLeft + " turns");
			}
		}
	}

	// We prevent Vanilla from applying the 15% hit chance bonus from Shield Expert. This effect has now moved to "Line Breaker"
	q.onAnySkillUsed = @(__original) function( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			local oldIsSpecializedInShields = _properties.IsSpecializedInShields;
			_properties.IsSpecializedInShields = false;
			__original(_skill, _targetEntity, _properties);
			_properties.IsSpecializedInShields = oldIsSpecializedInShields;
		}
	}
});
