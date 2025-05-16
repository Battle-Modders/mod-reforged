this.rf_banshee <- ::inherit("scripts/entity/tactical/enemies/ghost", {
	m = {},
	function create()
	{
		this.ghost.create();
		
		this.m.Type = ::Const.EntityType.RF_Banshee;
		this.m.XP = ::Const.Tactical.Actor.RF_Banshee.XP;
		this.m.Sound[::Const.Sound.ActorEvent.Death] = [
			"sounds/enemies/rf_banshee_death_01.wav",
			"sounds/enemies/rf_banshee_death_02.wav",
			"sounds/enemies/rf_banshee_death_03.wav"
		];
		this.m.Sound[::Const.Sound.ActorEvent.Idle] = [
			"sounds/enemies/rf_banshee_idle_01.wav",
			"sounds/enemies/rf_banshee_idle_02.wav"
		];

		// The ghost.create() above calls actor.create() which sets the name based on ghost entitytype
		this.setName(::Const.Strings.EntityName[::Const.EntityType.RF_Banshee]);
	}

	function onInit()
	{
		// We don't use the base ghost.onInit to keep things cleaner here and more controlled
		// otherwise we have to change sprites and remove skills afterward, and any submod changes to
		// ghost would change this enemy's design.
		this.actor.onInit();

		// The logic below is mostly copied from ghost.nut

		this.setRenderCallbackEnabled(true);
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.RF_Banshee);

		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = ::Const.SameMovementAPCost;
		this.m.FatigueCosts = ::Const.DefaultMovementFatigueCost;
		this.m.MaxTraversibleLevels = 3;
		this.m.Items.getAppearance().Body = "bust_rf_banshee_01";
		this.addSprite("socket").setBrush("bust_base_undead");
		this.addSprite("fog").setBrush("bust_ghost_fog_02");
		local body = this.addSprite("body");
		body.setBrush("bust_rf_banshee_01");
		body.varySaturation(0.25);
		body.varyColor(0.2, 0.2, 0.2);
		local head = this.addSprite("head");
		head.setBrush("bust_rf_banshee_01");
		head.varySaturation(0.25);
		head.varyColor(0.2, 0.2, 0.2);
		local blur_1 = this.addSprite("blur_1");
		blur_1.setBrush("bust_rf_banshee_01");
		blur_1.varySaturation(0.25);
		blur_1.varyColor(0.2, 0.2, 0.2);
		local blur_2 = this.addSprite("blur_2");
		blur_2.setBrush("bust_rf_banshee_01");
		blur_2.varySaturation(0.25);
		blur_2.varyColor(0.2, 0.2, 0.2);
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.55;
		this.setSpriteOffset("status_rooted", this.createVec(-5, -5));
		this.m.Skills.add(::new("scripts/skills/perks/perk_fearsome"));
		this.m.Skills.add(::new("scripts/skills/racial/ghost_racial"));
		this.m.Skills.add(::new("scripts/skills/actives/rf_banshee_wail_skill"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_whimpering_veil"));
	}

	function makeMiniboss()
	{
		if (!this.actor.makeMiniboss())
			return;

		this.getSkills().add(::new("scripts/skills/perks/perk_nine_lives"));
		this.getSkills().add(::new("scripts/skills/perks/perk_rf_menacing"));
	}
});
