this.rf_retribution_effect <- ::inherit("scripts/skills/skill", {
	m = {
		Stacks = 0,
		BonusPerStack = 25
	},
	function create()
	{
		this.m.ID = "effects.rf_retribution";
		this.m.Name = "Retribution";
		this.m.Description = "This character hits significantly harder after taking a hit.";
		this.m.Icon = "ui/perks/rf_retribution.png";
		this.m.IconMini = "";	// A mini-icon would be useful
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Last;
		this.m.IsActive = false;
		this.m.IsHidden = false;
		this.m.IsRemovedAfterBattle = true;
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

	function getNestedTooltip()
	{
		if (this.getContainer().getActor().getID() != ::MSU.getDummyPlayer().getID())
			return this.getTooltip();

		local tooltip = this.skill.getTooltip();

		tooltip.push({
			id = 6,
			type = "text",
			icon = "ui/icons/regular_damage.png",
			text = "Stacking " + ::MSU.Text.colorPositive(this.m.BonusPerStack + "%") + " increased damage dealt for every hit received"
		});

		tooltip.push({
			id = 6,
			type = "text",
			icon = "ui/icons/warning.png",
			text = ::MSU.Text.colorNegative("Will expire upon performing the next attack or ending the turn")
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
});
