::mods_hookExactClass("entity/tactical/enemies/bandit_thug", function(o) {
	o.onInit = function()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.BanditThug);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_bandits");

		if (this.Math.rand(1, 100) <= 10)
		{
			local pox = this.getSprite("tattoo_head");
			pox.Visible = true;
			pox.setBrush("bust_head_pox_01");
		}
		else if (this.Math.rand(1, 100) <= 15)
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

		this.getSprite("armor").Saturation = 0.8;
		this.getSprite("helmet").Saturation = 0.8;
		this.getSprite("helmet_damage").Saturation = 0.8;
		this.getSprite("shield_icon").Saturation = 0.8;
		this.getSprite("shield_icon").setBrightness(0.9);

		// Reforged
		this.m.Skills.add(::new("scripts/skills/perks/perk_bully"));
	}

	local assignRandomEquipment = o.assignRandomEquipment;
	o.assignRandomEquipment = function()
	{
	    assignRandomEquipment();

	    if (::Reforged.Config.IsLegendaryDifficulty)
    	{
    		local weapon = this.getMainhandItem();
    		if (weapon == null) return;
    		if (weapon != null && weapon.isWeaponType(this.Const.Items.WeaponType.Sword) || weapon.isWeaponType(this.Const.Items.WeaponType.Polearm))
    		{
    			::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 2);
    		}
    		else
    		{
    			::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 1);
    		}
    	}
	}
});
