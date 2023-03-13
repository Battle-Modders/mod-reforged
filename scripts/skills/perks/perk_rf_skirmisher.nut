this.perk_rf_skirmisher <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.rf_skirmisher";
		this.m.Name = ::Const.Strings.PerkName.RF_Skirmisher;
		this.m.Description = "This character gains moves faster than most.";
		this.m.Icon = "ui/perks/rf_skirmisher.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = true;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();
		tooltip.push({
			id = 6,
			type = "text",
			icon = "ui/icons/initiative.png",
			text = "Initiative loss due to built Fatigue is reduced by [color=" + ::Const.UI.Color.PositiveValue + "]50%[/color]"
		});

		return tooltip;
	}

	function onUpdate( _properties )
	{
		_properties.FatigueToInitiativeRate *= 0.5;
		_properties.InitiativeModifierMult[::Const.ItemSlot.Body] *= 0.7;
		_properties.InitiativeModifierMult[::Const.ItemSlot.Head] *= 0.7;
	}
});
