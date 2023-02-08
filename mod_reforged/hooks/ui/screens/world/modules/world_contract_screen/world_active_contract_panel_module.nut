::mods_hookExactClass("ui/screens/world/modules/world_contract_screen/world_active_contract_panel_module", function(o){
	o.m.SelectionClickedArray <- [];
	o.onActiveContractDetailsClicked <- function()
	{
		// Map size: 140 x 170 tiles
		// This does not translate entirely to the Pos style distances, but 25000 radius covers the whole map
		local centerTile = this.World.getTileSquare(70, 85);
		local entities = this.World.getAllEntitiesAtPos(centerTile, 25000);
		local markedEntites = entities.filter(function(_idx, _entity){
			return _entity.getSprite("selection").Visible;
		})
		// Reset if we clicked through them all
		if (this.m.SelectionClickedArray.len() == markedEntites.len())
			this.m.SelectionClickedArray.clear();

		foreach (entity in markedEntites)
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
