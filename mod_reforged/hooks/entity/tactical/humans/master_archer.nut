::Reforged.HooksMod.hook("scripts/entity/tactical/humans/master_archer", function(q) {
	q.onInit = @() function()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.MasterArcher);
		b.Vision = 8;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_militia");
		this.m.Skills.add(::new("scripts/skills/perks/perk_battle_flow"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_bullseye"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_crippling_strikes"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_coup_de_grace"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_footwork"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_finesse"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_nimble"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_pathfinder"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_quick_hands"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_relentless"));
	}

	q.assignRandomEquipment = @() function()
	{
		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Mainhand))
		{
			local r = ::Math.rand(1, 2);

			if (r == 1)
			{
				this.m.Items.equip(::new("scripts/items/weapons/war_bow"));
				this.m.Items.equip(::new("scripts/items/ammo/quiver_of_arrows"));
			}
			else if (r == 2)
			{
				this.m.Items.equip(::new("scripts/items/weapons/heavy_crossbow"));
				this.m.Items.equip(::new("scripts/items/ammo/quiver_of_bolts"));
			}
		}

		local sidearm = ::MSU.Class.WeightedContainer([
			[1, "scripts/items/weapons/falchion"],
			[1, "scripts/items/weapons/hand_axe"],
			[1, "scripts/items/weapons/rondel_dagger"],
			[1, "scripts/items/weapons/scramasax"]
		]).roll();

		if (sidearm != null) this.m.Items.addToBag(::new(sidearm));

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Body))
		{
			this.m.Items.equip(::new(::MSU.Class.WeightedContainer([
				[1, "scripts/items/armor/thick_tunic"],
				[1, "scripts/items/armor/padded_surcoat"],
				[1, "scripts/items/armor/gambeson"]
			]).roll()));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Head))
		{
			if (this.m.IsMiniboss)
			{
				this.m.Items.equip(::new("scripts/items/helmets/greatsword_hat"));
			}
			else
			{
				local helmet = ::MSU.Class.WeightedContainer([
					[1, "scripts/items/helmets/hood"],
					[1, "scripts/items/helmets/hunters_hat"]
				]).rollChance(33);

				if (helmet != null) this.m.Items.equip(::new(helmet));
			}
		}
	}

	q.makeMiniboss = @() function()
	{
		if (!this.actor.makeMiniboss())
		{
			return false;
		}

		this.getSprite("miniboss").setBrush("bust_miniboss");

		if (::Math.rand(1, 100) < 70)
		{
			local r = ::Math.rand(1, 2);
			if (r == 1)
			{
				this.m.Items.equip(::new("scripts/items/weapons/named/named_warbow"));
				this.m.Items.equip(::new("scripts/items/ammo/quiver_of_arrows"));
			}
			else if (r == 2)
			{
				this.m.Items.equip(::new("scripts/items/weapons/named/named_crossbow"));
				this.m.Items.equip(::new("scripts/items/ammo/quiver_of_bolts"));
			}
		}
		else
		{
			local armor = ::Reforged.ItemTable.NamedArmorNorthern.roll({
				Apply = function ( _script, _weight )
				{
					local conditionMax = ::ItemTables.ItemInfoByScript[_script].ConditionMax;
					if (conditionMax > 140) return 0.0;
					return _weight;
				}
			})
			if (armor != null) this.m.Items.equip(::new(armor));
		}

		this.m.Skills.add(::new("scripts/skills/perks/perk_dodge"));
		return true;
	}

	q.onSpawned = @() function()
	{
		local mainhandItem = this.getMainhandItem();
		if (mainhandItem != null)
		{
			::Reforged.Skills.addPerkGroupOfEquippedWeapon(this)
		}
	}
});
