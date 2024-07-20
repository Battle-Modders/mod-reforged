::Reforged.HooksMod.hook("scripts/skills/actives/gash_skill", function(q) {
	q.m.BleedStacks <- 3;

	q.create = @(__original) function()
	{
		__original();
		this.m.HitChanceBonus = 5;
		this.m.AIBehaviorID = ::Const.AI.Behavior.ID.Gash;
	}

	q.getTooltip = @() function()
	{
		local ret = this.getDefaultTooltip();
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/hitchance.png",
			text = "Has " + ::MSU.Text.colorizePercentage(this.m.HitChanceBonus) + " chance to hit"
		});

		if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInSwords)
		{
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Has a [color=" + ::Const.UI.Color.NegativeValue + "]50%[/color] lower threshold to inflict injuries"
			});
		}
		else
		{
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Has a [color=" + ::Const.UI.Color.NegativeValue + "]33%[/color] lower threshold to inflict injuries"
			});
		}

		if (this.m.BleedStacks != 0)
		{
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Reforged.Mod.Tooltips.parseString("Applies " + ::MSU.Text.colorGreen(this.m.BleedStacks) + " stacks of [Bleeding|Skill+bleeding_effect] when inflicting at least " + ::MSU.Text.colorRed(::Const.Combat.MinDamageToApplyBleeding) + " damage")
			});
		}

		return ret;
	}

	q.onAnySkillUsed = @() function( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.MeleeSkill += this.m.HitChanceBonus;
		}
	}

	q.onTargetHit = @(__original) function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		__original(_skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor);
		if (_skill == this && _targetEntity.isAlive() && _damageInflictedHitpoints >= ::Const.Combat.MinDamageToApplyBleeding && !_targetEntity.getCurrentProperties().IsImmuneToBleeding)
		{
			local bleed = ::new("scripts/skills/effects/bleeding_effect");
			for (local i = 0; i < this.m.BleedStacks; i++)
			{
				_targetEntity.getSkills().add(bleed);
			}
		}
	}
});
