this.rf_zombie_orc_berserker <- ::inherit("scripts/entity/tactical/enemies/rf_zombie_orc", {
	function create()
	{
		this.m.Type = ::Const.EntityType.RF_ZombieOrcBerserker;
		this.m.XP = ::Const.Tactical.Actor.RF_ZombieOrcBerserker.XP;
		this.rf_zombie_orc.create();
		this.m.BloodSplatterOffset = this.createVec(0, 0);
		this.m.DecapitateSplatterOffset = this.createVec(20, -20);
		this.m.SoundPitch *= 0.9;
		this.m.ResurrectionValue = 9.5;
		this.m.ResurrectionChance = 80,
		this.m.ResurrectWithScript = "scripts/entity/tactical/enemies/rf_zombie_orc_berserker";
	}

	function getZombifyBrushNameHead()
	{
		return "rf_zombify_" + this.getSprite("head").getBrush().Name.slice(5) + (this.m.InjuryType < 10 ? "_0" : "_") + this.m.InjuryType;
	}

	function getZombifyBrushNameBody()
	{
		return "rf_zombify_orc_young_body_" + (this.m.InjuryType < 10 ? "0" : "") + 1;//this.m.InjuryType;
	}

	function setOrcSpecificSprites()
	{
		local body = this.getSprite("body");
		body.setBrush("bust_orc_02_body");

		local head = this.getSprite("head");
		head.setBrush("bust_orc_02_head_0" + ::Math.rand(1, 3));

		if (::Math.rand(1, 100) <= 50)
		{
			this.getSprite("tattoo_body").setBrush("bust_orc_02_body_paint_0" + ::Math.rand(1, 3));
		}

		if (::Math.rand(1, 100) <= 50)
		{
			this.getSprite("tattoo_head").setBrush("bust_orc_02_head_paint_0" + ::Math.rand(1, 3));
		}
	}

	function onInit()
	{
		this.rf_zombie_orc.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.RF_ZombieOrcBerserker);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.Skills.add(::new("scripts/skills/perks/perk_battering_ram"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_fearsome"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_hold_out"));
	}

	function assignRandomEquipment()
	{
		this.assignRandomEquipmentFromScript("scripts/entity/tactical/enemies/orc_berserker");

		foreach (item in this.m.Items.getAllItems())
		{
			switch (item.getCurrentSlotType())
			{
				// Chance to have damaged armor and helmet
				case ::Const.ItemSlot.Body:
				case ::Const.ItemSlot.Head:
					if (::Math.rand(1, 100) <= 66)
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
		}
	}
});
