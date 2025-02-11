::Reforged.HooksMod.hook("scripts/entity/tactical/humans/bounty_hunter", function(q) {
	q.onInit = @() function()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.BountyHunter);
		// b.IsSpecializedInSwords = true;
		// b.IsSpecializedInAxes = true;
		// b.IsSpecializedInMaces = true;
		// b.IsSpecializedInFlails = true;
		// b.IsSpecializedInPolearms = true;
		// b.IsSpecializedInThrowing = true;
		// b.IsSpecializedInHammers = true;
		// b.IsSpecializedInSpears = true;
		// b.IsSpecializedInCleavers = true;
		// b.IsSpecializedInDaggers = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_militia");
		// this.m.Skills.add(::new("scripts/skills/perks/perk_brawny"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_bullseye"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_quick_hands"));
		// this.m.Skills.add(::new("scripts/skills/effects/dodge_effect")); // Replaced as perk
		this.m.Skills.add(::new("scripts/skills/perks/perk_nimble"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_overwhelm"));
		// this.m.Skills.add(::new("scripts/skills/actives/rotation")); // Replaced as perk
		// this.m.Skills.add(::new("scripts/skills/actives/footwork")); // Replaced as perk
		// this.m.Skills.add(::new("scripts/skills/actives/recover_skill"));	// Now granted to all humans by default

		//Reforged
		this.m.Skills.add(::new("scripts/skills/perks/perk_dodge"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_footwork"));
	}

	q.assignRandomEquipment = @(__original) function()
	{
		__original();
		::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 4);

		if (this.getBodyItem() != null && ::Math.rand(1, 100) <= ::Reforged.Config.ArmorAttachmentChance.Tier3)
		{
			local armor = this.getBodyItem();
			local conditionModifierCutoff = armor.getConditionMax() < 115 ? 20 : 30;

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
				this.getBodyItem().setUpgrade(::new(armorAttachment));
			}
		}
	}
});
