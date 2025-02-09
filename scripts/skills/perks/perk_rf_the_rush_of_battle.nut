this.perk_rf_the_rush_of_battle <- ::inherit("scripts/skills/skill", {
	m = {
		NewStacks = 0, // Gained from start of a turn until start of next turn at which point are converted into OldStacks.
		OldStacks = 0, // Reset to 0 at the end of a turn.
		BonusPerStack = 5,
		MaxStacks = 5
	},
	function create()
	{
		this.m.ID = "perk.rf_the_rush_of_battle";
		this.m.Name = ::Const.Strings.PerkName.RF_TheRushOfBattle;
		this.m.Description = "This character is in the thick of battle. The heart beats faster, pumping fresh blood through the veins.";
		this.m.Icon = "ui/perks/perk_rf_the_rush_of_battle.png";
		this.m.IconMini = "perk_rf_the_rush_of_battle_mini";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Any;
	}

	function getName()
	{
		local stacks = this.getStacks();
		return stacks > 1 ? this.m.Name + " (x" + stacks + ")" : this.m.Name;
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();
		local bonus = this.getBonus();

		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/initiative.png",
			text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorPositive("+" + bonus) + " [Initiative|Concept.Initiative]")
		});

		ret.push({
			id = 11,
			type = "text",
			icon = "ui/icons/fatigue.png",
			text = ::Reforged.Mod.Tooltips.parseString("Skills build up " + ::MSU.Text.colorPositive(bonus + "%") + " less [Fatigue|Concept.Fatigue]")
		});

		local stacksToLose = this.getStacks() - this.m.NewStacks;
		if (stacksToLose > 0)
		{
			ret.push({
				id = 12,
				type = "text",
				icon = "ui/icons/warning.png",
				text = ::Reforged.Mod.Tooltips.parseString("Will lose " + ::MSU.Text.colorNegative(stacksToLose) + " stack(s) at the end of this [turn|Concept.Turn]")
			});
		}

		return ret;
	}

	function isHidden()
	{
		return this.getStacks() == 0;
	}

	function onMissed( _attacker, _skill )
	{
		if (_attacker != null && _skill.isAttack())
		{
			this.addStacks(1);
		}
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		if (_skill != null && _skill.isAttack() && _attacker != null && _attacker.getID() != this.getContainer().getActor().getID())
		{
			this.addStacks(1);
		}
	}

	function onAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		if (_skill.isAttack())
		{
			this.addStacks(1);
		}
	}

	function addStacks( _num )
	{
		this.m.NewStacks = ::Math.min(this.m.MaxStacks, this.m.NewStacks + 1);
	}

	function getStacks()
	{
		return ::Math.min(this.m.MaxStacks, this.m.NewStacks + this.m.OldStacks);
	}

	function getBonus()
	{
		return this.getStacks() * this.m.BonusPerStack;
	}

	function onUpdate( _properties )
	{
		if (this.getStacks() > 0)
		{
			local bonus = this.getBonus();
			_properties.Initiative += bonus;
		}
	}

	function onAfterUpdate( _properties )
	{
		if (this.getStacks() > 0)
		{
			foreach (skill in this.getContainer().getAllSkillsOfType(::Const.SkillType.Active))
			{
				skill.m.FatigueCostMult *= 1.0 - this.getBonus() * 0.01;
			}
		}
	}

	function onTurnEnd()
	{
		this.m.OldStacks = 0;
	}

	function onTurnStart()
	{
		// Any stacks gained before the start of the first turn should be considered NewStacks
		if (::Time.getRound() != 1)
		{
			this.m.OldStacks = this.m.NewStacks;
			this.m.NewStacks = 0;
		}
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.NewStacks = 0;
		this.m.OldStacks = 0;
	}
});
