::Reforged.HooksMod.hook("scripts/entity/tactical/humans/hedge_knight", function(q) {
	q.onInit = @() function()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.HedgeKnight);
		b.TargetAttractionMult = 1.0;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_military");
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_battle_fervor"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_battle_forged"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_berserk"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_bully"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_crippling_strikes"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_coup_de_grace"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_fearsome"));
		// this.m.Skills.add(::new("scripts/skills/perks/perk_rf_heartless"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_killing_frenzy"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_menacing"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_hold_out"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_savage_strength"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_survival_instinct"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_underdog"));
	}

	q.assignRandomEquipment = @() function()
	{
		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Mainhand))
		{
			local weapon = ::MSU.Class.WeightedContainer([
				[1, "scripts/items/weapons/bardiche"],
				[1, "scripts/items/weapons/greataxe"],
				[1, "scripts/items/weapons/two_handed_flail"],
				[1, "scripts/items/weapons/two_handed_hammer"],
				[1, "scripts/items/weapons/two_handed_flanged_mace"]
			]).roll();

			this.m.Items.equip(::new(weapon));
		}

		if (this.m.IsMiniboss)
		{
			if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Body))
			{
				this.m.Items.equip(::new(::MSU.Class.WeightedContainer([
					[1, "scripts/items/armor/rf_breastplate_armor"],
					[1, "scripts/items/armor/rf_breastplate_harness"]
				]).roll()));
			}

			if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Head))
			{
				this.m.Items.equip(::new(::MSU.Class.WeightedContainer([
					[1, "scripts/items/helmets/rf_half_closed_sallet_with_mail"],
					[1, "scripts/items/helmets/rf_visored_bascinet"],
					[1, "scripts/items/helmets/rf_half_closed_sallet_with_bevor"]
				]).roll()));
			}
		}
		else
		{
			if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Body))
			{
				this.m.Items.equip(::new(::MSU.Class.WeightedContainer([
					[1, "scripts/items/armor/heavy_lamellar_armor"],
					[1, "scripts/items/armor/coat_of_plates"],
					[1, "scripts/items/armor/coat_of_scales"]
				]).roll()));
			}

			if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Head))
			{
				this.m.Items.equip(::new(::MSU.Class.WeightedContainer([
					[1, "scripts/items/helmets/closed_flat_top_with_mail"],
					[0.5, "scripts/items/helmets/conic_helmet_with_faceguard"],
					[1, "scripts/items/helmets/full_helm"]
				]).roll()));
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

		local r = ::Math.rand(1, 3);

		if (r == 1)
		{
			local weapon = ::MSU.Class.WeightedContainer([
				[1, "scripts/items/weapons/named/named_bardiche"],
				[1, "scripts/items/weapons/named/named_greataxe"],
				[1, "scripts/items/weapons/named/named_two_handed_flail"],
				[1, "scripts/items/weapons/named/named_two_handed_hammer"],
				[1, "scripts/items/weapons/named/named_two_handed_mace"]
			]).roll();

			this.m.Items.equip(::new(weapon));
		}
		else if (r == 2)
		{
			local armor = ::Reforged.ItemTable.NamedArmorNorthern.roll({
				Apply = function ( _script, _weight )
				{
					local conditionMax = ::ItemTables.ItemInfoByScript[_script].ConditionMax;
					if (conditionMax < 280) return 0.0;
					return _weight;
				}
			})
			if (armor != null) this.m.Items.equip(::new(armor));
		}
		else
		{
			local helmet = ::Reforged.ItemTable.NamedHelmetNorthern.roll({
				Apply = function ( _script, _weight )
				{
					local conditionMax = ::ItemTables.ItemInfoByScript[_script].ConditionMax;
					if (conditionMax < 280) return 0.0;
					return _weight;
				}
			})
			if (helmet != null) this.m.Items.equip(::new(helmet));
		}

		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_man_of_steel"));
		return true;
	}

	q.onSpawned = @() function()
	{
		local mainhandItem = this.getMainhandItem();
		if (mainhandItem != null)
		{
			::Reforged.Skills.addPerkGroupOfEquippedWeapon(this);

			if (mainhandItem.isAoE())
			{
				this.m.Skills.add(::new("scripts/skills/perks/perk_rf_death_dealer"));
				this.m.Skills.add(::new("scripts/skills/perks/perk_rf_sweeping_strikes"));
			}
			else
			{
				this.m.Skills.add(::new("scripts/skills/perks/perk_rf_formidable_approach"));
			}
		}
	}
});
