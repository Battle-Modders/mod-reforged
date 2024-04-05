::Reforged.HooksMod.hook("scripts/entity/tactical/enemies/goblin_fighter", function(q) {
	q.onInit = @() function()
	{
	    this.goblin.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.GoblinFighter);
		// b.DamageDirectMult = 1.25;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		this.getSprite("head").setBrush("bust_goblin_01_head_0" + this.Math.rand(1, 3));
		this.addDefaultStatusSprites();

		// if (!this.m.IsLow)
		// {
		// 	b.IsSpecializedInThrowing = true;
		// 	b.IsSpecializedInSpears = true;
		// 	b.IsSpecializedInSwords = true;

		// 	if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 50)
		// 	{
		// 		b.MeleeDefense += 5;
		// 		b.RangedDefense += 5;
		// 		this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));

		// 		if (this.World.getTime().Days >= 90)
		// 		{
		// 			b.RangedSkill += 5;
		// 		}
		// 	}

		// 	this.m.Skills.update();
		// }

		// Reforged
		this.m.Skills.add(::new("scripts/skills/perks/perk_backstabber"));
	}

	q.assignRandomEquipment = @(__original) function()
	{
	    __original();

	    local weapon = this.getMainhandItem();
	    if (weapon != null)
	    {
	    	if (weapon.isItemType(::Const.Items.ItemType.OneHanded))
	    	{
	    		::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 4)
	    	}
	    	else
	    	{
	    		::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 3)
	    		this.m.Skills.add(::new("scripts/skills/perks/perk_crippling_strikes"));
	    	}
		}
	}

	q.makeMiniboss = @(__original) function()
	{
		local ret = __original();
		if (ret)
		{
			this.m.Skills.removeByID("perk.nine_lives"); // revert vanilla
			// Rest from vanilla: Nimble, Dodge, Relentless

			local weapon = this.getMainhandItem();
			if (weapon != null)
			{
				if (weapon.isItemType(::Const.Items.ItemType.OneHanded))
		    	{
		    		this.m.Skills.add(::new("scripts/skills/perks/perk_duelist"));
		    		::Reforged.Skills.addPerkGroupOfEquippedWeapon(this)
		    	}
		    	else
		    	{
		    		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_intimidate"));
		    		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_long_reach"));
		    		this.m.BaseProperties.DamageDirectMult = 1.25;
		    	}
			}
		}

		return ret;
	}
});
