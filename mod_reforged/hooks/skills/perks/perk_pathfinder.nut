::Reforged.HooksMod.hook("scripts/skills/perks/perk_pathfinder", function(q) {
	// VanillaFix: Pathfinder does not revert costs when removed from the actor.
	// We save the original values during onAdded and revert them during onRemoved.
	q.m.RF_ActionPointCostsBackup <- null;
	q.m.RF_FatigueCostsBackup <- null;
	q.m.RF_LevelActionPointCostBackup <- null;

	q.onAdded = @(__original) { function onAdded()
	{
		__original();
		local actor = this.getContainer().getActor();
		this.m.RF_ActionPointCostsBackup = actor.m.ActionPointCosts;
		this.m.RF_FatigueCostsBackup = actor.m.FatigueCosts;
		this.m.RF_LevelActionPointCostBackup = actor.m.LevelActionPointCost;
	}}.onAdded;

	q.onRemoved = @(__original) { function onRemoved()
	{
		__original();
		local actor = this.getContainer().getActor();
		actor.m.ActionPointCosts = this.m.RF_ActionPointCostsBackup;
		actor.m.FatigueCosts = this.m.RF_FatigueCostsBackup;
		actor.m.LevelActionPointCost = this.m.RF_LevelActionPointCostBackup;
	}}.onRemoved;
});
