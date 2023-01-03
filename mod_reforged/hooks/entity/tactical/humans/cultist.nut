::mods_hookExactClass("entity/tactical/humans/cultist", function(o) {
	o.onInit = function()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.Cultist);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_militia");
		// this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
		// this.m.Skills.add(this.new("scripts/skills/perks/perk_berserk"));
		// this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
		// this.m.Skills.add(this.new("scripts/skills/effects/dodge_effect"));  // Replaced with perk
		this.m.Skills.add(this.new("scripts/skills/perks/perk_nimble"));
		// this.m.Skills.add(this.new("scripts/skills/perks/perk_overwhelm"));
		// this.m.Skills.add(this.new("scripts/skills/perks/perk_mastery_dagger"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));

		// Reforged
		this.m.Skills.add(this.new("scripts/skills/perks/perk_dodge"));
		this.m.Skills.add(this.new("scripts/skills/traits/bloodthirsty_trait"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_bloodbath"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fearsome"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_unstoppable"));

		if (::Reforged.Config.IsLegendaryDifficulty)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_assured_conquest"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_flow"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_fortified_mind"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_menacing"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_hold_out"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_survival_instinct"));
		}
	}

	local assignRandomEquipment = o.assignRandomEquipment;
	o.assignRandomEquipment = function()
	{
	    assignRandomEquipment();
	    ::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 3);

		if (::Reforged.Config.IsLegendaryDifficulty)
		{
			::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 5);
		}
	}
});
