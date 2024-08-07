this.rf_bandit_killer <- ::inherit("scripts/entity/tactical/human", {
	m = {
		MyVariant = 0 // 1 for regular throwing weapons, 0 for not or throwing spear.
	},
	function create()
	{
		this.m.Type = ::Const.EntityType.RF_BanditKiller;
		this.m.BloodType = ::Const.BloodType.Red;
		this.m.XP = ::Const.Tactical.Actor.RF_BanditKiller.XP;
		this.human.create();
		this.m.Faces = ::Const.Faces.AllMale;
		this.m.Hairs = ::Const.Hair.UntidyMale;
		this.m.HairColors = ::Const.HairColors.All;
		this.m.Beards = ::Const.Beards.Raider;
		this.m.AIAgent = ::new("scripts/ai/tactical/agents/rf_bandit_fast_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.RF_BanditKiller);
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
		this.m.Skills.add(::new("scripts/skills/perks/perk_dodge"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_footwork"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_ghostlike"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_pathfinder"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_quick_hands"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_skirmisher"));

		this.m.MyVariant = ::Math.rand(0, 1); // 1 is thrower
	}

	function onAppearanceChanged( _appearance, _setDirty = true )
	{
		this.actor.onAppearanceChanged(_appearance, false);
		this.setDirty(true);
	}

	function assignRandomEquipment()
	{
		if (::Math.rand (1, 100) < 33 && (this.m.Items.hasEmptySlot(::Const.ItemSlot.Offhand)))
		{
			this.m.Items.equip(::new("scripts/items/tools/throwing_net"))
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Mainhand))
		{
			if (this.m.MyVariant == 0) // Not regular throwing weapons
			{
				local throwing = ::MSU.Class.WeightedContainer([
					[1, "scripts/items/weapons/throwing_spear"]
				]).rollChance(25);

				if (throwing != null) this.m.Items.equip(::new(throwing));
			}
			else // Thrower
			{
				local throwing = ::MSU.Class.WeightedContainer([
					[1, "scripts/items/weapons/javelin"],
					[1, "scripts/items/weapons/throwing_axe"]
				]).roll();

				this.m.Items.equip(::new(throwing));
			}
		}

		local weapon = ::MSU.Class.WeightedContainer([
			[1, "scripts/items/weapons/arming_sword"],
			[1, "scripts/items/weapons/boar_spear"],
			[1, "scripts/items/weapons/rondel_dagger"],
			[1, "scripts/items/weapons/scramasax"],

			[1, "scripts/items/weapons/billhook"],
			[1, "scripts/items/weapons/longsword"],
			[1, "scripts/items/weapons/rf_poleflail"],
			[1, "scripts/items/weapons/pike"],
			[1, "scripts/items/weapons/spetum"],
			[1, "scripts/items/weapons/warbrand"]
		]).roll();
		weapon = ::new(weapon);

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Mainhand) && this.m.Items.hasEmptySlot(::Const.ItemSlot.Offhand)) // both hands free
		{
			this.m.Items.equip(weapon);
		}
		else if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Mainhand) && weapon.isItemType(::Const.Items.ItemType.OneHanded)) // rolled 1h melee weapon
		{
			this.m.Items.equip(weapon);
		}
		else // cannot equip melee weapon to hands
		{
			this.m.Items.addToBag(weapon);
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Body))
		{
			local armor = ::Reforged.ItemTable.BanditArmorFast.roll({
				Apply = function ( _script, _weight )
				{
					local conditionMax = ::ItemTables.ItemInfoByScript[_script].ConditionMax;
					if (conditionMax <= 100 || conditionMax > 140) return 0.0;
					return _weight;
				}
			})
			if (armor != null) this.m.Items.equip(::new(armor));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Head))
		{
			local helmet = ::Reforged.ItemTable.BanditHelmetFast.roll({
				Apply = function ( _script, _weight )
				{
					local conditionMax = ::ItemTables.ItemInfoByScript[_script].ConditionMax;
					if (conditionMax <= 90 || conditionMax > 130) return 0.0;
					return _weight;
				}
			})
			this.m.Items.equip(::new(helmet));
		}
	}

	function onSetupEntity()
	{
		local offhand = this.getOffhandItem();
		if (offhand != null && offhand.isItemType(::Const.Items.ItemType.Tool)) //rolled throwing net
		{
			this.m.Skills.add(::new("scripts/skills/perks/perk_rf_angler"));
		}

		local weapon = this.getMainhandItem();
		if (weapon == null || !weapon.isItemType(::Const.Items.ItemType.MeleeWeapon))
		{
			foreach (item in this.m.Items.getAllItemsAtSlot(::Const.ItemSlot.Bag))  //primary weapon in bag and not equipped
			{
				if (item.isItemType(::Const.Items.ItemType.MeleeWeapon))
				{
					weapon = item;
					break;
				}
			}
		}

		if (weapon != null)
		{
			::Reforged.Skills.addPerkGroupOfEquippedWeapon(this);
			if (weapon.isWeaponType(::Const.Items.WeaponType.Dagger))
			{
				this.m.Skills.add(::new("scripts/skills/perks/perk_backstabber"));
				this.m.Skills.add(::new("scripts/skills/perks/perk_rf_cheap_trick"));
				this.m.Skills.add(::new("scripts/skills/perks/perk_rf_double_strike"));
				this.m.Skills.add(::new("scripts/skills/perks/perk_overwhelm"));
			}
			switch (weapon.getID())
			{
				case "weapon.pike":
					this.m.Skills.add(::new("scripts/skills/perks/perk_devastating_strikes"));
					break;
			}

			if (::Reforged.Items.isDuelistValid(weapon))
			{
				this.m.Skills.add(::new("scripts/skills/perks/perk_duelist"));
			}
		}

		if (this.m.MyVariant == 1) // Thrower
		{
			this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_throwing"));
			this.m.Skills.add(::new("scripts/skills/perks/perk_rf_opportunist"));
		}
	}
});
