::Reforged.HooksMod.hook("scripts/entity/tactical/humans/desert_stalker", function(q) {
	q.onInit = @() { function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.DesertStalker);
		// b.DamageDirectMult = 1.25;
		// b.IsSpecializedInBows = true;
		b.Vision = 8;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_nomads");
		this.m.Skills.add(::new("scripts/skills/perks/perk_crippling_strikes"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_coup_de_grace"));
		// this.m.Skills.add(::new("scripts/skills/perks/perk_anticipation"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_bullseye"));
		// this.m.Skills.add(::new("scripts/skills/perks/perk_fast_adaption"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_battle_flow"));
		// this.m.Skills.add(::new("scripts/skills/perks/perk_steel_brow"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_quick_hands"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_head_hunter"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_pathfinder"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_nimble"));
		this.m.Skills.add(::new("scripts/skills/actives/throw_dirt_skill"));
		// this.m.Skills.add(::new("scripts/skills/actives/rotation"));
		// this.m.Skills.add(::new("scripts/skills/actives/footwork"));
		// this.m.Skills.add(::new("scripts/skills/actives/recover_skill"));	// Now granted to all humans by default

		//Reforged
		b.RangedDefense += 15;
		this.m.Skills.add(::new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_footwork"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_small_target"));
	}}.onInit;

	q.assignRandomEquipment = @(__original) { function assignRandomEquipment()
	{
		__original();
		::Reforged.Skills.addPerkGroupOfEquippedWeapon(this);
	}}.assignRandomEquipment;

	q.makeMiniboss = @(__original) { function makeMiniboss()
	{
		local ret = __original();
		if (ret)
		{
			this.m.Skills.add(::new("scripts/skills/perks/perk_rf_finesse"));
			this.m.Skills.add(::new("scripts/skills/perks/perk_rf_fresh_and_furious"));
		}

		return ret;
	}}.makeMiniboss;
});
