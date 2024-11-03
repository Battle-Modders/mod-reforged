::Reforged.HooksMod.hook("scripts/skills/perks/perk_bullseye", function(q) {
	q.onAnySkillUsed = @(__original) function( _skill, _targetEntity, _properties )
	{
		__original(_skill, _targetEntity, _properties);

		if (!_skill.isRanged() || _targetEntity == null)
			return;

		local actor = this.getContainer().getActor();
		if (actor.getCurrentProperties().RangedAttackBlockedChanceMult == 0 || ::Const.Tactical.Common.getBlockedTiles(actor.getTile(), _targetEntity.getTile(), actor.getFaction()).len() == 0)
		{
			_properties.DamageDirectAdd += 0.20;
		}
	}

	q.onGetHitFactors = @(__original) function( _skill, _targetTile, _tooltip )
	{
		__original(_skill, _targetTile, _tooltip);

		if (_skill != this)
			return;

		local actor = this.getContainer().getActor();
		if (actor.getCurrentProperties().RangedAttackBlockedChanceMult == 0 || ::Const.Tactical.Common.getBlockedTiles(actor.getTile(), _targetTile, actor.getFaction()).len() == 0)
		{
			_tooltip.push({
				icon = "ui/tooltips/positive.png",
				text = this.getName()
			});
		}
	}
});
