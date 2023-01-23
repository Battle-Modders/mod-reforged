::mods_hookExactClass("skills/actives/knock_back", function(o) {
	local getTooltip = o.getTooltip;
	o.getTooltip = function()
	{
		local tooltip = getTooltip();
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

	local onUse = o.onUse;
	o.onUse = function( _user, _targetTile )
	{
		local targetEntity = _targetTile.getEntity();
		local ret = onUse( _user, _targetTile );

		if (ret && targetEntity != null && targetEntity.isAlive() && !targetEntity.isDying() && this.getContainer().hasSkill("perk.shield_expert") && !targetEntity.getSkills().hasSkill("effects.staggered"))
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
