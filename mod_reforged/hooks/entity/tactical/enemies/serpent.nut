::mods_hookExactClass("entity/tactical/enemies/serpent", function(o) {
	o.onInit = function()
	{
	    this.actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.Serpent);
		b.Initiative += this.Math.rand(0, 50);
		b.IsAffectedByNight = false;
		b.IsImmuneToDisarm = true;

		// if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 20)
		// {
		// 	b.MeleeDefense += 5;

		// 	if (this.World.getTime().Days >= 50)
		// 	{
		// 		b.DamageDirectMult += 0.15;
		// 	}
		// }

		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		this.addSprite("socket").setBrush("bust_base_beasts");
		local body = this.addSprite("body");
		this.m.Variant = this.Math.rand(1, 2);
		body.setBrush("bust_snake_0" + this.m.Variant + "_head_0" + this.Math.rand(1, 2));

		if (this.m.Variant == 2 && this.Math.rand(0, 100) < 90)
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

		local injury = this.addSprite("injury");
		injury.Visible = false;
		injury.setBrush("bust_snake_injury");
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.65;
		this.setSpriteOffset("status_rooted", this.createVec(-10, 20));
		this.setSpriteOffset("status_stunned", this.createVec(-35, 20));
		this.setSpriteOffset("arrow", this.createVec(0, 20));
		this.m.Skills.add(this.new("scripts/skills/racial/serpent_racial"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));
		this.m.Skills.add(this.new("scripts/skills/actives/serpent_hook_skill"));
		this.m.Skills.add(this.new("scripts/skills/actives/serpent_bite_skill"));
		this.Tactical.getTemporaryRoster().add(this);

		// Reforged
		this.m.BaseProperties.Reach = ::Reforged.Reach.Default.BeastLarge;
		this.m.BaseProperties.MeleeDefense = 15;
		this.m.Skills.add(::MSU.new("scripts/skills/perks/perk_rf_between_the_ribs", function(o) {
			o.m.IsForceEnabled = true;
		}));
		this.m.Skills.add(::MSU.new("scripts/skills/perks/perk_rf_from_all_sides", function(o) {
			o.m.IsForceEnabled = true;
		}));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_personal_armor"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_through_the_gaps"));
		if (::Reforged.Config.IsLegendaryDifficulty)
    	{
    		this.m.BaseProperties.Armor = [80, 80];
    		this.m.Skills.add(::new("scripts/skills/perks/perk_adrenalin"));
    		this.m.Skills.add(::new("scripts/skills/perks/perk_colossus"));
    		this.m.Skills.add(::new("scripts/skills/perks/perk_dodge"));
    		this.m.Skills.add(::MSU.new("scripts/skills/effects/poison_coat_effect", function(o) {
				o.m.Name = "Serpent venom";
			}));
    	}
	}
});
