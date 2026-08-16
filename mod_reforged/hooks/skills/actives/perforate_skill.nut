::Reforged.HooksMod.hook("scripts/skills/actives/perforate_skill", function(q) {
	q.m.MeleeSkillAdd <- -10;

	q.create = @(__original) { function create()
	{
		__original();
		this.m.Description = "A series of two or more thrusts made in quick succession. The faster you are related to your opponent, the more thrusts you perform.";
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
		
		if (this.m.MeleeSkillAdd != 0)
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Has " + ::MSU.Text.colorizeValue(this.m.MeleeSkillAdd, {AddSign = true, AddPercent = true}) + " chance to hit"
			});
		}

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
		// skill.onUse triggers after paying fatigue cost
        // this can be float
		local injuryCount = (_user.getInitiative() - target.getInitiative())/75;
		local ret = this.attackEntity(_user, target);
		local timeDelay = 200;
		local followup = this.getContainer().getSkillByID("actives.rf_perforate_sword_thrust");

		if ((this.Tactical.TurnSequenceBar.getActiveEntity() == null || this.Tactical.TurnSequenceBar.getActiveEntity().getID() == _user.getID()) && (!_user.isHiddenToPlayer() || _targetTile.IsVisibleForPlayer))
		{
			this.m.IsDoingAttackMove = false;
			this.getContainer().setBusy(true);
			this.Time.scheduleEvent(this.TimeUnit.Virtual, 150, this.onAdditionalAttack, {
				User = _user,
				Skill = this,
				SkillFollowUp = followup,
				Target = target,
				IsLast = injuryCount < 1
			});

			for( local i = 0; i < injuryCount; i = ++i )
			{
				this.Time.scheduleEvent(this.TimeUnit.Virtual, timeDelay + this.Math.rand(0, 55), this.onAdditionalAttack, {
					User = _user,
					Skill = this,
					SkillFollowUp = followup,
					Target = target,
					IsLast = i == injuryCount - 1
				});
				timeDelay = timeDelay + 150;
			}
		}
		else
		{
			if (target.isAlive())
			{
				this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.Skill, _user.getPos());
				followup.m.IsHidden = false;
				followup.useForFree(target.getTile())
				followup.m.IsHidden = true;
				for( local i = 0; i < injuryCount; i = ++i )
				{
					followup.m.IsHidden = false;
					followup.useForFree(target.getTile());
					followup.m.IsHidden = true;
				}
			}
		}

		// only the first hit counts for the return value
		return ret;
	}}.onUse;

	// use a different skill such that it works with tempo etc
	q.onAdditionalAttack = @() { function onAdditionalAttack( _tag )
	{		
		local user = _tag.User;
		local skill = _tag.Skill;
		local followup = _tag.SkillFollowUp;
		local target = _tag.Target;
		local isLast = _tag.IsLast;

		if (target.isAlive() && skill.getContainer() != null)
		{
			followup.m.IsHidden = false;
			followup.useForFree(target.getTile());
			followup.m.IsHidden = true;
		}

		if (isLast)
		{
			skill.m.IsDoingAttackMove = true;
			skill.getContainer().setBusy(false);
		}
	}}.onAdditionalAttack;

	// only applies to the first hit, follow up attacks uses the field defined in its own script
	q.onAnySkillUsed = @() { function onAnySkillUsed( _skill, _targetEntity, _properties )
	{		
		if (_skill == this)
		{
			if (!this.getContainer().getActor().isPlayerControlled())
			{
				_properties.MeleeSkill += this.m.MeleeSkillAdd;
			}
		}
	}}.onAnySkillUsed;
});
