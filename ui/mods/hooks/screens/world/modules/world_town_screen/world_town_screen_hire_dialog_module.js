// This hook adds the ability to toggle between description and perks display for hires in the crowd building
var createDIV = WorldTownScreenHireDialogModule.prototype.createDIV;
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

var destroyDIV = WorldTownScreenHireDialogModule.prototype.destroyDIV
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

WorldTownScreenHireDialogModule.prototype.toggleModule = function()
{
	this.mDetailsPanel.ActiveModule.hide();

	this.mDetailsPanel.ActiveModuleIdx++;
	if (this.mDetailsPanel.ActiveModuleIdx > this.mDetailsPanel.mModules.length - 1)
		this.mDetailsPanel.ActiveModuleIdx = 0;

	this.mDetailsPanel.ActiveModule = this.mDetailsPanel.mModules[this.mDetailsPanel.ActiveModuleIdx];
	this.mDetailsPanel.ActiveModule.show();
}

var selectListEntry = WorldTownScreenHireDialogModule.prototype.selectListEntry;
WorldTownScreenHireDialogModule.prototype.selectListEntry = function(_element, _scrollToEntry)
{
	selectListEntry.call(this, _element, _scrollToEntry)
	if (_element === null || _element.length === 0)
		return;
	// Via data_helper, the recruits now also get their perkTree
	this.mDetailsPanel.mPerksModule.loadFromData(_element.data('entry').perkTree);
}

