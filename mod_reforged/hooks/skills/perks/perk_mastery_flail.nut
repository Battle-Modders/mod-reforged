::Reforged.HooksMod.hook("scripts/skills/perks/perk_mastery_flail", function(q) {
	q.onAdded = @(__original) function()
	{
		__original();
		this.getContainer().add(::Reforged.new("scripts/skills/perks/perk_rf_from_all_sides", function(o) {
			o.m.IsRefundable = false;
			o.m.IsSerialized = false;
		}));
	}

	q.onRemoved = @(__original) function()
	{
		__original();
		this.getContainer().removeByID("perk.rf_from_all_sides");
	}
});
