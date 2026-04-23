::Reforged.HooksMod.hook("scripts/entity/tactical/enemies/zombie_yeoman_bodyguard", function(q) {
	q.assignRandomEquipment = @(__original) function()
	{
		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Mainhand))
		{
			local weapons = ::MSU.Class.WeightedContainer([
				[1, "scripts/items/weapons/bludgeon"],
				[1, "scripts/items/weapons/hatchet"],
				[1, "scripts/items/weapons/hand_axe"],
				[1, "scripts/items/weapons/scramasax"],
				[1, "scripts/items/weapons/militia_spear"],
				[1, "scripts/items/weapons/shortsword"]
			]);

			this.m.Items.equip(::new(weapons.roll()));
		}

		if (::Math.rand(1, 100) <= 50 && this.m.Items.hasEmptySlot(::Const.ItemSlot.Offhand))
		{
			local shield = ::MSU.Class.WeightedContainer([
				[1, "scripts/items/shields/worn_heater_shield"],
				[1, "scripts/items/shields/wooden_shield_old"]
			]);

			this.m.Items.equip(::new(weapons.roll()));
		}
		__original();
	}
});
