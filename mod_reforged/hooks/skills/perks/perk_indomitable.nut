::mods_hookExactClass("skills/perks/perk_indomitable", function (o) {
	local onCombatStarted = "onCombatStarted" in o ? o.onCombatStarted : null;
	o.onCombatStarted <- function()
	{
		if (onCombatStarted != null) onCombatStarted();
		this.getContainer().add(::new("scripts/skills/effects/rf_retribution_effect"));
	}
});
