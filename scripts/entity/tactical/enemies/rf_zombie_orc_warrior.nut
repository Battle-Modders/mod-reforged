this.rf_zombie_orc_warrior <- ::inherit("scripts/entity/tactical/enemies/rf_zombie_orc", {
	function create()
	{
		this.m.Type = ::Const.EntityType.RF_ZombieOrcWarrior;
		this.m.XP = ::Const.Tactical.Actor.RF_ZombieOrcWarrior.XP;
		this.rf_zombie_orc.create();

		this.m.BloodSplatterOffset = this.createVec(0, 0);
		this.m.DecapitateSplatterOffset = this.createVec(20, -20);

		this.m.SoundPitch *= 0.85;

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

		local app = this.getItems().getAppearance();
		app.Body = body.getBrush().Name;
		app.Corpse = app.Body + "_dead";

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

		::new("scripts/entity/tactical/enemies/orc_warrior").assignRandomEquipment.call(this);

		this.m.Skills.add = add;

		this.m.Items.equip = equip;
		foreach (item in items)
		{
			this.m.Items.equip(item);
			if (::Math.rand(1, 100) <= 50)
			{
				item.setCondition(item.getConditionMax() * 0.5 - 1);
			}
		}
	}
});
