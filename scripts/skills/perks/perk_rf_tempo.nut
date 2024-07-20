this.perk_rf_tempo <- ::inherit("scripts/skills/skill", {
	m = {
		RequiredWeaponType = ::Const.Items.WeaponType.Sword,
		BonusInitiative = 15,
		Stacks = 0,
		HasCarriedOverInitiative = false, // Is used to carry over initiative bonus from one turn to the next
		APRecovery = 2,
		AttacksRemaining = 2,
		SkillCount = 0,
		LastTargetID = 0
	},
	function create()
	{
		this.m.ID = "perk.rf_tempo";
		this.m.Name = ::Const.Strings.PerkName.RF_Tempo;
		this.m.Description = "This character is building upon the advantage of going first in the flow of battle.";
		this.m.Icon = "ui/perks/rf_tempo.png";
		this.m.IconMini = "rf_tempo_mini";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function isHidden()
	{
		if (this.m.Stacks == 0 && this.m.AttacksRemaining == 0)
			return true;

		if (this.m.RequiredWeaponType == null)
			return false;

		local weapon = this.getContainer().getActor().getMainhandItem();
		return ::MSU.isNull(weapon) || !weapon.isItemType(::Const.Items.ItemType.Weapon) || !weapon.isWeaponType(this.m.RequiredWeaponType);
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();

		if (this.m.Stacks != 0)
		{
			tooltip.push({
				id = 10,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeValue(this.getBonus()) + " [Initiative|Concept.Initiative]")
			});
		}

		if (this.m.AttacksRemaining > 0)
		{
			tooltip.push({
				id = 10,
				type = "text",
				icon = "ui/icons/action_points.png",
				text = ::Reforged.Mod.Tooltips.parseString("The next " + this.m.AttacksRemaining + " hit(s) against a target that acts after you in this [round|Concept.Round] will recover " + ::MSU.Text.colorPositive(this.m.APRecovery) + " [Action Points|Concept.ActionPoints]")
			});
		}

		if (this.m.HasCarriedOverInitiative)
		{
			tooltip.push({
				id = 10,
				type = "text",
				icon = "ui/icons/warning.png",
				text = ::MSU.Text.colorNegative("The Initiative bonus has been carried over from the previous turn and will expire after using a skill or upon waiting or ending this turn")
			});
		}

		return tooltip;
	}

	function getBonus()
	{
		return this.m.Stacks * this.m.BonusInitiative;
	}

	function gainStackIfApplicable( _skill, _targetEntity )
	{
		if (this.m.HasCarriedOverInitiative)
		{
			this.m.Stacks = 0;
			this.m.HasCarriedOverInitiative = false;
		}

		if (!_skill.isAttack() || !::Tactical.TurnSequenceBar.isActiveEntity(this.getContainer().getActor()))
		{
			return;
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
		if (!this.isSkillValid(_skill))
			return;

		if (this.m.AttacksRemaining > 0 && ::Tactical.TurnSequenceBar.isActiveEntity(this.getContainer().getActor()))
		{
			this.m.AttacksRemaining--;
			if (!_targetEntity.isTurnDone() && !_targetEntity.isTurnStarted())
			{
				local actor = this.getContainer().getActor();
				actor.setActionPoints(::Math.min(actor.getActionPointsMax(), actor.getActionPoints() + this.m.APRecovery));
			}
		}

		this.gainStackIfApplicable(_skill, _targetEntity);
	}

	function onTargetMissed( _skill, _targetEntity )
	{
		if (!this.isSkillValid(_skill))
			return;

		this.gainStackIfApplicable(_skill, _targetEntity);
		if (this.m.AttacksRemaining > 0 && ::Tactical.TurnSequenceBar.isActiveEntity(this.getContainer().getActor()))
			this.m.AttacksRemaining--;
	}

	// Lose all bonus upon equipping an invalid weapon
	function onEquip( _item )
	{
		if (this.m.RequiredWeaponType == null || !_item.isItemType(::Const.Items.ItemType.Weapon))
			return;

		if (!_item.isWeaponType(this.m.RequiredWeaponType))
		{
			this.m.AttacksRemaining = 0;
			this.m.Stacks = 0;
			this.m.HasCarriedOverInitiative = false;
		}
	}

	function onUpdate( _properties )
	{
		if (this.m.RequiredWeaponType != null)
		{
			if (this.getContainer().getActor().isDisarmed())
				return;

			local weapon = this.getContainer().getActor().getMainhandItem();
			if (weapon == null || !weapon.isWeaponType(this.m.RequiredWeaponType))
				return;
		}

		_properties.Initiative += this.getBonus();
	}

	function onTurnStart()
	{
		this.m.AttacksRemaining = 2;
		if (this.m.Stacks > 0)
		{
			this.m.HasCarriedOverInitiative = true;
		}
	}

	function onTurnEnd()
	{
		this.m.AttacksRemaining = 0;
		if (this.m.HasCarriedOverInitiative)
		{
			this.m.Stacks = 0;
			this.m.HasCarriedOverInitiative = false;
		}
	}

	function onWaitTurn()
	{
		this.m.AttacksRemaining = 0;
		if (this.m.HasCarriedOverInitiative)
		{
			this.m.Stacks = 0;
			this.m.HasCarriedOverInitiative = false;
		}
	}

	function onCombatStarted()
	{
		this.m.Stacks = 0;
		this.m.AttacksRemaining = 2;
		this.m.HasCarriedOverInitiative = false;
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.Stacks = 0;
		this.m.AttacksRemaining = 0;
		this.m.HasCarriedOverInitiative = false;
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
});
