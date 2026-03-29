this.rf_zombie_orc_young <- ::inherit("scripts/entity/tactical/enemies/rf_zombie_orc", {
	function create()
	{
		this.m.Type = ::Const.EntityType.RF_ZombieOrcYoung;
		this.m.XP = ::Const.Tactical.Actor.RF_ZombieOrcYoung.XP;
		this.rf_zombie_orc.create();
		this.m.BloodSplatterOffset = this.createVec(0, 0);
		this.m.DecapitateSplatterOffset = this.createVec(25, -25);
		this.m.ResurrectionValue = 4.5;
		this.m.ResurrectionChance = 66,
		this.m.ResurrectWithScript = "scripts/entity/tactical/enemies/rf_zombie_orc_young";
	}

	function getZombifyBrushNameHead()
	{
		return "rf_zombify_orc_young_" + (this.m.InjuryType < 10 ? "0" : "") + this.m.InjuryType;
	}

	function getZombifyBrushNameBody()
	{
		return "rf_zombify_orc_young_body_" + (this.m.InjuryType < 10 ? "0" : "") + 1;//this.m.InjuryType;
	}

	function setOrcSpecificSprites()
	{
		local body = this.getSprite("body");
		body.setBrush("bust_orc_01_body");

		local head = this.getSprite("head");
		head.setBrush("bust_orc_01_head_0" + ::Math.rand(1, 3));
	}

	function onInit()
	{
		this.rf_zombie_orc.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.RF_ZombieOrcYoung);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
	}

	function assignRandomEquipment()
	{
		this.assignRandomEquipmentFromScript("scripts/entity/tactical/enemies/orc_young");

		local garbage = [];
		foreach (item in this.m.Items.getAllItems())
		{
			switch (item.getCurrentSlotType())
			{
				// Unequip shield
				case ::Const.ItemSlot.Offhand:
					garbage.push(item);
					break;

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

		foreach (item in garbage)
		{
			this.m.Items.unequip(item);
		}
	}
});
