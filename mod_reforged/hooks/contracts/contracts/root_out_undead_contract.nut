::Reforged.HooksMod.hook("scripts/contracts/contracts/root_out_undead_contract", function(q) {
	q.RF_getDestinations = @() { function RF_getDestinations()
	{
		return [this.m.Objective1, this.m.Objective2];
	}}.RF_getDestinations;
});
