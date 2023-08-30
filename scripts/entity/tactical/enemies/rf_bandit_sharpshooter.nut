this.rf_bandit_sharpshooter <- this.inherit("scripts/entity/tactical/human", {
	m = {
		MyVariant = 0
	},
	function create()
	{
		this.m.Type = ::Const.EntityType.RF_BanditSharpshooter;
		this.m.BloodType = ::Const.BloodType.Red;
		this.m.XP = ::Const.Tactical.Actor.RF_BanditSharpshooter.XP;
		this.human.create();
		this.m.Faces = ::Const.Faces.AllMale;
		this.m.Hairs = ::Const.Hair.UntidyMale;
		this.m.HairColors = ::Const.HairColors.All;
		this.m.Beards = ::Const.Beards.Raider;
		this.m.AIAgent = ::new("scripts/ai/tactical/agents/bandit_ranged_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.RF_BanditSharpshooter);
		b.TargetAttractionMult = 1.1;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_bandits");

		if (::Math.rand(1, 100) <= 20)
		{
			local pox = this.getSprite("tattoo_head");
			pox.Visible = true;
			pox.setBrush("bust_head_darkeyes_01");
		}
		else
		{
			local dirt = this.getSprite("dirt");
			dirt.Visible = true;
			dirt.Alpha = ::Math.rand(150, 255);
		}

		this.getSprite("armor").Saturation = 0.85;
		this.getSprite("helmet").Saturation = 0.85;
		this.getSprite("helmet_damage").Saturation = 0.85;
		this.getSprite("shield_icon").Saturation = 0.85;
		this.getSprite("shield_icon").setBrightness(0.85);

		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_bully"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_pathfinder"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_recover"));

		this.m.MyVariant = ::Math.rand(0, 1); // 1 is Crossbow
	}

	function onAppearanceChanged( _appearance, _setDirty = true )
	{
		this.actor.onAppearanceChanged(_appearance, false);
		this.setDirty(true);
	}

	function assignRandomEquipment()
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

		local sidearm = null;
		if (this.m.MyVariant == 0) // bow
        {
			sidearm = ::MSU.Class.WeightedContainer([
				[1, "scripts/items/weapons/falchion"],
				[1, "scripts/items/weapons/hatchet"],
				[1, "scripts/items/weapons/reinforced_wooden_flail"],
				[1, "scripts/items/weapons/scramasax"]
	    	]).roll();
		}
		else // crossbow
		{
			sidearm = ::MSU.Class.WeightedContainer([
				[1, "scripts/items/weapons/flail"],
				[1, "scripts/items/weapons/hand_axe"],
				[1, "scripts/items/weapons/military_pick"],
				[1, "scripts/items/weapons/morning_star"]
	    	]).roll();
		}

		this.m.Items.addToBag(::new(sidearm));

		if (this.m.MyVariant == 1) // crossbow
		{
			this.m.Items.addToBag(::new("scripts/items/shields/wooden_shield"))
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
						if (conditionMax < 70 || conditionMax > 95) return 0.0;
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
						if (conditionMax < 95 || conditionMax > 140) return 0.0;
						return _weight;
					}
				})
			}
			this.m.Items.equip(::new(armor));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Head))
		{
			local helmet = null;
			if (this.m.MyVariant == 0) // bow
			{
				helmet = ::Reforged.ItemTable.BanditHelmetBasic.roll({
					Apply = function ( _script, _weight )
					{
						if (_script == "scripts/items/helmets/open_leather_cap") return _weight * 0.5;
						local conditionMax = ::ItemTables.ItemInfoByScript[_script].ConditionMax;
						if (conditionMax < 30 || conditionMax > 80) return 0.0;
						if (conditionMax >= 30 || conditionMax < 40) return _weight * 0.0;
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
					Apply = function ( _script, _weight )
					{
						local conditionMax = ::ItemTables.ItemInfoByScript[_script].ConditionMax;
						if (conditionMax < 105 || conditionMax > 140) return 0.0;
						if (conditionMax > 130 || conditionMax <= 140) return _weight * 0.5;
						return _weight;
					}
				})
			}
			this.m.Items.equip(::new(helmet));
		}
	}

	function onSetupEntity()
	{
		local mainhandItem = this.getMainhandItem();
		if (mainhandItem != null)
		{
			if (this.m.MyVariant == 0) // bow
			{
		    	this.m.Skills.add(::new("scripts/skills/perks/perk_footwork"));
		    	this.m.Skills.add(::new("scripts/skills/perks/perk_rf_ghostlike"));
		    	this.m.Skills.add(::new("scripts/skills/perks/perk_relentless"));
		    	this.m.Skills.add(::new("scripts/skills/perks/perk_rf_target_practice"));
		    	this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_bow"));
		    	this.m.Skills.add(::new("scripts/skills/perks/perk_rf_eyes_up"));
		    	this.m.Skills.add(::new("scripts/skills/perks/perk_crippling_strikes"));
		    	this.m.Skills.add(::new("scripts/skills/perks/perk_rf_hip_shooter"));
			}
			else // crossbow
			{
				this.m.Skills.add(::new("scripts/skills/perks/perk_rf_entrenched"));
				this.m.Skills.add(::new("scripts/skills/perks/perk_quick_hands"));
				this.m.Skills.add(::new("scripts/skills/perks/perk_rotation"));
				this.m.Skills.add(::new("scripts/skills/perks/perk_shield_expert"));
				this.m.Skills.add(::new("scripts/skills/perks/perk_rf_skirmisher"));
				this.m.Skills.add(::new("scripts/skills/perks/perk_bullseye"));
				this.m.Skills.add(::new("scripts/skills/perks/perk_rf_power_shot"));
				this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_crossbow"));

				foreach (item in this.m.Items.getAllItemsAtSlot(::Const.ItemSlot.Bag))  //sidearm in bag
				{
					if (!item.isItemType(::Const.Items.ItemType.Weapon)) continue;
					if (item.isWeaponType(::Const.Items.WeaponType.Flail))
					{
						this.m.Skills.add(::new("scripts/skills/perks/perk_rf_from_all_sides"));
					}
					else if (item.isWeaponType(::Const.Items.WeaponType.Axe))
					{
						this.m.Skills.add(::new("scripts/skills/perks/perk_coup_de_grace"));
					}
					else if (item.isWeaponType(::Const.Items.WeaponType.Hammer))
					{
						this.m.Skills.add(::new("scripts/skills/perks/perk_crippling_strikes"));
					}
					else //morning star
					{
						this.m.Skills.add(::new("scripts/skills/perks/perk_rf_rattle"));
					}
				}
			}
		}
	}
});

