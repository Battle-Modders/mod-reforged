this.perk_rf_bulwark <- ::inherit("scripts/skills/skill", {
	m = {
		ArmorPercentageAsBonus = 2
	},
	function create()
	{
		this.m.ID = "perk.rf_bulwark";
		this.m.Name = ::Const.Strings.PerkName.RF_Bulwark;
		this.m.Description = "This character feels braver while wearing more durable armor!"
		this.m.Icon = "ui/perks/rf_bulwark.png";
		this.m.IconMini = "rf_bulwark_mini";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function isHidden()
	{
		return this.getBonus() == 0;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();

		local bonus = this.getBonus();
		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/bravery.png",
			text = "[color=" + ::Const.UI.Color.PositiveValue + "]+" + bonus + "[/color] Resolve"
		});

		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/bravery.png",
			text = "Additional [color=" + ::Const.UI.Color.PositiveValue + "]+" + bonus + "[/color] Resolve at negative morale checks except mental attacks"
		});

		return tooltip;
	}

	function getBonus()
	{
		local armor = this.getContainer().getActor().getArmor(::Const.BodyPart.Head) + this.getContainer().getActor().getArmor(::Const.BodyPart.Body);
		return ::Math.floor(armor * this.m.ArmorPercentageAsBonus * 0.01);
	}

	function onUpdate(_properties)
	{
		_properties.Bravery += this.getBonus();
	}
});
