::Reforged.HooksMod.hook("scripts/items/armor/legendary/ijirok_armor", function(q) {
	q.m.RecoveredHitpoints <- 10;

	// Overwrite because we want to prevent Vanilla from using setHitpoints and also EventLog.log
	q.onTurnStart = @() function()
	{
		local actor = this.getContainer().getActor()
		if (actor.recoverHitpoints(this.m.RecoveredHitpoints, true) != 0 && !actor.isHiddenToPlayer())
		{
			// Usually this is shortened by the 'function spawnIcon' but that function only exists in the skill.nut
			::Tactical.spawnIconEffect("status_effect_79", actor.getTile(), ::Const.Tactical.Settings.SkillIconOffsetX, ::Const.Tactical.Settings.SkillIconOffsetY, ::Const.Tactical.Settings.SkillIconScale, ::Const.Tactical.Settings.SkillIconFadeInDuration, ::Const.Tactical.Settings.SkillIconStayDuration, ::Const.Tactical.Settings.SkillIconFadeOutDuration, ::Const.Tactical.Settings.SkillIconMovement);

			::Sound.play("sounds/enemies/unhold_regenerate_01.wav", ::Const.Sound.Volume.RacialEffect * 1.25, actor.getPos());
		}
	}
});
