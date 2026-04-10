::Reforged.HooksMod.hook("scripts/contracts/contracts/escort_caravan_contract", function(q) {
	q.onPrepareVariables = @(__original) { function onPrepareVariables( _vars )
	{
		__original(_vars);
		foreach (var in _vars)
		{
			if (var[0] != "days") continue;
			local seconds = this.getSecondsRequiredToTravel(this.m.Flags.get("Distance"), ::Const.World.MovementSettings.Speed * 0.6, true);
			var[1] = "[color=#f6eedb]" + ::Reforged.Text.getDaysAndHalf(seconds) + "[/color]"; // Same color as vanilla OOC var but we can't use a var within a var
			break;
		}
	}}.onPrepareVariables;

	q.RF_getDaysRequiredToTravel = @() { function RF_getDaysRequiredToTravel( _start, _dest )
	{
		return this.getDaysRequiredToTravel(_start.getTile().getDistanceTo(_dest.getTile()), ::Const.World.MovementSettings.Speed * 0.6, true);
	}}.RF_getDaysRequiredToTravel;
});
