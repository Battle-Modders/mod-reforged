::Reforged.HooksMod.hook("scripts/items/shields/shield", function(q) {
	q.m.ReachIgnore <- 2; // By default it is 2 so we don't have to hook all shields to add this

	q.getReachIgnore <- function()
	{
		return this.m.ReachIgnore;
	}

	q.getTooltip = @(__original) function()
	{
		local ret = __original();

		local maxReduction = 0.5;
		if (!::MSU.isNull(this.getContainer()) && !::MSU.isNull(this.getContainer().getActor()))
		{
			maxReduction = this.getContainer().getActor().getCurrentProperties().IsSpecializedInShields ? 0.25 : 0.5;
		}

		ret.push({
			id = 8,
			type = "text",
			icon = "ui/icons/fatigue.png",
			text = ::Reforged.Mod.Tooltips.parseString("The defense values drop linearly as you build [Fatigue|Concept.Fatigue] up to " + ::MSU.Text.colorRed((maxReduction * 100) + "%") + " at maximum [Fatigue|Concept.Fatigue]")
		});

		ret.push({
			id = 8,
			type = "text",
			icon = "ui/icons/reach.png",
			text = ::Reforged.Mod.Tooltips.parseString("Ignores " + ::MSU.Text.colorGreen(this.getReachIgnore()) + " [Reach Advantage|Concept.ReachAdvantage]")
		});

		return ret;
	}

	q.getMeleeDefense = @(__original) function()
	{
		if (::MSU.isNull(this.getContainer()) || ::MSU.isNull(this.getContainer().getActor()))
			return __original();

		local actor = this.getContainer().getActor();
		local mult = 1.0 - (actor.getFatigue() / actor.getFatigueMax()) * (actor.getCurrentProperties().IsSpecializedInShields ? 0.25 : 0.5);
		return ::Math.floor(__original() * mult);
	}

	q.getRangedDefense = @(__original) function()
	{
		if (::MSU.isNull(this.getContainer()) || ::MSU.isNull(this.getContainer().getActor()))
			return __original();

		local actor = this.getContainer().getActor();
		local mult = 1.0 - (actor.getFatigue() / actor.getFatigueMax()) * (actor.getCurrentProperties().IsSpecializedInShields ? 0.25 : 0.5);
		return ::Math.floor(__original() * mult);
	}

	// We hook it to use getMeleeDefense(), getRangedDefense(), getStaminaModifier() instead of
	// vanilla using this.m.MeleeDefense, this.m.RangedDefense, this.m.StaminaModifier.
	q.onUpdateProperties = @() function( _properties )
	{
		if (this.m.Condition == 0)
		{
			return;
		}

		local mult = this.getContainer().getActor().getCurrentProperties().IsSpecializedInShields ? 1.25 : 1.0;

		_properties.MeleeDefense += ::Math.floor(this.getMeleeDefense() * mult);
		_properties.RangedDefense += ::Math.floor(this.getRangedDefense() * mult);
		_properties.Stamina += this.getStaminaModifier();
	}

// New Functions
	q.getMeleeDefenseBonus <- function()
	{
		local mult = (this.getContainer().getActor().getCurrentProperties().IsSpecializedInShields) ? 1.25 : 1.0;
		return ::Math.floor(this.getMeleeDefense() * mult);
	}

	q.getRangedDefenseBonus <- function()
	{
		local mult = (this.getContainer().getActor().getCurrentProperties().IsSpecializedInShields) ? 1.25 : 1.0;
		return ::Math.floor(this.getRangedDefense() * mult);
	}
});
