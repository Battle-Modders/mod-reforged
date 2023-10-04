::Reforged.HooksMod.hook("scripts/skills/actives/knock_back", function(q) {
	q.getTooltip = @(__original) function()
	{
		local tooltip = __original();
		if (this.getContainer().hasSkill("perk.shield_expert"))
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

		if (ret && targetEntity != null && targetEntity.isAlive() && !targetEntity.isDying() && this.getContainer().hasSkill("perk.shield_expert"))
		{
			local effect = this.new("scripts/skills/effects/staggered_effect");
			targetEntity.getSkills().add(effect);
			if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
			{
				::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_user) + " has staggered " + ::Const.UI.getColorizedEntityName(targetEntity) + " for " + effect.m.TurnsLeft + " turns");
			}
		}
	}
});
