this.perk_rf_bloodlust <- ::inherit("scripts/skills/skill", {
	m = {
		BleedStacksBeforeAttack = 0,
		FatigueRecoveryStacks = 0,		
		FatigueReductionPercentage = 5
	},
	function create()
	{
		this.m.ID = "perk.rf_bloodlust";
		this.m.Name = ::Const.Strings.PerkName.RF_Bloodlust;
		this.m.Description = "This character gains increased vigor when next to bleeding enemies.";
		this.m.Icon = "ui/perks/rf_bloodlust.png";
		this.m.IconMini = "rf_bloodlust_mini";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function isHidden()
	{
		return this.m.FatigueRecoveryStacks == 0;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();
		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/fatigue.png",
			text = "[color=" + ::Const.UI.Color.PositiveValue + "]+" + this.m.FatigueRecoveryStacks + "[/color] Fatigue Recovery on the next turn"
		});
		return tooltip;
	}

	function onBeforeAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		if (_skill.isAttack() && !_skill.isRanged() && _targetEntity == null)
		{
			this.m.BleedStacksBeforeAttack = _targetEntity.getSkills().getAllSkillsByID("effects.bleeding").len();
		}
	}

	function onAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		if (!_skill.isAttack() || _skill.isRanged() || _targetEntity == null || _targetEntity.isAlliedWith(this.getContainer().geta()) || !::Tactical.TurnSequenceBar.isActiveEntity(this.getContainer().getActor()))
		{
			return;
		}

		local bleedCount = _targetEntity.isAlive() ? _targetEntity.getSkills().getAllSkillsByID("effects.bleeding").len() : this.m.BleedStacksBeforeAttack + 1;
		this.m.FatigueRecoveryStacks += bleedCount;

		local user = this.getContainer().getActor();
		user.setFatigue(::Math.max(0, user.getFatigue() - user.getFatigue() * (bleedCount * this.m.FatigueReductionPercentage * 0.01)));
	}

	function onUpdate( _properties )
	{
		_properties.FatigueRecoveryRate += this.m.FatigueRecoveryStacks;
	}

	function onTurnStart()
	{
		this.m.FatigueRecoveryStacks = 0;
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.FatigueRecoveryStacks = 0;
	}
});
