::mods_hookExactClass("skills/special/bag_fatigue", function(o) {

    local create = o.create;
    o.create = function()
    {
        this.m.Order = ::Const.SkillOrder.Item;     // Anything which inflicts an ItemWeight must do so as early as possible so that other skills can reference those values
    }

    // Overwrite of vanilla function. Functionaly this is mostly identical except that we write into 'Weight' instead of 'Stamina'
	o.onUpdate = function( _properties )
	{
        local combinedBagWeight = 0;

		local hasBagsAndBelts = this.getContainer().hasSkill("perk.bags_and_belts");
		foreach( item in this.getContainer().getActor().getItems().getAllItemsAtSlot(::Const.ItemSlot.Bag) )
		{
            // While we have BagsAndBelts we skip all bag items which have no BlockedSlots. Aka everything except two-handed weapons. This is the quick&dirty vanilla method
			if (hasBagsAndBelts && item.getBlockedSlotType() == null) continue;

            combinedBagWeight += item.getWeight();
		}
        _properties.Weight[::Const.ItemSlot.Bag] = combinedBagWeight;
	}
});
