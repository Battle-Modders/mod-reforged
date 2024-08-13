this.rf_bandit_outlaw <- ::inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = ::Const.EntityType.RF_BanditOutlaw;
		this.m.BloodType = ::Const.BloodType.Red;
		this.m.XP = ::Const.Tactical.Actor.RF_BanditOutlaw.XP;
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
		b.setValues(::Const.Tactical.Actor.RF_BanditOutlaw);
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
				[0.5, "scripts/items/weapons/rf_greatsword"],
				[1, "scripts/items/weapons/two_handed_mace"],
				[1, "scripts/items/weapons/two_handed_wooden_hammer"],
				[1, "scripts/items/weapons/two_handed_wooden_flail"]
			]).roll();

			this.m.Items.equip(::new(weapon));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Body))
		{
			local armor = ::Reforged.ItemTable.BanditArmorTough.roll({
				Apply = function ( _script, _weight )
				{
					local conditionMax = ::ItemTables.ItemInfoByScript[_script].ConditionMax;
					if (conditionMax < 55 || conditionMax > 95) return 0.0;
					return _weight;
				}
			})
			if (armor != null) this.m.Items.equip(::new(armor));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Head))
		{
			local helmet = ::Reforged.ItemTable.BanditHelmetTough.roll({
				Apply = function ( _script, _weight )
				{
					local conditionMax = ::ItemTables.ItemInfoByScript[_script].ConditionMax;
					if (conditionMax < 40 || conditionMax > 70) return 0.0;
					return _weight;
				}
			})
			if (helmet != null) this.m.Items.equip(::new(helmet));
		}
	}

	function onSetupEntity()
	{
		local mainhandItem = this.getMainhandItem();
		if (mainhandItem != null)
		{
			::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 4);
			if (mainhandItem.isWeaponType(::Const.Items.WeaponType.Sword))
			{
				this.m.Skills.removeByID("actives.rf_kata_step_skill");
			}
			else if (mainhandItem.isWeaponType(::Const.Items.WeaponType.Mace) || mainhandItem.isWeaponType(::Const.Items.WeaponType.Hammer) || mainhandItem.isWeaponType(::Const.Items.WeaponType.Flail))
			{
				this.m.Skills.add(::new("scripts/skills/perks/perk_rf_formidable_approach"));
			}
		}
	}
});
