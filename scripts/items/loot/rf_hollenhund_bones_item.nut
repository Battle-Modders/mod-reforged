this.rf_hollenhund_bones_item <- ::inherit("scripts/items/item", {
	m = {},
	function create()
	{
		this.item.create();
		this.m.ID = "misc.rf_hollenhund_bones";
		this.m.Name = "Hollenhund Bones";
		this.m.Description = "You don\'t know how these bones become solid because the creature they came from definitely wasn\'t. They must contain some power from the realm of spirits.";
		this.m.Icon = "loot/rf_hollenhund_bones.png";
		this.m.SlotType = ::Const.ItemSlot.None;
		this.m.ItemType = ::Const.Items.ItemType.Misc | ::Const.Items.ItemType.Crafting;
		this.m.IsDroppedAsLoot = true;
		this.m.Value = 1000;
	}

	function playInventorySound( _eventType )
	{
		::Sound.play("sounds/combat/armor_leather_impact_03.wav", ::Const.Sound.Volume.Inventory);
	}

	function getSellPriceMult()
	{
		return ::World.State.getCurrentTown().getBeastPartsPriceMult();
	}

	function getBuyPriceMult()
	{
		return ::World.State.getCurrentTown().getBeastPartsPriceMult();
	}
});
