::Reforged.HooksMod.hook("scripts/skills/actives/decapitate", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.AIBehaviorID = ::Const.AI.Behavior.ID.Decapitate;
	}}.create;

	q.getHitFactors = @(__original) { function getHitFactors( _targetTile )
	{
		local ret = __original(_targetTile);

		if (!_targetTile.IsOccupiedByActor)
			return ret;
		
		local targetEntity = _targetTile.getEntity();
		local bonusDamage = 1.0 - targetEntity.getHitpoints() / (targetEntity.getHitpointsMax() * 1.0);

		if (bonusDamage >= 0.01)
		{
			ret.push({
				icon = ::Reforged.Mod.Tooltips.parseString(::Reforged.NestedTooltips.getNestedSkillImage(this, "entityId:" + this.getContainer().getActor().getID())),
				text = ::MSU.Text.colorizePct(bonusDamage) + " more damage"
			});
		}

		return ret;
	}}.getHitFactors
});
