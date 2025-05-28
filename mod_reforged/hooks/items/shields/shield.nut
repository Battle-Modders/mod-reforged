::Reforged.HooksMod.hook("scripts/items/shields/shield", function(q) {
	q.m.ReachIgnore <- 2; // By default it is 2 so we don't have to hook all shields to add this

	q.getReachIgnore <- { function getReachIgnore()
	{
		return this.m.ReachIgnore;
	}}.getReachIgnore;

	q.getTooltip = @(__original) { function getTooltip()
	{
		local ret = __original();

		if (this.RF_getDefenseMult() != 1.0)
		{
			ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = ::Reforged.Mod.Tooltips.parseString("Except when using [Shieldwall,|Skill+shieldwall] the defense values drop linearly as you build [Fatigue|Concept.Fatigue] up to " + ::MSU.Text.colorizeMult(this.RF_getDefenseMult()) + " at maximum [Fatigue|Concept.Fatigue]")
			});
		}

		if (this.getReachIgnore() != 0)
		{
			ret.push({
				id = 12,
				type = "text",
				icon = "ui/icons/rf_reach.png",
				text = ::Reforged.Mod.Tooltips.parseString("Ignores " + ::MSU.Text.colorPositive(this.getReachIgnore()) + " [Reach Advantage|Concept.ReachAdvantage]")
			});
		}

		return ret;
	}}.getTooltip;

	q.getMeleeDefense = @(__original) { function getMeleeDefense()
	{
		if (::MSU.isNull(this.getContainer()) || ::MSU.isNull(this.getContainer().getActor()))
			return __original();

		return ::Math.floor(__original() * this.RF_getDefenseMult());
	}}.getMeleeDefense;

	q.getRangedDefense = @(__original) { function getRangedDefense()
	{
		if (::MSU.isNull(this.getContainer()) || ::MSU.isNull(this.getContainer().getActor()))
			return __original();

		return ::Math.floor(__original() * this.RF_getDefenseMult());
	}}.getRangedDefense;

	// We hook it to use getMeleeDefense(), getRangedDefense(), getStaminaModifier() instead of
	// vanilla using this.m.MeleeDefense, this.m.RangedDefense, this.m.StaminaModifier.
	q.onUpdateProperties = @() { function onUpdateProperties( _properties )
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
	}}.onUpdateProperties;

// New Functions
	q.getMeleeDefenseBonus <- { function getMeleeDefenseBonus()
	{
		local mult = (this.getContainer().getActor().getCurrentProperties().IsSpecializedInShields) ? 1.25 : 1.0;
		return ::Math.floor(this.getMeleeDefense() * mult);
	}}.getMeleeDefenseBonus;

	q.getRangedDefenseBonus <- { function getRangedDefenseBonus()
	{
		local mult = (this.getContainer().getActor().getCurrentProperties().IsSpecializedInShields) ? 1.25 : 1.0;
		return ::Math.floor(this.getRangedDefense() * mult);
	}}.getRangedDefenseBonus;

	// Used to drop defenses of the actor as the actor builds fatigue
	q.RF_getDefenseMult <- { function RF_getDefenseMult()
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

		return 1.0 - (actor.getCurrentProperties().IsSpecializedInShields ? 0.25 : 0.5) * actor.getFatiguePct();
	}}.RF_getDefenseMult;
});
