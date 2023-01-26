::mods_hookExactClass("entity/tactical/humans/desert_stalker", function(o) {
	o.onInit = function()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.DesertStalker);
		// b.DamageDirectMult = 1.25;
		// b.IsSpecializedInBows = true;
		b.Vision = 8;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_nomads");
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_anticipation"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_bullseye"));
		// this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_flow"));
		// this.m.Skills.add(this.new("scripts/skills/perks/perk_steel_brow"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_quick_hands"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_head_hunter"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_nimble"));
		this.m.Skills.add(this.new("scripts/skills/actives/throw_dirt_skill"));
		// this.m.Skills.add(this.new("scripts/skills/actives/rotation"));
		// this.m.Skills.add(this.new("scripts/skills/actives/footwork"));
		// this.m.Skills.add(this.new("scripts/skills/actives/recover_skill"));

		//Reforged
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_footwork"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_flow"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_small_target"));

		if (::Reforged.Config.IsLegendaryDifficulty)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_dodge"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_fortified_mind"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_marksmanship"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));
		}
	}

	local assignRandomEquipment = o.assignRandomEquipment;
	o.assignRandomEquipment = function()
	{
	    assignRandomEquipment();
		::Reforged.Skills.addPerkGroupOfEquippedWeapon(this);
	}

	local makeMiniboss = o.makeMiniboss;
	o.makeMiniboss = function()
	{
		local ret = makeMiniboss();
		if (ret)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_finesse"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_fresh_and_furious"));

			if (::Reforged.Config.IsLegendaryDifficulty)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_entrenched"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_lone_wolf"));
			}
		}

		return ret;
	}
});
