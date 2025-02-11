::Reforged.HooksMod.hook("scripts/entity/tactical/humans/mercenary_ranged", function(q) {
	q.onInit = @() function()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.MercenaryRanged);
		b.TargetAttractionMult = 1.1;
		b.Vision = 8;
		// b.IsSpecializedInBows = true;
		// b.IsSpecializedInCrossbows = true;
		// b.IsSpecializedInDaggers = true; // Replaced with perk
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_militia");
		// this.m.Skills.add(::new("scripts/skills/perks/perk_brawny"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_bullseye"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_quick_hands"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_crippling_strikes"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_coup_de_grace"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_fast_adaption"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_nimble"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_overwhelm"));
		// this.m.Skills.add(::new("scripts/skills/actives/rotation")); // Replaced with perk
		// this.m.Skills.add(::new("scripts/skills/actives/footwork")); // Replaced with perk
		// this.m.Skills.add(::new("scripts/skills/actives/recover_skill"));	// Now granted to all humans by default

		// Reforged
		this.m.Skills.add(::new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_footwork"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_through_the_ranks"));
	}

	q.assignRandomEquipment = @(__original) function()
	{
		__original();

		::Reforged.Skills.addPerkGroupOfEquippedWeapon(this);

		if (this.getBodyItem() != null && ::Math.rand(1, 100) <= ::Reforged.Config.ArmorAttachmentChance.Tier3)
		{
			local armor = this.getBodyItem();
			local conditionModifierCutoff = armor.getConditionMax() < 115 ? 10 : 20;
			local armorAttachment = ::Reforged.ItemTable.ArmorAttachmentNorthern.roll({
				Apply = function ( _script, _weight )
				{
					local conditionModifier = ::ItemTables.ItemInfoByScript[_script].ConditionModifier;
					if (conditionModifier > conditionModifierCutoff) return 0.0;
					return _weight;
				}
			});

			if (armorAttachment != null)
			{
				armor.setUpgrade(::new(armorAttachment));
			}
		}
	}
});
