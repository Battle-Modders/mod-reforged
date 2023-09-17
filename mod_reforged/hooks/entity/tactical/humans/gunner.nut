::mods_hookExactClass("entity/tactical/humans/gunner", function(o) {
	o.onInit = function()
	{
	    this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.Gunner);
		b.TargetAttractionMult = 1.1;
		// b.IsSpecializedInSwords = true;
		// b.IsSpecializedInMaces = true;
		// b.IsSpecializedInCrossbows = true; // Replaced with perk
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_southern");
		// this.m.Skills.add(this.new("scripts/skills/perks/perk_anticipation"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_overwhelm"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fearsome"));
		// this.m.Skills.add(this.new("scripts/skills/actives/rotation")); // Replaced with perk
		// this.m.Skills.add(this.new("scripts/skills/actives/recover_skill")); // Replaced with perk

		// Reforged
		b.RangedDefense += 10;
		this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_crossbow"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_recover"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_entrenched"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_power_shot"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_through_the_ranks"));
		if (::Reforged.Config.IsLegendaryDifficulty)
    	{
    		this.m.Skills.add(::new("scripts/skills/perks/perk_dodge"));
    		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_muscle_memory"));
    		this.m.Skills.add(::new("scripts/skills/perks/perk_relentless"));
    	}
	}

	local assignRandomEquipment = o.assignRandomEquipment;
	o.assignRandomEquipment = function()
	{
	    assignRandomEquipment();

	    foreach (item in this.getItems().getAllItemsAtSlot(::Const.ItemSlot.Bag))
	    {
	    	if (item.isItemType(::Const.Items.ItemType.MeleeWeapon))
	    	{
	    		if (item.isWeaponType(::Const.Items.WeaponType.Sword))
	    		{
	    			this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_sword"));
	    		}
	    		else if (item.isWeaponType(::Const.Items.WeaponType.Mace))
	    		{
	    			this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_mace"));
	    		}
	    	}
	    }
	}
});
