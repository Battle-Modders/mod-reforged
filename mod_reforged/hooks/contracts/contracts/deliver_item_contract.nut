::Reforged.HooksMod.hook("scripts/contracts/contracts/deliver_item_contract", function(q) {
	q.onPrepareVariables = @(__original) function( _vars )
	{
		__original(_vars);
		foreach (var in _vars)
		{
			if (var[0] != "days") continue;
			local seconds = ::MSU.Time.getSecondsRequiredToTravel(this.m.Flags.get("Distance"), ::Const.World.MovementSettings.Speed, true);
			var[1] = ::Reforged.Text.getDaysAndHalf(seconds);
			break;
		}
	}
});
