::mods_hookExactClass("entity/tactical/enemies/bandit_marksman", function(o) {
	o.onInit = function()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.BanditMarksman);
		b.TargetAttractionMult = 1.1;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_bandits");

		if (this.Math.rand(1, 100) <= 20)
		{
			local pox = this.getSprite("tattoo_head");
			pox.Visible = true;
			pox.setBrush("bust_head_darkeyes_01");
		}
		else
		{
			local dirt = this.getSprite("dirt");
			dirt.Visible = true;
			dirt.Alpha = this.Math.rand(150, 255);
		}

		this.getSprite("armor").Saturation = 0.85;
		this.getSprite("helmet").Saturation = 0.85;
		this.getSprite("helmet_damage").Saturation = 0.85;
		this.getSprite("shield_icon").Saturation = 0.85;
		this.getSprite("shield_icon").setBrightness(0.85);

		// if (!this.m.IsLow)
		// {
		// 	b.IsSpecializedInBows = true;
		// 	b.IsSpecializedInCrossbows = true;
			b.Vision = 8;
		// }

		// if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 40)
		// {
			b.RangedDefense += 5;
		// }

		// this.m.Skills.add(this.new("scripts/skills/actives/rotation")); // Replaced with perk
		// this.m.Skills.add(this.new("scripts/skills/actives/recover_skill")); //Replaced with perk

		// if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 20)
		// {
			this.m.Skills.add(this.new("scripts/skills/perks/perk_bullseye"));
		// }

		//Reforged
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_bully"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rotation"));

		if (::Reforged.Config.IsLegendaryDifficulty)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_entrenched"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
		}
	}

	local assignRandomEquipment = o.assignRandomEquipment;
	o.assignRandomEquipment = function()
	{
	    assignRandomEquipment();
		local weapon = this.getMainhandItem();
	    if (weapon == null) return;
		if (weapon.isWeaponType(::Const.Items.WeaponType.Bow))
	    {
	    	this.m.Skills.add(::new("scripts/skills/perks/perk_rf_target_practice"));
	    	this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_bow"));
	    }
    	else
    	{
    		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_power_shot"));
    		this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_crossbow"));
    	}
	}
});
