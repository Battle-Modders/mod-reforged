this.perk_rf_the_rush_of_battle <- ::inherit("scripts/skills/skill", {
	m = {
		Stacks = 0,
		BonusPerStack = 5,
		MaxStacks = 5
	},
	function create()
	{
		this.m.ID = "perk.rf_the_rush_of_battle";
		this.m.Name = ::Const.Strings.PerkName.RF_TheRushOfBattle;
		this.m.Description = "This character is in the thick of battle. The heart beats faster, pumping fresh blood through the veins.";
		this.m.Icon = "ui/perks/rf_the_rush_of_battle.png";
		this.m.IconMini = "rf_the_rush_of_battle_mini";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function getName()
	{
		return this.m.Stacks > 1 ? this.m.Name + " (x" + this.m.Stacks + ")" : this.m.Name;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();
		local bonus = this.getBonus();

		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/initiative.png",
			text = "[color=" + ::Const.UI.Color.PositiveValue + "]+" + bonus + "[/color] Initiative"
		});

		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/melee_skill.png",
			text = "Skills build up [color=" + ::Const.UI.Color.PositiveValue + "]" + bonus + "%[/color] less Fatigue"
		});

		return tooltip;
	}

	function isHidden()
	{
		return this.m.Stacks == 0;
	}

	function onMissed( _attacker, _skill )
	{
		if (_attacker != null && _skill.isAttack())
		{
			this.m.Stacks = ::Math.min(this.m.MaxStacks, this.m.Stacks + 1);
		}
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		if (_skill != null && _skill.isAttack() && _attacker != null && _attacker.getID() != this.getContainer().getActor().getID())
		{
			this.m.Stacks = ::Math.min(this.m.MaxStacks, this.m.Stacks + 1);
		}
	}

	function getBonus()
	{
		return this.m.Stacks * this.m.BonusPerStack;
	}

	function onUpdate( _properties )
	{
		if (this.m.Stacks > 0)
		{
			local bonus = this.getBonus();
			_properties.Initiative += bonus;
		}
	}

	function onAfterUpdate( _properties )
	{
		if (this.m.Stacks > 0)
		{
			foreach (skill in this.getContainer().getAllSkillsOfType(::Const.SkillType.Active))
			{
				skill.m.FatigueCostMult *= 1.0 - this.getBonus() * 0.01;
			}
		}
	}

	function onTurnEnd()
	{
		this.m.Stacks = 0;
	}

	function onCombatStarted()
	{
		this.m.Stacks = 0;
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.Stacks = 0;
	}
});
