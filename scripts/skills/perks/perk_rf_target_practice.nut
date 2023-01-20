this.perk_rf_target_practice <- ::inherit("scripts/skills/skill", {
	m = {
		RangedSkillBonus = 10
	},
	function create()
	{
		this.m.ID = "perk.rf_target_practice";
		this.m.Name = ::Const.Strings.PerkName.RF_TargetPractice;
		this.m.Description = ::Const.Strings.PerkDescription.RF_TargetPractice;
		this.m.Icon = "ui/perks/rf_target_practice.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
		this.m.ItemActionOrder = ::Const.ItemActionOrder.First;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (!_skill.isRanged() || _targetEntity == null) return;

		if (_targetEntity.isArmedWithRangedWeapon() || ::Tactical.Entities.getAlliedActors(_targetEntity, _targetEntity.getTile(), 1, true).len() == 0)
		{
			_properties.RangedSkill += this.m.RangedSkillBonus;
		}
	}

	function onGetHitFactors( _skill, _targetTile, _tooltip )
	{
		local targetEntity = _targetTile.getEntity();
		if (_skill.isRanged() && targetEntity != null && (targetEntity.isArmedWithRangedWeapon() || ::Tactical.Entities.getAlliedActors(targetEntity, targetEntity.getTile(), 1, true).len() == 0))
		{
			_tooltip.push({
				icon = "ui/tooltips/positive.png",
				text = "[color=" + ::Const.UI.Color.PositiveValue + "]" + this.m.RangedSkillBonus + "%[/color] " + this.getName()
			});
		}
	}

	function getItemActionCost( _items )
	{
		local count = 0;

		foreach (item in _items)
		{
			if (item != null && item.isItemType(::Const.Items.ItemType.Ammo) && item.getSlotType() == ::Const.ItemSlot.Ammo)
			{
				count++;
			}
		}

		return count == 2 ? 0 : null;
	}
});
