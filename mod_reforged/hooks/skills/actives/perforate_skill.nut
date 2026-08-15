::Reforged.HooksMod.hook("scripts/skills/actives/perforate_skill", function(q) {
	q.m.MeleeSkillAdd <- -10;

	q.create = @(__original) { function create()
	{
		__original();
		this.m.DirectDamageMult = 0.25;
	}}.create;

	q.getTooltip = @() { function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		ret.extend([
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Will perform two quick thrusts"
			},
			{
				id = 9,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Reforged.Mod.Tooltips.parseString("Performs an additional attack for every 75 [Initiative|Concept.Initiative] higher than the target")
			}
		]);

		return ret;
	}}.getTooltip;

	q.onAfterUpdate = @() { function onAfterUpdate( _properties )
	{
        // Use sword mastery instead of dagger
		if (_properties.IsSpecializedInSwords)
		{
			this.m.FatigueCostMult = this.Const.Combat.WeaponSpecFatigueMult;
		}
	}}.onAfterUpdate;

    // Overwrite to change injury into init difference
	q.onUse = @() { function onUse( _user, _targetTile )
	{		
		this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectStab);
		local target = _targetTile.getEntity();
        // this can be float
		local injuryCount = (_user.getInitiative() - target.getInitiative())/75;
		local ret = this.attackEntity(_user, target);
		local timeDelay = 200;

		if ((this.Tactical.TurnSequenceBar.getActiveEntity() == null || this.Tactical.TurnSequenceBar.getActiveEntity().getID() == _user.getID()) && (!_user.isHiddenToPlayer() || _targetTile.IsVisibleForPlayer))
		{
			this.m.IsDoingAttackMove = false;
			this.getContainer().setBusy(true);
			this.Time.scheduleEvent(this.TimeUnit.Virtual, 150, this.onAdditionalAttack, {
				User = _user,
				Skill = this,
				Target = target,
				IsLast = injuryCount < 1
			});

			for( local i = 0; i < injuryCount; i = ++i )
			{
				this.Time.scheduleEvent(this.TimeUnit.Virtual, timeDelay + this.Math.rand(0, 55), this.onAdditionalAttack, {
					User = _user,
					Skill = this,
					Target = target,
					IsLast = i == injuryCount - 1
				});
				timeDelay = timeDelay + 150;
			}

			return true;
		}
		else
		{
			if (target.isAlive())
			{
				this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.Skill, _user.getPos());
				ret = this.attackEntity(_user, target) || ret;
			}

			return ret;
		}
	}}.onUse;
});
