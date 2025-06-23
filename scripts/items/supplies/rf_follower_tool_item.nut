this.rf_follower_tool_item <- this.inherit("scripts/items/item", {
	m = {
		Amount = 0,
		FollowerTypeID = "generic",
		BaseName = "Follower Tools (%s)"
		FollowerTypeName = "Follower Tools (Generic)",
		BaseImgPath = "supplies/follower/rf_follower_tool.",
	},

	function create()
	{
		this.item.create();
		this.m.ID = "supplies.rf_follower_tool";
		this.m.SlotType = this.Const.ItemSlot.None;
		this.m.ItemType = this.Const.Items.ItemType.Supply;
		this.m.Amount = 0;
		this.m.IsDroppedAsLoot = true;
		this.m.IsChangeableInBattle = false;
		this.updateIconPath();
	}

	function isAmountShown()
	{
		return true;
	}

	function updateIconPath()
	{
		this.m.Icon = this.m.BaseImgPath + this.m.FollowerTypeID + ".70x70.png";
	}

	function getAmount()
	{
		return this.m.Amount;
	}

	function getAmountString()
	{
		return this.m.Amount;
	}

	function setAmount( _a )
	{
		this.m.Amount = _a;
	}

	function getFollowerTypeID()
	{
		return this.m.FollowerTypeID;
	}

	function setFollowerType(_type)
	{
		local typeName = "Generic";
		if (_type != "generic")
		{
			local followerTypeExists = false;
			foreach(follower in ::World.Retinue.m.Followers)
			{
				if (follower.getID() == _type)
				{
					followerTypeExists = true;
					typeName = follower.getName();
					break;
				}
			}
			if (!followerTypeExists)
			{
				// TODO Change to MSU popup
				::logError("Reforged: Tried to set rf_follower_tool_item to follower id which does not exist, defaulting to generic: " _type);
				_type = "generic";
			}
		}
		this.m.FollowerTypeID = _type;
		this.m.FollowerTypeName = format(this.m.BaseName, typeName);
		this.updateIconPath();
	}

	function getName()
	{
		return this.m.FollowerTypeName;
	}

})
