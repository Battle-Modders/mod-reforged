this.perk_rf_headless <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.rf_headless";
		this.m.Name = "Headless";
		this.m.Description = "This character has no head.";
		this.m.Icon = "ui/perks/rf_death_dealer.png";	// TODO
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, superCurrent )
	{
		_hitInfo.BodyPart = ::Const.BodyPart.Body;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();

		tooltip.push({
			id = 5,
			type = "text",
			icon = "ui/icons/chance_to_hit_head.png",
			text = "Every incoming damage will hit the body"
		});

		return tooltip;
	}
});
