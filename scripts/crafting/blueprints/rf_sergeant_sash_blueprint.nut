this.rf_sergeant_sash_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.sergeant_sash";
		this.m.PreviewCraftable = ::new("scripts/items/accessory/sergeant_badge_item");
		this.m.Cost = 500;
		local ingredients = [
			{
				Script = "scripts/items/trade/cloth_rolls_item",
				Num = 1
			},
			{
				Script = "scripts/items/trade/dies_item",
				Num = 1
			}
		];
		this.init(ingredients);
	}

	function onCraft( _stash )
	{
		local item = ::new("scripts/items/accessory/sergeant_badge_item");
		_stash.add(item);
	}

	function isCraftable()
	{
		if (::World.Ambitions.getAmbition("ambition.sergeant").isDone() == false) return false;

		return this.blueprint.isCraftable();
	}

});

