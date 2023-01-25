::mods_hookExactClass("entity/tactical/humans/gladiator", function(o) {
	o.onInit = function()
	{
	    this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.Gladiator);
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
		this.m.Skills.add(this.new("scripts/skills/perks/perk_quick_hands"));
		// this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
		// this.m.Skills.add(this.new("scripts/skills/effects/dodge_effect")); // Replaced with perk
		// this.m.Skills.add(this.new("scripts/skills/perks/perk_overwhelm"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_nimble"));
		// this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));
		// this.m.Skills.add(this.new("scripts/skills/perks/perk_underdog"));
		// this.m.Skills.add(this.new("scripts/skills/actives/footwork")); // Replaced with perk
		// this.m.Skills.add(this.new("scripts/skills/actives/recover_skill")); // Replaced with perk

		// Reforged
		this.m.Skills.add(::new("scripts/skills/perks/perk_dodge"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_footwork"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_recover"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_skirmisher"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_bully"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_pathfinder"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_pattern_recognition"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_hold_out"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_survival_instinct"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_the_rush_of_battle"));
		if (::Reforged.Config.IsLegendaryDifficulty)
    	{
    		this.m.Skills.add(::new("scripts/skills/perks/perk_colossus"));
    		this.m.Skills.add(::new("scripts/skills/perks/perk_fortified_mind"));
    		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_fresh_and_furious"));
    		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_fruits_of_labor"));
    		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_unstoppable"));
    		this.m.Skills.add(::new("scripts/skills/perks/perk_overwhelm"));
    	}
	}

	local assignRandomEquipment = o.assignRandomEquipment;
	o.assignRandomEquipment = function()
	{
	    assignRandomEquipment();

	    ::Reforged.Skills.addPerkGroupOfEquippedWeapon(this);

	    local aoo = this.m.Skills.getAttackOfOpportunity();
	    if (aoo != null && aoo.isDuelistValid())
	    {
	    	this.m.Skills.add(::new("scripts/skills/perks/perk_duelist"));
	    }
	    else
	    {
	    	this.m.Skills.add(::new("scripts/skills/perks/perk_rf_formidable_approach"));
	    }

	    local weapon = this.getMainhandItem();
	    if (weapon != null)
	    {
	    	if (weapon.getRangeMax() == 2) this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_polearm"));
	    	if (weapon.isAOE()) this.m.Skills.add(::new("scripts/skills/perks/perk_rf_death_dealer"));
	    	if (weapon.isItemType(::Const.Items.ItemType.TwoHanded) && weapon.isWeaponType(::Const.Items.WeaponType.Mace))
	    	{
	    		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_leverage"));
	    	}
	    }

	    foreach (item in this.getItems().getAllItemsAtSlot(::Const.ItemSlot.Bag))
	    {
	    	if (item.isItemType(::Const.Items.ItemType.RangedWeapon) && item.isWeaponType(::Const.Items.WeaponType.Throwing))
	    	{
	    		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_momentum"));
	    		this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_throwing"));
	    		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_proximity_throwing_specialist"));
	    		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_opportunist"));
	    		break;
	    	}
	    }
	}

	local makeMiniboss = o.makeMiniboss;
	o.makeMiniboss = function()
	{
		local ret = makeMiniboss();
		if (ret)
		{
			this.m.Skills.removeByID("perk.fearsome"); // revert vanilla

			this.m.Skills.add(::new("scripts/skills/perks/perk_lone_wolf"));
		}

		return ret;
	}
});
