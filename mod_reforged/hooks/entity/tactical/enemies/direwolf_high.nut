::Reforged.HooksMod.hook("scripts/entity/tactical/enemies/direwolf_high", function(q) {
	q.onInit = @() function()
	{
		this.direwolf.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.FrenziedDirewolf);
		b.IsAffectedByNight = false;
		b.IsImmuneToDisarm = true;
		b.DamageTotalMult = 1.25;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = ::Const.DefaultMovementAPCost;
		this.m.FatigueCosts = ::Const.DefaultMovementFatigueCost;
		local head_frenzy = this.getSprite("head_frenzy");
		head_frenzy.setBrush(this.getSprite("head").getBrush().Name + "_frenzy");
		this.m.Skills.add(::new("scripts/skills/perks/perk_overwhelm"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_relentless"));

		// Reforged
		this.m.Skills.add(::new("scripts/skills/perks/perk_dodge"));
	}
});
