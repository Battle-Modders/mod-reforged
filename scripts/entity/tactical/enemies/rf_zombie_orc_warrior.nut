this.rf_zombie_orc_warrior <- ::inherit("scripts/entity/tactical/enemies/rf_zombie_orc", {
	function create()
	{
		this.m.Type = ::Const.EntityType.RF_ZombieOrcWarrior;
		this.m.XP = ::Const.Tactical.Actor.RF_ZombieOrcWarrior.XP;
		this.rf_zombie_orc.create();
		this.m.BloodSplatterOffset = this.createVec(0, 0);
		this.m.DecapitateSplatterOffset = this.createVec(20, -20);
		this.m.SoundPitch *= 0.85;
		this.m.ResurrectionValue = 8.5;
		this.m.ResurrectionChance = 80,
		this.m.ResurrectWithScript = "scripts/entity/tactical/enemies/rf_zombie_orc_warrior";
	}

	function getZombifyBrushNameHead()
	{
		return "rf_zombify_orc_warrior_" + (this.m.InjuryType < 10 ? "0" : "") + this.m.InjuryType;
	}

	function getZombifyBrushNameBody()
	{
		return "rf_zombify_orc_young_body_" + (this.m.InjuryType < 10 ? "0" : "") + 1;//this.m.InjuryType;
	}

	function setOrcSpecificSprites()
	{
		local body = this.getSprite("body");
		body.setBrush("bust_orc_03_body");

		local head = this.getSprite("head");
		head.setBrush("bust_orc_03_head_0" + ::Math.rand(1, 3));

		this.setSpriteOffset("status_rooted", this.createVec(0, 5));
		this.setSpriteOffset("status_rage", this.createVec(-10, 0));
	}

	function onInit()
	{
		this.rf_zombie_orc.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.RF_ZombieOrcWarrior);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.Skills.add(::new("scripts/skills/perks/perk_battering_ram"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_fearsome"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_hold_out"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_stalwart"));
	}

	function assignRandomEquipment()
	{
		this.assignRandomEquipmentFromScript("scripts/entity/tactical/enemies/orc_warrior");

		foreach (item in this.m.Items.getAllItems())
		{
			switch (item.getCurrentSlotType())
			{
				// Chance to have damaged armor and helmet
				case ::Const.ItemSlot.Body:
				case ::Const.ItemSlot.Head:
					if (::Math.rand(1, 100) <= 50)
					{
						item.setCondition(item.getConditionMax() * 0.5 - 1);
					}
					break;
			}
		}
	}

	function onSpawned()
	{
		::Reforged.Skills.addPerkGroupOfEquippedWeapon(this, 4);
		local mainhandItem = this.getMainhandItem();
		if (mainhandItem != null)
		{
			if (mainhandItem.isWeaponType(::Const.Items.WeaponType.Axe))
			{
				this.m.Skills.removeByID("actives.rf_bearded_blade");
				this.m.Skills.removeByID("actives.rf_hook_shield");
			}
			else if (mainhandItem.isWeaponType(::Const.Items.WeaponType.Cleaver))
			{
				this.m.Skills.removeByID("perk.rf_bloodlust");
			}
		}
	}
});
