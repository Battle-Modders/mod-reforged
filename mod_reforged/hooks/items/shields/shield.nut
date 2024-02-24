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

	q.getMeleeDefense = @(__original) function( _isScaled = true, _respectShieldIgnore = true )
	{
		if (!_isScaled || ::MSU.isNull(this.getContainer()) || ::MSU.isNull(this.getContainer().getActor()))
			return __original();

		local actor = this.getContainer().getActor();
		local mult = actor.getCurrentProperties().ShieldDefenseMult;
		if (mult < 0.0)
		{
			if (_respectShieldIgnore)
			{
				mult = 0.0;	// a negative mult means that the defense is ignored
			}
			else	// _respectShieldIgnore is only ever false when we want to display how much defense a character would have had if their shield was functioning normally/is not ignored
			{
				mult = ::Math.abs(mult);
			}
		}

		return ::Math.floor(__original() * mult);
	}

	q.getRangedDefense = @(__original) function( _isScaled = true, _respectShieldIgnore = true )
	{
		if (!_isScaled || ::MSU.isNull(this.getContainer()) || ::MSU.isNull(this.getContainer().getActor()))
			return __original();

			local actor = this.getContainer().getActor();
			local mult = actor.getCurrentProperties().ShieldDefenseMult;
			if (mult < 0.0)
			{
				if (_respectShieldIgnore)
				{
					mult = 0.0;	// a negative mult means that the defense is ignored
				}
				else
				{
					mult = ::Math.abs(mult);
				}
			}

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
		_properties.DefensiveReachIgnore += this.getReachIgnore();
	}

// New Functions
});
