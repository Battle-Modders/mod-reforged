::Reforged.HooksMod.hook("scripts/skills/racial/trickster_god_racial", function(q) {
	q.m.RecoveredPercentage <- 0.06;

	q.create = @(__original) function()
	{
		__original();
		this.m.Name = "Ijrok Racial";
		this.m.IsHidden = false;
		this.addType(::Const.SkillType.StatusEffect);	// We now want this effect to show up on the enemies
	}

	// The recovered amount is now being capped by the recoverHitpoints function instead of here. That will make it better against recovery debuffs
	q.onTurnStart = @() function()
	{
		local actor = this.getContainer().getActor()
		if (actor.recoverHitpoints(actor.getHitpointsMax() * this.m.RecoveredPercentage, true) != 0 && !actor.isHiddenToPlayer())
		{
			this.spawnIcon("status_effect_79", actor.getTile());

			if (this.m.SoundOnUse.len() != 0)
			{
				::Sound.play(this.m.SoundOnUse[::Math.rand(0, this.m.SoundOnUse.len() - 1)], ::Const.Sound.Volume.RacialEffect * 1.25, actor.getPos());
			}
		}
	}

	q.getTooltip <- function()
	{
		local ret = this.skill.getTooltip();
		ret.extend([
			{
				id = 10,
				type = "text",
                icon = "ui/icons/health.png",
				text = "At the start of each turn, this character heals by " + ::MSU.Text.colorGreen((this.m.RecoveredPercentage * 100) + "%") + " of Maximum Hitpoints"
			}
		]);
		return ret;
	}
});
