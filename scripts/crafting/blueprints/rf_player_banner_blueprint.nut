this.rf_player_banner_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.ID = "blueprint.player_banner";
		this.m.PreviewCraftable = ::new("scripts/items/tools/player_banner");
		this.m.Cost = 500;
		local ingredients = [
			{
				Script = "scripts/items/trade/quality_wood_item",
				Num = 1
			},
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
		local item = ::new("scripts/items/tools/player_banner");
		item.setVariant(::World.Assets.getBannerID());
		_stash.add(item);
	}

	function isCraftable()
	{
		if (::World.Ambitions.getAmbition("ambition.make_nobles_aware").isDone() == false) return false;

		return this.blueprint.isCraftable();
	}

});

