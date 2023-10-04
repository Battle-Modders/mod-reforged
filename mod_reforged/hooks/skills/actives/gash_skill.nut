::Reforged.HooksMod.hook("scripts/skills/actives/gash_skill", function(q) {
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
				text = "Has a [color=" + this.Const.UI.Color.NegativeValue + "]50%[/color] lower threshold to inflict injuries"
			});
		}
		else
		{
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Has a [color=" + this.Const.UI.Color.NegativeValue + "]33%[/color] lower threshold to inflict injuries"
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
});
