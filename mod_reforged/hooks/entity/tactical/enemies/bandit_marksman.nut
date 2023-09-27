::Reforged.HooksMod.hook("scripts/entity/tactical/enemies/bandit_marksman", function(q) {
	q.m.MyVariant <- 0;

	q.onInit = @(__original) function()
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

		this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_bully"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));

		this.m.MyVariant = ::Math.rand(0, 1); // 1 is crossbow
	}

	q.assignRandomEquipment = @(__original) function()
	{
	    if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Mainhand))
		{
			if (this.m.MyVariant == 0) // bow
            {
				this.m.Items.equip(this.new("scripts/items/weapons/hunting_bow"));
				this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
			}
			else // crossbow
			{
				this.m.Items.equip(this.new("scripts/items/weapons/crossbow"));
				this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_bolts"));
			}
		}

		local sidearm = ::MSU.Class.WeightedContainer([
			[1, "scripts/items/weapons/dagger"],
			[1, "scripts/items/weapons/reinforced_wooden_flail"],
			[1, "scripts/items/weapons/falchion"],
			[1, "scripts/items/weapons/scramasax"]
    	]).roll();

		this.m.Items.addToBag(::new(sidearm));

		if (this.m.MyVariant == 1) // crossbow
		{
			local shield = ::MSU.Class.WeightedContainer([
				[1, "scripts/items/shields/wooden_shield"]
	    	]).rollChance(66);

			if (shield != null) this.m.Items.addToBag(::new(shield));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Body))
		{
			local armor = null;
			if (this.m.MyVariant == 0) // bow
            {
				armor = ::Reforged.ItemTable.BanditArmorBowman.roll({
					Apply = function ( _script, _weight )
					{
						local conditionMax = ::ItemTables.ItemInfoByScript[_script].ConditionMax;
						if (conditionMax < 50 || conditionMax > 80) return 0.0;
						return _weight;
					}
				})
			}
			else // crossbow
			{
				armor = ::Reforged.ItemTable.BanditArmorBasic.roll({
					Apply = function ( _script, _weight )
					{
						local conditionMax = ::ItemTables.ItemInfoByScript[_script].ConditionMax;
						if (conditionMax < 65 || conditionMax > 115) return 0.0;
						return _weight;
					}
				})
			}
			this.m.Items.equip(::new(armor));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Head))
		{
			local helmet = null;
			if (this.m.MyVariant == 0  && ::Math.rand(1, 100) >= 15) // bow
			{
				helmet = ::Reforged.ItemTable.BanditHelmetBasic.roll({
					Apply = function ( _script, _weight )
					{
						local conditionMax = ::ItemTables.ItemInfoByScript[_script].ConditionMax;
						if (conditionMax < 30 || conditionMax > 80) return 0.0;
						return _weight;
					},
					Add = [
						[0.2, "scripts/items/helmets/hunters_hat"],
						[0.2, "scripts/items/helmets/feathered_hat"]
					]
				})
			}
			else // crossbow
			{
				helmet = ::Reforged.ItemTable.BanditHelmetBasic.roll({
					Exclude = [
						"scripts/items/helmets/dented_nasal_helmet"
					],
					Apply = function ( _script, _weight )
					{
						local conditionMax = ::ItemTables.ItemInfoByScript[_script].ConditionMax;
						if (conditionMax < 50 || conditionMax > 115) return 0.0;
						if (conditionMax > 105 || conditionMax <= 115) return _weight * 0.5;
						return _weight;
					}
				})
			}
			this.m.Items.equip(::new(helmet));
		}
	}

	q.onSetupEntity <- function()
	{
		local mainhandItem = this.getMainhandItem();
		if (mainhandItem != null)
		{
			if (this.m.MyVariant == 0) // bow
			{
		    	this.m.Skills.add(::new("scripts/skills/perks/perk_rf_ghostlike"));
		    	this.m.Skills.add(::new("scripts/skills/perks/perk_relentless"));
		    	this.m.Skills.add(::new("scripts/skills/perks/perk_rf_target_practice"));
		    	this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_bow"));
		    	this.m.Skills.add(::new("scripts/skills/perks/perk_rf_eyes_up"));
		    	this.m.Skills.add(::new("scripts/skills/perks/perk_crippling_strikes"));
			}
			else // crossbow
			{
				this.m.Skills.add(::new("scripts/skills/perks/perk_rf_entrenched"));
				this.m.Skills.add(::new("scripts/skills/perks/perk_quick_hands"));
				this.m.Skills.add(::new("scripts/skills/perks/perk_rotation"));
				this.m.Skills.add(::new("scripts/skills/perks/perk_rf_skirmisher"));
				this.m.Skills.add(::new("scripts/skills/perks/perk_bullseye"));
				this.m.Skills.add(::new("scripts/skills/perks/perk_rf_power_shot"));
				this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_crossbow"));
			}
		}
	}

});
