// TODO implement "current location known" with name or not (influenced by visiting town, rumors)

// This hook adds the ability to toggle between description and perks display for hires in the crowd building
Reforged.Hooks.WorldTownScreenHireDialogModule_createDIV = WorldTownScreenHireDialogModule.prototype.createDIV;
WorldTownScreenHireDialogModule.prototype.createDIV = function (_parentDiv)
{
	Reforged.Hooks.WorldTownScreenHireDialogModule_createDIV.call(this, _parentDiv);
	var self = this;
	this.mDetailsPanel.CharacterBackgroundPerksContainer = $("<div class='hire-screen-perks-container'/>")
		.append($("<div class='name title-font-normal font-bold font-color-brother-name'>Perks</div>"))
		.hide()
		.appendTo(this.mDetailsPanel.Container);

	this.mDetailsPanel.CharacterBackgroundPerkGroupsContainer = $("<div class='hire-screen-perkgroups-container'/>")
		.append($("<div class='name title-font-normal font-bold font-color-brother-name'>Perk Groups</div>"))
		.hide()
		.appendTo(this.mDetailsPanel.Container);

	this.mDetailsPanel.mPerksModule = new DynamicPerks.GenericPerksModule(this.mDetailsPanel.CharacterBackgroundPerksContainer);
	this.mDetailsPanel.mPerkGroupsModule = new DynamicPerks.GenericPerkGroupsModule(this.mDetailsPanel.CharacterBackgroundPerkGroupsContainer, 1);

	this.mDetailsPanel.mModules = [
		this.mDetailsPanel.Container.find(".is-character-container"), // The character icon, description etc that will be hidden
		this.mDetailsPanel.CharacterBackgroundPerkGroupsContainer,
		this.mDetailsPanel.CharacterBackgroundPerksContainer
	];
	this.mDetailsPanel.SwitchModuleContainer = $("<div class='hire-screen-switch-module-container'/>")
		.hide()
		.appendTo(this.mDetailsPanel.Container);
	this.mDetailsPanel.SwitchModuleButton = this.mDetailsPanel.SwitchModuleContainer.createImageButton(Path.GFX + Asset.BUTTON_PLAY, function ()
	{
		self.toggleModuleIfValid();
	}, '', 6);
	this.mDetailsPanel.ActiveModule = this.mDetailsPanel.mModules[0];
	this.mDetailsPanel.ActiveModuleIdx = 0;
}

Reforged.Hooks.WorldTownScreenHireDialogModule_destroyDIV = WorldTownScreenHireDialogModule.prototype.destroyDIV
WorldTownScreenHireDialogModule.prototype.destroyDIV = function()
{
	this.mDetailsPanel.mPerksModule.destroyDIV();
	this.mDetailsPanel.mPerksModule = null;
	this.mDetailsPanel.CharacterBackgroundPerksContainer.remove();
	this.mDetailsPanel.CharacterBackgroundPerksContainer = null;
	this.mDetailsPanel.ActiveModule = null;
	this.mDetailsPanel.ActiveModuleIdx = 0;

	Reforged.Hooks.WorldTownScreenHireDialogModule_destroyDIV.call(this);
}

Reforged.Hooks.WorldTownScreenHireDialogModule_updateDetailsPanel = WorldTownScreenHireDialogModule.prototype.updateDetailsPanel;
WorldTownScreenHireDialogModule.prototype.updateDetailsPanel = function(_element)
{
	Reforged.Hooks.WorldTownScreenHireDialogModule_updateDetailsPanel.call(this, _element);
	if (!this.checkToggleModule())
	{
		this.mDetailsPanel.SwitchModuleContainer.unbindTooltip();
		this.toggleModule(0);
		this.mDetailsPanel.SwitchModuleContainer.hide();
	}
	else
	{
		this.mDetailsPanel.mPerksModule.loadFromData(_element.data('entry').perkTree);
		this.mDetailsPanel.mPerkGroupsModule.loadFromData(_element.data('entry').perkGroupsOrdered);
		this.mDetailsPanel.SwitchModuleContainer.bindTooltip({ contentType: 'msu-generic', modId: Reforged.ID, elementId: "HireScreen.DescriptionContainer+1"});
		this.toggleModule(1);
		this.mDetailsPanel.SwitchModuleContainer.show();
	}
}

WorldTownScreenHireDialogModule.prototype.checkToggleModule = function()
{
	if (this.mSelectedEntry === null || !this.mSelectedEntry.data('entry').IsTryoutDone)
		return false;
	return true;
}

WorldTownScreenHireDialogModule.prototype.toggleModuleIfValid = function()
{
	if (this.checkToggleModule())
		this.toggleModule();
}

WorldTownScreenHireDialogModule.prototype.toggleModule = function(_idx)
{
	var oldIdx = this.mDetailsPanel.ActiveModuleIdx;
	this.mDetailsPanel.ActiveModuleIdx = _idx === undefined ? this.mDetailsPanel.ActiveModuleIdx + 1 : _idx;
	if (this.mDetailsPanel.ActiveModuleIdx > this.mDetailsPanel.mModules.length - 1)
		this.mDetailsPanel.ActiveModuleIdx = 0;

	if (oldIdx != this.mDetailsPanel.ActiveModuleIdx)
	{
		this.mDetailsPanel.ActiveModule.hide();
		this.mDetailsPanel.ActiveModule = this.mDetailsPanel.mModules[this.mDetailsPanel.ActiveModuleIdx];
		this.mDetailsPanel.ActiveModule.show();
		this.mDetailsPanel.SwitchModuleContainer.updateTooltip({ contentType: 'msu-generic', modId: Reforged.ID, elementId: "HireScreen.DescriptionContainer+" + this.mDetailsPanel.ActiveModuleIdx});
	}
}
