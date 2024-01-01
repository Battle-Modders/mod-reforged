this.perk_rf_tricksters_purses <- ::inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.rf_tricksters_purses";
		this.m.Name = ::Const.Strings.PerkName.RF_TrickstersPurses;
		this.m.Description = ::Const.Strings.PerkDescription.RF_TrickstersPurses;
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
	}

	function onUpdate( _properties )
	{
		// This works exactly like how the vanilla bags_and_belts perk adds its slots. Both at the same time will therefore not have any effect
		this.getContainer().getActor().getItems().setUnlockedBagSlots(4);
	}

	function onAdded()
	{
		this.getContainer().add(::new("scripts/skills/actives/rf_pocket_sand_skill"));
	}

	function onRemoved()
	{
		this.getContainer().removeByID("actives.rf_pocket_sand_skill");

		// Recover items from the lost bag slots when this perk is removed. This is a copy of how vanilla does it in bags_and_belts
		local items = this.getContainer().getActor().getItems();

		local item = items.getItemAtBagSlot(2);
		if (item != null)
		{
			items.removeFromBag(item);
			::World.Assets.getStash().add(item);
		}

		item = items.getItemAtBagSlot(3);
		if (item != null)
		{
			items.removeFromBag(item);
			::World.Assets.getStash().add(item);
		}

		this.getContainer().getActor().getItems().setUnlockedBagSlots(2);
	}
});
