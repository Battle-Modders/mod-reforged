this.rf_frostbound_manager <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "special.rf_frostbound_manager";
		this.m.Type = ::Const.SkillType.Special;
		this.m.IsHidden = true;
		this.m.IsSerialized = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function onAdded()
	{
		// TODO: Better to do this via a skill_container.onAnySkillAdded event
		if (this.getContainer().hasSkill("effects.rf_warmth_potion"))
		{
			this.removeSelf();
		}
	}

	function onTurnStart()
	{
		local actor = this.getContainer().getActor();
		foreach (a in ::Tactical.Entities.getAdjacentActors(actor.getTile()))
		{
			if (a.isAlliedWith(actor))
				continue;

			local s = a.getSkills().getSkillByID("effects.rf_frostbound");
			if (s != null)
			{
				s.onEnemyTurnStart(actor);
				if (!actor.isAlive())
				{
					break;
				}
			}
		}
	}

	function onTurnEnd()
	{
		local frostbound = null;
		local actor = this.getContainer().getActor();
		foreach (a in ::Tactical.Entities.getAdjacentActors(actor.getTile()))
		{
			if (a.isAlliedWith(actor))
				continue;

			local s = a.getSkills().getSkillByID("effects.rf_frostbound");
			if (s != null)
			{
				frostbound = s;
				s.onEnemyTurnEnd(actor);
				if (!actor.isAlive())
				{
					break;
				}
			}
		}

		if (frostbound != null && actor.isAlive())
		{
			::Sound.play(::MSU.Array.rand(frostbound.m.SoundOnUse), ::Const.Sound.Volume.Actor * actor.m.SoundVolume[::Const.Sound.ActorEvent.DamageReceived] * (::Math.rand(75, 100) * 0.01), actor.getPos(), actor.m.SoundPitch);
		}
	}
});
