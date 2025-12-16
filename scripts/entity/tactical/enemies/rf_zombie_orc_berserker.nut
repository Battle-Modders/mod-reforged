this.rf_zombie_orc_berserker <- ::inherit("scripts/entity/tactical/enemies/rf_zombie_orc", {
	function create()
	{
		this.m.Type = ::Const.EntityType.RF_ZombieOrcBerserker;
		this.m.XP = ::Const.Tactical.Actor.RF_ZombieOrcBerserker.XP;
		this.rf_zombie_orc.create();

		this.m.BloodSplatterOffset = this.createVec(0, 0);
		this.m.DecapitateSplatterOffset = this.createVec(20, -20);

		this.m.SoundPitch *= 0.9;

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
	}

	function assignRandomEquipment()
	{
		local add = this.m.Skills.add;
		this.m.Skills.add = @(...) null;

		local items = [];
		local equip = this.m.Items.equip;
		this.m.Items.equip = function( _item )
		{
			items.push(_item);
		}

		::new("scripts/entity/tactical/enemies/orc_berserker").assignRandomEquipment.call(this);

		this.m.Skills.add = add;

		this.m.Items.equip = equip;
		foreach (item in items)
		{
			this.m.Items.equip(item);
			if (::Math.rand(1, 100) <= 66)
			{
				item.setCondition(item.getConditionMax() * 0.5 - 1);
			}
		}

		local offhand = this.getOffhandItem();
		if (offhand != null)
		{
			this.getItems().unequip(offhand);
		}
	}
});
