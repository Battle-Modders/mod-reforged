this.rf_man_at_arms <- ::inherit("scripts/entity/tactical/human" {
	m = {},
	function create()
	{
		this.m.Type = ::Const.EntityType.RF_ManAtArms;
		this.m.BloodType = ::Const.BloodType.Red;
		this.m.XP = ::Const.Tactical.Actor.RF_ManAtArms.XP;
		this.human.create();
		this.m.Faces = ::Const.Faces.AllMale;
		this.m.Hairs = ::Const.Hair.CommonMale;
		this.m.HairColors = ::Const.HairColors.Young;
		this.m.Beards = ::Const.Beards.Tidy;
		this.m.AIAgent = ::new("scripts/ai/tactical/agents/military_melee_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.RF_ManAtArms);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_military");

		this.m.Skills.add(::new("scripts/skills/perks/perk_battle_forged"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_finesse"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_pattern_recognition"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_rebuke"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_skirmisher"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_vigilant"));
	}

	function assignRandomEquipment()
	{
		local banner = ::Tactical.State.isScenarioMode() ? ::World.FactionManager.getFaction(this.getFaction()).getBanner() : this.getFaction();
		this.m.Surcoat = banner;
		if (::Math.rand(1, 100) <= 50)
		{
			this.getSprite("surcoat").setBrush("surcoat_" + (banner < 10 ? "0" + banner : banner));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Mainhand))
		{
			this.m.Items.equip(::new(::MSU.Class.WeightedContainer([
				[1, "scripts/items/weapons/greataxe"],
				[1, "scripts/items/weapons/rf_kriegsmesser"],
				[1, "scripts/items/weapons/longsword"],
				[1, "scripts/items/weapons/rf_swordstaff"],
				[1, "scripts/items/weapons/two_handed_flanged_mace"],
				[1, "scripts/items/weapons/two_handed_flail"],
			]).roll()));
		}

		if (this.m.IsMiniboss)
		{
			if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Body))
			{
				this.m.Items.equip(::new(::MSU.Class.WeightedContainer([
					[1, "scripts/items/armor/rf_brigandine_harness"],
					[1, "scripts/items/armor/rf_breastplate_armor"]
				]).roll()));
			}

			if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Head))
			{
				this.m.Items.equip(::new(::MSU.Class.WeightedContainer([
					[1, "scripts/items/helmets/rf_sallet_helmet_with_bevor"],
					[1, "scripts/items/helmets/rf_half_closed_sallet_with_mail"],
					[1, "scripts/items/helmets/rf_visored_bascinet"]
				]).roll()));
			}
		}
		else
		{
			if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Body))
			{
				this.m.Items.equip(::new(::MSU.Class.WeightedContainer([
					[1, "scripts/items/armor/reinforced_mail_hauberk"],
					[1, "scripts/items/armor/scale_armor"],
					[1, "scripts/items/armor/rf_reinforced_footman_armor"]
				]).roll()));
			}

			if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Head))
			{
				this.m.Items.equip(::new(::MSU.Class.WeightedContainer([
					[1, "scripts/items/helmets/rf_skull_cap_with_mail"],
					[1, "scripts/items/helmets/rf_conical_billed_helmet"],
					[1, "scripts/items/helmets/rf_sallet_helmet_with_mail"],
					[1, "scripts/items/helmets/rf_padded_conical_billed_helmet"]
				]).roll()));
			}
		}
	}

	function onSetupEntity()
	{
		local weapon = this.getMainhandItem();
		if (weapon != null)
		{
			if (weapon.isWeaponType(::Const.Items.WeaponType.Axe))
			{
				this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_axe"));
				this.m.Skills.add(::new("scripts/skills/perks/perk_coup_de_grace"));
				this.m.Skills.add(::new("scripts/skills/perks/perk_rf_between_the_eyes"));
			}
			else if (weapon.isWeaponType(::Const.Items.WeaponType.Sword))
			{
				if (weapon.isWeaponType(::Const.Items.WeaponType.Cleaver)) // Sword/Cleaver hybrid
				{
					::Reforged.Skills.addPerkGroup(this, "pg.rf_sword", 4);
					this.m.Skills.add(::new("scripts/skills/perks/perk_crippling_strikes"));
				}
				else if (weapon.isWeaponType(::Const.Items.WeaponType.Spear)) // Sword/Spear hybrid
				{
					this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_spear"));
					this.m.Skills.add(::new("scripts/skills/perks/perk_rf_two_for_one"));
					this.m.Skills.add(::new("scripts/skills/perks/perk_rf_through_the_gaps"));
					this.m.Skills.add(::new("scripts/skills/perks/perk_rf_exploit_opening"));
				}
				else
				{
					::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 5);
				}
			}
			else if (weapon.isWeaponType(::Const.Items.WeaponType.Mace))
			{
				this.m.Skills.add(::new("scripts/skills/perks/perk_crippling_strikes"));
				::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 4);
			}
			else if (weapon.isWeaponType(::Const.Items.WeaponType.Flail))
			{
				this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_flail"));
				this.m.Skills.add(::new("scripts/skills/perks/perk_rf_concussive_strikes"));
				this.m.Skills.add(::new("scripts/skills/perks/perk_rf_deep_impact"));
			}
			if (this.m.IsMiniboss)
			{
				if (weapon.isWeaponType(::Const.Items.WeaponType.Axe))
				{
					this.m.Skills.add(::new("scripts/skills/perks/perk_rf_cull"));
				}
				else if (weapon.isWeaponType(::Const.Items.WeaponType.Sword))
				{
					if (weapon.isWeaponType(::Const.Items.WeaponType.Cleaver)) // Sword/Cleaver hybrid
					{
						this.m.Skills.add(::new("scripts/skills/perks/perk_rf_swordlike"));
						this.m.Skills.add(::new("scripts/skills/perks/perk_rf_bloodlust"));
					}
					else if (weapon.isWeaponType(::Const.Items.WeaponType.Spear)) // Sword/Spear hybrid
					{
						this.m.Skills.add(::new("scripts/skills/perks/perk_rf_king_of_all_weapons"));
					}
					else
					{
						this.m.Skills.add(::new("scripts/skills/perks/perk_rf_en_garde"));
					}
				}
				else if (weapon.isWeaponType(::Const.Items.WeaponType.Mace))
				{
					this.m.Skills.add(::new("scripts/skills/perks/perk_rf_bone_breaker"));
				}
				else if (weapon.isWeaponType(::Const.Items.WeaponType.Flail))
				{
					this.m.Skills.add(::new("scripts/skills/perks/perk_rf_flail_spinner"));
				}
			}
		}
	}

	function makeMiniboss()
	{
		if (!this.actor.makeMiniboss())
		{
			return false;
		}

		this.getSprite("miniboss").setBrush("bust_miniboss");

		local r = ::Math.rand(1, 100);
		if (r <= 40)
		{
			local weapon = ::MSU.Class.WeightedContainer([
	    		[1, "scripts/items/weapons/named/named_greataxe"],
	    		[1, "scripts/items/weapons/named/named_rf_kriegsmesser"],
	    		[1, "scripts/items/weapons/named/named_rf_longsword"],
				[1, "scripts/items/weapons/named/named_rf_swordstaff"],
				[1, "scripts/items/weapons/named/named_two_handed_mace"],
				[1, "scripts/items/weapons/named/named_two_handed_flail"]
	    	]).roll();

			this.m.Items.equip(::new(weapon));
		}
		else if (r <= 70)
		{
			local armor = ::Reforged.ItemTable.NamedArmorNoble.roll({
				Apply = function ( _script, _weight )
				{
					local conditionMax = ::ItemTables.ItemInfoByScript[_script].ConditionMax;
					if (conditionMax < 205 || conditionMax > 270) return 0.0;
					return _weight;
				}
			})
			this.m.Items.equip(::new(armor));
		}
		else
		{
			local helmet = ::Reforged.ItemTable.NamedHelmetNoble.roll({
				Apply = function ( _script, _weight )
				{
					local conditionMax = ::ItemTables.ItemInfoByScript[_script].ConditionMax;
					if (conditionMax < 200 || conditionMax > 270) return 0.0;
					return _weight;
				}
			})
			this.m.Items.equip(::new(helmet));
		}
		return true;
	}
});

