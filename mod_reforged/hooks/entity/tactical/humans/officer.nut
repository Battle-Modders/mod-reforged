::mods_hookExactClass("entity/tactical/humans/officer", function(o) {
	o.onInit = function()
	{
	    this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.Officer);
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
		this.getSprite("socket").setBrush("bust_base_southern");
		this.m.Skills.add(this.new("scripts/skills/perks/perk_captain"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_shield_expert"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
		// this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));
		// this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
		// this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));
		// this.m.Skills.add(this.new("scripts/skills/actives/rotation")); // Replaced by perk
		// this.m.Skills.add(this.new("scripts/skills/actives/recover_skill")); // Replaced by perk

		// Reforged
		this.m.Skills.add(::new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_recover"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_blitzkrieg"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_onslaught"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_hold_steady"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_shield_sergeant"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_battle_fervor"));
		this.m.Skills.add(::MSU.new("scripts/skills/perks/perk_rf_bolster", function(o) {
			o.m.IsForceEnabled = true;
		}));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_bulwark"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_finesse"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_exude_confidence"));
		this.m.Skills.add(::MSU.new("scripts/skills/perks/perk_inspiring_presence", function(o) {
			o.m.IsForceEnabled = true;
		}));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_personal_armor"));
		this.m.Skills.add(::MSU.new("scripts/skills/perks/perk_rally_the_troops", function(o) {
			o.m.Cooldown = 3;
		}));
		if (::Reforged.Config.IsLegendaryDifficulty)
    	{
    		this.m.Skills.removeByID("perk.rf_personal_armor");
    		this.m.Skills.add(::new("scripts/skills/perks/perk_fortified_mind"));
    		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_man_of_steel"));
    		this.m.Skills.add(::new("scripts/skills/perks/perk_hold_out"));
    		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_strength_in_numbers"));
    	}
	}

	local assignRandomEquipment = o.assignRandomEquipment;
	o.assignRandomEquipment = function()
	{
	    assignRandomEquipment();

	    local weapon = this.getMainhandItem();
	    if (weapon == null) return;

		if (weapon.isItemType(::Const.Items.ItemType.OneHanded))
		{
			this.m.Skills.add(::new("scripts/skills/perks/perk_duelist"));
		}
		else
		{
			this.m.Skills.add(::new("scripts/skills/perks/perk_rf_formidable_approach"));
		}

	    if (weapon.isWeaponType(::Const.Items.WeaponType.Sword))
	    {
	    	this.m.Skills.add(::new("scripts/skills/perks/perk_rf_exploit_opening"));
	    	this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_sword"));
	    	this.m.Skills.add(::new("scripts/skills/perks/perk_rf_tempo"));
	    	this.m.Skills.add(::new("scripts/skills/perks/perk_rf_en_garde"));
	    	this.m.Skills.add(::new("scripts/skills/perks/perk_coup_de_grace"));
	    }
	    else
	    {
	    	::Reforged.Skills.addPerkGroupOfEquippedWeapon(this);
	    }

	    if (this.isArmedWithShield())
	    {
	    	this.m.Skills.add(::new("scripts/skills/perks/perk_rf_phalanx"));
	    }
	}
});
