::Reforged.HooksMod.hook("scripts/entity/tactical/humans/slave", function(q) {
	q.onInit = @() function()
	{
	    this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.Slave);
		b.TargetAttractionMult = 0.5;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_southern");

		if (this.Math.rand(1, 100) <= 50)
		{
			local tattoo_head = this.actor.getSprite("tattoo_head");
			tattoo_head.setBrush("bust_head_darkeyes_01");
			tattoo_head.Visible = true;
		}
		else
		{
			local tattoo_head = this.actor.getSprite("tattoo_head");
			tattoo_head.setBrush("scar_02_head");
			tattoo_head.Visible = true;
		}

		if (this.Math.rand(1, 100) <= 75)
		{
			local dirt = this.getSprite("dirt");
			dirt.Visible = true;
		}

		if (this.Math.rand(1, 100) <= 75)
		{
			local tattoo_body = this.actor.getSprite("tattoo_body");
			local body = this.actor.getSprite("body");
			tattoo_body.setBrush("scar_02_" + body.getBrush().Name);
			tattoo_body.Visible = true;
		}

		if (this.m.Ethnicity == 0)
		{
			local body = this.getSprite("body");
			body.Color = this.createColor("#ffeaea");
			body.varyColor(0.05, 0.05, 0.05);
			local head = this.getSprite("head");
			head.Color = body.Color;
			head.Saturation = body.Saturation;
		}

		this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));

		// Reforged
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_strength_in_numbers"));
	}
});
