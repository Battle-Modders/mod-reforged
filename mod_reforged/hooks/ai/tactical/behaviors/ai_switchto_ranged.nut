::Reforged.HooksMod.hook("scripts/ai/tactical/behaviors/ai_switchto_ranged", function(q) {
	// Prevent AI from swapping to ranged weapon when close to enemy melee units
	// because dropping your Reach is a bad idea in this case
	q.onEvaluate = @(__original) function( _entity )
	{
		this.m.WeaponToEquip = null;

		local myTile = _entity.getTile();
		local switchMaxDangerDist = ::Math.max(_entity.getIdealRange(), ::Const.AI.Behavior.SwitchToRangedMaxDangerDist);

		foreach (enemy in this.getAgent().getKnownOpponents())
		{
			if (::MSU.isNull(enemy.Actor) || enemy.Actor.getMoraleState() == ::Const.MoraleState.Fleeing || enemy.Actor.isArmedWithRangedWeapon())
			{
				continue;
			}

			if (enemy.Actor.getTile().getZoneOfControlCountOtherThan(enemy.Actor.getAlliedFactions()) >= ::Const.AI.Behavior.SwitchToRangedIgnoreDangerMinZones)
			{
				continue;
			}

			local dist = myTile.getDistanceTo(enemy.Tile);
			if (dist > switchMaxDangerDist)
			{
				continue;
			}

			// If an enemy can reach us in 1 turn, don't swap to a ranged weapon
			if (this.queryActorTurnsNearTarget(enemy.Actor, myTile, _entity).Turns <= 1)
			{
				return ::Const.AI.Behavior.Score.Zero;
			}
		}

		return __original(_entity);
	}
});
