this.perk_rf_the_rush_of_battle <- ::inherit("scripts/skills/skill", {
	m = {
		// We use two pools because each pool is tracked separately and expires at the end of the next turn
		StackPool1 = 0,
		StackPool2 = 0,
		CurrPool = true, // Which pool is currently gaining stacks. true is pool 1 and false is pool 2. Flipped onTurnEnd.
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

		local stacksToLose = this.m.CurrPool ? this.getStacks() - this.m.StackPool1 : this.getStacks() - this.m.StackPool2;
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
		local pool = this.m.CurrPool ? "StackPool1" : "StackPool2";
		this.m[pool] = ::Math.min(this.m.MaxStacks, this.m[pool] + _num);
	}

	function getStacks()
	{
		return ::Math.min(this.m.MaxStacks, this.m.StackPool1 + this.m.StackPool2);
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
		if (this.m.CurrPool)
		{
			this.m.StackPool2 = 0;
		}
		else
		{
			this.m.StackPool1 = 0;
		}
	}

	function onTurnStart()
	{
		// Any stacks gained before the start of the first turn should be in the first pool
		if (::Time.getRound() != 1)
			this.m.CurrPool = !this.m.CurrPool;
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.StackPool1 = 0;
		this.m.StackPool2 = 0;
		this.m.CurrPool = true;
	}
});
