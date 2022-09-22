this.perk_rf_sweeping_strikes <- ::inherit("scripts/skills/skill", {
	m = {
		IsForceEnabled = false,
		Stacks = 0
	},
	function create()
	{
		this.m.ID = "perk.rf_sweeping_strikes";
		this.m.Name = ::Const.Strings.PerkName.RF_SweepingStrikes;
		this.m.Description = "This character is swinging his weapon in large sweeping motions, making it harder to approach him.";
		this.m.Icon = "ui/perks/rf_sweeping_strikes.png";
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
			id = 6,
			type = "text",
			icon = "ui/icons/reach.png",
			text = ::MSU.Text.colorizeValue(this.m.Stacks) + " Reach"
		});

		return tooltip;
	}

	function isEnabled()
	{
		if (this.m.IsForceEnabled) return true;

		if (this.getContainer().getActor().isDisarmed()) return false;

		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon == null || weapon.getReach() < 3)
		{
			return false;
		}

		return true;
	}

	function onAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		if (_skill.isAttack() && _skill.isRanged() && _targetEntity != null)
		{
			this.m.Stacks += _skill.isAOE() ? 3 : 1;
		}
	}

	function onUpdate( _properties )
	{
		_properties.Reach += this.m.Stacks;
	}

	function onTurnStart()
	{
		this.m.Stacks = 0;
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished()
		this.m.Stacks = 0;
	}
});
