this.rf_pocket_sand_skill <- ::inherit("scripts/skills/actives/throw_dirt_skill", {
	m = {
		// Private
		RemainingUses = 0
	},
	function create()
	{
		this.throw_dirt_skill.create();

		this.m.ID = "actives.rf_pocket_sand_skill";
		this.m.Name = "Throw Pocket Sand";
	}

	function getTooltip()
	{
		local ret = this.throw_dirt_skill.getTooltip();

		if (this.getContainer().getActor().isPlacedOnMap())
		{
			if (this.getRemainingUses() == 0)
			{
				ret.push({
					id = 20,
					type = "text",
					icon = "ui/tooltips/warning.png",
					text = "Remaining uses: " + ::MSU.Text.colorRed("0")
				});
			}
			else
			{
				ret.push({
					id = 20,
					type = "text",
					icon = "ui/icons/special.png",
					text = "Remaining uses: " + ::MSU.Text.colorGreen(this.getRemainingUses())
				});
			}
		}
		else
		{
			ret.push({
				id = 21,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Reforged.Mod.Tooltips.parseString("You have one use for each empty [bag slot|Concept.BagSlots] that you start the battle with")
			});
		}

		return ret;
	}

	function isUsable()
	{
		return this.throw_dirt_skill.isUsable() && this.m.RemainingUses != 0;
	}

	function onCombatStarted()
	{
		this.throw_dirt_skill.onCombatStarted();

		this.m.RemainingUses = this.getMaximumUses();
	}

	function onUse( _user, _targetTile )
	{
		local ret = this.throw_dirt_skill.onUse(_user, _targetTile);

		this.m.RemainingUses = ::Math.max(0, this.m.RemainingUses - 1);

		return ret;
	}

// New Functions
	function getRemainingUses()
	{
		return this.m.RemainingUses;
	}

	function getMaximumUses()
	{
		local itemContainer = this.getContainer().getActor().getItems();
		return itemContainer.getUnlockedBagSlots() - itemContainer.getAllItemsAtSlot(::Const.ItemSlot.Bag).len();
	}
});
