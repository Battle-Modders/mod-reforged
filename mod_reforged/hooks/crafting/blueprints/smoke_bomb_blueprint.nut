::Reforged.HooksMod.hook("scripts/crafting/blueprints/smoke_bomb_blueprint", function(q) {
	q.getName = @(__original) { function getName()
	{
		return __original() + " (x2)";	// We adjust the name of the recipe to communicate that you receive two of them
	}}.getName;

	q.onCraft = @(__original) { function onCraft( _stash )
	{
		__original(_stash);
		_stash.add(::new(::IO.scriptFilenameByHash(this.m.PreviewCraftable.ClassNameHash))); // crafting gives one additional yield over vanilla
	}}.onCraft;
});
