::Reforged.HooksMod.hook("scripts/entity/tactical/enemies/flying_skull", function(q) {
	q.onInit = @() function()
	{
		this.actor.onInit();
		this.setRenderCallbackEnabled(true);
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.FlyingSkull);
		b.TargetAttractionMult = 0.5;
		b.IsAffectedByNight = false;
		b.IsAffectedByInjuries = false;
		b.IsImmuneToBleeding = true;
		b.IsImmuneToPoison = true;
		b.IsImmuneToStun = true;
		b.IsImmuneToDisarm = true;
		b.IsImmuneToFire = true;
		b.IsImmuneToRoot = true;

		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 25)
		{
			b.DamageDirectAdd += 0.05;

			if (this.World.getTime().Days >= 50)
			{
				b.DamageDirectAdd += 0.05;
			}
		}

		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.SameMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		this.m.MaxTraversibleLevels = 3;
		this.addSprite("socket").setBrush("bust_base_undead");
		local body = this.addSprite("body");
		body.setBrush("bust_skeleton_flying_head_0" + this.Math.rand(1, 2));

		if (this.Math.rand(0, 100) < 90)
		{
			body.varySaturation(0.1);
		}

		if (this.Math.rand(0, 100) < 90)
		{
			body.varyColor(0.1, 0.1, 0.1);
		}

		if (this.Math.rand(0, 100) < 90)
		{
			body.varyBrightness(0.1);
		}

		local flames1 = this.addSprite("flames1");
		flames1.setBrush("bust_skeleton_flying_head_flames1");
		flames1.varyColor(0.1, 0.1, 0.1);
		local flames2 = this.addSprite("flames2");
		flames2.setBrush("bust_skeleton_flying_head_flames3");
		flames2.varyColor(0.1, 0.1, 0.1);
		local glow = this.addSprite("glow");
		glow.setBrush("bust_skeleton_flying_head_glow");
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.65;
		this.setSpriteOffset("status_rooted", this.createVec(7, 10));
		this.setSpriteOffset("status_stunned", this.createVec(0, -20));
		this.setSpriteOffset("arrow", this.createVec(0, -20));
		this.m.Skills.add(this.new("scripts/skills/actives/explode_skill"));
		this.spawnEffect();

		//Reforged
		this.m.BaseProperties.IsAffectedByReach = false;
		this.getSkills().update()
	}
});
