this.rf_unnerving_presence_manager <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "special.rf_unnerving_presence_manager";
		this.m.Type = ::Const.SkillType.Special;
		this.m.IsHidden = true;
		this.m.IsSerialized = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function onTurnEnd()
	{
		local actor = this.getContainer().getActor();
		foreach (a in ::Tactical.Entities.getAdjacentActors(actor.getTile()))
		{
			if (a.isAlliedWith(actor))
				continue;

			local s = a.getSkills().getSkillByID("effects.rf_unnerving_presence");
			if (s == null)
				continue;

			s.onEnemyTurnEnd(actor);
			if (!actor.isAlive())
			{
				break;
			}
		}
	}
});
