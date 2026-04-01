::Reforged.HooksMod.hook("scripts/skills/actives/zombie_bite", function(q) {
	q.create = @(__original) { function create()
	{
		__original();
		// Vanilla is missing a description for this skill
		this.m.Description = "Use your rotten teeth to deliver a painful bite.";
	}}.create;

	// Hide this skill when equipping a weapon. Because in the nested tooltip
	// of this skill on an actor the damage numbers are wrong when the actor is
	// equipping a weapon with double grip. This is consistent with how vanilla
	// hides Hand to Hand skill when it's not usable.
	q.isHidden = @() { function isHidden()
	{
		local actor = this.getContainer().getActor();
		return actor.getMainhandItem() != null && !actor.isDisarmed();
	}}.isHidden;

	// Vanilla doesn't have a getTooltip function defined for this skill
	q.getTooltip = @() { function getTooltip()
	{
		return this.getDefaultTooltip();
	}}.getTooltip;
});
