::Reforged.HooksMod.hook("scripts/skills/perks/perk_mastery_mace", function(q) {
	q.onAdded = @(__original) { function onAdded()
	{
		__original();
		this.getContainer().add(::Reforged.new("scripts/skills/perks/perk_rf_bear_down", function(o) {
			o.m.IsRefundable = false;
			o.m.IsSerialized = false;
		}));
	}}.onAdded;

	q.onRemoved = @(__original) { function onRemoved()
	{
		__original();
		this.getContainer().removeByID("perk.rf_bear_down");
	}}.onRemoved;
});
