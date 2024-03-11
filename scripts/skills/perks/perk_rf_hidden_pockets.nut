this.perk_rf_hidden_pockets <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.rf_hidden_pockets";
		this.m.Name = ::Const.Strings.PerkName.RF_HiddenPockets;
		this.m.Description = ::Const.Strings.PerkDescription.RF_HiddenPockets;
		this.m.Icon = "ui/perks/rf_hidden_pockets.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Last;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		// This works exactly like how the vanilla bags and belts perk adds its slots. Both at the same time will therefor not have any effect
		this.getContainer().getActor().getItems().setUnlockedBagSlots(4);
	}

	function onRemoved()
	{
		this.getContainer().removeByID("actives.rf_pocket_sand_skill");

		// Recover items from the lost bag slots when this perk is removed. This is a copy of how vanilla does it
		local items = this.getContainer().getActor().getItems();
		local item;
		item = items.getItemAtBagSlot(2);

		if (item != null)
		{
			items.removeFromBag(item);
			this.World.Assets.getStash().add(item);
		}

		item = items.getItemAtBagSlot(3);

		if (item != null)
		{
			items.removeFromBag(item);
			this.World.Assets.getStash().add(item);
		}

		// This line exists in bags and belts aswell. Let's hope that there happens another onUpdate over all skills right after.
		// Otherwise this can cause problems with both Bags and Belts and Hidden Pockets were allocated, but only one was removed
		this.getContainer().getActor().getItems().setUnlockedBagSlots(2);
	}

	function onAdded()
	{
		this.getContainer().add(::new("scripts/skills/actives/rf_pocket_sand_skill"));
	}
}
