::Reforged.HooksMod.hook("scripts/skills/actives/thrust", function(q) {
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
		return 10; // vanilla 20
	}}.getHitChanceModifier;
});
