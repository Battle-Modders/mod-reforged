::Reforged.HooksMod.hook("scripts/entity/tactical/humans/cultist", function(q) {
	q.onInit = @() { function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.Cultist);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_militia");
		this.m.Skills.add(::new("scripts/skills/perks/perk_backstabber"));
		// this.m.Skills.add(::new("scripts/skills/perks/perk_berserk"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_coup_de_grace"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_crippling_strikes"));
		// this.m.Skills.add(::new("scripts/skills/effects/dodge_effect"));  // Replaced with perk
		this.m.Skills.add(::new("scripts/skills/perks/perk_nimble"));
		// this.m.Skills.add(::new("scripts/skills/perks/perk_overwhelm"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_dagger"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_fast_adaption"));

		// Reforged
		this.m.Skills.add(::new("scripts/skills/perks/perk_dodge"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_fearsome"));
	}}.onInit;
});
