::Reforged.HooksMod.hook("scripts/items/shields/legendary/gilders_embrace_shield", function(q) {
	q.create = @(__original) function()
	{
		__original();
		local sipar = ::new("scripts/items/shields/oriental/metal_round_shield");
		// vanilla -16 which is 2 less than vanilla sipar of -18
		// but in Reforged we have sipar at different stamina modifier so we dynamically set this
		this.m.StaminaModifier = sipar.m.StaminaModifier - 2;
		this.m.ReachIgnore = 3;
	}
});
