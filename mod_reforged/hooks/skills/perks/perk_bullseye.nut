::Reforged.HooksMod.hook("scripts/skills/perks/perk_bullseye", function(q) {
	q.onAnySkillUsed = @(__original) function( _skill, _targetEntity, _properties )
	{
		if (!_skill.isRanged() || _targetEntity != null)
			return;

		local actor = this.getContainer().getActor();
		if (_properties.RangedAttackBlockedChanceMult == 0 || ::Const.Tactical.Common.getBlockedTiles(actor.getTile(), _targetEntity.getTile(), actor.getFaction()).len() == 0)
		{
			_properties.DamageDirectAdd += 0.25;
		}
	}
});
