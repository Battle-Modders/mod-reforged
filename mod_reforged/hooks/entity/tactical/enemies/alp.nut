::mods_hookExactClass("entity/tactical/enemies/alp", function(o) {
    o.onInit = function()
    {
		this.actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.Alp);
		b.Initiative += this.Math.rand(0, 55);
		// b.IsAffectedByNight = false;				// Now handled by racial effect
		// b.IsAffectedByInjuries = false;			// Now handled by racial effect
		// b.IsImmuneToBleeding = true;				// Now handled by racial effect
		// b.IsImmuneToPoison = true;				// Now handled by racial effect
		// b.IsImmuneToDisarm = true;				// Now handled by racial effect
		// b.IsImmuneToKnockBackAndGrab = true;		// Now handled by racial effect
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		this.addSprite("socket").setBrush("bust_base_beasts");
		local body = this.addSprite("body");
		body.setBrush("bust_alp_body_01");
		body.varySaturation(0.2);
		local head = this.addSprite("head");
		head.setBrush("bust_alp_head_0" + this.Math.rand(1, 3));
		head.Saturation = body.Saturation;
		local injury = this.addSprite("injury");
		injury.setBrush("bust_alp_01_injured");
		injury.Visible = false;
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.55;
		this.setSpriteOffset("status_rooted", this.createVec(0, 10));
		this.m.Skills.add(this.new("scripts/skills/actives/sleep_skill"));
		this.m.Skills.add(this.new("scripts/skills/actives/nightmare_skill"));
		this.m.Skills.add(this.new("scripts/skills/actives/alp_teleport_skill"));
		this.m.Skills.add(this.new("scripts/skills/racial/alp_racial"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_underdog"));

		//Reforged
		this.m.BaseProperties.IsAffectedByReach = false;
		if (::Reforged.Config.IsLegendaryDifficulty)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_dodge"));
		}
		this.getSkills().update()
    }
});
