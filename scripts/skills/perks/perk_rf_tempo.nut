this.perk_rf_tempo <- ::inherit("scripts/skills/skill", {
	m = {
		BonusInitiative = 15,
		InitiativeForTurnOrderMult = 1.5,
		Stacks = 0,
		IsPrimed = false,
		APRecovery = [], // Is populated during onTurnStart using resetAPRecovery function
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
		return this.m.Stacks == 0 && this.m.APRecovery.len() == 0;
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

		if (this.m.APRecovery.len() != 0)
		{
			tooltip.push({
				id = 10,
				type = "text",
				icon = "ui/icons/action_points.png",
				text = ::Reforged.Mod.Tooltips.parseString("The next attack, if successful, against a target that acts after you in this [round|Concept.Round] will recover " + ::MSU.Text.colorGreen(this.m.APRecovery[0]) + " [Action Points|Concept.ActionPoints]")
			});
		}

		if (this.m.IsPrimed)
		{
			tooltip.push({
				id = 10,
				type = "text",
				icon = "ui/icons/warning.png",
				text = ::MSU.Text.colorRed("The Initiative bonus has been carried over from the previous turn and will expire after using a skill or upon waiting or ending this turn")
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
		if (this.m.IsPrimed)
		{
			this.m.Stacks = 0;
			this.m.IsPrimed = false;
		}

		if (!_skill.isAttack() || !::Tactical.TurnSequenceBar.isActiveEntity(this.getContainer().getActor()) || _targetEntity.isTurnDone() || _targetEntity.isTurnStarted())
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
		if (this.m.APRecovery.len() != 0 && _skill.isAttack() && ::Tactical.TurnSequenceBar.isActiveEntity(this.getContainer().getActor()) && !_targetEntity.isTurnDone() && !_targetEntity.isTurnStarted())
		{
			local actor = this.getContainer().getActor();
			actor.setActionPoints(::Math.min(actor.getActionPointsMax(), actor.getActionPoints() + this.m.APRecovery.remove(0)));
		}

		this.gainStackIfApplicable(_skill, _targetEntity);
	}

	function onTargetMissed( _skill, _targetEntity )
	{
		this.gainStackIfApplicable(_skill, _targetEntity);
	}

	function onUpdate( _properties )
	{
		_properties.Initiative += this.getBonus();
		_properties.InitiativeForTurnOrderMult *= this.m.InitiativeForTurnOrderMult;
	}

	function onTurnStart()
	{
		this.resetAPRecovery();
		if (this.m.Stacks > 0)
		{
			this.m.IsPrimed = true;
		}
	}

	function onTurnEnd()
	{
		this.m.APRecovery.clear();
		if (this.m.IsPrimed)
		{
			this.m.Stacks = 0;
			this.m.IsPrimed = false;
		}
	}

	function onWaitTurn()
	{
		this.m.APRecovery.clear();
		if (this.m.IsPrimed)
		{
			this.m.Stacks = 0;
			this.m.IsPrimed = false;
		}
	}

	function onCombatStarted()
	{
		this.m.Stacks = 0;
		this.m.IsPrimed = false;
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.Stacks = 0;
		this.m.IsPrimed = false;
		this.m.APRecover.clear();
	}

	function resetAPRecovery()
	{
		this.m.APRecovery = [2, 1];
	}
});
