::mods_hookExactClass("ambitions/ambitions/battle_standard_ambition", function(o) {

	local create = o.create;
	o.create = function()
	{
		create();
		this.m.ButtonText = "We need a battle standard so that we\'re recognized from afar!\nBuying one is costly, so we shall gather wood, cloth and dye to make one ourselves.";
		this.m.UIText = "Have one Quality Wood, one Cloth Rolls and one Dyes"
		this.m.TooltipText = "Gather one Quality Wood, one Cloth Rolls and one Dyes to craft your very-own battle standard for the company. You can buy these ingredients from settlements or find them randomly by looting camps and ruins.";
	}

	// replace vanilla function as we completely redo the conditions
	o.onCheckSuccess = function()
	{
		local stash = ::World.Assets.getStash().getItems();

		local foundWood = false;
		local foundCloth = false;
		local foundDye = false;
		foreach( item in stash )	// this is a enormous check compared to all other ambitions which could slow down the game alot while this ambition is active but not completed
		{
			if (item == null) continue;
			if (!foundWood && item.getID() == "misc.quality_wood") foundWood = true;
			if (!foundCloth && item.getID() == "misc.cloth_rolls") foundCloth = true;
			if (!foundDye && item.getID() == "misc.dies") foundDye = true;
		}

		return (foundWood && foundCloth && foundDye);
	}

	// replace vanilla function as we completely redo the reward system
	o.onReward = function()
	{
		local removedWood = false;
		local removedCloth = false;
		local removedDye = false;

		local items = ::World.Assets.getStash().getItems();
		foreach (i, item in items)
		{
			if (!removedWood && item.getID() == "misc.quality_wood")
			{
				this.m.SuccessList.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You lose " + ::Const.Strings.getArticle(item.getName()) + item.getName()
				});
				items[i] = null;
				removedWood = true;
			}
			else if (!removedCloth && item.getID() == "misc.cloth_rolls")
			{
				this.m.SuccessList.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You lose " + ::Const.Strings.getArticle(item.getName()) + item.getName()
				});
				items[i] = null;
				removedCloth = true;
			}
			else if (!removedDye && item.getID() == "misc.dies")
			{
				this.m.SuccessList.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "You lose " + ::Const.Strings.getArticle(item.getName()) + item.getName()
				});
				items[i] = null;
				removedDye = true;
			}
		}

		local item = this.new("scripts/items/tools/player_banner");
		item.setVariant(::World.Assets.getBannerID());
		::World.Assets.getStash().add(item);
		this.m.SuccessList.push({
			id = 10,
			icon = "ui/items/" + item.getIcon(),
			text = "You gain " + this.Const.Strings.getArticle(item.getName()) + item.getName()
		});
	}
});
