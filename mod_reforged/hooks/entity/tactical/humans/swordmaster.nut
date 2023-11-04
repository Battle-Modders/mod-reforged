::Reforged.HooksMod.hook("scripts/entity/tactical/humans/swordmaster", function(q) {
	q.m.SwordmasterVariants <- {
        BladeDancer = 0,
        Metzger = 1,
        Reaper = 2,
        Precise = 3,
        Grappler = 4
    };
	q.m.MyArmorVariant <- 0;
	q.m.MyVariant <- 0;

	q.onInit = @() function()
	{
	    this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.Swordmaster);
		b.IsSpecializedInSwords = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_militia");
		this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_flow"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_dodge"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_footwork"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_finesse"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_overwhelm"));

		this.m.MyVariant = ::MSU.Table.randValue(this.m.SwordmasterVariants);
        this.m.MyArmorVariant = ::Math.rand(0, 1); // 0 = Light Armor, 1 = Medium Armor
	}

	q.assignRandomEquipment = @() function()
	{
		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Body))
		{
			if (this.m.MyArmorVariant == 0) // light armor
            {
               this.m.Items.equip(::new("scripts/items/armor/noble_mail_armor"));
            }
            else // medium armor
            {
               local armor = ::MSU.Class.WeightedContainer([
		    		[1, "scripts/items/armor/rf_breastplate"],
					[1, "scripts/items/armor/rf_brigandine_armor"]
		    	]).roll();

               this.m.Items.equip(::new(armor));
            }
        }

        if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head))
		{
			local helmet = null;
			if (this.m.MyArmorVariant == 0) // light armor
			{
				helmet = ::MSU.Class.WeightedContainer([
		    		[1, "scripts/items/helmets/greatsword_hat"],
					[1, "scripts/items/helmets/reinforced_mail_coif"]
		    	]).roll();
			}
			else // medium armor
			{
				helmet = ::MSU.Class.WeightedContainer([
		    		[1, "scripts/items/helmets/greatsword_faction_helm"],
					[1, "scripts/items/helmets/rf_padded_sallet_helmet"],
					[1, "scripts/items/helmets/barbute_helmet"],
					[1, "scripts/items/helmets/rf_half_closed_sallet"]
		    	]).roll();
			}
		this.m.Items.equip(::new(helmet));
		}

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Mainhand))
		{
			local weapon;
			switch(this.m.MyVariant)
	        {
	            case this.m.SwordmasterVariants.BladeDancer:
	                weapon = ::MSU.Class.WeightedContainer([
			    		[1, "scripts/items/weapons/longsword"],
						[1, "scripts/items/weapons/rf_greatsword"],
						[1, "scripts/items/weapons/noble_sword"],
						[1, "scripts/items/weapons/warbrand"]
			    	]).roll();
	                break;

	            case this.m.SwordmasterVariants.Metzger:
					if (this.m.MyArmorVariant == 0) // light armor
					{
						weapon = "scripts/items/weapons/shamshir";
					}
					else // medium armor
					{
						weapon = "scripts/items/weapons/rf_kriegsmesser";
					}
	                break;

	            case this.m.SwordmasterVariants.Precise:
	                weapon = ::MSU.Class.WeightedContainer([
			    		[1, "scripts/items/weapons/fencing_sword"],
						[1, "scripts/items/weapons/rf_estoc"]
			    	]).roll();
	                break;

	            case this.m.SwordmasterVariants.Reaper:
	            case this.m.SwordmasterVariants.Grappler:
	                weapon = ::MSU.Class.WeightedContainer([
			    		[1, "scripts/items/weapons/rf_greatsword"],
						[1, "scripts/items/weapons/warbrand"],
						[1, "scripts/items/weapons/greatsword"]
			    	]).roll();
	                break;
	        }
       	 	this.m.Items.equip(::new(weapon));
  	 	}
	}

	q.makeMiniboss = @() function()
	{
		if (!this.actor.makeMiniboss())
		{
			return false;
		}

		this.getSprite("miniboss").setBrush("bust_miniboss");

		local r = ::Math.rand(1, 100);
		if (r <= 60) // named weapon
		{
			local weapon = null;
			switch(this.m.MyVariant)
	        {
	            case this.m.SwordmasterVariants.BladeDancer:
	                weapon = ::MSU.Class.WeightedContainer([
						[1, "scripts/items/weapons/named/named_sword"],
						[1, "scripts/items/weapons/named/named_rf_longsword"],
						[1, "scripts/items/weapons/named/named_warbrand"]
			    	]).roll();
	                break;

	            case this.m.SwordmasterVariants.Metzger:
					if (this.m.MyArmorVariant == 0) // light armor
					{
						weapon = "scripts/items/weapons/named/named_shamshir";
					}
					else // medium armor
					{
						 weapon = "scripts/items/weapons/named/named_rf_kriegsmesser";
					}
	                break;

	            case this.m.SwordmasterVariants.Precise:
	                weapon = ::MSU.Class.WeightedContainer([
			    		[1, "scripts/items/weapons/named/named_fencing_sword"],
						[1, "scripts/items/weapons/named/named_rf_estoc"]
			    	]).roll();
	                break;

	            case this.m.SwordmasterVariants.Reaper:
	            case this.m.SwordmasterVariants.Grappler:
	                weapon = ::MSU.Class.WeightedContainer([
						[1, "scripts/items/weapons/named/named_warbrand"],
						[1, "scripts/items/weapons/named/named_greatsword"]
			    	]).roll();
	                break;
	        }
        	this.m.Items.equip(::new(weapon));
		}
		else if (r <= 80) // named armor
		{
			local armor = null;
			if (this.m.MyArmorVariant == 0) // light armor
            {
                armor = ::Reforged.ItemTable.NamedArmorNorthern.roll({
					Apply = function ( _script, _weight )
					{
						local stam = ::ItemTables.ItemInfoByScript[_script].StaminaModifier;
						if (stam < -16) return 0.0;
						return _weight;
					}
				})
            }
            else // medium armor
            {
               armor = ::Reforged.ItemTable.NamedArmorNorthern.roll({
					Apply = function ( _script, _weight )
					{
						local stam = ::ItemTables.ItemInfoByScript[_script].StaminaModifier;
						if (stam > -26 || stam < -32) return 0.0;
						return _weight;
					}
				})
            }
        	this.m.Items.equip(::new(armor));
        }
		else // named helmet
		{
			local helmet = null;
			if (this.m.MyArmorVariant == 0) // light armor
			{
				helmet = ::Reforged.ItemTable.NamedHelmetNorthern.roll({
					Apply = function ( _script, _weight )
					{
						local stam = ::ItemTables.ItemInfoByScript[_script].StaminaModifier;
						if (stam < -8) return 0.0;
						return _weight;
					}
				})
			}
			else // medium armor
			{
				helmet = ::Reforged.ItemTable.NamedHelmetNorthern.roll({
					Apply = function ( _script, _weight )
					{
						local stam = ::ItemTables.ItemInfoByScript[_script].StaminaModifier;
						if (stam > -10 || stam < -16) return 0.0;
						return _weight;
					}
				})
			}
			this.m.Items.equip(::new(helmet));
		}

		return true;
	}

	q.onSetupEntity <- function()
	{
		if (this.m.MyArmorVariant == 0) // light armor
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_nimble"));
		}
		else // medium armor
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_skirmisher"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_poise"));
		}

		local mainhandItem = this.getMainhandItem();
		if (mainhandItem != null)
		{
			switch(this.m.MyVariant)
	        {
	            case this.m.SwordmasterVariants.BladeDancer:
		            this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_exploit_opening"));
					this.m.Skills.add(this.new("scripts/skills/perks/perk_mastery_sword"));
					this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_tempo"));
					this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_kata"));
					this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_swordmaster_blade_dancer"));

					switch (mainhandItem.getID())
		    		{
		    			case "weapon.rf_greatsword":
		    				this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_formidable_approach"));
		    				break;
		    			case "weapon.warbrand":
		    			case "weapon.named_warbrand":
		    				this.m.Skills.add(this.new("scripts/skills/perks/perk_duelist"));
		    				this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_death_dealer"));
		    				break;
		    		}
			    	if (this.m.Skills.hasSkill("actives.riposte")) //longsword and noble sword
					{
						this.m.Skills.add(this.new("scripts/skills/perks/perk_duelist"));
						this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_en_garde"));
					}
					else //greatsword and warbrand
					{
						this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_sweeping_strikes"));
					}
                	break;

	            case this.m.SwordmasterVariants.Metzger:
	            	this.m.Skills.add(this.new("scripts/skills/perks/perk_duelist"));
    				this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_swordmaster_metzger"));

					switch (mainhandItem.getID())
		    		{
		    			case "weapon.shamshir":
		    			case "weapon.named_shamshir":
		    				::Reforged.Skills.addPerkGroupOfEquippedWeapon(this);
		    				this.m.Skills.add(this.new("scripts/skills/perks/perk_overwhelm"));
		    				break;
		    			case  "weapon.rf_kriegsmesser":
		    			case  "weapon.named_rf_kriegsmesser":
		    				this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_exploit_opening"));
		    				this.m.Skills.add(this.new("scripts/skills/perks/perk_mastery_sword"));
		    				this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_kata"));
		    				this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_en_garde"));
		    				this.m.Skills.add(this.new("scripts/skills/perks/perk_berserk"));
		    				this.m.Skills.add(this.new("scripts/skills/perks/perk_fearsome"));
		    				break;
		    		}
	                break;

	            case this.m.SwordmasterVariants.Precise:
			    	::Reforged.Skills.addPerkGroupOfEquippedWeapon(this);
			    	this.m.Skills.add(this.new("scripts/skills/perks/perk_duelist"));
			    	this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_fencer"));
			    	this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_swordmaster_precise"));
	                break;

	            case this.m.SwordmasterVariants.Reaper:
		    		::Reforged.Skills.addPerkGroupOfEquippedWeapon(this);
		    		this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_death_dealer"));
			    	this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_swordmaster_reaper"));
			    	this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_sweeping_strikes"));

			    	local attack = this.getSkills().getAttackOfOpportunity();
					if (attack != null && attack.getBaseValue("ActionPointCost") <= 4)
					{
						this.m.Skills.add(::new("scripts/skills/perks/perk_duelist"));
					}
					else
					{
						this.m.Skills.add(::new("scripts/skills/perks/perk_rf_formidable_approach"));
					}
	                break;

	            case this.m.SwordmasterVariants.Grappler:
	            	::Reforged.Skills.addPerkGroupOfEquippedWeapon(this);
	            	this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_swordmaster_grappler"));
	            	this.m.Skills.add(this.new("scripts/skills/perks/perk_rotation"));
	            	this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_kata"));
	            	local attack = this.getSkills().getAttackOfOpportunity();
					if (attack != null && attack.getBaseValue("ActionPointCost") <= 4)
					{
						this.m.Skills.add(::new("scripts/skills/perks/perk_duelist"));
					}
					else
					{
						this.m.Skills.add(::new("scripts/skills/perks/perk_rf_formidable_approach"));
					}
					break;
	        }
        }

        if (this.m.IsMiniboss)
        {
			switch(this.m.MyVariant)
	        {
	            case this.m.SwordmasterVariants.BladeDancer:
	            	this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_pattern_recognition"));
	                break;

	            case this.m.SwordmasterVariants.Metzger:
	            	local mainhandItem = this.getMainhandItem();
		            switch (mainhandItem.getID())
		    		{
		            	case "weapon.shamshir":
		            	case "weapon.named_shamshir":
		    				this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_swordlike"));
		    				break;
		    			case  "weapon.rf_kriegsmesser":
		    			case  "weapon.named_rf_kriegsmesser":
		    				this.m.Skills.add(this.new("scripts/skills/perks/perk_killing_frenzy"));
		    				break;
		            }
	                break;

	            case this.m.SwordmasterVariants.Precise:
	            	this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_pattern_recognition"));
	                break;

	            case this.m.SwordmasterVariants.Reaper:
	            case this.m.SwordmasterVariants.Grappler:
	            	this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_pattern_recognition"));
	                break;
	        }
        }
	}
});
