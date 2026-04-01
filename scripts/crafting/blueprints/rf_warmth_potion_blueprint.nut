this.rf_warmth_potion_blueprint <- ::inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.rf_warmth_potion";
		this.m.PreviewCraftable = ::new("scripts/items/accessory/rf_warmth_potion_item");
		this.m.Cost = 250;
		local ingredients = [
			{
				Script = "scripts/items/misc/sulfurous_rocks_item",
				Num = 1
			},
			{
				Script = "scripts/items/misc/serpent_skin_item",
				Num = 1
			},
			{
				Script = "scripts/items/loot/rf_hollenhund_bones_item",
				Num = 1
			}
		];
		this.init(ingredients);
	}

	function onCraft( _stash )
	{
		_stash.add(::new(::IO.scriptFilenameByHash(this.m.PreviewCraftable.ClassNameHash)));
	}
});
