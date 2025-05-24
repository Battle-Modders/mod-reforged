::Reforged.HooksMod.hook("scripts/skills/actives/throw_net", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.ActionPointCost = 5; // vanilla is 4
		this.m.MaxRange = 2; // vanilla is 3
		this.m.AIBehaviorID = ::Const.AI.Behavior.ID.ThrowNet;
	}

	q.getTooltip = @(__original) function()
	{
		local ret = __original();

		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("Apply [Net Effect|Skill+net_effect] to the target")
		});

		return ret;
	}

	q.onVerifyTarget = @(__original) function( _originTile, _targetTile )
	{
		return __original(_originTile, _targetTile) && !_targetTile.getEntity().getCurrentProperties().IsImmuneToRoot && _targetTile.getEntity().getBaseProperties().Reach < ::Reforged.Reach.Default.BeastHuge;
	}

	q.onNetSpawn = @(__original) function( _data )
	{
		// Prevent crash from the TargetEntity having died/removed from map due to a delayed effect
		// while onNetSpawn was scheduled.
		// Doesn't cause any issue in vanilla because throw_net is never used in such a context.
		// Causes crash in Reforged due to perks which trigger delayed attacks and throw_net on hit
		// e.g. Flail Spinner and Kingfisher at the time of writing this comment.
		if (!_data.TargetEntity.isPlacedOnMap())
		{
			return;
		}

		__original(_data);
	}
});
