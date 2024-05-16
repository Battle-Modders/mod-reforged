::Reforged.HooksMod.hook("scripts/crafting/blueprints/daze_bomb_blueprint", function(q) {
	q.onCraft = @(__original) function( _stash )
	{
		__original(_stash);
		_stash.add(::new(::IO.scriptFilenameByHash(this.m.PreviewCraftable.ClassNameHash))); // crafting gives one additional yield over vanilla
	}
});
