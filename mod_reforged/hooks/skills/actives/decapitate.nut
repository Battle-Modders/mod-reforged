::Reforged.HooksMod.hook("scripts/skills/actives/decapitate", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.AIBehaviorID = ::Const.AI.Behavior.ID.Decapitate;
	}}.create;

	q.getHitFactors = @() { function getHitFactors( _targetTile )
	{
		local ret = this.skill.getHitFactors(_targetTile);
		local targetEntity = _targetTile.IsOccupiedByActor ? _targetTile.getEntity() : null;
		local bonusDamage = 1.0 - targetEntity.getHitpoints() / (targetEntity.getHitpointsMax() * 1.0);
		bonusDamage = ::Math.ceil(bonusDamage * 100);

		if (bonusDamage >= 1)
		{
			ret.push({
				icon = "ui/tooltips/positive.png",
				text = ::MSU.Text.colorPositive(bonusDamage + "%") + " Bonus damage based on current injury"
			});
		}

		return ret;
	}}.getHitFactors
});
