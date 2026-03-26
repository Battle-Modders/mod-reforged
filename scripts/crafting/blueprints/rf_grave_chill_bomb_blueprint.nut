this.rf_grave_chill_bomb_blueprint <- ::inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.rf_grave_chill_bomb";
		this.m.PreviewCraftable = ::new("scripts/items/tools/rf_grave_chill_bomb_item");
		this.m.Cost = 50;
		local ingredients = [
			{
				Script = "scripts/items/loot/rf_hollenhund_bones_item",
				Num = 1
			},
			{
				Script = "scripts/items/misc/petrified_scream_item",
				Num = 1
			},
			{
				Script = "scripts/items/misc/glistening_scales_item",
				Num = 1
			}
		];
		this.init(ingredients);
	}

	function getName()
	{
		return this.blueprint.getName() + " (x2)";
	}

	function onCraft( _stash )
	{
		_stash.add(::new(::IO.scriptFilenameByHash(this.m.PreviewCraftable.ClassNameHash)));
		_stash.add(::new(::IO.scriptFilenameByHash(this.m.PreviewCraftable.ClassNameHash)));
	}
});
