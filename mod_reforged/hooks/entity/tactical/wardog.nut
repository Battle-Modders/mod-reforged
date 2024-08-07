::Reforged.HooksMod.hook("scripts/entity/tactical/wardog", function(q) {
	q.onInit = @() function()
	{
		this.actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.Wardog);
		b.TargetAttractionMult = 0.1;
		b.IsAffectedByInjuries = false;
		b.IsImmuneToDisarm = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = ::Const.DefaultMovementAPCost;
		this.m.FatigueCosts = ::Const.DefaultMovementFatigueCost;
		local variant = ::Math.rand(1, 4);
		this.m.Items.getAppearance().Body = "bust_dog_01_body_0" + variant;
		this.addSprite("socket").setBrush("bust_base_player");
		local body = this.addSprite("body");
		body.setBrush("bust_dog_01_body_0" + variant);
		local armor = this.addSprite("armor");
		this.addSprite("head").setBrush("bust_dog_01_head_0" + variant);
		local closed_eyes = this.addSprite("closed_eyes");
		closed_eyes.setBrush("bust_dog_01_body_0" + variant + "_eyes_closed");
		closed_eyes.Visible = false;
		local injury = this.addSprite("injury");
		injury.Visible = false;
		injury.setBrush("bust_dog_01_injured");
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.46;
		this.setSpriteOffset("status_rooted", this.createVec(8, -15));
		this.setSpriteOffset("status_stunned", this.createVec(0, -25));
		this.setSpriteOffset("arrow", this.createVec(0, -25));
		this.m.Skills.add(::new("scripts/skills/actives/wardog_bite"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_pathfinder"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_steel_brow"));

		//Reforged
		this.m.BaseProperties.Reach = ::Reforged.Reach.Default.BeastMedium - 1;
		this.getSkills().update();
	}
});
