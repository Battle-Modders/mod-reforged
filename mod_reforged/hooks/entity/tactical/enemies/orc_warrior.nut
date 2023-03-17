::mods_hookExactClass("entity/tactical/enemies/orc_warrior", function(o) {
	o.onInit = function()
	{
	    this.actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.OrcWarrior);

		// if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 200)
		// {
		// 	b.MeleeSkill += 5;
		// 	b.DamageTotalMult += 0.1;
		// }

		// this.m.BaseProperties.DamageTotalMult -= 0.1;
		// b.IsSpecializedInAxes = true;
		// b.IsSpecializedInCleavers = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		this.m.Items.getAppearance().Body = "bust_orc_03_body";
		this.addSprite("socket").setBrush("bust_base_orcs");
		local body = this.addSprite("body");
		body.setBrush("bust_orc_03_body");
		body.varyColor(0.09, 0.09, 0.09);
		local injury_body = this.addSprite("injury_body");
		injury_body.Visible = false;
		injury_body.setBrush("bust_orc_03_body_injured");
		this.addSprite("armor");
		local head = this.addSprite("head");
		head.setBrush("bust_orc_03_head_0" + this.Math.rand(1, 3));
		head.Saturation = body.Saturation;
		head.Color = body.Color;
		local injury = this.addSprite("injury");
		injury.Visible = false;
		injury.setBrush("bust_orc_03_head_injured");
		this.addSprite("helmet");
		local body_blood = this.addSprite("body_blood");
		body_blood.setBrush("bust_orc_03_body_bloodied");
		body_blood.Visible = false;
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.6;
		this.setSpriteOffset("status_rooted", this.createVec(0, 5));
		this.m.Skills.add(this.new("scripts/skills/special/double_grip"));
		this.m.Skills.add(this.new("scripts/skills/actives/hand_to_hand_orc"));
		this.m.Skills.add(this.new("scripts/skills/actives/line_breaker"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_battering_ram"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_stalwart"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_shield_bash"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_hold_out"));

		if (this.Const.DLC.Unhold)
		{
			this.m.Skills.add(this.new("scripts/skills/actives/wake_ally_skill"));
		}

		// this.m.Skills.add(this.new("scripts/skills/effects/captain_effect"));	// Now only added onCombatStarted with a captain present

		// Reforged
		this.m.BaseProperties.Reach = ::Reforged.Reach.Default.Orc;
		this.m.Skills.add(::new("scripts/skills/racial/rf_orc_racial"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_bulwark"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_menacing"));
		if (::Reforged.Config.IsLegendaryDifficulty)
    	{
    		this.m.Skills.add(::new("scripts/skills/perks/perk_battle_forged"));
    		this.m.Skills.add(::new("scripts/skills/perks/perk_fearsome"));
    	}
	}

	local assignRandomEquipment = o.assignRandomEquipment;
	o.assignRandomEquipment = function()
	{
	    assignRandomEquipment();

	    local weapon = this.getMainhandItem();
	    if (weapon == null) return;

	    if (weapon.isWeaponType(::Const.Items.WeaponType.Axe))
	    {
	    	this.m.Skills.add(::new("scripts/skills/perks/perk_rf_shield_splitter"));
	    	this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_axe"));
	    	if (::Reforged.Config.IsLegendaryDifficulty)
	    	{
	    		this.m.Skills.add(::new("scripts/skills/perks/perk_killing_frenzy"));
	    	}
	    }
	    else if (weapon.isWeaponType(::Const.Items.WeaponType.Cleaver))
	    {
	    	this.m.Skills.add(::new("scripts/skills/perks/perk_crippling_strikes"));
	    	this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_cleaver"));
	    	this.m.Skills.add(::new("scripts/skills/perks/perk_coup_de_grace"));
	    	if (::Reforged.Config.IsLegendaryDifficulty)
	    	{
	    		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_swordlike"));
	    	}
	    }
	}

	local makeMiniboss = o.makeMiniboss;
	o.makeMiniboss = function()
	{
		local ret = makeMiniboss();
		if (ret)
		{
			this.m.Skills.add(::new("scripts/skills/perks/perk_rf_personal_armor"));
			this.m.Skills.add(::new("scripts/skills/perks/perk_rf_unstoppable"));
	    	if (::Reforged.Config.IsLegendaryDifficulty)
    		{
    			this.m.Skills.removeByID("perk.perk_rf_personal_armor");
    			this.m.Skills.add(::new("scripts/skills/perks/perk_rf_skirmisher"));
    			this.m.Skills.add(::new("scripts/skills/perks/perk_rf_man_of_steel"));
    		}
		}

		return ret;
	}
});
