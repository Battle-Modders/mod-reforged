this.rf_forgetfulness_potion_blueprint <- ::inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.rf_forgetfulness_potion";
		this.m.PreviewCraftable = ::new("scripts/items/consumable/rf_forgetfulness_potion");
		this.m.Cost = 500;

		local ingredients = [
			{
				Script = "scripts/items/loot/rf_geist_tear_item",
				Num = 1
			},
			{
				Script = "scripts/items/misc/vampire_dust_item",
				Num = 1
			}
		];
		this.init(ingredients);
	}

	function onCraft( _stash )
	{
		_stash.add(::new("scripts/items/consumable/rf_forgetfulness_potion"));
	}

});
