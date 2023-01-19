::mods_hookExactClass("entity/tactical/humans/swordmaster", function(o) {
	o.onInit = function()
	{
	    this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.Swordmaster);
		b.IsSpecializedInSwords = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_militia");
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_anticipation"));
		// this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_flow"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_nimble"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_duelist"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_underdog"));
		// this.m.Skills.add(this.new("scripts/skills/perks/perk_steel_brow"));
		this.m.Skills.add(this.new("scripts/skills/effects/dodge_effect"));
		// this.m.Skills.add(this.new("scripts/skills/perks/perk_berserk"));
		// this.m.Skills.add(this.new("scripts/skills/actives/footwork")); // Replaced by perk
		// this.m.Skills.add(this.new("scripts/skills/actives/recover_skill")); // Replaced by perk

		// Reforged
		this.m.Skills.add(this.new("scripts/skills/perks/perk_footwork"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));

		if (::Reforged.Config.IsLegendaryDifficulty)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_clarity"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_double_strike"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_fortified_mind"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_personal_armor"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_overwhelm"));
		}
	}

	local assignRandomEquipment = o.assignRandomEquipment;
	o.assignRandomEquipment = function()
	{
	    assignRandomEquipment();

	    local weapon = this.getMainhandItem();
	    if (weapon == null) return;

	    ::Reforged.Skills.addPerkGroupOfEquippedWeapon(this);
	    if (weapon.isItemType(::Const.Items.ItemType.BFFencing))
	    {
	    	this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_fencer"));
	    	this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_swordmaster_precise"));
	    }
	    else
	    {
	    	this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_swordmaster_blade_dancer"));
	    	this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_pattern_recognition"));
	    }
	}

	local makeMiniboss = o.makeMiniboss;
	o.makeMiniboss = function()
	{
		local ret = makeMiniboss();

		if (ret)
		{
			this.m.BaseProperties.DamageDirectMult /= 1.25; // revert vanilla armor penetration increase
			this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_the_rush_of_battle"));
			if (::Reforged.Config.IsLegendaryDifficulty)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_unstoppable"));
			}
		}

		return ret;
	}
});
