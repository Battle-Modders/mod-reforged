::Reforged.HooksMod.hook("scripts/entity/tactical/humans/bounty_hunter_ranged", function(q) {
	q.onInit = @() { function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.BountyHunterRanged);
		b.TargetAttractionMult = 1.1;
		b.Vision = 8;
		// b.IsSpecializedInCrossbows = true;
		// b.IsSpecializedInBows = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_militia");
		// this.m.Skills.add(::new("scripts/skills/perks/perk_brawny"));
		// this.m.Skills.add(::new("scripts/skills/perks/perk_bullseye"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_quick_hands"));
		// this.m.Skills.add(::new("scripts/skills/actives/rotation")); // Replaced with perk
		// this.m.Skills.add(::new("scripts/skills/actives/footwork")); // Replaced with perk
		// this.m.Skills.add(::new("scripts/skills/actives/recover_skill"));	// Now granted to all humans by default

		// Reforged
		this.m.Skills.add(::new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_footwork"));
	}}.onInit;

	q.assignRandomEquipment = @(__original) { function assignRandomEquipment()
	{
		__original();
		::Reforged.Skills.addPerkGroupOfEquippedWeapon(this);

		if (this.getBodyItem() != null)
		{
			if (::Math.rand(1, 100) <= ::Reforged.Config.ArmorAttachmentChance.Tier2)
			{
				local armorAttachment = ::Reforged.ItemTable.ArmorAttachmentNorthern.roll({
					Apply = function ( _script, _weight )
					{
						local conditionModifier = ::ItemTables.ItemInfoByScript[_script].ConditionModifier;
						if (conditionModifier > 20) return 0.0;
						return _weight;
					}
				})

				if (armorAttachment != null)
					this.getBodyItem().setUpgrade(::new(armorAttachment));
			}
		}
	}}.assignRandomEquipment;
});
