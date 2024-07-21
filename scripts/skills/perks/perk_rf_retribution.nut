this.perk_rf_retribution <- ::inherit("scripts/skills/skill", {
	m = {
		Stacks = 0,
		BonusPerStack = 25
	},
	function create()
	{
		this.m.ID = "perk.rf_retribution";
		this.m.Name = ::Const.Strings.PerkName.RF_Retribution;
		this.m.Description = "This character hits significantly harder after taking a hit.";
		this.m.Icon = "ui/perks/perk_rf_retribution.png";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Perk;
	}

	function isHidden()
	{
		return this.m.Stacks == 0;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();
		tooltip.push({
			id = 6,
			type = "text",
			icon = "ui/icons/regular_damage.png",
			text = ::MSU.Text.colorPositive((this.m.Stacks * this.m.BonusPerStack) + "%") + " increased damage dealt"
		});

		tooltip.push({
			id = 6,
			type = "text",
			icon = "ui/icons/warning.png",
			text = ::MSU.Text.colorNegative("Will expire upon performing an attack or ending the turn")
		});

		return tooltip;
	}

	function onUpdate( _properties )
	{
		_properties.DamageTotalMult *= 1.0 + this.m.Stacks * this.m.BonusPerStack * 0.01;
	}

	function onDamageReceived( _attacker, _damageHitpoints, _damageArmor )
	{
		local actor = this.getContainer().getActor();
		if (_attacker.getID() == actor.getID() || _attacker.isAlliedWith(actor))
			return;

		this.m.Stacks += 1;
	}

	function onAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		if (_skill.isAttack())
		{
			this.m.Stacks = 0;
		}
	}

	function onTurnEnd()
	{
		this.m.Stacks = 0;
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.Stacks = 0;
	}
});
