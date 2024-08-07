::Reforged.HooksMod.hook("scripts/entity/tactical/enemies/goblin_leader", function(q) {
	q.onInit = @() function()
	{
		this.goblin.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.GoblinLeader);
		b.TargetAttractionMult = 1.5;
		// b.DamageDirectMult = 1.1;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = ::Const.DefaultMovementAPCost;
		this.m.FatigueCosts = ::Const.DefaultMovementFatigueCost;
		this.getSprite("head").setBrush("bust_goblin_03_head_01");
		this.addDefaultStatusSprites();
		// b.IsSpecializedInSwords = true;
		// b.IsSpecializedInCrossbows = true;
		this.m.Skills.add(::new("scripts/skills/perks/perk_captain"));
		this.m.Skills.add(::new("scripts/skills/actives/goblin_whip"));

		// Reforged
		this.m.Skills.add(::new("scripts/skills/perks/perk_duelist"));
	}

	q.onSpawned = @() function()
	{
		::Reforged.Skills.addPerkGroupOfEquippedWeapon(this);
		::Reforged.Skills.addPerkGroup(this, "pg.rf_sword");
	}
});
