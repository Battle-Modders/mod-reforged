this.perk_rf_survival_instinct <- ::inherit("scripts/skills/skill", {
	m = {
		MissStacks = 0,
		HitStacks = 0,
		MissStacksMax = 5,
		HitStacksMax = 2,
		BonusPerMiss = 2,
		BonusPerHit = 5,
		IsGettingHit = false
	},
	function create()
	{
		this.m.ID = "perk.rf_survival_instinct";
		this.m.Name = ::Const.Strings.PerkName.RF_SurvivalInstinct;
		this.m.Description = "This character\'s senses are heightened when faced with mortal danger.";
		this.m.Icon = "ui/perks/perk_rf_survival_instinct.png";
		this.m.IconMini = "perk_rf_survival_instinct_mini";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Perk;
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
		local ret = this.skill.getTooltip();

		local bonus = this.getBonus();

		ret.extend([
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorPositive("+" + bonus) + " [Melee Defense|Concept.MeleeDefense]")
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorPositive("+" + bonus) + " [Ranged Defense|Concept.RangeDefense]")
			}
		]);

		return ret;
	}

	function getBonus()
	{
		return (this.m.MissStacks * this.m.BonusPerMiss) + (this.m.HitStacks * this.m.BonusPerHit);
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		this.m.IsGettingHit = false;
		if (_skill != null && _skill.isAttack() && _attacker != null && _attacker.getID() != this.getContainer().getActor().getID())
		{
			this.m.IsGettingHit = true;
		}
	}

	function onDamageReceived( _attacker, _damageHitpoints, _damageArmor )
	{
		if (!this.m.IsGettingHit)
			return;

		if (!this.getContainer().RF_isNewSkillUseOrEntity(_attacker, true))
			return;

		this.m.HitStacks = ::Math.min(this.m.HitStacksMax, this.m.HitStacks + 1);
	}

	function onMissed( _attacker, _skill )
	{
		if (_skill == null || !_skill.isAttack() || _attacker == null || _attacker.getID() == this.getContainer().getActor().getID())
			return;

		if (!this.getContainer().RF_isNewSkillUseOrEntity(_attacker, true))
			return;

		this.m.MissStacks = ::Math.min(this.m.MissStacksMax, this.m.MissStacks + 1);
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

		if (this.m.HitStacks > this.m.HitStacksMax)
		{
			this.m.HitStacks = this.m.HitStacksMax;
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
				text = ::MSU.Text.colorNegative(this.getBonus() + " %") + this.m.Name
			});
		}
	}
});
