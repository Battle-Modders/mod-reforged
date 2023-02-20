this.perk_rf_offhand_training <- ::inherit("scripts/skills/skill", {
	m = {
		IsSpent = true,
		IsFreeUse = false,
	},
	function create()
	{
		this.m.ID = "perk.rf_offhand_training";
		this.m.Name = ::Const.Strings.PerkName.RF_OffhandTraining;
		this.m.Description = "This character is skilled in the use of offhand items such as tools and bucklers.";
		this.m.Icon = "ui/perks/rf_offhand_training.png";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Last;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
		this.m.ItemActionOrder = ::Const.ItemActionOrder.BeforeLast;
	}

	function isHidden()
	{
		return this.m.IsSpent && !this.m.IsFreeUse;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();

		if (!this.m.IsSpent)
		{
			tooltip.push({
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "The first swap of a tool or buckler in the offhand this turn costs no Action Points"
			});
		}

		if (this.m.IsFreeUse)
		{
			tooltip.push({
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "The first use of a tool in the offhand this turn costs no Action Points"
			});
		}

		return tooltip;
	}

	function getItemActionCost( _items )
	{
		if (this.m.IsSpent)
		{
			return null;
		}

		local validItemsCount = 0;

		foreach (i in _items)
		{
			if (i == null || i.getSlotType() != ::Const.ItemSlot.Offhand)
			{
				continue;
			}

			if (i.isItemType(::Const.Items.ItemType.Tool))
			{
				validItemsCount++;
				continue;
			}

			if (i.isItemType(::Const.Items.ItemType.Shield))
			{
				 if (i.getID().find("buckler") != null)
				 {
					 validItemsCount++;
				 }
				 else
				 {
					 return null;
				 }
			}
		}

		if (validItemsCount > 0)
		{
			return 0;
		}

		return null;
	}

	function onPayForItemAction(_skill, _items)
	{
		if (_skill != null && _skill.getID() != "perk.rf_target_practice")
		{
			this.m.IsSpent = true;
		}
	}

	function onAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		if (_skill.getItem() != null)
		{
			local off = this.getContainer().getActor().getOffhandItem();
			if (off != null && _skill.getItem().getID() == off.getID())
			{
				this.m.IsFreeUse = false;
			}
		}
	}

	function onAfterUpdate( _properties )
	{
		if (this.m.IsFreeUse)
		{
			local off = this.getContainer().getActor().getOffhandItem();
			if (off != null && off.isItemType(::Const.Items.ItemType.Tool))
			{
				foreach (skill in off.getSkills())
				{
					skill.m.ActionPointCost = 0;
				}
			}
		}
	}

	function onTurnStart()
	{
		this.m.IsFreeUse = true;
		this.m.IsSpent = false;
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.IsFreeUse = false;
		this.m.IsSpent = true;
	}
});
