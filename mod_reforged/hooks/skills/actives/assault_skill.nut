::Reforged.HooksMod.hook("scripts/skills/actives/assault_skill", function(q) {
	q.getTooltip = @() { function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		// create temp skill to bind to the same container instead of dummy
		local hew = ::Reforged.new("scripts/skills/actives/rf_assault_hew_skill");
		hew.m.Container = this.getContainer();
		hew.saveBaseValues();
		local extraData = "";
		if (this.getContainer().getActor() != null)
		{
			extraData = "entityId:" + this.getContainer().getActor().getID();
		}
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
			text = ::Reforged.Mod.Tooltips.parseString("Follow up with a weaker " + ::Reforged.NestedTooltips.getNestedSkillName(hew,extraData) + " attack against staggered targets")
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
						local hew = _skill.getContainer().getSkillByID("actives.rf_assault_hew")
						hew.m.IsHidden = false;
						hew.useForFree(target.getTile())
						hew.m.IsHidden = true;
					}
				}.bindenv(this), this);
			}
			else
			{
				if (target.isAlive() && this.getContainer() != null)
				{
					local hew = _skill.getContainer().getSkillByID("actives.rf_assault_hew")
					hew.m.IsHidden = false;
					hew.useForFree(target.getTile())
				}
			}
		}

		// only the impale hit counts for the return value
		return ret;
	}}.onUse;
});
