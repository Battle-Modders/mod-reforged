this.rf_magic_mirror <- this.inherit("scripts/items/item", {
	m = {
		SoundOnUse = [
			"sounds/combat/acid_flask_impact_01.wav",
			"sounds/combat/acid_flask_impact_02.wav",
			"sounds/combat/acid_flask_impact_03.wav",
			"sounds/combat/acid_flask_impact_04.wav"
		],

	// Private
		__IndexUsedIn = null
	},
	function create()
	{
		this.item.create();
		this.m.ID = "consumable.rf_magic_mirror";
		this.m.Name = "Magic Mirror";
		this.m.Description = "A finely made standing mirror with a simple oak frame and iron fittings, showing little wear despite its age. The glass is unusually clear and seems to hold a depth that is difficult to explain.";
		this.m.Icon = "consumables/rf_magic_mirror.png";
		this.m.SlotType = ::Const.ItemSlot.None;
		this.m.ItemType = ::Const.Items.ItemType.Usable | ::Const.Items.ItemType.Legendary;
		this.m.IsDroppedAsLoot = true;
		this.m.IsAllowedInBag = false;
		this.m.IsUsable = true;
		this.m.Value = 5000;
	}

	function getTooltip()
	{
		local ret = this.item.getTooltip();

        local targetItem = this.hasPreviousItem() ? this.getPreviousItem().item : null;
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString(format("Creates a copy of the item to its left%s", targetItem == null ? "" : " (" + ::Reforged.NestedTooltips.getNestedItemName(targetItem) + ")")),
		});

		ret.push({
			id = 21,
			type = "text",
			icon = "ui/icons/warning.png",
			text = "This item will be consumed in the process"
		});

		return ret;
	}

	function isUsable()
	{
		return this.item.isUsable() && this.hasPreviousItem();
	}

	function onUse( _actor, _item = null )
	{
		::Sound.play(::MSU.Array.rand(this.m.SoundOnUse), ::Const.Sound.Volume.Inventory);

		// Vanilla removes the item, sitting in the slot of the consumable item after onUse returns true
		// We can't generate the copy during onUse, because it would always then be removed by vanilla
		// Instead we remember the index of the mirror and only generate the copy during onRemovedFromStash
		this.m.__IndexUsedIn = ::World.Assets.getStash().getItemByInstanceID(this.getInstanceID()).index;

		return true;
	}

	function onRemovedFromStash( _stashID )
	{
		if (this.m.__IndexUsedIn == null)
			return;

		// At this point, our item is no longer in the stash, so we can't use the getPreviousItem function
		local previousItem = ::World.Assets.getStash().getItemAtIndex(this.m.__IndexUsedIn - 1);
		local itemCopy = this.createCopyOf(previousItem.item);
 		::World.Assets.getStash().insert(itemCopy, this.m.__IndexUsedIn);

		this.m.__IndexUsedIn = null;
	}

	function playInventorySound( _eventType )
	{
		::Sound.play("sounds/combat/armor_leather_impact_03.wav", ::Const.Sound.Volume.Inventory);
	}

// New Functions
	function hasPreviousItem()
	{
		local previousItem = this.getPreviousItem();
		return previousItem != null && previousItem.item != null;
	}

	function getPreviousItem()
	{
		return ::World.Assets.getStash().getItemAtIndex(::World.Assets.getStash().getItemByInstanceID(this.getInstanceID()).index - 1);
	}

	function createCopyOf( _item )
	{
		local data = ::MSU.Class.SerializationData();
		_item.onSerialize(data.getSerializationEmulator());

		local clonedItem = ::new(::IO.scriptFilenameByHash(_item.ClassNameHash));
		clonedItem.onDeserialize(data.getDeserializationEmulator());

		return clonedItem;
	}
});
