this.perk_rf_dynamic_duo_abstract <- ::inherit("scripts/skills/skill", {
	m = {
		PartnerSkill = null,
		AttackBonusEnemies = [],
		DefenseBonusEnemies = [],
		MeleeSkillModifier = 10,
		MeleeDefenseModifier = 10
	},
	function create()
	{
		this.m.ID = "perk.rf_dynamic_duo_abstract";
		this.m.Name = ::Const.Strings.PerkName.RF_DynamicDuo;
		this.m.Description = "Instead of fighting in a larger formation, this character has trained to fight as a duo and gains bonuses while there is only one nearby ally."
		this.m.Icon = "ui/perks/perk_rf_dynamic_duo.png";
		this.m.IconMini = "perk_rf_dynamic_duo_mini";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Perk;
	}

	function isEnabled()
	{
		if (::MSU.isNull(this.m.PartnerSkill) || ::MSU.isNull(this.m.PartnerSkill.getContainer()))
			return false;

		local actor = this.getContainer().getActor();
		local partner = this.m.PartnerSkill.getContainer().getActor();
		if (!actor.isPlacedOnMap() || !partner.isPlacedOnMap() || partner.getFaction() != actor.getFaction())
			return false;

		local myTile = actor.getTile();
		local partnerTile = partner.getTile();
		if (myTile.getDistanceTo(partnerTile) > 1)
			return false;

		return ::Tactical.Entities.getFactionActors(actor.getFaction(), myTile, 1, true).len() == 1 && ::Tactical.Entities.getFactionActors(partner.getFaction(), partnerTile, 1, true).len() == 1;
	}

	function isHidden()
	{
		return !this.isEnabled();
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Partner: " + this.m.PartnerSkill.getContainer().getActor().getName()
		});

		if (this.m.MeleeSkillModifier != 0)
		{
			local attackBonusEnemies = this.m.AttackBonusEnemies.filter(@(_, _a) !::MSU.isNull(_a) && _a.isAlive());
			if (attackBonusEnemies.len() != 0)
			{
				ret.push({
					id = 13,
					type = "text",
					icon = "ui/icons/melee_skill.png",
					text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeValue(this.m.MeleeSkillModifier, {AddSign = true}) + " [Melee Skill|Concept.MeleeSkill] this [turn|Concept.Turn] against:"),
					children = attackBonusEnemies.map(@(_a) { id = 10, type = "text", icon = "ui/orientation/" + _a.getOverlayImage() + ".png", text = _a.getName() })
				});
			}
		}

		if (this.m.MeleeDefenseModifier != 0)
		{
			local defenseBonusEnemies = this.m.DefenseBonusEnemies.filter(@(_, _a) !::MSU.isNull(_a) && _a.isAlive());
			if (defenseBonusEnemies.len() != 0)
			{
				ret.push({
					id = 14,
					type = "text",
					icon = "ui/icons/melee_defense.png",
					text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeValue(this.m.MeleeDefenseModifier, {AddSign = true}) + " [Melee Defense|Concept.MeleeDefense] this [turn|Concept.Turn] against:"),
					children = defenseBonusEnemies.map(@(_a) { id = 10, type = "text", icon = "ui/orientation/" + _a.getOverlayImage() + ".png", text = _a.getName() })
				});
			}
		}

		return ret;
	}

	function onAdded()
	{
		if (!::MSU.isNull(this.m.PartnerSkill))
			this.onPartnerAdded();
	}

	function setPartnerSkill( _skill )
	{
		if (_skill == null)
		{
			if (!::MSU.isNull(this.m.PartnerSkill))
			{
				local partnerSkill = this.m.PartnerSkill;
				this.m.PartnerSkill = null;
				partnerSkill.setPartnerSkill(null);
			}

			this.m.PartnerSkill = null;
			this.onPartnerRemoved();
			return;
		}

		this.m.PartnerSkill = ::MSU.asWeakTableRef(_skill);
		this.onPartnerAdded();
	}

	function onPartnerAdded()
	{
		this.getContainer().getActor().getFlags().set("RF_IsDynamicDuo", true);
		this.getContainer().removeByID("actives.rf_dynamic_duo_select_partner");
		local shuffle = ::new("scripts/skills/actives/rf_dynamic_duo_shuffle_skill");
		shuffle.m.DynamicDuoPerk = ::MSU.asWeakTableRef(this);
		this.getContainer().add(shuffle);
	}

	function onPartnerRemoved()
	{
		this.getContainer().getActor().getFlags().remove("RF_IsDynamicDuo");
		this.getContainer().removeByID("actives.rf_dynamic_duo_shuffle");
	}

	function getPartner()
	{
		return ::MSU.isNull(this.m.PartnerSkill) ? null : this.m.PartnerSkill.getContainer().getActor();
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null || !_skill.isAttack() || _skill.isRanged() || !this.isEnabled())
			return;

		if (this.hasEntityForAttackBonus(_targetEntity))
		{
			_properties.MeleeSkill += this.m.MeleeSkillModifier;
		}
		else if (_skill.isAOE() && ::MSU.isEqual(_targetEntity, this.getPartner()))
		{
			_properties.MeleeSkillMult = 0;
			_properties.DamageTotalMult *= 0.5;
		}
	}

	function onBeingAttacked( _attacker, _skill, _properties )
	{
		if (_skill.isAttack() && !_skill.isRanged() && this.hasEntityForDefenseBonus(_attacker) && this.isEnabled())
		{
			_properties.MeleeDefense += this.m.MeleeDefenseModifier;
		}
	}

	function onMissed( _attacker, _skill )
	{
		if (_skill.isAttack() && !_skill.isRanged() && this.isEnabled())
		{
			this.m.PartnerSkill.addEntityForAttackBonus(::MSU.asWeakTableRef(_attacker));
		}
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		if (_attacker != null && _skill != null && _skill.isAttack() && !_skill.isRanged() && this.isEnabled())
		{
			this.m.PartnerSkill.addEntityForAttackBonus(::MSU.asWeakTableRef(_attacker));
		}
	}

	function onAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		if (_targetEntity != null && _skill.isAttack() && !_skill.isRanged() && this.isEnabled())
		{
			this.m.PartnerSkill.addEntityForDefenseBonus(_targetEntity);
		}
	}

	function onTurnEnd()
	{
		this.m.AttackBonusEnemies.clear();
		this.m.DefenseBonusEnemies.clear();
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.AttackBonusEnemies.clear();
		this.m.DefenseBonusEnemies.clear();
	}

	function onRemoved()
	{
		this.setPartnerSkill(null);
	}

	function onDeath( _fatalityType )
	{
		if (_fatalityType != ::Const.FatalityType.Unconscious)
			this.setPartnerSkill(null);
	}

	function onDismiss()
	{
		this.setPartnerSkill(null);
	}

	function onGetHitFactors( _skill, _targetTile, _tooltip )
	{
		if (this.m.MeleeSkillModifier != 0 && _skill.isAttack() && !_skill.isRanged() && _targetTile.IsOccupiedByActor && this.hasEntityForAttackBonus(_targetTile.getEntity()))
		{
			_tooltip.push({
				icon = "ui/tooltips/positive.png",
				text = ::MSU.Text.colorPositive(this.m.MeleeSkillModifier + "% ") + this.m.Name
			});
		}
	}

	function onGetHitFactorsAsTarget( _skill, _targetTile, _tooltip )
	{
		if (this.m.MeleeDefenseModifier != 0 && _skill.isAttack() && !_skill.isRanged() && this.hasEntityForDefenseBonus(_skill.getContainer().getActor()))
		{
			_tooltip.push({
				icon = "ui/tooltips/negative.png",
				text = ::MSU.Text.colorNegative(this.m.MeleeDefenseModifier + "% ") + this.m.Name
			});
		}
	}

	function hasEntityForAttackBonus( _entity )
	{
		foreach (actor in this.m.AttackBonusEnemies)
		{
			if (::MSU.isEqual(actor, _entity))
				return true;
		}
		return false;
	}

	function hasEntityForDefenseBonus( _entity )
	{
		foreach (actor in this.m.DefenseBonusEnemies)
		{
			if (::MSU.isEqual(actor, _entity))
				return true;
		}
		return false;
	}

	function addEntityForAttackBonus( _entity )
	{
		if (!this.hasEntityForAttackBonus(_entity))
			this.m.AttackBonusEnemies.push(::MSU.asWeakTableRef(_entity));
	}

	function addEntityForDefenseBonus( _entity )
	{
		if (!this.hasEntityForDefenseBonus(_entity))
			this.m.DefenseBonusEnemies.push(::MSU.asWeakTableRef(_entity));
	}

	function onSerialize( _out )
	{
		this.skill.onSerialize(_out);
		if (!::MSU.isNull(this.m.PartnerSkill))
		{
			_out.writeBool(true);
			_out.writeI32(this.m.PartnerSkill.getContainer().getActor().getUID());
		}
		else
		{
			_out.writeBool(false);
		}
	}
});
