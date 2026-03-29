this.rf_warmth_potion_item <- ::inherit("scripts/items/item", {
	m = {},
	function create()
	{
		this.item.create();
		this.m.ID = "accessory.rf_warmth_potion";
		this.m.Name = "Fireblood Tonic";
		this.m.Description = "A fiery concoction that scrubs the throat when swallowed but grants vigor unlike anything you\'ve ever ingested. Lasts for the next battle.";
		this.m.SlotType = ::Const.ItemSlot.None;
		this.m.ItemType = ::Const.Items.ItemType.Usable;
		this.m.IsDroppedAsLoot = true;
		this.m.IsAllowedInBag = false;
		this.m.IsUsable = true;
		this.m.IconLarge = "";
		this.m.Icon = "consumables/rf_warmth_potion_item.png";
		this.m.Value = 550;
	}

	function getTooltip()
	{
		local ret = this.item.getTooltip();

		local effect = ::new("scripts/skills/effects/rf_warmth_potion_effect");
		ret.extend(effect.getTooltip().slice(2)) // slice 2 to remove name and description

		ret.push({
			id = 65,
			type = "text",
			text = "Right-click or drag onto the currently selected character in order to drink. This item will be consumed in the process"
		});
		ret.push({
			id = 65,
			type = "hint",
			icon = "ui/tooltips/warning.png",
			text = "Overindulgence may lead to sickness"
		});
		return ret;
	}

	function playInventorySound( _eventType )
	{
		::Sound.play("sounds/bottle_01.wav", ::Const.Sound.Volume.Inventory);
	}

	function onUse( _actor, _item = null )
	{
		::Sound.play("sounds/combat/drink_0" + ::Math.rand(1, 3) + ".wav", ::Const.Sound.Volume.Inventory);
		_actor.getSkills().add(::new("scripts/skills/effects/rf_warmth_potion_effect"));
		::Const.Tactical.Common.checkDrugEffect(_actor);
		return true;
	}
});
