::Reforged.HooksMod.hook("scripts/skills/effects/taunted_effect", function(q) {
	q.m.DefenseModifier <- 0;

	q.create = @(__original) function()
	{
		__original();
		this.m.Description = "This character is taunted by another character and is much more likely to engage and attack them.";
	}

	q.isHidden = @() function()
	{
		return ::MSU.isNull(this.getTauntSource());
	}

	q.getTooltip = @(__original) function()
	{
		local ret = __original();

		if (this.getTauntSource() != null)
		{
			ret.push({
				id = 9,
				type = "text",
				icon = "ui/icons/special.png",
				text = "This character has been taunted by " + ::MSU.Text.colorNegative(this.getTauntSource().getName())
			});

			if (this.getMeleeDefenseModifier() != 0)
			{
				ret.push({
					id = 10,
					type = "text",
					icon = "ui/icons/melee_defense.png",
					text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeValue(this.getMeleeDefenseModifier()) + " [Melee Defense|Concept.MeleeDefense]")
				});
			}

			if (this.getRangedDefenseModifier() != 0)
			{
				ret.push({
					id = 11,
					type = "text",
					icon = "ui/icons/ranged_defense.png",
					text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeValue(this.getRangedDefenseModifier()) + " [Ranged Defense|Concept.RangeDefense]")
				});
			}
		}

		return ret;
	}

	q.onUpdate = @(__original) function( _properties )
	{
		__original(_properties);

		if (this.getTauntSource() != null)
		{
			_properties.MeleeDefense += this.getMeleeDefenseModifier();
			_properties.RangedDefense += this.getRangedDefenseModifier();
		}
	}

// New Functions
	q.getTauntSource <- function()
	{
		local ret = this.getContainer().getActor().getAIAgent().getForcedOpponent();
		return !::MSU.isNull(ret) && ret.isAlive() ? ret : null;
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
