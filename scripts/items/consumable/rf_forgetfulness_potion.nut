this.rf_forgetfulness_potion <- this.inherit("scripts/items/item", {
	m = {},
	function create()
	{
		this.item.create();
		this.m.ID = "consumable.rf_forgetfulness_potion";
		this.m.Name = "Forgetfulness Potion";
		this.m.Description = "One sip, and a random perk will slip from your grasp. You never know which ability may vanish from your memory.";
		this.m.Icon = "consumables/vial_blue_01.png";
		this.m.SlotType = ::Const.ItemSlot.None;
		this.m.ItemType = ::Const.Items.ItemType.Usable;
		this.m.IsDroppedAsLoot = true;
		this.m.IsAllowedInBag = false;
		this.m.IsUsable = true;
		this.m.Value = 800;
	}

	function getTooltip()
	{
		local result = this.item.getTooltip();

		result.push({
			id = 65,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Refund a random perk point."
		});
		result.push({
			id = 65,
			type = "text",
			text = "Right-click or drag onto the currently selected character in order to drink. This item will be consumed in the process."
		});

		return result;
	}

	function isUsable()
	{
		return this.m.IsUsable;
	}

	function onUse( _actor, _item = null )
	{
		local refundablePerks = ::Reforged.Utility.Perks.getRefundablePerks(_actor);
		if (refundablePerks.len() == 0) return false;	// Can't be used if there is nothing to refund

		// Same sound effect as Anatomist Potions
		::Sound.play("sounds/combat/drink_0" + ::Math.rand(1, 3) + ".wav", ::Const.Sound.Volume.Inventory);

		// Main Effect
		::Reforged.Utility.Perks.refundPerk(_actor, ::MSU.Array.rand(refundablePerks));

		return true;
	}

});

