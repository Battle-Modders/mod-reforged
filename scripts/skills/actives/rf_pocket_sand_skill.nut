this.rf_pocket_sand_skill <- this.inherit("scripts/skills/actives/throw_dirt_skill", {
	m = {
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

		if (this.getContainer().getActor().isPlacedOnMap() == false)
		{
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "You have one use for each empty bag slot that you start the battle with"
			})
		}

		if (this.m.RemainingUses == 0)
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "Remaining uses: " + ::MSU.Text.colorRed("0")
			})
		}
		else
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Remaining uses: " + ::MSU.Text.colorGreen(this.m.RemainingUses)
			})
		}

		return ret;
	}

	function isUsable()
	{
		return (this.throw_dirt_skill.isUsable() && this.m.RemainingUses != 0);
	}

	function onCombatStarted()
	{
		this.throw_dirt_skill.onCombatStarted();

		this.m.RemainingUses = this.getMaximumUses();
	}

	function onUse( _user, _targetTile )
	{
		this.throw_dirt_skill.onUse(_user, _targetTile);

		this.m.RemainingUses = ::Math.max(0, this.m.RemainingUses - 1);
	}

// New Functions
	function getRemainingUses()
	{
		if (this.getContainer().getActor().isPlacedOnMap())
		{
			return this.m.RemainingUses;
		}
		else	// This way the skill will give better feedback while outside of combat
		{
			return this.getMaximumUses();
		}
	}

	function getMaximumUses()
	{
		local itemContainer = this.getContainer().getActor().getItems();
		return itemContainer.getUnlockedBagSlots() - itemContainer.getAllItemsAtSlot(::Const.ItemSlot.Bag);
	}
});
