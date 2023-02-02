// This hook adds the ability to toggle between description and perks display for hires in the crowd building
Reforged.Hooks.WorldTownScreenHireDialogModule_createDIV = WorldTownScreenHireDialogModule.prototype.createDIV;
WorldTownScreenHireDialogModule.prototype.createDIV = function (_parentDiv)
{
	Reforged.Hooks.WorldTownScreenHireDialogModule_createDIV.call(this, _parentDiv);
	//perkGroups

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
		this.mDetailsPanel.CharacterBackgroundPerksContainer,
	];
	$.each(this.mDetailsPanel.mModules, $.proxy(function(_idx, _module)
	{
		_module.on("click", this.toggleModuleIfValid.bind(this));
	}, this));
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
		this.toggleModule(0);
	else
	{
		this.mDetailsPanel.mPerksModule.loadFromData(_element.data('entry').perkTree);
		this.mDetailsPanel.mPerkGroupsModule.loadFromData(_element.data('entry').perkGroupsOrdered);
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
	}
}
