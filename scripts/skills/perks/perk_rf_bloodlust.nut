this.perk_rf_bloodlust <- ::inherit("scripts/skills/skill", {
	m = {
		BleedStacksBeforeAttack = 0,
		FatigueRecoveryStacks = 0,		
		FatigueReductionPercentage = 5,
		ActorFatigue = null,
		DidHit = false
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
		this.m.ActorFatigue = null;
		this.m.BleedStacksBeforeAttack = 0;
		this.m.DidHit = false;

		if (_skill.isAttack() && !_skill.isRanged() && _targetEntity != null)
		{
			this.m.BleedStacksBeforeAttack = _targetEntity.getSkills().getAllSkillsByID("effects.bleeding").len();
		}
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		this.m.DidHit = true;
	}

	// We need to do it like this in two split functions i.e. onAnySkillExecuted and onTargetKilled:
	// onAnySkillExecuted is used for counting the bleed stacks applied during the attack e.g. cleave skill's onUse function
	// onTargetKilled is used separately to handle situations where the attack is delayed e.g. Lunge, and onAnySkillExecuted runs before the target actually gets killed
	function onAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		local actor = this.getContainer().getActor();
		if (!this.m.DidHit || !_skill.isAttack() || _skill.isRanged() || _targetEntity == null || _targetEntity.isAlliedWith(actor) || !::Tactical.TurnSequenceBar.isActiveEntity(actor))
			return;

		local bleedCount = _targetEntity.isAlive() ? _targetEntity.getSkills().getAllSkillsByID("effects.bleeding").len() : this.m.BleedStacksBeforeAttack;

		this.m.FatigueRecoveryStacks += bleedCount;

		if (this.m.ActorFatigue == null) this.m.ActorFatigue = actor.getFatigue();

		actor.setFatigue(::Math.max(0, this.m.ActorFatigue - this.m.ActorFatigue * (bleedCount * this.m.FatigueReductionPercentage * 0.01)));
	}

	function onTargetKilled( _targetEntity, _skill )
	{
		local actor = this.getContainer().getActor();
		if (!_skill.isAttack() || _skill.isRanged() || _targetEntity.isAlliedWith(actor) || !::Tactical.TurnSequenceBar.isActiveEntity(actor))
			return;

		this.m.FatigueRecoveryStacks += 1;

		if (this.m.ActorFatigue == null) this.m.ActorFatigue = actor.getFatigue();

		actor.setFatigue(::Math.max(0, this.m.ActorFatigue - this.m.ActorFatigue * (this.m.FatigueReductionPercentage * 0.01)));
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
