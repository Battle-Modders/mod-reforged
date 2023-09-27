::Reforged.HooksMod.hook("scripts/entity/tactical/humans/militia_guest_ranged", function(q) {
	q.onInit = @(__original) function()
	{
	    this.player.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.MilitiaRanged);
		b.TargetAttractionMult = 1.0;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.Talents.resize(this.Const.Attributes.COUNT, 0);
		this.m.Attributes.resize(this.Const.Attributes.COUNT, [
			0
		]);
		this.m.Name = this.Const.Strings.CharacterNames[this.Math.rand(0, this.Const.Strings.CharacterNames.len() - 1)];
		this.m.Title = "the Militiaman";
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_militia");
		this.getSprite("accessory_special").setBrush("bust_militia_band_01");

		// Reforged
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_strength_in_numbers"));
		if (::Reforged.Config.IsLegendaryDifficulty)
    	{
    		this.m.Skills.add(::new("scripts/skills/perks/perk_dodge"));
    		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_through_the_ranks"));
    		local skill = ::MSU.Class.WeightedContainer([
    			[25, "scripts/skills/perks/perk_rf_eyes_up"],
    			[25, "scripts/skills/perks/perk_rf_flaming_arrows"],
    			[50, ""]
    		]).roll();

    		if (skill != "") this.m.Skills.add(::new(skill));
    	}
	}

	q.assignRandomEquipment = @(__original) function()
	{
	    __original();

	    ::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 4);
	}
});
