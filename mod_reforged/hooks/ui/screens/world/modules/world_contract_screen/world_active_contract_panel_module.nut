::mods_hookExactClass("ui/screens/world/modules/world_contract_screen/world_active_contract_panel_module", function(o)
{
	o.m.SelectionClickedArray <- [];
	o.onActiveContractDetailsClicked <- function()
	{
		local contract = this.World.Contracts.getActiveContract();
		local markedEntites = [];
		local addEligibleMembers;
		addEligibleMembers = function(_obj)
		{
			if (::MSU.isBBObject(_obj) && _obj.getSprite("selection").Visible)
			{
				markedEntites.push(_obj);
			}
			else if (typeof _obj == "table" || typeof _obj == "array")
			{
				foreach(key, value in _obj)
					addEligibleMembers(value);
			}
		}
		addEligibleMembers(contract.m);
		if (markedEntites.len() == 0)
			return;
		if (this.m.SelectionClickedArray.len() == markedEntites.len())
		{
			this.m.SelectionClickedArray.clear();
		}
		foreach(idx, entity in markedEntites)
		{
			if (this.m.SelectionClickedArray.find(entity.getID()) == null)
			{
				this.m.SelectionClickedArray.push(entity.getID());
				this.World.getCamera().moveTo(this.World.getEntityByID(entity.getID()));
				return;
			}
		}
	}

	local updateContract = o.updateContract;
	o.updateContract = function(_contract = null)
	{
		this.m.SelectionClickedArray.clear();
		return updateContract(_contract);
	}

	local clearContract = o.clearContract;
	o.clearContract = function()
	{
		this.m.SelectionClickedArray.clear();
		return clearContract();
	}

	local onContractCancelled = o.onContractCancelled;
	o.onContractCancelled = function()
	{
		this.m.SelectionClickedArray.clear();
		return onContractCancelled();
	}
})
