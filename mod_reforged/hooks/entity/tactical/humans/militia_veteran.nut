::Reforged.HooksMod.hook("scripts/entity/tactical/humans/militia_veteran", function(q) {
	q.onInit = @() function()
	{
	    this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.MilitiaVeteran);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_militia");
		this.getSprite("accessory_special").setBrush("bust_militia_band_01");
		// this.m.Skills.add(this.new("scripts/skills/perks/perk_shield_expert"));
		// this.m.Skills.add(this.new("scripts/skills/actives/recover_skill"));	// Now granted to all humans by default

		// Reforged
		this.m.Skills.add(::new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_strength_in_numbers"));
	}

	q.assignRandomEquipment = @(__original) function()
	{
	    __original();
	    	::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 4);

	    if (this.isArmedWithShield())
	    {
	    	this.m.Skills.add(::new("scripts/skills/perks/perk_rf_phalanx"));
    		this.m.Skills.add(::new("scripts/skills/perks/perk_shield_expert"));
	    }

	    local weapon = this.getMainhandItem();
	    if (weapon != null)
	    {
	    	if (weapon.isItemType(::Const.Items.ItemType.TwoHanded))
	    	{
	    		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_formidable_approach"));
	    	}

	    	local offhand = this.getOffhandItem();
    		if (offhand == null)
    		{
    			this.m.Skills.add(::new("scripts/skills/perks/perk_duelist"));
    		}
	    }
	}
});
