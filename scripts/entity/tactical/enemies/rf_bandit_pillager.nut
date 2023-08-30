this.rf_bandit_pillager <- this.inherit("scripts/entity/tactical/human", {
	m = {
		MyVariant = 0
	},
	function create()
	{
		this.m.Type = ::Const.EntityType.RF_BanditPillager;
		this.m.BloodType = ::Const.BloodType.Red;
		this.m.XP = ::Const.Tactical.Actor.RF_BanditPillager.XP;
		this.human.create();
		this.m.Faces = ::Const.Faces.AllMale;
		this.m.Hairs = ::Const.Hair.UntidyMale;
		this.m.HairColors = ::Const.HairColors.All;
		this.m.Beards = ::Const.Beards.Raider;
		this.m.AIAgent = ::new("scripts/ai/tactical/agents/bandit_melee_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.RF_BanditPillager);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_bandits");
		local dirt = this.getSprite("dirt");
		dirt.Visible = true;
		dirt.Alpha = ::Math.rand(150, 255);
		this.getSprite("armor").Saturation = 0.85;
		this.getSprite("helmet").Saturation = 0.85;
		this.getSprite("helmet_damage").Saturation = 0.85;
		this.getSprite("shield_icon").Saturation = 0.85;
		this.getSprite("shield_icon").setBrightness(0.85);

		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_bully"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_recover"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_survival_instinct"));

		if (::Math.rand(1, 100) <= 25)
		{
			this.m.MyVariant = 1; // Shield
		}
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
			local weapon;
			if (this.m.MyVariant == 0) // Two Handed
			{
				weapon = ::MSU.Class.WeightedContainer([
					[1, "scripts/items/weapons/goedendag"],
					[1, "scripts/items/weapons/two_handed_mace"],
					[1, "scripts/items/weapons/two_handed_wooden_flail"],
					[1, "scripts/items/weapons/two_handed_wooden_hammer"],
					[1, "scripts/items/weapons/woodcutters_axe"]
  				]).roll();
			}
			else // Shield
			{
				weapon = ::MSU.Class.WeightedContainer([
					[1, "scripts/items/weapons/hand_axe"],
					[1, "scripts/items/weapons/flail"],
					[1, "scripts/items/weapons/military_pick"],
					[1, "scripts/items/weapons/morning_star"]
  				]).roll();
			}

			this.m.Items.equip(::new(weapon));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Offhand) && this.m.MyVariant == 1) // Shield
		{
			local shield = ::MSU.Class.WeightedContainer([
				[1, "scripts/items/shields/wooden_shield"],
				[0.33, "scripts/items/shields/kite_shield"]
			]).roll();

			this.m.Items.equip(::new(shield));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Body))
		{
			local armor = ::Reforged.ItemTable.BanditArmorBasic.roll({
				Apply = function ( _script, _weight )
				{
					local conditionMax = ::ItemTables.ItemInfoByScript[_script].ConditionMax;
					if (conditionMax < 95 || conditionMax > 130) return 0.0;
					return _weight;
				}
			})
			this.m.Items.equip(::new(armor));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Head) && ::Math.rand(1, 100) > 25)
		{
			local helmet = ::Reforged.ItemTable.BanditHelmetBasic.roll({
				Exclude = ["scripts/items/helmets/kettle_hat"],
				Apply = function ( _script, _weight )
				{
					local conditionMax = ::ItemTables.ItemInfoByScript[_script].ConditionMax;
					if (conditionMax < 45 || conditionMax > 115) return 0.0;
					return _weight;
				},
				Add = [[0.5, "scripts/items/helmets/nasal_helmet_with_rusty_mail"]]
			})
			this.m.Items.equip(::new(helmet));
		}
	}

	function onSetupEntity()
	{
		local mainhandItem = this.getMainhandItem();
		if (mainhandItem != null)
		{
			if (this.m.MyVariant == 0) // Two Handed
			{
				if (mainhandItem.isWeaponType(::Const.Items.WeaponType.Spear)) //Goedendag
				{
					this.m.Skills.add(::new("scripts/skills/perks/perk_rf_spear_advantage"));
					this.m.Skills.add(::new("scripts/skills/perks/perk_rf_rattle"));
					this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_mace"));
				}
				else if (mainhandItem.isWeaponType(::Const.Items.WeaponType.Flail))
				{
					this.m.Skills.add(::new("scripts/skills/perks/perk_rf_rattle"));
					this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_flail"));
					this.m.Skills.add(::new("scripts/skills/perks/perk_rf_concussive_strikes"));
				}
				else if (mainhandItem.isWeaponType(::Const.Items.WeaponType.Axe))
				{
					::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 4);
				}
				else // mace or hammer
				{
					::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 4);
				}
			}
			else // Shield
			{
				this.m.Skills.add(::new("scripts/skills/perks/perk_rf_line_breaker"));
				if (mainhandItem.isWeaponType(::Const.Items.WeaponType.Axe))
				{
					::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 4);
				}
				else if (mainhandItem.isWeaponType(::Const.Items.WeaponType.Flail))
				{
					this.m.Skills.add(::new("scripts/skills/perks/perk_rf_rattle"));
					this.m.Skills.add(::new("scripts/skills/perks/perk_rf_from_all_sides"));
					this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_flail"));
				}
				else // mace or hammer
				{
					::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 4);
				}
			}
		}
	}

	function onSkillsUpdated()
	{
		this.human.onSkillsUpdated();
		if (!::MSU.isNull(this.m.Skills)) this.m.Skills.removeByID("actives.rf_bearded_blade");
	}
});

