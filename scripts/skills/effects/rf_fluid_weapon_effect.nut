this.rf_fluid_weapon_effect <- ::inherit("scripts/skills/skill", {
	m = {
		IsForceEnabled = false,
		ArmorPenAsInit = 0.35,
		ArmorEffAsFatCostRed = 0.20,
	},
	function create()
	{
		this.m.ID = "effects.rf_fluid_weapon";
		this.m.Name = "Fluid Weapon";
		this.m.Description = "This weapon movements of this character are both graceful and fast.";
		this.m.Icon = "ui/perks/rf_fluid_weapon.png";
		// this.m.IconMini = "rf_fluid_weapon_mini";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Last;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function isHidden()
	{
		return !this.isEnabled();
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();

		local initiativeBonus = this.getInitiativeBonus();
		if (initiativeBonus > 0)
		{
			tooltip.push({
				id = 10,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=" + ::Const.UI.Color.PositiveValue + "]+" + initiativeBonus + "[/color] Initiative"
			});
		}

		local fatReductionBonus = this.getFatigueReductionBonus();
		if (fatReductionBonus > 0)
		{
			tooltip.push({
				id = 10,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "Weapon skills build up [color=" + ::Const.UI.Color.PositiveValue + "]" + fatReductionBonus + "%[/color] less Fatigue"
			});
		}

		return tooltip;
	}

	function isEnabled()
	{
		if (this.m.IsForceEnabled)
		{
			return true;
		}

		if (this.getContainer().getActor().isDisarmed()) return false;

		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon == null || !weapon.isWeaponType(::Const.Items.WeaponType.Sword))
		{
			return false;
		}

		return true;
	}

	function onUpdate(_properties)
	{
		if (this.isEnabled())
		{
			_properties.Initiative += this.getInitiativeBonus();
		}
	}

	function onAfterUpdate(_properties)
	{
		if (!this.isEnabled())
		{
			return;
		}

		foreach (skill in this.getContainer().getActor().getMainhandItem().getSkills())
		{
			if (skill.isType(::Const.SkillType.Active)) skill.m.FatigueCostMult *= 1.0 - this.getFatigueReductionBonus() * 0.01;
		}
	}

	function getInitiativeBonus()
	{
		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon == null) return 0;

		local armorPen = weapon.m.DirectDamageMult + weapon.m.DirectDamageAdd;
		return ::Math.floor(this.m.ArmorPenAsInit * armorPen * 100);
	}

	function getFatigueReductionBonus()
	{
		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon == null) return 0;

		return ::Math.floor(this.m.ArmorEffAsFatCostRed * weapon.m.ArmorDamageMult * 100);
	}
});
