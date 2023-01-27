this.perk_rf_king_of_all_weapons <- ::inherit("scripts/skills/skill", {
	m = {
		IsForceEnabled = false,
		IsSpent = true,
		DamageReductionPercentage = 25,
		Skills = [
			"actives.thrust",
			"actives.prong"
		]
	},
	function create()
	{
		this.m.ID = "perk.rf_king_of_all_weapons";
		this.m.Name = ::Const.Strings.PerkName.RF_KingOfAllWeapons;
		this.m.Description = "This character is highly skilled with the spear, which is known by many to be the king of all weapons.";
		this.m.Icon = "ui/perks/rf_king_of_all_weapons.png";
		this.m.IconMini = "rf_king_of_all_weapons_mini";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.VeryLast;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function isHidden()
	{
		return this.m.IsSpent;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();

		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = "The next Thrust or Prong attack costs [color=" + ::Const.UI.Color.PositiveValue + "]0[/color] Action Points, builds [color=" + ::Const.UI.Color.NegativeValue + "]0[/color] Fatigue but does [color=" + ::Const.UI.Color.NegativeValue + "]-" + this.m.DamageReductionPercentage + "%[/color] Damage"
		});

		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/warning.png",
			text = "[color=" + ::Const.UI.Color.PositiveValue + "]Will be lost upon switching your weapon![/color]"
		});

		return tooltip;
	}

	function isEnabled()
	{
		if (this.m.IsForceEnabled) return true;

		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon == null || !weapon.isWeaponType(::Const.Items.WeaponType.Spear) || this.getContainer().getSkillsByFunction((@(s) this.m.Skills.find(s.getID()) != null).bindenv(this)).len() == 0)
		{
			return false;
		}

		return true;
	}

	function onAfterUpdate( _properties )
	{
		if (this.m.IsSpent || !this.isEnabled() || !this.getContainer().getActor().isPlacedOnMap())
		{
			this.m.IsSpent = true;
			return;
		}

		foreach (skill in this.getContainer().getSkillsByFunction((@(s) this.m.Skills.find(s.getID()) != null).bindenv(this)))
		{
			skill.m.ActionPointCost = 0;
			skill.m.FatigueCostMult *= 0;
		}
	}

	function onAffordablePreview( _skill, _movementTile )
	{
		if (_skill != null)
		{
			foreach (skill in this.getContainer().getSkillsByFunction((@(s) this.m.Skills.find(s.getID()) != null).bindenv(this)))
			{
				this.modifyPreviewField(skill, "ActionPointCost", 0, false);
				this.modifyPreviewField(skill, "FatigueCostMult", 1, true);
			}
		}
	}

	function onAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		if (_targetEntity != null && this.m.Skills.find(_skill.getID()) != null && ::Tactical.TurnSequenceBar.isActiveEntity(this.getContainer().getActor()))
		{
			this.m.IsSpent = true;
		}
	}

	function onPayForItemAction( _skill, _items )
	{
		foreach (item in _items)
		{
			if (item != null && item.getSlotType() == ::Const.ItemSlot.Mainhand)
			{
				this.m.IsSpent = true;
				return;
			}
		}
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (!this.m.IsSpent && this.m.Skills.find(_skill.getID()) != null && ::Tactical.TurnSequenceBar.isActiveEntity(this.getContainer().getActor()))
		{
			_properties.MeleeDamageMult *= 1.0 - this.m.DamageReductionPercentage * 0.01;
		}
	}

	function onTurnStart()
	{
		if (this.isEnabled())
		{
			this.m.IsSpent = false;
		}
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.IsSpent = true;
	}
});
