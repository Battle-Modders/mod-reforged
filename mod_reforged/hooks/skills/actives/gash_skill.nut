::mods_hookExactClass("skills/actives/gash_skill", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.HitChanceBonus = 5;
		this.m.AIBehaviorID = ::Const.AI.Behavior.ID.Gash;
	}

	o.getTooltip = function()
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

	o.onAnySkillUsed = function( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.MeleeSkill += this.m.HitChanceBonus;
		}
	}
});
