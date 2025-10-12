this.rf_line_breaker_skill <- ::inherit("scripts/skills/actives/line_breaker", {
	m = {
		RequiresShield = true
	},
	function create()
	{
		this.line_breaker.create();
		this.m.ID = "actives.rf_line_breaker";
		this.m.Name = "Line Breaker";
		this.m.Description = "Push through the ranks of your enemies by knocking back a target and taking its place, all in one action.";
		this.m.Icon = "skills/rf_line_breaker_skill.png";
		this.m.IconDisabled = "skills/rf_line_breaker_skill_sw.png";
		this.m.Overlay = "rf_line_breaker_skill";
		this.m.SoundOnUse = [
			"sounds/combat/indomitable_01.wav",
			"sounds/combat/indomitable_02.wav"
		];
		this.m.IsSerialized = false;
		this.m.FatigueCost = 25;
		this.m.AIBehaviorID = ::Const.AI.Behavior.ID.LineBreaker;
	}

	function isUsable()
	{
		local actor = this.getContainer().getActor();
		return this.skill.isUsable() && (!this.m.RequiresShield || actor.isArmedWithShield()) && !actor.getCurrentProperties().IsRooted && !actor.getCurrentProperties().IsStunned;
	}
});
