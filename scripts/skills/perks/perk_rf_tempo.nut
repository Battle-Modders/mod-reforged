this.perk_rf_tempo <- ::inherit("scripts/skills/skill", {
	m = {
		RequiredWeaponType = ::Const.Items.WeaponType.Sword,

		Stacks = 0,
		HasCarriedOverInitiative = false, // Is used to carry over initiative bonus from one turn to the next
		SkillCount = 0,
		LastTargetID = 0,
		APBonusThisTurn = 0,
		FatBonusThisTurn = 0
	},
	function create()
	{
		this.m.ID = "perk.rf_tempo";
		this.m.Name = ::Const.Strings.PerkName.RF_Tempo;
		this.m.Description = "This character is building upon the advantage of going first in the flow of battle.";
		this.m.Icon = "ui/perks/perk_rf_tempo.png";
		this.m.IconMini = "perk_rf_tempo_mini";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Perk;
	}

	function getName()
	{
		return this.m.Stacks == 0 ? this.m.Name : this.m.Name + " (x" + this.m.Stacks + ")";
	}

	function isHidden()
	{
		return this.m.Stacks == 0 || !this.isEnabled();
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();

		local initiativeBonus = this.getInitiativeModifier();
		if (initiativeBonus != 0)
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeValue(initiativeBonus, {AddSign = true}) + " [Initiative|Concept.Initiative]")
			});
		}

		if (this.m.APBonusThisTurn != 0)
		{
			ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/action_points.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeValue(this.m.APBonusThisTurn, {AddSign = true}) + " [Action Point(s)|Concept.ActionPoints]")
			});
		}

		if (this.m.FatBonusThisTurn != 1.0)
		{
			local startString = this.m.RequiredWeaponType == null ? "Attacks" : ::Const.Items.getWeaponTypeName(this.m.RequiredWeaponType) + " attacks";
			ret.push({
				id = 12,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = ::Reforged.Mod.Tooltips.parseString(startString + " build up " + ::MSU.Text.colorizeMultWithText(this.m.FatBonusThisTurn, {InvertColor = true}) + " [Fatigue|Concept.Fatigue]")
			});
		}

		if (this.m.HasCarriedOverInitiative)
		{
			ret.push({
				id = 20,
				type = "text",
				icon = "ui/icons/warning.png",
				text = ::Reforged.Mod.Tooltips.parseString("The [Initiative|Concept.Initiative] bonus has been carried over from the previous [turn|Concept.Turn] and will expire after using a skill or upon [waiting|Concept.Wait] or ending this [turn|Concept.Turn]")
			});
		}
		else
		{
			local nextTurnBonus = [];
			if (this.getAPModifier() != 0)
			{
				nextTurnBonus.push({
					id = 13,
					type = "text",
					icon = "ui/icons/action_points.png",
					text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeValue(this.getAPModifier(), {AddSign = true}) + " [Action Points|Concept.ActionPoints]")
				});
			}

			if (this.getFatigueCostMultMult() != 1.0)
			{
				local startString = this.m.RequiredWeaponType == null ? "Attacks" : ::Const.Items.getWeaponTypeName(this.m.RequiredWeaponType) + " attacks";
				nextTurnBonus.push({
					id = 13,
					type = "text",
					icon = "ui/icons/fatigue.png",
					text = ::Reforged.Mod.Tooltips.parseString(startString + " build up " + ::MSU.Text.colorizeMultWithText(this.getFatigueCostMultMult(), {InvertColor = true}) + " [Fatigue|Concept.Fatigue]")
				});
			}

			if (nextTurnBonus.len() != 0)
			{
				ret.push({
					id = 13,
					type = "text",
					icon = "ui/icons/special.png",
					text = ::Reforged.Mod.Tooltips.parseString("In the next [turn:|Concept.Turn]"),
					children = nextTurnBonus
				});
			}
		}

		return ret;
	}

	function getInitiativeModifier()
	{
		return this.m.Stacks * 15;
	}

	function getAPModifier()
	{
		return ::Math.floor(this.m.Stacks * 0.5);
	}

	function getFatigueCostMultMult()
	{
		return ::Math.maxf(1.0 - this.m.Stacks * 0.05);
	}

	function gainStackIfApplicable( _skill, _targetEntity )
	{
		if (!::Tactical.TurnSequenceBar.isActiveEntity(this.getContainer().getActor()))
		{
			return;
		}

		if (this.m.HasCarriedOverInitiative)
		{
			this.m.Stacks = 0;
			this.m.HasCarriedOverInitiative = false;
		}

		if (this.m.SkillCount == ::Const.SkillCounter && this.m.LastTargetID == _targetEntity.getID())
		{
			return;
		}

		this.m.SkillCount = ::Const.SkillCounter;
		this.m.LastTargetID = _targetEntity.getID();

		this.m.Stacks++;
	}

	function onBeforeTargetHit( _skill, _targetEntity, _hitInfo )
	{
		if (this.isSkillValid(_skill))
			this.gainStackIfApplicable(_skill, _targetEntity);
	}

	function onTargetMissed( _skill, _targetEntity )
	{
		if (this.isSkillValid(_skill))
			this.gainStackIfApplicable(_skill, _targetEntity);
	}

	// Lose all bonus upon equipping an invalid weapon
	function onEquip( _item )
	{
		if (this.m.RequiredWeaponType == null || !_item.isItemType(::Const.Items.ItemType.Weapon))
			return;

		if (!_item.isWeaponType(this.m.RequiredWeaponType))
		{
			this.m.Stacks = 0;
			this.m.HasCarriedOverInitiative = false;
		}
	}

	function onUpdate( _properties )
	{
		if (this.isEnabled())
		{
			_properties.Initiative += this.getInitiativeModifier();
			_properties.ActionPoints += this.m.APBonusThisTurn;
		}
	}

	function onAfterUpdate( _properties )
	{
		if (!this.isEnabled())
			return;

		foreach (s in this.m.RequiredWeaponType != null ? this.getContainer().getActor().getMainhandItem().getSkills() : this.getContainer().getAllSkillsOfType(::Const.SkillType.Active))
		{
			if (this.isSkillValid(s))
			{
				s.m.FatigueCostMult *= this.m.FatBonusThisTurn;
			}
		}
	}

	function onTurnStart()
	{
		if (this.m.Stacks > 0)
		{
			this.m.HasCarriedOverInitiative = true;
		}

		this.m.APBonusThisTurn = this.getAPModifier();
		local actor = this.getContainer().getActor();
		actor.setActionPoints(actor.getActionPoints() + this.m.APBonusThisTurn);

		this.m.FatBonusThisTurn = this.getFatigueCostMultMult();
	}

	function onTurnEnd()
	{
		if (this.m.HasCarriedOverInitiative)
		{
			this.m.Stacks = 0;
			this.m.HasCarriedOverInitiative = false;
		}
	}

	function onWaitTurn()
	{
		if (this.m.HasCarriedOverInitiative)
		{
			this.m.Stacks = 0;
			this.m.HasCarriedOverInitiative = false;
		}
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.Stacks = 0;
		this.m.HasCarriedOverInitiative = false;
		this.m.APBonusThisTurn = 0;
		this.m.FatBonusThisTurn = 0;
	}

	function isSkillValid( _skill )
	{
		if (_skill.isRanged() || !_skill.isAttack())
			return false;

		if (this.m.RequiredWeaponType == null)
			return true;

		local weapon = _skill.getItem();
		return !::MSU.isNull(weapon) && weapon.isItemType(::Const.Items.ItemType.Weapon) && weapon.isWeaponType(this.m.RequiredWeaponType);
	}

	function isEnabled()
	{
		if (this.m.RequiredWeaponType == null)
			return true;

		if (this.getContainer().getActor().isDisarmed())
			return false;

		local weapon = this.getContainer().getActor().getMainhandItem();
		return weapon != null && weapon.isWeaponType(this.m.RequiredWeaponType);
	}
});
