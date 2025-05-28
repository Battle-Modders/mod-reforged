::Reforged.HooksMod.hook("scripts/entity/tactical/enemies/lesser_flesh_golem", function(q) {
	q.onInit = @() { function onInit()
	{
		this.actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.LesserFleshGolem);
		b.IsImmuneToDisarm = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = ::Const.DefaultMovementAPCost;
		this.m.FatigueCosts = ::Const.DefaultMovementFatigueCost;
		this.m.Items.getAppearance().Body = "bust_flesh_golem_body_01";
		this.addSprite("socket").setBrush("bust_base_undead");
		local body = this.addSprite("body");
		body.setBrush("bust_flesh_golem_body_01");
		body.varySaturation(0.1);
		body.varyColor(0.09, 0.09, 0.09);
		local injury_body = this.addSprite("injury");
		injury_body.Visible = false;
		injury_body.setBrush("bust_flesh_golem_body_01_injured");
		this.addSprite("armor");
		local head = this.addSprite("head");
		head.setBrush("bust_flesh_golem_head_0" + ::Math.rand(1, 3));
		head.Saturation = body.Saturation;
		head.Color = body.Color;
		this.addSprite("helmet");
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.45;
		this.setSpriteOffset("status_rooted", this.createVec(-4, 7));
		this.m.Skills.add(::new("scripts/skills/racial/flesh_golem_racial"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_pathfinder"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_steel_brow"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_underdog"));

		// Reforged
		this.m.BaseProperties.Reach = ::Reforged.Reach.Default.BeastMedium;
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_menacing"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_fearsome"));
	}}.onInit;

	q.onSpawned = @() { function onSpawned()
	{
		local weapon = this.getMainhandItem();
		if (weapon != null)
		{
			switch (weapon.getID())
			{
				case "weapon.golem_cleaver_hammer":
					this.m.Skills.add(::new("scripts/skills/perks/perk_rf_mauler"));
					this.m.Skills.add(::new("scripts/skills/perks/perk_rf_rattle"));
					this.m.Skills.add(::new("scripts/skills/perks/perk_rf_dent_armor"));
					break;

				case "weapon.golem_mace_flail":
					this.m.Skills.add(::new("scripts/skills/perks/perk_rf_concussive_strikes"));
					this.m.Skills.add(::new("scripts/skills/perks/perk_rf_whirling_death"));
					this.m.Skills.add(::new("scripts/skills/perks/perk_rf_from_all_sides"));
					break;

				case "weapon.golem_mace_hammer":
					this.m.Skills.add(::new("scripts/skills/perks/perk_rf_concussive_strikes"));
					this.m.Skills.add(::new("scripts/skills/perks/perk_rf_rattle"));
					this.m.Skills.add(::new("scripts/skills/perks/perk_rf_dent_armor"));
					break;

				case "weapon.golem_spear_sword":
					this.m.Skills.add(::new("scripts/skills/perks/perk_rf_through_the_gaps"));
					this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_spear"));
					this.m.Skills.add(::new("scripts/skills/perks/perk_rf_tempo"));
					break;
			}
		}
	}}.onSpawned;
});
