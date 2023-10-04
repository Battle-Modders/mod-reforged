::Reforged.HooksMod.hook("scripts/skills/perks/perk_dodge", function(q) {
	// Add dodge in onAdded instead of onCombatStarted so that its effect
	// is applied and is visible even on the world map
	q.onAdded <- function()
	{
		this.getContainer().add(::new("scripts/skills/effects/dodge_effect"));
	}

	// Overwrite the vanilla function to remove its functionality
	q.onCombatStarted = @() function() {};
});
