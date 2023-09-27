::Reforged.HooksMod.hook("scripts/entity/tactical/enemies/wolf", function(q) {
	q.onInit = @(__original) function()
	{
	    this.actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.Wolf);
		b.TargetAttractionMult = 0.5;
		b.IsAffectedByInjuries = false;
		b.IsImmuneToDisarm = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		local variant = this.Math.rand(1, 2);
		this.m.Items.getAppearance().Body = "bust_wolf_0" + variant;
		this.addSprite("socket").setBrush("bust_base_goblins");
		local body = this.addSprite("body");
		body.setBrush("bust_wolf_0" + variant + "_body");
		body.varySaturation(0.15);
		body.varyColor(0.07, 0.07, 0.07);
		local head = this.addSprite("head");
		head.setBrush("bust_wolf_0" + variant + "_head");
		head.Color = body.Color;
		head.Saturation = body.Saturation;
		local injury = this.addSprite("injury");
		injury.Visible = false;
		injury.setBrush("bust_wolf_01_injured");
		local armor = this.addSprite("armor");
		armor.setBrush("bust_wolf_02_armor_01");
		armor.Visible = false;
		this.setAlwaysApplySpriteOffset(false);
		local offset = this.createVec(0, -20);
		this.setSpriteOffset("body", offset);
		this.setSpriteOffset("head", offset);
		this.setSpriteOffset("injury", offset);
		this.setSpriteOffset("armor", offset);
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.58;
		this.setSpriteOffset("status_rooted", this.createVec(-6, -39));
		this.setSpriteOffset("status_stunned", this.createVec(-10, -40));
		this.setSpriteOffset("arrow", this.createVec(-10, -40));
		this.m.Skills.add(this.new("scripts/skills/actives/wolf_bite"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));

		// Reforged
		this.m.BaseProperties.Reach = ::Reforged.Reach.Default.BeastMedium - 1;
		this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
		if (::Reforged.Config.IsLegendaryDifficulty)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_dodge"));
		}
	}
});
