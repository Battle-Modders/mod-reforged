::Reforged.HooksMod.hook("scripts/entity/tactical/enemies/grand_diviner", function(q) {
	q.onInit = @() { function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.GrandDiviner);
		b.IsAffectedByNight = false;
		b.Vision = 8;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_undead");
		this.getSprite("head").Color = this.createColor("#ffffff");
		this.getSprite("head").Saturation = 1.0;
		this.getSprite("body").Saturation = 0.6;
		b.IsSpecializedInFlails = true;
		this.m.Skills.add(::new("scripts/skills/perks/perk_adrenalin"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_hold_out"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_pathfinder"));
		// this.m.Skills.add(::new("scripts/skills/perks/perk_anticipation"));
		// this.m.Skills.add(::new("scripts/skills/perks/perk_reach_advantage"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_nimble"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_fearsome"));
		this.m.Skills.add(::new("scripts/skills/racial/grand_diviner_racial"));
		// this.m.Skills.add(::new("scripts/skills/actives/footwork")); replaced with perk
		this.m.Skills.add(::new("scripts/skills/actives/corpse_explosion_skill"));

		// Reforged
		this.m.Skills.add(::new("scripts/skills/perks/perk_footwork"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_savage_strength"));
		// this.m.Skills.add(::new("scripts/skills/perks/perk_overwhelm"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_sweeping_strikes"));
	}}.onInit;

	q.onSpawned = @() { function onSpawned()
	{
		local mainhandItem = this.getMainhandItem();
		if (mainhandItem != null)
		{
			::Reforged.Skills.addPerkGroupOfEquippedWeapon(this);
		}
	}}.onSpawned;
});
