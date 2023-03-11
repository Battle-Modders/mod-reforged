::mods_hookExactClass("contracts/contracts/escort_caravan_contract", function(o) {
    local onPrepareVariables = o.onPrepareVariables;
    o.onPrepareVariables = function( _vars )
    {
        onPrepareVariables(_vars);
        foreach (var in _vars)
        {
            if (var[0] != "days") continue;
            local seconds = ::MSU.Time.getSecondsRequiredToTravel(this.m.Flags.get("Distance"), ::Const.World.MovementSettings.Speed * 0.6, true);
            var[1] = ::Reforged.Text.getDaysAndHalf(seconds);
            break;
        }
    }
});
