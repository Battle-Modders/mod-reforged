::Reforged.HooksMod.hook("scripts/skills/actives/throw_net", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		this.m.ActionPointCost = 5; // vanilla is 4
		this.m.MaxRange = 2; // vanilla is 3
		this.m.AIBehaviorID = ::Const.AI.Behavior.ID.ThrowNet;
	}}.create;

	q.getTooltip = @(__original) { function getTooltip()
	{
		local ret = __original();

		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("Apply [Net Effect|Skill+net_effect] to the target")
		});

		return ret;
	}}.getTooltip;

	q.onVerifyTarget = @(__original) { function onVerifyTarget( _originTile, _targetTile )
	{
		return __original(_originTile, _targetTile) && !_targetTile.getEntity().getCurrentProperties().IsImmuneToRoot && _targetTile.getEntity().getBaseProperties().Reach < ::Reforged.Reach.Default.BeastHuge;
	}}.onVerifyTarget;

	q.onNetSpawn = @(__original) { function onNetSpawn( _data )
	{
		// Prevent crash from TargetEntity having died due to a delayed effect while onNetSpawn was scheduled.
		// Doesn't cause any issue in vanilla because throw_net is never used in such a context.
		// Causes crash in Reforged due to perks which trigger delayed attacks and throw_net on hit
		// e.g. Flail Spinner and Kingfisher at the time of writing this comment.
		if (!_data.TargetEntity.isAlive())
		{
			return;
		}

		__original(_data);
	}}.onNetSpawn;
});
