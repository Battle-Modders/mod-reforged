this.rf_bandit_hunter <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = ::Const.EntityType.RF_BanditHunter;
		this.m.BloodType = ::Const.BloodType.Red;
		this.m.XP = ::Const.Tactical.Actor.RF_BanditHunter.XP;
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
		b.setValues(::Const.Tactical.Actor.RF_BanditHunter);
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
		this.m.Skills.add(::new("scripts/skills/perks/perk_relentless"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_recover"));
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
			local r = ::Math.rand(1, 4);

			if (r == 1)
			{
				this.m.Items.equip(::new("scripts/items/weapons/short_bow"));
				this.m.Items.equip(::new("scripts/items/ammo/quiver_of_arrows"));
			}
			else if (r == 2)
			{
				this.m.Items.equip(::new("scripts/items/weapons/hunting_bow"));
				this.m.Items.equip(::new("scripts/items/ammo/quiver_of_arrows"));
			}
			else if (r == 3)
			{
				this.m.Items.equip(::new("scripts/items/weapons/crossbow"));
				this.m.Items.equip(::new("scripts/items/ammo/quiver_of_bolts"));
			}
			else if (r == 4)
			{
				this.m.Items.equip(::new("scripts/items/weapons/light_crossbow"));
				this.m.Items.equip(::new("scripts/items/ammo/quiver_of_bolts"));
			}
		}

		local sidearm = ::MSU.Class.WeightedContainer([
			[1, "scripts/items/weapons/bludgeon"],
			[1, "scripts/items/weapons/dagger"],
			[1, "scripts/items/weapons/hatchet"],
			[1, "scripts/items/weapons/reinforced_wooden_flail"],
			[0.5, "scripts/items/weapons/shortsword"],
		]).roll();

		this.m.Items.addToBag(::new(sidearm));

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Body))
		{
			local armor = ::Reforged.ItemTable.BanditArmorBowman.roll({
				Apply = function ( _script, _weight )
				{
					local conditionMax = ::ItemTables.ItemInfoByScript[_script].ConditionMax;
					if (conditionMax < 35 || conditionMax > 70) return 0.0;
					return _weight;
				}
			})
			this.m.Items.equip(::new(armor));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Head) && ::Math.rand(1, 100) > 25)
		{
			local helmet = ::Reforged.ItemTable.BanditHelmetBasic.roll({
				Apply = function ( _script, _weight )
				{
					local conditionMax = ::ItemTables.ItemInfoByScript[_script].ConditionMax;
					if (conditionMax > 40) return 0.0;
					return _weight;
				},
				Add = [
					[0.5, "scripts/items/helmets/straw_hat"],
					[0.2, "scripts/items/helmets/hunters_hat"]
				]
			})
			this.m.Items.equip(::new(helmet));
		}
	}

	function onSetupEntity()
	{
		local weapon = this.getMainhandItem();
		if (weapon.isWeaponType(::Const.Items.WeaponType.Bow))
		{
			this.m.Skills.add(::new("scripts/skills/perks/perk_rf_target_practice"));
			this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_bow"));
			this.m.Skills.add(::new("scripts/skills/perks/perk_crippling_strikes"));
		}
		else if (weapon.isWeaponType(::Const.Items.WeaponType.Crossbow))
		{
			this.m.Skills.add(::new("scripts/skills/perks/perk_rf_power_shot"));
			this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_crossbow"));
			this.m.Skills.add(::new("scripts/skills/perks/perk_bullseye"));
		}
	}
});

