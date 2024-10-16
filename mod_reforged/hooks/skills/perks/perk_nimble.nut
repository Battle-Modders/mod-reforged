::Reforged.HooksMod.hook("scripts/skills/perks/perk_nimble", function(q) {
	q.m.StaminaModifierThresholdMult <- 0.15;
	q.m.WeightThresholdMin <- 15;	// This perks weight threshold can never be lower than this

	q.isHidden = @() function()
	{
		return ::Math.floor(this.getHitpointsDamage() * 100) >= 100 && ::Math.floor(this.getArmorDamage() * 100) >= 100;
	}

	q.getTooltip = @() function()
	{
		local ret = this.skill.getTooltip();
		local hpBonus = ::Math.round(this.getHitpointsDamage() * 100);
		if (hpBonus < 100)
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Reforged.Mod.Tooltips.parseString("Damage to [Hitpoints|Concept.Hitpoints] from attacks is reduced by " + ::MSU.Text.colorPositive((100-hpBonus) + "%"))
			});
		}
		local armorBonus = ::Math.round(this.getArmorDamage() * 100);
		if (armorBonus < 100)
		{
			ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Damage to armor from attacks is reduced by " + ::MSU.Text.colorPositive((100-armorBonus) + "%")
			});
		}

		if (hpBonus >= 100 && armorBonus >= 100)
		{
			ret.push({
				id = 20,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = ::MSU.Text.colorNegative("This character\'s body and head armor are too heavy to gain any benefit from " + this.m.Name)
			});
		}

		ret.push({
			id = 12,
			type = "text",
			icon = "ui/icons/rf_reach.png",
			text = ::Reforged.Mod.Tooltips.parseString("Ignore 1 [Reach Disadvantage|Concept.ReachAdvantage] when attacking a target with lower [Initiative|Concept.Initiative] than yours")
		});

		local actor = this.getContainer().getActor();
		local maxHPString = ::Math.floor(actor.getHitpointsMax() / (hpBonus * 0.01));
		local currHPString = ::Math.floor(actor.getHitpoints() / (hpBonus * 0.01));

		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::MSU.Text.colorPositive("Effective Hitpoints: ") + currHPString + " / " + maxHPString
		});

		ret.push({
			id = 13,
			type = "text",
			icon = "ui/icons/fatigue.png",
			text = "The effectiveness is reduced above combined head and body armor weight of " + this.getStaminaModifierThreshold()
		});

		return ret;
	}

	q.getHitpointsDamage <- function()
	{
		local fat = this.getContainer().getActor().getItems().getStaminaModifier([::Const.ItemSlot.Body, ::Const.ItemSlot.Head]);
		fat = ::Math.min(0, fat + this.getStaminaModifierThreshold());
		return ::Math.minf(1.0, 1.0 - 0.5 + ::Math.pow(::Math.abs(fat), 1.23) * 0.01);
	}

	q.getArmorDamage <- function()
	{
		local fat = this.getContainer().getActor().getItems().getStaminaModifier([::Const.ItemSlot.Body, ::Const.ItemSlot.Head]);
		fat = ::Math.min(0, fat + this.getStaminaModifierThreshold());
		return ::Math.minf(1.0, 1.0 - 0.25 + ::Math.pow(::Math.abs(fat), 1.23) * 0.01);
	}

	q.onBeforeDamageReceived = @() function( _attacker, _skill, _hitInfo, _properties )
	{
		if (_attacker != null && _attacker.getID() == this.getContainer().getActor().getID() || _skill == null || !_skill.isAttack() || !_skill.isUsingHitchance())
		{
			return;
		}

		_properties.DamageReceivedRegularMult *= this.getHitpointsDamage();
		_properties.DamageReceivedArmorMult *= this.getArmorDamage();
	}

	q.onAnySkillUsed <- function( _skill, _targetEntity, _properties )
	{
		if (!this.isHidden() && _targetEntity != null && _skill.isAttack() && !_skill.isRanged() && _targetEntity.getInitiative() < this.getContainer().getActor().getInitiative())
		{
			_properties.OffensiveReachIgnore += 1;
		}
	}

	q.getStaminaModifierThreshold <- function()
	{
		local b = this.getContainer().getActor().getBaseProperties().getClone();
		foreach (trait in this.getContainer().getSkillsByFunction(@(s) s.isType(::Const.SkillType.Trait) || s.isType(::Const.SkillType.PermanentInjury)))
		{
			trait.onUpdate(b);
		}
		return ::Math.max(this.m.WeightThresholdMin, this.m.StaminaModifierThresholdMult * b.Stamina * (b.StaminaMult >= 0 ? b.StaminaMult : 1.0 / b.StaminaMult));
	}
});
