this.rf_bandit_marauder <- this.inherit("scripts/entity/tactical/human", {
	m = {
		IsLow = false
	},
	function create()
	{
		this.m.Type = ::Const.EntityType.RF_BanditMarauder;
		this.m.BloodType = ::Const.BloodType.Red;
		this.m.XP = ::Const.Tactical.Actor.RF_BanditMarauder.XP;
		this.human.create();
		this.m.Faces = ::Const.Faces.AllMale;
		this.m.Hairs = ::Const.Hair.UntidyMale;
		this.m.HairColors = ::Const.HairColors.All;
		this.m.Beards = ::Const.Beards.Raider;
		this.m.AIAgent = ::new("scripts/ai/tactical/agents/rf_bandit_tough_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.RF_BanditMarauder);
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
		this.m.Skills.add(::new("scripts/skills/perks/perk_hold_out"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_survival_instinct"));
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
			local weapon = ::MSU.Class.WeightedContainer([
				[1, "scripts/items/weapons/rf_battle_axe"],
				[1, "scripts/items/weapons/rf_greatsword"],
				[1, "scripts/items/weapons/two_handed_mace"],
				[1, "scripts/items/weapons/two_handed_wooden_hammer"],
				[1, "scripts/items/weapons/two_handed_wooden_flail"],
				[1, "scripts/items/weapons/woodcutters_axe"]
			]).roll();

			this.m.Items.equip(::new(weapon));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Body))
		{
			local armor = ::Reforged.ItemTable.BanditArmorBasic.roll({
				Apply = function ( _script, _weight )
				{
					local conditionMax = ::ItemTables.ItemInfoByScript[_script].ConditionMax;
					if (conditionMax < 170 || conditionMax > 210) return 0.0;
					return _weight;
				}
			})
			this.m.Items.equip(::new(armor));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Head))
		{
			local helmet = ::Reforged.ItemTable.BanditHelmetBasic.roll({
				Apply = function ( _script, _weight )
				{
					local conditionMax = ::ItemTables.ItemInfoByScript[_script].ConditionMax;
					if (conditionMax < 140 || conditionMax > 180) return 0.0;
					if (conditionMax >= 140 || conditionMax < 150) return _weight * 0.5;
					return _weight;
				}
			})
			this.m.Items.equip(::new(helmet));
		}
	}

	function onSetupEntity()
	{
		local mainhandItem = this.getMainhandItem();
		if (mainhandItem != null)
		{
			if (mainhandItem.isWeaponType(::Const.Items.WeaponType.Axe))
			{
				local aoo = this.m.Skills.getAttackOfOpportunity();
				if (aoo != null && aoo.getBaseValue("ActionPointCost") <= 4)
				{
					::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 4);
					this.m.Skills.add(::new("scripts/skills/perks/perk_rf_exploit_opening"));
					this.m.Skills.add(::new("scripts/skills/perks/perk_rf_rebuke"));
				}
				else
				{
					::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 4);
					this.m.Skills.add(::new("scripts/skills/perks/perk_coup_de_grace"));
					this.m.Skills.add(::new("scripts/skills/perks/perk_crippling_strikes"));
					this.m.Skills.add(::new("scripts/skills/perks/perk_sundering_strikes"));
				}
			}
			else if (mainhandItem.isWeaponType(::Const.Items.WeaponType.Sword))
			{
				this.m.Skills.add(::new("scripts/skills/perks/perk_rf_rebuke"));
				this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_sword"));
				this.m.Skills.add(::new("scripts/skills/perks/perk_rf_formidable_approach"));
			}
			else if (mainhandItem.isWeaponType(::Const.Items.WeaponType.Mace))
			{
				::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 5);
				this.m.Skills.add(::new("scripts/skills/perks/perk_rf_formidable_approach"));
			}
			else if (mainhandItem.isWeaponType(::Const.Items.WeaponType.Hammer))
			{
				::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 6);
				this.m.Skills.add(::new("scripts/skills/perks/perk_rf_formidable_approach"));
			}
			else if (mainhandItem.isWeaponType(::Const.Items.WeaponType.Flail))
			{
				this.m.Skills.add(::new("scripts/skills/perks/perk_rf_rattle"));
				this.m.Skills.add(::new("scripts/skills/perks/perk_rf_from_all_sides"));
				this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_flail"));
				this.m.Skills.add(::new("scripts/skills/perks/perk_rf_whirling_death"));
				this.m.Skills.add(::new("scripts/skills/perks/perk_rf_formidable_approach"));
			}
		}
	}

	function onSkillsUpdated()
	{
		this.human.onSkillsUpdated();
		if (!::MSU.isNull(this.m.Skills)) this.m.Skills.removeByID("actives.rf_bearded_blade");
	}
});

