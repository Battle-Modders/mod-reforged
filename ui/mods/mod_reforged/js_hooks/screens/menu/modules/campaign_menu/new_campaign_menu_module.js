Reforged.Hooks.NewCampaignMenuModule_createDIV = NewCampaignMenuModule.prototype.createDIV;
NewCampaignMenuModule.prototype.createDIV = function (_parentDiv)
{
	Reforged.Hooks.NewCampaignMenuModule_createDIV.call(this, _parentDiv);
	var column = this.mScenariosDesc.parent();
	var desc = this.mScenariosDesc.detach();
	var listContainerLayout = $('<div class="l-list-container"/>');
	column.append(listContainerLayout);
	var listContainer = listContainerLayout.createList(5, null, true);
	var scrollContainer = listContainer.findListScrollContainer();
	scrollContainer.append(desc);
}
