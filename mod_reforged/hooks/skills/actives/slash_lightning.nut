::Reforged.HooksMod.hook("scripts/skills/actives/slash_lightning", function(q) {
	// VanillaFix: Prevent this skill from spawning lightning strikes when killing someone with zone of control or riposte attacks
	q.onUse = @(__original) { function onUse( _user, _targetTile )
	{
		// Vanilla allows lightning strikes to trigger, when the active entity is null. When the active entity dies, it is always immediately removed from spot of the active entity, causing it to be null
		// We fix that by running a very simply implementation of the original skill, if it is NOT the users turn
		if (!::Tactical.TurnSequenceBar.isActiveEntity(this.getContainer().getActor()))
		{
			this.spawnAttackEffect(_targetTile, ::Const.Tactical.AttackEffectSlash);
			return this.attackEntity(_user, _targetTile.getEntity());
		}

		return __original(_user, _targetTile);
	}}.onUse;
});
