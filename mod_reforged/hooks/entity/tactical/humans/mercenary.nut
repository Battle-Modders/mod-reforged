::mods_hookExactClass("entity/tactical/humans/mercenary", function(o) {
	o.onInit = function()
	{
	    this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.Mercenary);
		// b.IsSpecializedInSwords = true;
		// b.IsSpecializedInAxes = true;
		// b.IsSpecializedInMaces = true;
		// b.IsSpecializedInFlails = true;
		// b.IsSpecializedInPolearms = true;
		// b.IsSpecializedInThrowing = true;
		// b.IsSpecializedInHammers = true;
		// b.IsSpecializedInSpears = true;
		// b.IsSpecializedInCleavers = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_militia");
		this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_quick_hands"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_anticipation"));
		// this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_overwhelm"));
		// this.m.Skills.add(this.new("scripts/skills/actives/rotation")); // Replaced with perk
		// this.m.Skills.add(this.new("scripts/skills/actives/recover_skill")); // Replaced with perk

		// Reforged
		this.m.Skills.add(::new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_recover"));
		if (::Reforged.Config.IsLegendaryDifficulty)
    	{
    		this.m.Skills.add(::new("scripts/skills/perks/perk_dodge"));
    		this.m.Skills.add(::new("scripts/skills/perks/perk_relentless"));
    	}
	}

	local assignRandomEquipment = o.assignRandomEquipment;
	o.assignRandomEquipment = function()
	{
	    assignRandomEquipment();

	    if (::Reforged.Config.IsLegendaryDifficulty)
	    {
	    	::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 7);
	    }
	    else
	    {
	    	::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 6);
	    }

	    if (this.isArmedWithShield())
	    {
	    	this.m.Skills.add(::new("scripts/skills/perks/perk_shield_expert"));
	    }

	    local aoo = this.m.Skills.getAttackOfOpportunity();
	    if (aoo != null && aoo.isDuelistValid())
	    {
	    	this.m.Skills.add(::new("scripts/skills/perks/perk_duelist"));
	    }
	    else
	    {
	    	this.m.Skills.add(::new("scripts/skills/perks/perk_rf_formidable_approach"));
	    }

	    foreach (item in this.getItems().getAllItemsAtSlot(::Const.ItemSlot.Bag))
	    {
	    	if (item.isItemType(::Const.Items.RangedWeapon) && item.isWeaponType(::Const.Items.WeaponType.Throwing))
	    	{
	    		this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_throwing"));
	    		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_proximity_throwing_specialist"));
	    		if (::Reforged.Config.IsLegendaryDifficulty)
			    {
			    	this.m.Skills.add(::new("scripts/skills/perks/perk_rf_opportunist"));
			    }
	    		break;
	    	}
	    }
	}
});
