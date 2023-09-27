::Reforged.HooksMod.hook("scripts/ui/screens/world/modules/world_contract_screen/world_active_contract_panel_module", function(q) {
	q.m.SelectionClickedArray <- [];
	q.onActiveContractDetailsClicked <- function()
	{
		// Map size: 140 x 170 tiles
		// This does not translate entirely to the Pos style distances, but 25000 radius covers the whole map
		local centerTile = this.World.getTileSquare(70, 85);
		local entities = this.World.getAllEntitiesAtPos(centerTile, 25000);
		local markedEntites = entities.filter(function(_idx, _entity){
			return _entity.getSprite("selection").Visible && _entity.isDiscovered();
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

	q.updateContract = @(__original) function( _contract = null )
	{
		this.m.SelectionClickedArray.clear();
		return __original(_contract);
	}

	q.clearContract = @(__original) function()
	{
		this.m.SelectionClickedArray.clear();
		return __original();
	}

	q.onContractCancelled = @(__original) function()
	{
		this.m.SelectionClickedArray.clear();
		return __original();
	}
})
