this.rf_vampire_lord <- ::inherit("scripts/entity/tactical/enemies/vampire", {
	m = {},
	function create()
	{
		this.vampire.create();
		this.m.Type = ::Const.EntityType.RF_VampireLord;
		this.m.XP = ::Const.Tactical.Actor.RF_VampireLord.XP;
		this.m.Name = ::Const.Strings.EntityName[this.m.Type];
		this.m.AIAgent = ::new("scripts/ai/tactical/agents/rf_vampire_lord_agent");
		this.m.AIAgent.setActor(this);

		this.m.HeadSprites = [
			"bust_rf_vampire_lord_head_01",
			"bust_rf_vampire_lord_head_02",
			"bust_rf_vampire_lord_head_03"
		];
		this.m.BodySprites = [
			"bust_rf_vampire_lord_body_01",
			"bust_rf_vampire_lord_body_02",
			"bust_rf_vampire_lord_body_03"
		];
		this.m.VampireBloodHeadSprites = ::Const.RF_VampireLordBloodHead;
	}

	function onInit()
	{
	    this.vampire.onInit();

	    this.getSprite("body_detail").Visible = false;

		this.m.BaseProperties.Reach = ::Reforged.Reach.Default.Human;
		this.m.BaseProperties.ActionPoints = 9;
		this.m.Skills.getSkillByID("actives.darkflight").setBaseValue("ActionPointCost", 3);

		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_bloodbath"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_cleaver"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_crippling_strikes"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_terrifying_visage"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_head_hunter"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_nine_lives"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_sanguinary"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_sweeping_strikes"));
		this.m.Skills.add(::new("scripts/skills/actives/rf_sanguine_curse_skill"));
	}

	function onDeath( _killer, _skill, _tile, _fatalityType )
	{
		this.vampire.onDeath(_killer, _skill, _tile, _fatalityType);
		if (_tile != null)
		{
			local decal = _tile.spawnDetail("bust_rf_vampire_lord_dead", ::Const.Tactical.DetailFlag.Corpse, this.m.IsCorpseFlipped, false);
			decal.Scale = 0.9;
			decal.setBrightness(0.9);
		}
	}

	function assignRandomEquipment()
	{
		this.m.Items.equip(::new("scripts/items/helmets/rf_vampire_lord_helmet"));
		this.m.Items.equip(::new("scripts/items/armor/rf_vampire_lord_armor"));

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Mainhand))
		{
			this.m.Items.equip(::new("scripts/items/weapons/rf_great_khopesh"));
		}
	}

	function makeMiniboss()
	{
		if (!this.actor.makeMiniboss())
		{
			return false;
		}

		this.m.Items.equip(::new("scripts/items/weapons/named/named_crypt_cleaver"));

		this.m.Skills.add(this.new("scripts/skills/perks/perk_anticipation"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rf_unstoppable"));
		return true;
	}
});
