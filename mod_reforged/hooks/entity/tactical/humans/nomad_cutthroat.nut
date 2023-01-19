::mods_hookExactClass("entity/tactical/humans/nomad_cutthroat", function(o) {
	o.onInit = function()
	{
	    this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.NomadCutthroat);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_nomads");

		if (this.Math.rand(1, 100) <= 15)
		{
			local pox = this.getSprite("tattoo_head");
			pox.Visible = true;
			pox.setBrush("bust_head_darkeyes_01");
		}
		else
		{
			local dirt = this.getSprite("dirt");
			dirt.Visible = true;
		}

		if (this.Math.rand(1, 100) <= 25)
		{
			this.getSprite("eye_rings").Visible = true;
		}

		this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
		this.m.Skills.add(this.new("scripts/skills/actives/throw_dirt_skill"));
		// this.m.Skills.add(this.new("scripts/skills/actives/rotation"));
		// this.m.Skills.add(this.new("scripts/skills/actives/recover_skill")); // Replaced with perk
		this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));

		// if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 35)
		// {
		// 	this.m.Skills.add(this.new("scripts/skills/effects/dodge_effect"));
		// }

		// Reforged
		this.m.Skills.add(::new("scripts/skills/perks/perk_recover"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_relentless"));
		if (::Reforged.Config.IsLegendaryDifficulty)
    	{
    		this.m.Skills.add(::new("scripts/skills/perks/perk_dodge"));
    	}
	}

	local assignRandomEquipment = o.assignRandomEquipment;
	o.assignRandomEquipment = function()
	{
	    assignRandomEquipment();

	    local weapon = this.getMainhandItem();
	    if (weapon == null) return;

	    if (weapon.isWeaponType(::Const.Items.WeaponType.Sword))
	    {
	    	::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 2);
	    }
	    else
	    {
	    	::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 1);
	    }
	}
});
