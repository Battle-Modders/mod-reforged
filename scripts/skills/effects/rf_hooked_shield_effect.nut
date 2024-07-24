this.rf_hooked_shield_effect <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.rf_hooked_shield";
		this.m.Name = "Hooked Shield";
		this.m.Description = "This character\'s shield has been hooked and pulled away, making it difficult to use the shield properly.";
		this.m.Icon = "skills/rf_hooked_shield_effect.png";
		this.m.IconMini = "rf_hooked_shield_effect_mini";
		this.m.Overlay = "rf_hooked_shield_effect";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.IsRemovedAfterBattle = true;
	}

	function isHidden()
	{
		return !this.getContainer().getActor().isArmedWithShield();
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();
		local shield = this.getContainer().getActor().getOffhandItem();
		if (shield == null) // can be null during nested tooltip
		{
			ret.push({
				id = 9,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Reforged.Mod.Tooltips.parseString("Reduces the [Melee Defense|Concept.MeleeDefense] and [Ranged Defense|Concept.RangedDefense] granted by shields by " + ::MSU.Text.colorNegative("75%"))
			});
		}
		else
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeValue(-::Math.floor(shield.getMeleeDefenseBonus() * 0.75)) + " [Melee Defense|Concept.MeleeDefense] from equipped shield")
			});
			ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeValue(-::Math.floor(shield.getRangedDefenseBonus() * 0.75)) + " [Ranged Defense|Concept.RangeDefense] from equipped shield")
			});
		}
		ret.push({
			id = 12,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("Removes [Riposte|Skill+riposte_effect] and disables [Rebuke|Skill+rf_rebuke_effect]")
		});
		ret.push({
			id = 13,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("Will expire upon using any skill or starting a new [turn|Concept.Turn]")
		});

		return ret;
	}

	function onAdded()
	{
		this.getContainer().removeByID("effects.riposte");
	}

	// Make it impossible to swap the shield away while it is hooked
	function getItemActionCost( _items )
	{
		if (this.isHidden())
			return null;

		local shield = this.getContainer().getActor().getOffhandItem();
		foreach (item in _items)
		{
			if (item != null && ::MSU.isEqual(item, shield))
			{
				return 99;
			}
		}
	}

	function onUpdate( _properties )
	{
		if (!this.isHidden())
		{
			local shield = this.getContainer().getActor().getOffhandItem();
			_properties.MeleeDefense -= ::Math.floor(shield.getMeleeDefenseBonus() * 0.75);
			_properties.RangedDefense -= ::Math.floor(shield.getRangedDefenseBonus() * 0.75);
		}
	}

	// Add the defenses back for skills that ignore shield because we don't want them to double dip
	function onBeingAttacked( _attacker, _skill, _properties )
	{
		if (!_skill.m.IsShieldRelevant && !this.isHidden())
		{
			local shield = this.getContainer().getActor().getOffhandItem();
			_properties.MeleeDefense += ::Math.floor(shield.getMeleeDefenseBonus() * 0.75);
			_properties.RangedDefense += ::Math.floor(shield.getRangedDefenseBonus() * 0.75);
		}
	}

	function onAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		this.removeSelf();
	}

	function onTurnStart()
	{
		this.removeSelf();
	}

	function onGetHitFactorsAsTarget( _skill, _targetTile, _tooltip )
	{
		if (this.isHidden())
			return;

		local shield = this.getContainer().getActor().getOffhandItem();
		local bonus = _skill.isRanged() ? ::Math.floor(shield.getRangedDefenseBonus() * 0.75) : ::Math.floor(shield.getMeleeDefenseBonus() * 0.75);
		_tooltip.push({
			icon = "ui/tooltips/positive.png",
			text = ::MSU.Text.colorPositive(bonus + "% ") + this.getName()
		});
	}

	function onQueryTooltip( _skill, _tooltip )
	{
		if (_skill.getID() == "effects.rf_rebuke" && !this.isHidden())
		{
			local filename = ::IO.scriptFilenameByHash(this.ClassNameHash).split("/").top();
			_tooltip.push({
				id = 7,
				type = "text",
				icon = "ui/icons/warning.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorNegative("Is disabled because of [" + this.getName() + "|Skill+" + filename"]"))
			});
		}
	}
});
