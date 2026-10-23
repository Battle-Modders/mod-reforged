::Reforged.HooksMod.hook("scripts/skills/actives/slash", function(q) {
	// MSU Function
	// Add IsIgnooredAsAOO to softReset so that our adjustment to it
	// in perk_rf_en_garde works correctly.
	q.softReset = @(__original) { function softReset()
	{
		__original();
		this.resetField("IsIgnoredAsAOO");
	}}.softReset;

	q.getTooltip = @() { function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		if (this.m.HitChanceBonus != 0)
		{
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Has " + ::MSU.Text.colorizeValue(this.m.HitChanceBonus, {AddSign = true, AddPercent = true}) + " chance to hit"
			});
		}
		return ret;
	}}.getTooltip;

	q.getHitChanceModifier = @() { function getHitChanceModifier()
	{
		return 5; // vanilla 10
	}}.getHitChanceModifier;
});
