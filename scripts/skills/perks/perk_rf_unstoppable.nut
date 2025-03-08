this.perk_rf_unstoppable <- ::inherit("scripts/skills/skill", {
	m = {
		Stacks = 0,
		MaxStacks = 5,
		IsGainingStackThisTurn = false
	},
	function create()
	{
		this.m.ID = "perk.rf_unstoppable";
		this.m.Name = ::Const.Strings.PerkName.RF_Unstoppable;
		this.m.Description = "This character is like a boulder rolling down a hill. Unstoppable!";
		this.m.Icon = "ui/perks/perk_rf_unstoppable.png";
		this.m.IconMini = "perk_rf_unstoppable_mini";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Perk;
	}

	function getName()
	{
		return this.m.Stacks == 0 ? this.m.Name : this.m.Name + " (x" + this.m.Stacks + ")";
	}

	function isHidden()
	{
		return this.m.Stacks == 0;
	}

	function getAPBonus()
	{
		return this.m.Stacks;
	}

	function getInitiativeBonus()
	{
		return this.m.Stacks * 10;
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();

		if (this.getAPBonus() != 0)
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/action_points.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeValue(this.getAPBonus(), {AddSign = true}) + " [Action Points|Concept.ActionPoints]")
			});
		}

		if (this.getInitiativeBonus() != 0)
		{
			ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeValue(this.getInitiativeBonus(), {AddSign = true}) + " [Initiative|Concept.Initiative]")
			});
		}

		ret.push({
			id = 20,
			type = "text",
			icon = "ui/icons/warning.png",
			text = ::Reforged.Mod.Tooltips.parseString("Will expire upon using [Wait|Concept.Wait] or [Recover|Skill+recover_skill] or getting [stunned,|Skill+stunned_effect] rooted, or [staggered|Skill+staggered_effect]")
		});

		return ret;
	}

	function onTurnStart()
	{
		this.m.IsGainingStackThisTurn = false;
	}

	function onTurnEnd()
	{
		local actor = this.getContainer().getActor();
		if (actor.getActionPoints() > actor.getActionPointsMax() / 2)
			this.m.Stacks = 0;
		else if (this.m.IsGainingStackThisTurn)
			this.m.Stacks = ::Math.min(this.m.MaxStacks, this.m.Stacks + 1);
	}

	function onWaitTurn()
	{
		this.m.Stacks = 0;
	}

	function onAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		if (!::Tactical.TurnSequenceBar.isActiveEntity(this.getContainer().getActor()))
			return;

		if (_skill.isAttack())
		{
			this.m.IsGainingStackThisTurn = true;
		}
		else if (_skill.getID() == "actives.recover")
		{
			this.m.Stacks = 0;
			this.m.IsGainingStackThisTurn = false;
		}
	}

	function onUpdate( _properties )
	{
		if (_properties.IsStunned || _properties.IsRooted || this.getContainer().getActor().getMoraleState() == ::Const.MoraleState.Fleeing || this.getContainer().hasSkill("effects.staggered"))
		{
			this.m.Stacks = 0;
			return;
		}

		_properties.ActionPoints += this.getAPBonus();
		_properties.Initiative += this.getInitiativeBonus();
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.Stacks = 0;
		this.m.IsGainingStackThisTurn = false;
	}

	function onQueryTooltip( _skill, _tooltip )
	{
		if (this.m.Stacks != 0 && _skill.getID() == "actives.recover")
		{
			_tooltip.push({
				id = 100,
				type = "text",
				icon = "ui/icons/warning.png",
				text = ::Reforged.Mod.Tooltips.parseString("Will cause you to lose all stacks of " + ::Reforged.NestedTooltips.getNestedPerkName(this))
			});
		}
	}
});
