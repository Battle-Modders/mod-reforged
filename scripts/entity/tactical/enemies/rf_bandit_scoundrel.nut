this.rf_bandit_scoundrel <- ::inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = ::Const.EntityType.RF_BanditScoundrel;
		this.m.BloodType = ::Const.BloodType.Red;
		this.m.XP = ::Const.Tactical.Actor.RF_BanditScoundrel.XP;
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
		b.setValues(::Const.Tactical.Actor.RF_BanditScoundrel);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_bandits");

		if (::Math.rand(1, 100) <= 10)
		{
			local pox = this.getSprite("tattoo_head");
			pox.Visible = true;
			pox.setBrush("bust_head_pox_01");
		}
		else if (::Math.rand(1, 100) <= 15)
		{
			local pox = this.getSprite("tattoo_head");
			pox.Visible = true;
			pox.setBrush("bust_head_darkeyes_01");
		}
		else
		{
			local dirt = this.getSprite("dirt");
			dirt.Visible = true;
		}

		if (::Math.rand(1, 100) <= 25)
		{
			this.getSprite("eye_rings").Visible = true;
		}

		this.getSprite("armor").Saturation = 0.8;
		this.getSprite("helmet").Saturation = 0.8;
		this.getSprite("helmet_damage").Saturation = 0.8;
		this.getSprite("shield_icon").Saturation = 0.8;
		this.getSprite("shield_icon").setBrightness(0.9);

		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_bully"));
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
				[1, "scripts/items/weapons/butchers_cleaver"],
				[1, "scripts/items/weapons/dagger"],
				[1, "scripts/items/weapons/knife"],
				[1, "scripts/items/weapons/militia_spear"],
				[1, "scripts/items/weapons/shortsword"],
				[1, "scripts/items/weapons/wooden_flail"],
				[1, "scripts/items/weapons/wooden_stick"],

				[1, "scripts/items/weapons/pitchfork"]
			]).roll();

			this.m.Items.equip(::new(weapon));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Offhand))
		{
			local shield = ::MSU.Class.WeightedContainer([
				[1, "scripts/items/shields/buckler_shield"],
				[1, "scripts/items/shields/wooden_shield"]
			]).rollChance(33);

			if (shield != null) this.m.Items.equip(::new(shield));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Body))
		{
			local armor = ::Reforged.ItemTable.BanditArmorBalanced.roll({
				Apply = function ( _script, _weight )
				{
					local conditionMax = ::ItemTables.ItemInfoByScript[_script].ConditionMax;
					if (conditionMax > 65) return 0.0;
					return _weight;
				},
				Add = [
					[1, "scripts/items/armor/monk_robe"]
				]
			})
			this.m.Items.equip(::new(armor));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Head) && ::Math.rand(1, 100) > 50)
		{
			local helmet = ::Reforged.ItemTable.BanditHelmetBalanced.roll({
				Apply = function ( _script, _weight )
				{
					local conditionMax = ::ItemTables.ItemInfoByScript[_script].ConditionMax;
					if (conditionMax > 40) return 0.0;
					return _weight;
				}
			})
			if (helmet != null) this.m.Items.equip(::new(helmet));
		}
	}
});
