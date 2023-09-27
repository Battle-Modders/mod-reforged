::Reforged.HooksMod.hook("scripts/entity/tactical/enemies/bandit_leader", function(q) {
	q.create = @(__original) function()
	{
		__original();
		this.m.AIAgent = ::new("scripts/ai/tactical/agents/rf_bandit_leader_agent");
		this.m.AIAgent.setActor(this);
	}

    q.onInit = @(__original) function()
    {
       this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.BanditLeader);
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

		this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_battle_fervor"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_bully"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_captain"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));

		this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_shield_sergeant"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_hold_steady"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_onslaught"));
		this.m.Skills.add(::MSU.new("scripts/skills/perks/perk_inspiring_presence", function(o) {
    		o.m.IsForceEnabled = true;
    	}));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rally_the_troops"));
	}

	q.assignRandomEquipment = @(__original) function()
	{
		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Mainhand))
		{
			local weapon = ::MSU.Class.WeightedContainer([
	    		[1, "scripts/items/weapons/fighting_axe"],
				[1, "scripts/items/weapons/noble_sword"],
				[1, "scripts/items/weapons/warhammer"],
				[1, "scripts/items/weapons/winged_mace"],
				[1, "scripts/items/weapons/military_cleaver"],
				[1, "scripts/items/weapons/fighting_spear"],

				[1, "scripts/items/weapons/rf_kriegsmesser"],
				[1, "scripts/items/weapons/rf_swordstaff"],
				[1, "scripts/items/weapons/two_handed_flail"],
				[1, "scripts/items/weapons/two_handed_flanged_mace"],
				[1, "scripts/items/weapons/greatsword"]
	    	]).roll();

			this.m.Items.equip(::new(weapon));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Offhand))
		{
			local shield = ::MSU.Class.WeightedContainer([
				[1.0, "scripts/items/shields/heater_shield"],
				[1.0, "scripts/items/shields/kite_shield"]
			]).roll();

			this.m.Items.equip(::new(shield));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Body))
		{
			local armor = ::Reforged.ItemTable.BanditArmorLeader.roll({
				Apply = function ( _script, _weight )
				{
					local conditionMax = ::ItemTables.ItemInfoByScript[_script].ConditionMax;
					if (conditionMax < 210 || conditionMax > 240) return 0.0;
					return _weight;
				}
			})
			this.m.Items.equip(::new(armor));
		}


		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Head))
		{
			local helmet = ::Reforged.ItemTable.BanditHelmetLeader.roll({
				Apply = function ( _script, _weight )
				{
					local conditionMax = ::ItemTables.ItemInfoByScript[_script].ConditionMax;
					if (conditionMax < 180 || conditionMax > 230) return 0.0;
					return _weight;
				}
			})
			this.m.Items.equip(::new(helmet));
		}
	}

	q.onSetupEntity <- function()
	{
		local mainhandItem = this.getMainhandItem();
		if (mainhandItem != null)
		{
			if (mainhandItem.isItemType(::Const.Items.ItemType.OneHanded))
			{
				if (mainhandItem.isWeaponType(::Const.Items.WeaponType.Axe))
		    	{
		    		this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_shield_splitter"));
		    		this.m.Skills.add(this.new("scripts/skills/perks/perk_mastery_axe"));
		    		this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));
		    	}
		    	else if (mainhandItem.isWeaponType(::Const.Items.WeaponType.Sword))
		    	{
		    		this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_exploit_opening"));
		    		this.m.Skills.add(this.new("scripts/skills/perks/perk_mastery_sword"));
		    		this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_tempo"));
		    		this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_en_garde"));
		    	}
		    	else if (mainhandItem.isWeaponType(::Const.Items.WeaponType.Hammer))
		    	{
		    		this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_rattle"));
		    		this.m.Skills.add(this.new("scripts/skills/perks/perk_mastery_hammer"));
		    		this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_deep_impact"));
		    	}
		    	else if (mainhandItem.isWeaponType(::Const.Items.WeaponType.Mace))
		    	{
		    		this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_rattle"));
		    		this.m.Skills.add(this.new("scripts/skills/perks/perk_mastery_mace"));
		    		this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_concussive_strikes"));
		    	}
		    	else //cleaver or spear
		    	{
		    		::Reforged.Skills.addPerkGroupOfEquippedWeapon(this)
		    	}
			}
			else //Two Handed Weapon
			{
				if (mainhandItem.isWeaponType(::Const.Items.WeaponType.Flail))
		    	{
		    		::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 4);
		    		this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_rattle"));
		    		this.m.Skills.add(this.new("scripts/skills/perks/perk_mastery_flail"));
		    		this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_whirling_death"));
		    	}
		    	else if (mainhandItem.isWeaponType(::Const.Items.WeaponType.Mace))
		    	{
		    		this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_rattle"));
		    		this.m.Skills.add(this.new("scripts/skills/perks/perk_mastery_mace"));
		    		this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_concussive_strikes"));
		    	}
		    	else
		    	{
		    		switch (mainhandItem.getID())
		    		{
		    			case "weapon.rf_kriegsmesser":
		    				this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
		    				this.m.Skills.add(this.new("scripts/skills/perks/perk_mastery_cleaver"));
		    				this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_en_garde"));
		    				break;
		    			case "weapon.rf_swordstaff":
		    				this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_exploit_opening"));
		    				this.m.Skills.add(this.new("scripts/skills/perks/perk_mastery_sword"));
		    				this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_two_for_one"));
		    				break;
	    				case "weapon.greatsword":
	    					this.m.Skills.add(this.new("scripts/skills/perks/perk_mastery_sword"));
	    					this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_tempo"));
	    					this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_death_dealer"));
	    					break;
		    		}
		    	}
			}
		}

		local attack = this.getSkills().getAttackOfOpportunity();
		if (attack != null && attack.getBaseValue("ActionPointCost") <= 4)
		{
			this.m.Skills.add(::new("scripts/skills/perks/perk_duelist"));
		}
		else
		{
			this.m.Skills.add(::new("scripts/skills/perks/perk_rf_formidable_approach"));
		}

		local offhandItem = this.getOffhandItem();
		if (offhandItem != null && offhandItem.isItemType(::Const.Items.ItemType.Shield))
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_shield_expert"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_line_breaker"));
		}
	}
});
