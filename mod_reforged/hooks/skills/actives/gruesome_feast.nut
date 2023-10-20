::Reforged.HooksMod.hook("scripts/skills/actives/gruesome_feast", function(q) {
	q.onFeasted = @(__original) function( _effect )
	{
		local actor = _effect.getContainer().getActor();

		// Switcheroo to prevent the original function from setting the Hitpoints manually
		local oldSetHitpoints = actor.setHitpoints;
		actor.setHitpoints = function(_) {};
		__original(_effect);
		actor.setHitpoints = oldSetHitpoints;

		actor.recoverHitpoints(200, true);
	}
});
