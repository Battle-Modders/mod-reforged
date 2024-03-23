::Reforged.HooksMod.hook("scripts/skills/perks/perk_mastery_mace", function(q) {
	q.onAdded = @(__original) function()
	{
		__original();
		this.getContainer().add(::MSU.new("scripts/skills/perks/perk_rf_bear_down", function(o) {
			o.m.IsRefundable = false;
			o.m.IsSerialized = false;
		}));
	}

	q.onRemoved = @(__original) function()
	{
		__original();
		this.getContainer().removeByID("perk.rf_bear_down");
	}
});
