this.rf_dodge_potion_blueprint <- ::inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.rf_dodge_potion";
		this.m.PreviewCraftable = ::new("scripts/items/accessory/rf_dodge_potion_item");
		this.m.Cost = 250;
		local ingredients = [
			{
				Script = "scripts/items/loot/rf_geist_tear_item",
				Num = 2
			}
		];
		this.init(ingredients);
	}

	function onCraft( _stash )
	{
		_stash.add(::new(::IO.scriptFilenameByHash(this.m.PreviewCraftable.ClassNameHash)));
	}
});
