this.rf_bandit_highwayman <- ::inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = ::Const.EntityType.RF_BanditHighwayman;
		this.m.BloodType = ::Const.BloodType.Red;
		this.m.XP = ::Const.Tactical.Actor.RF_BanditHighwayman.XP;
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
		b.setValues(::Const.Tactical.Actor.RF_BanditHighwayman);
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
		this.m.Skills.add(::new("scripts/skills/perks/perk_quick_hands"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rotation"));
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
				[1, "scripts/items/weapons/arming_sword"],
				[1, "scripts/items/weapons/boar_spear"],
				[1, "scripts/items/weapons/flail"],
				[1, "scripts/items/weapons/hand_axe"],
				[1, "scripts/items/weapons/military_pick"],
				[1, "scripts/items/weapons/morning_star"],
				[1, "scripts/items/weapons/scramasax"],

				[1, "scripts/items/weapons/longaxe"],
				[1, "scripts/items/weapons/polehammer"],
				[1, "scripts/items/weapons/rf_two_handed_falchion"]
			]).roll();
			this.m.Items.equip(::new(weapon));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Bag))
		{
			local throwing = ::MSU.Class.WeightedContainer([
				[1, "scripts/items/weapons/throwing_spear"]
			]).rollChance(33);

			if (throwing != null) this.m.Items.addToBag(::new(throwing));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Offhand))
		{
			local shield = ::MSU.Class.WeightedContainer([
				[1, "scripts/items/shields/kite_shield"],
				[1, "scripts/items/shields/heater_shield"]
			]).roll();

			this.m.Items.equip(::new(shield));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Body))
		{
			local armor = ::Reforged.ItemTable.BanditArmorBalanced.roll({
				Apply = function ( _script, _weight )
				{
					local conditionMax = ::ItemTables.ItemInfoByScript[_script].ConditionMax;
					if (conditionMax < 150 || conditionMax > 190) return 0.0;
					return _weight;
				}
			})

			if (armor != null)
			{
				this.m.Items.equip(::new(armor));

				if (::Math.rand(1, 100) <= ::Reforged.Config.ArmorAttachmentChance.Tier2)
				{
					local armorAttachment = ::Reforged.ItemTable.ArmorAttachmentNorthern.roll({
						Apply = function ( _script, _weight )
						{
							local conditionModifier = ::ItemTables.ItemInfoByScript[_script].ConditionModifier;
							if (conditionModifier < 30 || conditionModifier >= 40) return 0.0;
							return _weight;
						}
					})

					if (armorAttachment != null)
						this.getBodyItem().setUpgrade(::new(armorAttachment));
				}
			}
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Head))
		{
			local helmet = ::Reforged.ItemTable.BanditHelmetBalanced.roll({
				Apply = function ( _script, _weight )
				{
					local conditionMax = ::ItemTables.ItemInfoByScript[_script].ConditionMax;
					if (conditionMax < 130 || conditionMax > 180) return 0.0;
					return _weight;
				}
			})
			this.m.Items.equip(::new(helmet));
		}
	}

	function onSpawned()
	{
		local mainhandItem = this.getMainhandItem();
		if (mainhandItem != null)
		{
			::Reforged.Skills.addPerkGroupOfEquippedWeapon(this);
			if (mainhandItem.isItemType(::Const.Items.ItemType.OneHanded))
			{
				this.m.Skills.add(::new("scripts/skills/perks/perk_devastating_strikes"));
			}
			else if (mainhandItem.isItemType(::Const.Items.ItemType.TwoHanded) && ::Reforged.Items.isDuelistValid(mainhandItem))
			{
				this.m.Skills.add(::new("scripts/skills/perks/perk_duelist"));
			}
			else
			{
				this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_polearm"));
				this.m.Skills.add(::new("scripts/skills/perks/perk_rf_formidable_approach"));
			}

			local offhandItem = this.getOffhandItem();
			if (offhandItem != null && offhandItem.isItemType(::Const.Items.ItemType.Shield))
			{
				this.m.Skills.add(::new("scripts/skills/perks/perk_shield_expert"));
			}
		}
	}
});
