::Reforged.HooksMod.hook("scripts/skills/actives/assault_skill", function(q) {
	q.getTooltip = @() { function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/hitchance.png",
			text = "Has [color=" + this.Const.UI.Color.PositiveValue + "]+" + this.getHitChanceModifier() + "%[/color] chance to hit"
		});
		ret.push({
			id = 9,
			type = "text",
			icon = "ui/icons/special.png",
			// TODO: bind this hew to the item
			text = ::Reforged.Mod.Tooltips.parseString("Performs an additional free [$ $|Skill+rf_assault_hew_skill] attack against staggered targets")
		});
		return ret;
	}}.getTooltip;

	// Put the 2nd hit into separate skill for clarity and easier damage type
	q.onUse = @() { function onUse( _user, _targetTile )
	{
		this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectImpale);
		local target = _targetTile.getEntity();
		this.setImpaleInfo();
		this.m.IsSecondAttack = false;
		local ret = this.attackEntity(_user, target);

		if (target.getSkills().hasSkill("effects.staggered") && target.isAlive())
		{
			if ((this.Tactical.TurnSequenceBar.getActiveEntity() == null || this.Tactical.TurnSequenceBar.getActiveEntity().getID() == _user.getID()) && (!_user.isHiddenToPlayer() || _targetTile.IsVisibleForPlayer))
			{
				this.m.IsDoingAttackMove = false;
				this.getContainer().setBusy(true);
				this.Time.scheduleEvent(this.TimeUnit.Virtual, 275, function ( _skill )
				{
					if (target.isAlive() && _skill.getContainer() != null)
					{
						_skill.getContainer().getSkills().getSkillByID("actives.rf_assault_hew").useForFree(target.getTile())
					}
				}.bindenv(this), this);
			}
			else
			{
				if (target.isAlive() && this._skill.getContainer() != null)
				{
					this.getContainer().getSkills().getSkillByID("actives.rf_assault_hew").useForFree(target.getTile())
				}
			}
		}

		// only the impale hit counts for the return value
		return ret;
	}}.onUse;
});
