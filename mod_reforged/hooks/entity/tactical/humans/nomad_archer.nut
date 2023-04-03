::mods_hookExactClass("entity/tactical/humans/nomad_archer", function(o) {
	o.onInit = function()
	{
	    this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.NomadArcher);
		b.TargetAttractionMult = 1.1;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_nomads");

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

		// b.IsSpecializedInBows = true; // Replaced with perk
		b.Vision = 8;

		// if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 30)
		// {
		// 	b.RangedSkill += 5;

		// 	if (this.World.getTime().Days >= 60)
		// 	{
		// 		this.m.Skills.add(this.new("scripts/skills/perks/perk_head_hunter"));
		// 		b.RangedDefense += 5;
		// 	}
		// }

		this.m.Skills.add(this.new("scripts/skills/actives/throw_dirt_skill"));
		// this.m.Skills.add(this.new("scripts/skills/actives/rotation")); // Replaced with perk
		// this.m.Skills.add(this.new("scripts/skills/actives/recover_skill")); // Replaced with perk
		this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));

		// if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 20)
		// {
		// 	this.m.Skills.add(this.new("scripts/skills/perks/perk_bullseye"));
		// }

		// Reforged
		this.m.Skills.add(::new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_recover"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_bow"));
		if (::Math.rand(1, 100) <= 25)
		{
			this.m.Skills.add(::new("scripts/skills/perks/perk_rf_eyes_up"));
		}
		elseif (::Math.rand(1, 100) <= 25)
		{
			this.m.Skills.add(::new("scripts/skills/perks/perk_rf_flaming_arrows"));
		}

		if (::Reforged.Config.IsLegendaryDifficulty)
    	{
    		this.m.Skills.add(::new("scripts/skills/perks/perk_dodge"));
    		this.m.Skills.add(::new("scripts/skills/perks/perk_footwork"));
    	}
	}
});
