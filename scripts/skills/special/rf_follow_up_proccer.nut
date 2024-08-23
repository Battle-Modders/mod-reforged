this.rf_follow_up_proccer <- ::inherit("scripts/skills/skill", {
	m = {
		SkillCount = 0
	},
	function create()
	{
		this.m.ID = "special.rf_follow_up_proccer";
		this.m.Icon = "ui/perks/perk_rf_follow_up.png";
		//this.m.IconMini = "perk_01_mini";
		this.m.Type = ::Const.SkillType.Special;
		this.m.IsHidden = true;
		this.m.IsSerialized = false;
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (!_skill.isAttack() || _skill.isRanged() || _targetEntity == null || !_targetEntity.isAlive() || _targetEntity.isDying())
		{
			return;
		}

		local actor = this.getContainer().getActor();

		if (this.m.SkillCount == ::Const.SkillCounter || _targetEntity.isAlliedWith(actor) || !::Tactical.TurnSequenceBar.isActiveEntity(actor))
		{
			return;
		}

		this.m.SkillCount = ::Const.SkillCounter;

		local targetTile = _targetEntity.getTile();

		local allies = ::Tactical.Entities.getHostileActors(_targetEntity.getFaction(), _targetEntity.getTile(), 2);
		foreach (ally in allies)
		{
			if (ally.isAlliedWith(actor) && ally.getID() != actor.getID())
			{
				local allySkill = ally.getSkills().getSkillByID("effects.rf_follow_up");
				if (allySkill != null)
				{
					if (!ally.isHiddenToPlayer() || targetTile.IsVisibleForPlayer)
					{
						this.getContainer().setBusy(true);
						allySkill.getContainer().setBusy(true);
						::Time.scheduleEvent(::TimeUnit.Virtual, 300, function( _proccer ) {
							allySkill.proc(_targetEntity);
							allySkill.getContainer().setBusy(false);
							_proccer.getContainer().setBusy(false);
						}.bindenv(this), this);
					}
					else
					{
						allySkill.proc(_targetEntity);
					}
				}
			}
		}
	}
});
