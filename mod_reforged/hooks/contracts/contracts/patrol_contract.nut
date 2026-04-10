::Reforged.HooksMod.hook("scripts/contracts/contracts/patrol_contract", function(q) {
	q.RF_getDestinations = @() { function RF_getDestinations()
	{
		return [this.m.Location1, this.m.Location2];
	}}.RF_getDestinations;
});
