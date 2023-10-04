::Reforged.HooksMod.hook("scripts/entity/tactical/enemies/orc_berserker", function(q) {
	q.onInit = @() function()
	{
	    this.actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.OrcBerserker);

		// if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 190)
		// {
		// 	b.MeleeSkill += 5;
		// 	b.DamageTotalMult += 0.1;
		// 	b.Bravery += 5;
		// }

		// b.IsSpecializedInAxes = true;
		// b.IsSpecializedInCleavers = true;
		// b.IsSpecializedInFlails = true;
		b.IsAffectedByFreshInjuries = false;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		this.m.Items.getAppearance().Body = "bust_orc_02_body";
		this.addSprite("socket").setBrush("bust_base_orcs");
		local body = this.addSprite("body");
		body.setBrush("bust_orc_02_body");
		body.varySaturation(0.1);
		body.varyColor(0.08, 0.08, 0.08);
		local tattoo_body = this.addSprite("tattoo_body");

		if (this.Math.rand(1, 100) <= 50)
		{
			tattoo_body.setBrush("bust_orc_02_body_paint_0" + this.Math.rand(1, 3));
		}

		local injury_body = this.addSprite("injury_body");
		injury_body.Visible = false;
		injury_body.setBrush("bust_orc_02_body_injured");
		this.addSprite("armor");
		local head = this.addSprite("head");
		head.setBrush("bust_orc_02_head_0" + this.Math.rand(1, 3));
		head.Saturation = body.Saturation;
		head.Color = body.Color;
		local tattoo_head = this.addSprite("tattoo_head");

		if (this.Math.rand(1, 100) <= 50)
		{
			tattoo_head.setBrush("bust_orc_02_head_paint_0" + this.Math.rand(1, 3));
		}

		local injury = this.addSprite("injury");
		injury.Visible = false;
		injury.setBrush("bust_orc_02_head_injured");
		this.addSprite("helmet");
		local body_rage = this.addSprite("body_rage");
		body_rage.Visible = false;
		body_rage.Alpha = 220;
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.6;
		this.m.Skills.add(this.new("scripts/skills/special/double_grip"));
		this.m.Skills.add(this.new("scripts/skills/actives/hand_to_hand_orc"));
		this.m.Skills.add(this.new("scripts/skills/actives/charge"));
		this.m.Skills.add(this.new("scripts/skills/effects/berserker_rage_effect"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_battering_ram"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_berserk"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_flow"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_hold_out"));

		// Reforged
		this.m.BaseProperties.Reach = ::Reforged.Reach.Default.Orc;
		this.m.Skills.add(::new("scripts/skills/racial/rf_orc_racial"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_menacing"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_vigorous_assault"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_survival_instinct"));
		if (::Reforged.Config.IsLegendaryDifficulty)
    	{
    		this.m.Skills.add(::new("scripts/skills/perks/perk_dodge"));
    		this.m.Skills.add(::new("scripts/skills/perks/perk_fearsome"));
    		this.m.Skills.add(::new("scripts/skills/perks/perk_fortified_mind"));
    		this.m.Skills.add(::new("scripts/skills/perks/perk_killing_frenzy"));
    	}
	}

	q.assignRandomEquipment = @(__original) function()
	{
	    __original();

	    local weapon = this.getMainhandItem();
	    if (weapon == null) return;

	    if (::Reforged.Config.IsLegendaryDifficulty)
	    {
	    	::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 7);
	    }
	    else
	    {
	    	::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 6);
	    }

	    if (weapon.isItemType(::Const.Items.ItemType.OneHanded))
	    {
	    	this.m.Skills.add(::new("scripts/skills/perks/perk_relentless"));
	    }
	    else
	    {
	    	this.m.Skills.add(::new("scripts/skills/perks/perk_rf_death_dealer"));
	    }
	}
});
