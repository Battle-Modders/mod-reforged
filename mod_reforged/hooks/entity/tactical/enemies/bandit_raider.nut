::mods_hookExactClass("entity/tactical/enemies/bandit_raider", function(o) {
	o.onInit = function()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.BanditRaider);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_bandits");
		local dirt = this.getSprite("dirt");
		dirt.Visible = true;
		dirt.Alpha = this.Math.rand(150, 255);
		this.getSprite("armor").Saturation = 0.85;
		this.getSprite("helmet").Saturation = 0.85;
		this.getSprite("helmet_damage").Saturation = 0.85;
		this.getSprite("shield_icon").Saturation = 0.85;
		this.getSprite("shield_icon").setBrightness(0.85);

		// if (!this.m.IsLow)
		// {
		// 	b.IsSpecializedInSwords = true;
		// 	b.IsSpecializedInAxes = true;
		// 	b.IsSpecializedInMaces = true;
		// 	b.IsSpecializedInFlails = true;
		// 	b.IsSpecializedInPolearms = true;
		// 	b.IsSpecializedInThrowing = true;
		// 	b.IsSpecializedInHammers = true;
		// 	b.IsSpecializedInSpears = true;
		// 	b.IsSpecializedInCleavers = true;

		// 	if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 40)
		// 	{
		// 		b.MeleeSkill += 5;
		// 		b.RangedSkill += 5;
		// 	}
		// }

		this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_bullseye"));
		// this.m.Skills.add(this.new("scripts/skills/actives/rotation")); // Replaced with perk
		// this.m.Skills.add(this.new("scripts/skills/actives/recover_skill")); //Replaced with perk

		//Reforged
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_bully"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_momentum"));

		if (::Reforged.Config.IsLegendaryDifficulty)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_mastery_throwing"));
		}
	}

	local assignRandomEquipment = o.assignRandomEquipment;
	o.assignRandomEquipment = function()
	{
	    assignRandomEquipment();
	    ::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 4);
	    if (::Reforged.Config.IsLegendaryDifficulty)
		{
			if (this.isArmedWithShield())
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_shield_expert"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_linebreaker"));
			}
			else
			{
				if (this.getOffhandItem() == null)
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_dodge"));
				}
			}
				else
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_vigorous_assault"));
				}
		}
	}
});
