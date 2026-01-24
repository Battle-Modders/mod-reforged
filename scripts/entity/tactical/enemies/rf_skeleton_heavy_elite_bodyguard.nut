// Ancient Praetorian
this.rf_skeleton_heavy_elite_bodyguard <- ::inherit("scripts/entity/tactical/enemies/rf_skeleton_heavy_elite", {
	m = {},
	function create()
	{
		this.rf_skeleton_heavy_elite.create();
		this.m.ResurrectWithScript = "scripts/entity/tactical/enemies/rf_skeleton_heavy_elite_bodyguard";
		this.m.AIAgent = ::new("scripts/ai/tactical/agents/skeleton_bodyguard_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.rf_skeleton_heavy_elite.onInit();
		this.getBaseProperties().Initiative -= 50;
		this.getSkills().update();
	}
});
