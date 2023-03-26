this.rf_ayahuasca_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.rf_ayahuasca";
		this.m.PreviewCraftable = ::new("scripts/items/consumable/rf_ayahuasca");
		this.m.Cost = 350;
		local ingredients = [
			{
				Script = "scripts/items/misc/mysterious_herbs_item",
				Num = 1
			},
			{
				Script = "scripts/items/misc/poison_gland_item",
				Num = 1
			}
		];
		this.init(ingredients);
	}

	function onCraft( _stash )
	{
		_stash.add(::new("scripts/items/consumable/rf_ayahuasca"));
	}

});

