::Reforged.HooksMod.hook("scripts/contracts/contracts/raid_caravan_contract", function(q) {
	q.RF_getDestinations = @() { function RF_getDestinations()
	{
		return [this.m.Target];
	}}.RF_getDestinations;
});
