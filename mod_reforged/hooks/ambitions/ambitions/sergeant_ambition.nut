::mods_hookExactClass("ambitions/ambitions/sergeant_ambition", function(o) {

	local create = o.create;
	o.create = function()
	{
		create();
		this.m.ButtonText = "We fight well, but we need to be better organized in case things get dire.\nWe shall gather cloth and dye to make a sash and name a sergeant to wear it.";
		this.m.UIText = "Have \'Cloth Rolls\', \'Dyes\' and \'Rally the Troops\' perk";
		this.m.TooltipText = "Gather one Cloth Rolls and one Dyes to craft your first Sergeant Sash for the company. You can buy these ingredients from settlements or find them randomly by looting camps and ruins.";
	}

	// replace vanilla function as we completely redo the conditions
	o.onCheckSuccess = function()
	{
		local stash = ::World.Assets.getStash().getItems();

		local foundCloth = false;
		local foundDye = false;
		foreach( item in stash )	// this is a enormous check compared to all other ambitions which could slow down the game alot while this ambition is active but not completed
		{
			if (item == null) continue;
			if (!foundCloth && item.getID() == "misc.cloth_rolls") foundCloth = true;
			if (!foundDye && item.getID() == "misc.dies") foundDye = true;
		}

		if (!foundCloth) return false;
		if (!foundDye) return false;

		local brothers = ::World.getPlayerRoster().getAll();
		foreach (bro in brothers)
		{
			if (bro.getSkills().hasSkill("perk.rally_the_troops"))
			{
				return true;
			}
		}
		return false;
	}

	// replace vanilla function as we completely redo the reward system
	o.onReward = function()
	{
		local removedCloth = false;
		local removedDye = false;

		local items = ::World.Assets.getStash().getItems();
		foreach (i, item in items)
		{
			if (!removedCloth && item.getID() == "misc.cloth_rolls")
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

		local item = ::new("scripts/items/accessory/sergeant_badge_item");
		::World.Assets.getStash().add(item);
		this.m.SuccessList.push({
			id = 10,
			icon = "ui/items/" + item.getIcon(),
			text = "You gain " + ::Const.Strings.getArticle(item.getName()) + item.getName()
		});
	}
});
