this.perk_rf_strength_in_numbers <- ::inherit("scripts/skills/skill", {
	m = {
		BonusPerAdjacentAlly = 2,
		MaxResolveBonus = 20
	},
	function create()
	{
		this.m.ID = "perk.rf_strength_in_numbers";
		this.m.Name = "Strength in Numbers";
		this.m.Description = "This character\'s martial prowess increases when fighting adjacent to allies.";
		this.m.Icon = "ui/perks/rf_strength_in_numbers.png";
		// this.m.IconMini = "rf_strength_in_numbers_mini";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function isHidden()
	{
		return !this.getContainer().getActor().isPlacedOnMap() || (this.getBonus() == 0 && this.getResolveBonus() == 0);
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();

		local bonus = this.getBonus();
		if (bonus > 0)
		{
			tooltip.extend([
				{
					id = 10,
					type = "text",
					icon = "ui/icons/melee_skill.png",
					text = "[color=" + ::Const.UI.Color.PositiveValue + "]+" + bonus + "[/color] Melee Skill"
				},
				{
					id = 10,
					type = "text",
					icon = "ui/icons/ranged_skill.png",
					text = "[color=" + ::Const.UI.Color.PositiveValue + "]+" + bonus + "[/color] Ranged Skill"
				},
				{
					id = 10,
					type = "text",
					icon = "ui/icons/melee_defense.png",
					text = "[color=" + ::Const.UI.Color.PositiveValue + "]+" + bonus + "[/color] Melee Defense"
				},
				{
					id = 10,
					type = "text",
					icon = "ui/icons/ranged_defense.png",
					text = "[color=" + ::Const.UI.Color.PositiveValue + "]+" + bonus + "[/color] Ranged Defense"
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
				text = "[color=" + ::Const.UI.Color.PositiveValue + "]+" + this.getResolveBonus() + "[/color] Resolve"
			});
		}

		return tooltip;
	}

	function getBonus()
	{
		return ::Tactical.Entities.getFactionActors(this.getContainer().getActor().getFaction(), this.getContainer().getActor().getTile(), 1, true).len() * this.m.BonusPerAdjacentAlly;
	}

	function getResolveBonus()
	{
		local actor = this.getContainer().getActor();
		local others = ::Tactical.Entities.getAllInstancesAsArray();

		local count = 0;
		foreach (o in others)
		{
			if (o.isAlliedWith(actor))
			{
				count++;
			}
		}

		// Subtract 1 to remove self from the count
		return ::Math.min(this.m.MaxResolveBonus, count - 1);
	}

	function onUpdate( _properties )
	{
		if (!this.getContainer().getActor().isPlacedOnMap())
		{
			return;
		}

		local bonus = this.getBonus();
		if (bonus > 0)
		{
			_properties.MeleeSkill += this.getBonus();
			_properties.RangedSkill += this.getBonus();
			_properties.MeleeDefense += this.getBonus();
			_properties.RangedDefense += this.getBonus();			
		}

		_properties.Bravery += this.getResolveBonus();
	}
});
