::Reforged.HooksMod.hook("scripts/entity/tactical/humans/militia_veteran", function(q) {
	q.onInit = @() { function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.MilitiaVeteran);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_militia");
		this.getSprite("accessory_special").setBrush("bust_militia_band_01");
		// this.m.Skills.add(::new("scripts/skills/perks/perk_shield_expert"));
		// this.m.Skills.add(::new("scripts/skills/actives/recover_skill"));	// Now granted to all humans by default

		// Reforged
		this.m.Skills.add(::new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_strength_in_numbers"));
	}}.onInit;

	q.onSpawned = @() { function onSpawned()
	{
		local mainhandItem = this.getMainhandItem();
		if (mainhandItem != null)
		{
			::Reforged.Skills.addAllPerkGroupsOfEquippedWeapon(this, 4);

			if (mainhandItem.isItemType(::Const.Items.ItemType.TwoHanded))
			{
				this.m.Skills.add(::new("scripts/skills/perks/perk_rf_formidable_approach"));
			}
			else
			{
				local offhand = this.getOffhandItem();
				if (offhand == null)
				{
					this.m.Skills.add(::new("scripts/skills/perks/perk_duelist"));
				}
				else if (offhand.isItemType(::Const.Items.ItemType.Shield))
				{
					this.m.Skills.add(::new("scripts/skills/perks/perk_rf_phalanx"));
					this.m.Skills.add(::new("scripts/skills/perks/perk_shield_expert"));
				}
			}
		}
	}}.onSpawned;
});
