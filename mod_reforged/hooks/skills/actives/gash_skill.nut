::Reforged.HooksMod.hook("scripts/skills/actives/gash_skill", function(q) {
	q.m.BleedStacks <- 3;

	q.create = @(__original) { function create()
	{
		__original();
		this.m.HitChanceBonus = 5;
		this.m.AIBehaviorID = ::Const.AI.Behavior.ID.Gash;
	}}.create;

	q.getTooltip = @() { function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/hitchance.png",
			text = "Has " + ::MSU.Text.colorizeValue(this.m.HitChanceBonus, {AddSign = true, AddPercent = true}) + " chance to hit"
		});

		if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInSwords)
		{
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = ::Reforged.Mod.Tooltips.parseString("Has a " + ::MSU.Text.colorNegative("50%") + " lower [threshold|Concept.InjuryThreshold] to inflict [injuries|Concept.InjuryTemporary]")
			});
		}
		else
		{
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = ::Reforged.Mod.Tooltips.parseString("Has a " + ::MSU.Text.colorNegative("33%") + " lower [threshold|Concept.InjuryThreshold] to inflict [injuries|Concept.InjuryTemporary]")
			});
		}

		if (this.m.BleedStacks != 0)
		{
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Reforged.Mod.Tooltips.parseString("Applies " + ::MSU.Text.colorPositive(this.m.BleedStacks) + " stacks of [Bleeding|Skill+bleeding_effect] when inflicting at least " + ::MSU.Text.color(::Const.UI.Color.DamageValue, ::Const.Combat.MinDamageToApplyBleeding) + " damage")
			});
		}

		return ret;
	}}.getTooltip;

	q.onAnySkillUsed = @() { function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.MeleeSkill += this.m.HitChanceBonus;
		}
	}}.onAnySkillUsed;

	q.onTargetHit = @(__original) { function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
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
	}}.onTargetHit;
});
