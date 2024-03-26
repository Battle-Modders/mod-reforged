::Reforged.HooksMod.hook("scripts/skills/effects/taunted_effect", function(q) {
	q.m.DefenseModifier <- 0;

	q.create = @(__original) function()
	{
		__original();
		this.m.Description = "This character is taunted by another character and is much more likely to engage and attack them.";
	}

	q.getTooltip = @(__original) function()
	{
		local ret = __original();

		if (this.getTauntedTarget() != null)
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "This character has been taunted by " + ::MSU.Text.colorRed(this.getTauntedTarget().getName())
			});
		}

		if (this.getMeleeDefenseModifier() != 0)
		{
			ret.push({
				id = 13,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = ::MSU.Text.colorizeValue(this.getMeleeDefenseModifier()) + " Melee Defense"
			});
		}

		if (this.getRangedDefenseModifier() != 0)
		{
			ret.push({
				id = 14,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = ::MSU.Text.colorizeValue(this.getRangedDefenseModifier()) + " Ranged Defense"
			});
		}

		return ret;
	}

	q.onUpdate = @(__original) function( _properties )
	{
		__original(_properties);

		_properties.MeleeDefense += this.getMeleeDefenseModifier();
		_properties.RangedDefense += this.getRangedDefenseModifier();
	}

// New Functions
	q.getTauntedTarget <- function()
	{
		return this.getContainer().getActor().getAIAgent().getForcedOpponent();
	}

	q.getMeleeDefenseModifier <- function()
	{
		return this.m.DefenseModifier;
	}

	q.getRangedDefenseModifier <- function()
	{
		return this.m.DefenseModifier;
	}
});
