// This hook adds the ability to toggle between description and perks display for hires in the crowd building
Reforged.WorldTownScreenHireDialogModule_createDIV = WorldTownScreenHireDialogModule.prototype.createDIV;
WorldTownScreenHireDialogModule.prototype.createDIV = function (_parentDiv)
{
	createDIV.call(this, _parentDiv);
	var self = this;
	var toggleFunction = function(_e)
	{
		if (self.checkToggleModule())
			self.toggleModule()
	}

	this.mDetailsPanel.CharacterBackgroundPerksContainer = $("<div class='hire-screen-perks-container'/>")
		.appendTo(this.mDetailsPanel.Container)
	this.mDetailsPanel.mPerksModule = new GenericPerksModule(this.mDetailsPanel.CharacterBackgroundPerksContainer);

	var characterDetailsContainer = this.mDetailsPanel.Container.find(".is-character-container"); // The character icon, description etc that will be hidden

	characterDetailsContainer.on("click", toggleFunction);
	this.mDetailsPanel.CharacterBackgroundPerksContainer.on("click", toggleFunction);

	this.mDetailsPanel.mModules = [
		characterDetailsContainer,
		this.mDetailsPanel.CharacterBackgroundPerksContainer
	]
	this.mDetailsPanel.ActiveModule = this.mDetailsPanel.mModules[0]
	this.mDetailsPanel.ActiveModuleIdx = 0
}

Reforged.WorldTownScreenHireDialogModule_destroyDIV = WorldTownScreenHireDialogModule.prototype.destroyDIV
WorldTownScreenHireDialogModule.prototype.destroyDIV = function()
{
	this.mDetailsPanel.mPerksModule.destroyDIV();
	this.mDetailsPanel.mPerksModule = null;
	this.mDetailsPanel.CharacterBackgroundPerksContainer.empty();
	this.mDetailsPanel.CharacterBackgroundPerksContainer.remove();
	this.mDetailsPanel.CharacterBackgroundPerksContainer = null;
	this.mDetailsPanel.ActiveModule = null
	this.mDetailsPanel.ActiveModuleIdx = 0

	destroyDIV.call(this)
}

WorldTownScreenHireDialogModule.prototype.checkToggleModule = function()
{
	if (this.mSelectedEntry === null || !this.mSelectedEntry.data('entry').IsTryoutDone)
		return false;
	return true;
}
WorldTownScreenHireDialogModule.prototype.toggleModule = function(_idx)
{
	if (_idx !== undefined)
	{
		this.mDetailsPanel.ActiveModuleIdx = _idx;
	}
	else
	{
		this.mDetailsPanel.ActiveModuleIdx++;
		if (this.mDetailsPanel.ActiveModuleIdx > this.mDetailsPanel.mModules.length - 1)
			this.mDetailsPanel.ActiveModuleIdx = 0;
	}

	this.mDetailsPanel.ActiveModule.hide();
	this.mDetailsPanel.ActiveModule = this.mDetailsPanel.mModules[this.mDetailsPanel.ActiveModuleIdx];
	this.mDetailsPanel.ActiveModule.show();
}

Reforged.WorldTownScreenHireDialogModule_updateDetailsPanel = WorldTownScreenHireDialogModule.prototype.updateDetailsPanel;
WorldTownScreenHireDialogModule.prototype.updateDetailsPanel = function(_element)
{
	updateDetailsPanel.call(this, _element);
	if (!this.checkToggleModule())
		this.toggleModule(0);
	else
		this.mDetailsPanel.mPerksModule.loadFromData(_element.data('entry').perkTree);
}
