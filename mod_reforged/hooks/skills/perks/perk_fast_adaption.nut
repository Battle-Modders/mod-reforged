::Reforged.HooksMod.hook("scripts/skills/perks/perk_fast_adaption", function(q) {
	q.onGetHitFactors <- function( _skill, _targetTile, _tooltip )
	{
		if (_skill.isAttack() && this.m.Stacks != 0)
		{
			_tooltip.push({
				icon = "ui/tooltips/positive.png",
				text = ::MSU.Text.colorGreen((this.m.Stacks * 10) + "% ") + this.getName()
			});
		}
	}
});
