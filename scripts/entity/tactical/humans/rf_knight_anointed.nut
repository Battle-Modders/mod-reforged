this.rf_knight_anointed <- ::inherit("scripts/entity/tactical/human" {
	m = {},
	function create()
	{
		this.m.Type = ::Const.EntityType.RF_KnightAnointed;
		this.m.BloodType = ::Const.BloodType.Red;
		this.m.XP = ::Const.Tactical.Actor.RF_KnightAnointed.XP;
		this.m.Name = this.generateName();
		this.m.IsGeneratingKillName = false;
		this.human.create();
		this.m.Faces = ::Const.Faces.AllMale;
		this.m.Hairs = ::Const.Hair.CommonMale;
		this.m.HairColors = ::Const.HairColors.Young;
		this.m.Beards = ::Const.Beards.Tidy;
		this.m.AIAgent = ::new("scripts/ai/tactical/agents/military_melee_agent");
		this.m.AIAgent.setActor(this);
	}

	function generateName()
	{
		return ::MSU.Array.rand(::Const.Strings.RF_KnightAnointedNames);
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.RF_KnightAnointed);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_military");

		this.m.Skills.add(::new("scripts/skills/perks/perk_battle_forged"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_duelist"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_finesse"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_rebuke"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_exude_confidence"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_pattern_recognition"));
		this.m.Skills.add(::MSU.new("scripts/skills/perks/perk_rf_mentor", function(o) {
			o.m.MaxStudents = 2;
		}));
	}

	function assignRandomEquipment()
	{
		local banner = ::Tactical.State.isScenarioMode() ? this.getFaction() : ::World.FactionManager.getFaction(this.getFaction()).getBanner();
		this.m.Surcoat = banner;
		if (::Math.rand(1, 100) <= 90)
		{
			this.getSprite("surcoat").setBrush("surcoat_" + (banner < 10 ? "0" + banner : banner));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Mainhand))
		{
			this.m.Items.equip(::new(::MSU.Class.WeightedContainer([
				[1, "scripts/items/weapons/fighting_axe"],
				[1, "scripts/items/weapons/warhammer"],
				[1, "scripts/items/weapons/winged_mace"],
				[1, "scripts/items/weapons/noble_sword"]
			]).roll()));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Offhand))
		{
			local shield = ::new(::MSU.Class.WeightedContainer([
				[1, "scripts/items/shields/faction_kite_shield"],
				[1, "scripts/items/shields/faction_heater_shield"]
			]).roll());

			shield.setFaction(banner);
			this.m.Items.equip(shield);
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Body))
		{
			this.m.Items.equip(::new(::MSU.Class.WeightedContainer([
				[1, "scripts/items/armor/rf_breastplate_harness"],
				[1, "scripts/items/armor/rf_foreign_plate_harness"]
			]).roll()));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Head))
		{
			this.m.Items.equip(::new(::MSU.Class.WeightedContainer([
				[1, "scripts/items/helmets/rf_snubnose_bascinet_with_mail"],
				[1, "scripts/items/helmets/rf_hounskull_bascinet_with_mail"]
			]).roll()));
		}
	}

	function onSetupEntity()
	{
		local weapon = this.getMainhandItem();
		if (weapon != null)
		{
			::Reforged.Skills.addMasteryOfEquippedWeapon(this);
			if (weapon.isWeaponType(::Const.Items.WeaponType.Axe))
			{
				this.m.Skills.add(::new("scripts/skills/perks/perk_crippling_strikes"));
				this.m.Skills.add(::new("scripts/skills/perks/perk_coup_de_grace"));
			}
			else if (weapon.isWeaponType(::Const.Items.WeaponType.Sword))
			{
				::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 4);
				this.m.Skills.add(::new("scripts/skills/perks/perk_rf_en_garde"));
			}
			else if (weapon.isWeaponType(::Const.Items.WeaponType.Hammer))
			{
				::Reforged.Skills.addPerkGroupOfEquippedWeapon(this);
			}
			else if (weapon.isWeaponType(::Const.Items.WeaponType.Hammer))
			{
				this.m.Skills.add(::new("scripts/skills/perks/perk_rf_rattle"));
				this.m.Skills.add(::new("scripts/skills/perks/perk_sundering_strikes"));
			}
		}

		local offhand = this.getOffhandItem();
		if (offhand != null && offhand.isItemType(::Const.Items.ItemType.Shield))
		{
			this.m.Skills.add(::new("scripts/skills/perks/perk_shield_expert"));
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
		if (r <= 25)
		{
			local weapon = ::MSU.Class.WeightedContainer([
	    		[1, "scripts/items/weapons/named/named_axe"],
	    		[1, "scripts/items/weapons/named/named_sword"],
	    		[1, "scripts/items/weapons/named/named_hammer"],
				[1, "scripts/items/weapons/named/named_mace"]
	    	]).roll();

			this.m.Items.equip(::new(weapon));
		}
		else if (r <= 50)
		{
			this.m.Items.equip(::new("scripts/items/" + ::Const.Items.NamedShields[::Math.rand(0, ::Const.Items.NamedShields.len() - 1)]));
		}
		else if (r <= 75)
		{
			local armor = ::Reforged.ItemTable.NamedArmorNoble.roll({
				Apply = function ( _script, _weight )
				{
					local conditionMax = ::ItemTables.ItemInfoByScript[_script].ConditionMax;
					if (conditionMax < 260) return 0.0;
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
					if (conditionMax < 265) return 0.0;
					return _weight;
				}
			})
			this.m.Items.equip(::new(helmet));
		}

		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_battle_fervor"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_hold_out"));
		return true;
	}
});

