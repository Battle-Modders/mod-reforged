this.perk_rf_offhand_training <- ::inherit("scripts/skills/skill", {
	m = {
		StaminaModifierThreshold = -10,
		IsSpent = true,
		IsFreeUse = false,
		IsConsumingFreeUse = false // Used in onBeforeAnySkillExecuted to flip IsFreeUse in onAnySkillExecuted
	},
	function create()
	{
		this.m.ID = "perk.rf_offhand_training";
		this.m.Name = ::Const.Strings.PerkName.RF_OffhandTraining;
		this.m.Description = "This character is skilled in the use of offhand items such as tools and bucklers.";
		this.m.Icon = "ui/perks/rf_offhand_training.png";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Last;
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
				text = "The first swap of an offhand item with a weight less than " + ::MSU.Text.colorNegative(-this.m.StaminaModifierThreshold) + " costs no Action Points"
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

	function onAdded()
	{
		this.getContainer().add(::new("scripts/skills/effects/rf_trip_artist_effect"));
	}

	function onRemoved()
	{
		this.getContainer().removeByID("effects.rf_trip_artist");
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

			if (i.getStaminaModifier() <= this.m.StaminaModifierThreshold)
			{
				return null;
			}

			validItemsCount++;
		}

		if (validItemsCount > 0)
		{
			return 0;
		}

		return null;
	}

	function onPayForItemAction(_skill, _items)
	{
		this.m.IsSpent = true;
	}

	function onBeforeAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		if (!this.m.IsFreeUse || _forFree || !::Tactical.TurnSequenceBar.isActiveEntity(this.getContainer().getActor()))
			return;

		if (_skill.getItem() != null && ::MSU.isEqual(_skill.getItem(), this.getContainer().getActor().getOffhandItem()))
		{
			// Using a net unequips the net and therefore the item of the used skill becomes null
			// Therefore we must check the item BEFORE use and then flip the member variable for free use AFTER use
			this.m.IsConsumingFreeUse = true;
		}
	}

	function onAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		if (this.m.IsConsumingFreeUse)
			this.m.IsFreeUse = false;
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
		this.m.IsConsumingFreeUse = false;
		this.m.IsFreeUse = true;
		this.m.IsSpent = false;
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.IsConsumingFreeUse = false;
		this.m.IsFreeUse = false;
		this.m.IsSpent = true;
	}
});
