::Reforged.HooksMod.hook("scripts/ui/screens/world/modules/world_contract_screen/world_active_contract_panel_module", function(q) {
	q.m.SelectionClickedArray <- [];
	q.onActiveContractDetailsClicked <- { function onActiveContractDetailsClicked()
	{
		// A radius this large covers the whole map, whatever its size
		local entities = ::World.getAllEntitiesAtPos(::createVec(0, 0), 1.0e9);
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
				::World.getCamera().moveTo(::World.getEntityByID(entity.getID()));
				return;
			}
		}
	}}.onActiveContractDetailsClicked;

	q.updateContract = @(__original) { function updateContract( _contract = null )
	{
		this.m.SelectionClickedArray.clear();
		return __original(_contract);
	}}.updateContract;

	q.clearContract = @(__original) { function clearContract()
	{
		this.m.SelectionClickedArray.clear();
		return __original();
	}}.clearContract;

	q.onContractCancelled = @(__original) { function onContractCancelled()
	{
		this.m.SelectionClickedArray.clear();
		return __original();
	}}.onContractCancelled;
})
