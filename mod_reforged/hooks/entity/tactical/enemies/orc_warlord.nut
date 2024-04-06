::Reforged.HooksMod.hook("scripts/entity/tactical/enemies/orc_warlord", function(q) {
	q.onInit = @() function()
	{
	    this.actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.OrcWarlord);

		// if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 200)
		// {
		// 	b.MeleeSkill += 5;
		// 	b.DamageTotalMult += 0.1;
		// }

		// b.IsSpecializedInAxes = true;
		// b.IsSpecializedInCleavers = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		this.m.Items.getAppearance().Body = "bust_orc_04_body";
		this.addSprite("socket").setBrush("bust_base_orcs");
		local body = this.addSprite("body");
		body.setBrush("bust_orc_04_body");
		body.varyColor(0.1, 0.1, 0.1);
		local injury_body = this.addSprite("injury_body");
		injury_body.Visible = false;
		injury_body.setBrush("bust_orc_04_body_injured");
		this.addSprite("armor");
		local head = this.addSprite("head");
		head.setBrush("bust_orc_04_head_01");
		head.Saturation = body.Saturation;
		head.Color = body.Color;
		local injury = this.addSprite("injury");
		injury.Visible = false;
		injury.setBrush("bust_orc_04_head_injured");
		this.addSprite("helmet");
		local body_blood = this.addSprite("body_blood");
		body_blood.setBrush("bust_orc_04_body_bloodied");
		body_blood.Visible = false;
		this.addDefaultStatusSprites();
		this.setSpriteOffset("arms_icon", this.createVec(-8, 0));
		this.setSpriteOffset("shield_icon", this.createVec(-5, 0));
		this.setSpriteOffset("stunned", this.createVec(0, 10));
		this.getSprite("status_rooted").Scale = 0.65;
		this.setSpriteOffset("status_rooted", this.createVec(0, 16));
		this.setSpriteOffset("status_stunned", this.createVec(-5, 30));
		this.setSpriteOffset("arrow", this.createVec(-5, 30));
		this.m.Skills.add(this.new("scripts/skills/special/double_grip"));
		this.m.Skills.add(this.new("scripts/skills/actives/hand_to_hand_orc"));
		this.m.Skills.add(this.new("scripts/skills/actives/warcry"));
		this.m.Skills.add(this.new("scripts/skills/actives/line_breaker"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_captain"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_battering_ram"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_hold_out"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_stalwart"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_shield_bash"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fearsome"));
		this.m.Skills.add(this.new("scripts/skills/effects/captain_effect"));

		// Reforged
		this.m.BaseProperties.Reach = ::Reforged.Reach.Default.Orc;
		this.m.Skills.add(::new("scripts/skills/racial/rf_orc_racial"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_menacing"));
	}

	q.assignRandomEquipment = @(__original) function()
	{
	    __original();

	    local weapon = this.getMainhandItem();
	    if (weapon == null) return;

	    ::Reforged.Skills.addPerkGroupOfEquippedWeapon(this);
	}

	q.makeMiniboss = @(__original) function()
	{
		local ret = __original();
		if (ret)
		{
			this.m.Skills.add(::new("scripts/skills/perks/perk_rf_man_of_steel"));
		}

		return ret;
	}
});
