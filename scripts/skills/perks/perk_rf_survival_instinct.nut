this.perk_rf_survival_instinct <- ::inherit("scripts/skills/skill", {
	m = {
		MissStacks = 0,
		HitStacks = 0,
		MissStacksMax = 5,
		HitStacksMax = 2,
		BonusPerMiss = 2,
		BonusPerHit = 5
	},
	function create()
	{
		this.m.ID = "perk.rf_survival_instinct";
		this.m.Name = ::Const.Strings.PerkName.RF_SurvivalInstinct;
		this.m.Description = "This character\'s senses are heightened when faced with mortal danger.";
		this.m.Icon = "ui/perks/rf_survival_instinct.png";
		this.m.IconMini = "rf_survival_instinct_mini";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = true;
	}

	function getName()
	{
		local name = this.m.Name;

		if (this.m.HitStacks > 0 && this.m.MissStacks > 0)
		{
			name += "(x" + this.m.HitStacks + " hits, x" + this.m.MissStacks + " misses)";
		}
		else if (this.m.HitStacks > 0)
		{
			name += "(x" + this.m.HitStacks + " hits)";
		}
		else
		{
			name += "(x" + this.m.MissStacks + " misses)";
		}

		return name;
	}

	function isHidden()
	{
		return this.m.HitStacks	== 0 && this.m.MissStacks == 0;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();

		local bonus = this.getBonus();

		tooltip.extend([
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=" + ::Const.UI.Color.PositiveValue + "]+" + bonus + "[/color] Melee Defense"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=" + ::Const.UI.Color.PositiveValue + "]+" + bonus + "[/color] Ranged Defense"
			}
		]);

		return tooltip;
	}

	function getBonus()
	{
		return (this.m.MissStacks * this.m.BonusPerMiss) + (this.m.HitStacks * this.m.BonusPerHit);
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		if (_skill != null && _skill.isAttack() && _attacker != null && _attacker.getID() != this.getContainer().getActor().getID())
		{
			this.m.HitStacks = ::Math.min(this.m.HitStacksMax, this.m.HitStacks + 1);
		}
	}

	function onMissed( _attacker, _skill )
	{
		if (_skill != null && _skill.isAttack() && _attacker != null && _attacker.getID() != this.getContainer().getActor().getID())
		{
			this.m.MissStacks = ::Math.min(this.m.MissStacksMax, this.m.MissStacks + 1);
		}
	}

	function onUpdate( _properties )
	{
		local bonus = this.getBonus();
		_properties.MeleeDefense += bonus;
		_properties.RangedDefense += bonus;
	}

	function onTurnStart()
	{
		this.m.MissStacks = 0;

		if (this.m.HitStacks > 2)
		{
			this.m.HitStacks = 2;
		}
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.MissStacks = 0;
		this.m.HitStacks = 0;
	}

	function onGetHitFactorsAsTarget( _skill, _targetTile, _tooltip )
	{
		if (_skill.isAttack() && (this.m.HitStacks > 0 || this.m.MissStacks > 0))
		{
			_tooltip.push({
				icon = "ui/tooltips/negative.png",
				text = ::MSU.Text.colorRed(this.getBonus()) + "% " + this.m.Name
			});
		}
	}
});
