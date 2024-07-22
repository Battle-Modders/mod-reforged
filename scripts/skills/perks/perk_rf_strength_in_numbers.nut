this.perk_rf_strength_in_numbers <- ::inherit("scripts/skills/skill", {
	m = {
		SkillBonus = 2,
		ResolveBonus = 5
	},
	function create()
	{
		this.m.ID = "perk.rf_strength_in_numbers";
		this.m.Name = "Strength in Numbers";
		this.m.Description = "This character\'s martial prowess increases when fighting adjacent to allies.";
		this.m.Icon = "ui/perks/perk_rf_strength_in_numbers.png";
		// this.m.IconMini = "perk_rf_strength_in_numbers_mini";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Perk;
	}

	function isHidden()
	{
		return !this.getContainer().getActor().isPlacedOnMap() || (this.getSkillBonus() == 0 && this.getResolveBonus() == 0);
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();

		local bonus = this.getSkillBonus();
		if (bonus > 0)
		{
			tooltip.extend([
				{
					id = 10,
					type = "text",
					icon = "ui/icons/melee_skill.png",
					text = ::MSU.Text.colorPositive("+" + bonus) + " Melee Skill"
				},
				{
					id = 10,
					type = "text",
					icon = "ui/icons/ranged_skill.png",
					text = ::MSU.Text.colorPositive("+" + bonus) + " Ranged Skill"
				},
				{
					id = 10,
					type = "text",
					icon = "ui/icons/melee_defense.png",
					text = ::MSU.Text.colorPositive("+" + bonus) + " Melee Defense"
				},
				{
					id = 10,
					type = "text",
					icon = "ui/icons/ranged_defense.png",
					text = ::MSU.Text.colorPositive("+" + bonus) + " Ranged Defense"
				}
			]);
		}

		local resolveBonus = this.getResolveBonus();
		if (resolveBonus > 0)
		{
			tooltip.push({
				id = 10,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = ::MSU.Text.colorPositive("+" + this.getResolveBonus()) + " Resolve"
			});
		}

		return tooltip;
	}

	function getSkillBonus()
	{
		return ::Tactical.Entities.getAlliedActors(this.getContainer().getActor().getFaction(), this.getContainer().getActor().getTile(), 1, true).len() * this.m.SkillBonus;
	}

	function getResolveBonus()
	{
		return ::Tactical.Entities.getAlliedActors(this.getContainer().getActor().getFaction(), this.getContainer().getActor().getTile(), 1, true).len() * this.m.ResolveBonus;
	}

	function onUpdate( _properties )
	{
		if (!this.getContainer().getActor().isPlacedOnMap())
		{
			return;
		}

		local bonus = this.getSkillBonus();
		if (bonus > 0)
		{
			_properties.MeleeSkill += bonus;
			_properties.RangedSkill += bonus;
			_properties.MeleeDefense += bonus;
			_properties.RangedDefense += bonus;
		}

		_properties.Bravery += this.getResolveBonus();
	}
});
