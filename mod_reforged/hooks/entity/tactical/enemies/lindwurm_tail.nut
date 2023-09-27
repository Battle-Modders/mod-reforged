::Reforged.HooksMod.hook("scripts/entity/tactical/enemies/lindwurm_tail", function(q) {
	q.onInit = @(__original) function()
	{
	    if (this.m.ParentID != 0)
		{
			this.m.Body = this.Tactical.getEntityByID(this.m.ParentID);
			this.m.Items = this.m.Body.m.Items;
		}

		this.actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.Lindwurm);
		// b.IsAffectedByNight = false;			// Now handled by racial effect
		// b.IsImmuneToKnockBackAndGrab = true;	// Now handled by racial effect
		// b.IsImmuneToStun = true;				// Now handled by racial effect
		b.IsMovable = false;
		// b.IsImmuneToDisarm = true;			// Now handled by racial effect
		// b.IsImmuneToRoot = true;				// Now handled by racial effect

		// if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 180)
		// {
		// 	b.MeleeSkill += 10;
		// 	b.DamageTotalMult += 0.1;
		// }

		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		this.addSprite("socket").setBrush("bust_base_beasts");
		local body = this.addSprite("body");
		body.setBrush("bust_lindwurm_tail_0" + this.Math.rand(1, 1));

		if (this.Math.rand(0, 100) < 90)
		{
			body.varySaturation(0.2);
		}

		if (this.Math.rand(0, 100) < 90)
		{
			body.varyColor(0.08, 0.08, 0.08);
		}

		local head = this.addSprite("head");
		head.Color = body.Color;
		head.Saturation = body.Saturation;
		local injury = this.addSprite("injury");
		injury.Visible = false;
		injury.setBrush("bust_lindwurm_tail_01_injured");
		local body_blood = this.addSprite("body_blood");
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.54;
		this.setSpriteOffset("status_rooted", this.createVec(0, 0));
		this.m.Racial = this.new("scripts/skills/racial/lindwurm_racial");
		this.m.Skills.add(this.m.Racial);
		this.m.Skills.add(this.new("scripts/skills/actives/tail_slam_skill"));
		this.m.Skills.add(this.new("scripts/skills/actives/tail_slam_big_skill"));
		this.m.Skills.add(this.new("scripts/skills/actives/tail_slam_split_skill"));
		this.m.Skills.add(this.new("scripts/skills/actives/tail_slam_zoc_skill"));
		this.m.Skills.add(this.new("scripts/skills/actives/move_tail_skill"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_hold_out"));
		// this.m.Skills.add(this.new("scripts/skills/perks/perk_reach_advantage"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fearsome"));

		// Reforged
		this.m.BaseProperties.Reach = ::Reforged.Reach.Default.BeastHuge;
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_sweeping_strikes"));
		if (::Reforged.Config.IsLegendaryDifficulty)
    	{
    		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_death_dealer"));
    	}
	}
});
