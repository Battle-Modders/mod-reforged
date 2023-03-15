this.perk_rf_tempo <- ::inherit("scripts/skills/skill", {
	m = {
		BonusInitiative = 15,
		Stacks = 0,
		IsPrimed = false,
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
		return this.m.Stacks == 0;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();

		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/initiative.png",
			text = "[color=" + ::Const.UI.Color.PositiveValue + "]+" + this.getBonus() + "[/color] Initiative"
		});

		if (this.m.IsPrimed)
		{
			tooltip.push({
				id = 10,
				type = "text",
				icon = "ui/icons/warning.png",
				text = ::MSU.Text.colorRed("This bonus has been carried over from the previous turn and will expire after using a skill or upon waiting or ending this turn")
			});
		}

		return tooltip;
	}

	function onAdded()
	{
		this.getContainer().add(::new("scripts/skills/effects/rf_fluid_weapon_effect"));
	}

	function onRemoved()
	{
		this.getContainer().removeByID("effects.rf_fluid_weapon");
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
		this.gainStackIfApplicable(_skill, _targetEntity);		
	}

	function onTargetMissed( _skill, _targetEntity )
	{
		this.gainStackIfApplicable(_skill, _targetEntity);
	}

	function onUpdate( _properties )
	{
		_properties.Initiative += this.getBonus();
	}

	function onTurnStart()
	{
		if (this.m.Stacks > 0)
		{
			this.m.IsPrimed = true;
		}
	}

	function onTurnEnd()
	{
		if (this.m.IsPrimed)
		{
			this.m.Stacks = 0;
			this.m.IsPrimed = false;
		}
	}

	function onWaitTurn()
	{
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
	}
});
