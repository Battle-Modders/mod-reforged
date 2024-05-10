::Reforged.HooksMod.hook("scripts/items/crafting/blueprints/acid_flask_blueprint", function(q) {
	q.onCraft = @(__original) function( _stash )
	{
		__original(_stash);
		_stash.add(::new("scripts/items/tools/acid_flask_item")); // crafting gives one additional yield over vanilla
	}
});
