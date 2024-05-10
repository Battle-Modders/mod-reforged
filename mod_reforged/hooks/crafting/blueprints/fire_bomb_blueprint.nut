::Reforged.HooksMod.hook("scripts/items/crafting/blueprints/fire_bomb_blueprint", function(q) {
	q.onCraft = @(__original) function( _stash )
	{
		__original(_stash);
		_stash.add(::new("scripts/items/tools/fire_bomb_item")); // crafting gives one additional yield over vanilla
	}
});
