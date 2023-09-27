::Reforged.HooksMod.hook("scripts/ai/tactical/behaviors/ai_engage_melee", function(q) {
	// The purpose of this skill is to allow the `ai_charge.nut` and `ai_engage_melee.nut` vanilla behaviors to be used for Lunge AI.
	// It adds a dummy skill that works like the charge skill i.e. it is used on empty tiles adjacent to an enemy
	// If it is usable then it allows the `ai_engage_melee.nut` behavior to tell the entity to carefully position themselves to engage with a Lunge
	// instead of walking straight into the face of an enemy.
	q.m.PossibleSkills.push("actives.rf_lunge_charge_dummy");

	q.onExecute = @(__original) function( _entity )
	{
		if (this.m.IsFirstExecuted)
		{
			if (this.m.Skill != null && this.m.Skill.getID() == "actives.rf_lunge_charge_dummy")
			{
				// Change the skill to Lunge and the target tile to the target actor's tile and let the the original function execute as normal
				// This is done because the "dummy" skill is targeting a tile adjacent to the target actor (just like the charge skill)
				this.m.Skill = null;
				local skill = _entity.getSkills().getSkillByID("actives.lunge");
				if (skill != null && skill.isUsable() && skill.isAffordable())
				{
					this.m.Skill = skill;
					this.m.TargetTile = this.m.TargetActor.getTile();
				}
			}
		}

		return __original(_entity);
	}
});
