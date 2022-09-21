this.perk_rf_balance <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.rf_balance";
		this.m.Name = ::Const.Strings.PerkName.RF_Balance;
		this.m.Description = "This character gains increased speed and endurance by balancing their armor and mobility.";
		this.m.Icon = "ui/perks/rf_balance.png";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();
		local initBonus = this.getInitiativeBonus()
		if (initBonus > 0)
		{
			tooltip.push({
				id = 6,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=" + ::Const.UI.Color.PositiveValue + "]+" + initBonus + "[/color] Initiative"
			});
		}
		tooltip.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Initiative loss due to built Fatigue is reduced by [color=" + ::Const.UI.Color.PositiveValue + "]50%[/color]"
		});

		return tooltip;
	}

	function getInitiativeBonus()
	{
		return ::Math.floor(this.getContainer().getActor().getItems().getStaminaModifier([::Const.ItemSlot.Body, ::Const.ItemSlot.Head]) * -1 * 0.3);
	}

	function onUpdate( _properties )
	{
		_properties.FatigueToInitiativeRate *= 0.5;
		_properties.Initiative += this.getInitiativeBonus();
	}
});
