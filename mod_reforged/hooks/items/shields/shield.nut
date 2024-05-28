::Reforged.HooksMod.hook("scripts/items/shields/shield", function(q) {
	q.m.ReachIgnore <- 2; // By default it is 2 so we don't have to hook all shields to add this

	q.getReachIgnore <- function()
	{
		return this.m.ReachIgnore;
	}

	q.getTooltip = @(__original) function()
	{
		local ret = __original();

		if (this.RF_getDefenseMult() != 1.0)
		{
			ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = ::Reforged.Mod.Tooltips.parseString("Except when using [Shieldwall|Skill+shieldwall], the defense values drop linearly as you build [Fatigue|Concept.Fatigue] up to " + ::MSU.Text.colorizeMult(this.RF_getDefenseMult()) + " at maximum [Fatigue|Concept.Fatigue]")
			});
		}

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

		return ::Math.floor(__original() * this.RF_getDefenseMult());
	}

	q.getRangedDefense = @(__original) function()
	{
		if (::MSU.isNull(this.getContainer()) || ::MSU.isNull(this.getContainer().getActor()))
			return __original();

		return ::Math.floor(__original() * this.RF_getDefenseMult());
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
		_properties.DefensiveReachIgnore += this.getReachIgnore();
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

	// Used to drop defenses of the actor as the actor builds fatigue
	q.RF_getDefenseMult <- function()
	{
		if (::MSU.isNull(this.getContainer()) || ::MSU.isNull(this.getContainer().getActor()))
		{
			return 0.5;
		}

		local actor = this.getContainer().getActor();
		if (actor.getSkills().hasSkill("effects.shieldwall"))
		{
			return 1.0;
		}

		return (actor.getCurrentProperties().IsSpecializedInShields ? 0.75 : 0.5) * actor.getFatigue() / actor.getFatigueMax();
	}
});
