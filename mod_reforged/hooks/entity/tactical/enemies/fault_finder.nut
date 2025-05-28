::Reforged.HooksMod.hook("scripts/entity/tactical/enemies/fault_finder", function(q) {
	q.onInit = @() { function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.FaultFinder);
		b.TargetAttractionMult = 3.0;
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
		this.m.Skills.add(::new("scripts/skills/actives/flesh_pull_skill"));
		this.m.Skills.add(::new("scripts/skills/actives/corpse_explosion_skill"));

		// Reforged
		this.m.Skills.add(::new("scripts/skills/perks/perk_anticipation"));
	}}.onInit;
});
