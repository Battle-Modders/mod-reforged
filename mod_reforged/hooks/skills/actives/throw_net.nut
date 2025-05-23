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
});
