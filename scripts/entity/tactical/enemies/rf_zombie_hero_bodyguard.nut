this.rf_zombie_hero_bodyguard <- ::inherit("scripts/entity/tactical/enemies/rf_zombie_hero", {
	m = {},
	function create()
	{
		this.rf_zombie_hero.create();
		this.m.ResurrectWithScript = "scripts/entity/tactical/enemies/rf_zombie_hero_bodyguard";
		this.m.AIAgent = ::new("scripts/ai/tactical/agents/zombie_bodyguard_agent");
		this.m.AIAgent.setActor(this);
	}
});
