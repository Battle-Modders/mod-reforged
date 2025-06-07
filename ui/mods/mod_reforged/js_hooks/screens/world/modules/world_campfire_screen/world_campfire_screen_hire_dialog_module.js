// This hook adds the ability to toggle between description and perks display for followers
Reforged.Hooks.WorldCampfireScreenHireDialogModule_createDIV = WorldCampfireScreenHireDialogModule.prototype.createDIV;
WorldCampfireScreenHireDialogModule.prototype.createDIV = function (_parentDiv)
{
	Reforged.Hooks.WorldCampfireScreenHireDialogModule_createDIV.call(this, _parentDiv);
	var self = this;
	this.mDetailsPanel.CharacterBackgroundPerksContainer = $("<div class='hire-screen-perks-container'/>")
		.append($("<div class='name title-font-normal font-bold font-color-brother-name'>Perks</div>"))
		.hide()
		.appendTo(this.mDetailsPanel.Container);

	this.mDetailsPanel.mPerksModule = new Reforged.RetinuePerksModule(this.mDetailsPanel.CharacterBackgroundPerksContainer, this.mDataSource);

	this.mDetailsPanel.mModules = [
		this.mDetailsPanel.Container.find(".is-character-container"),
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

Reforged.Hooks.WorldCampfireScreenHireDialogModule_destroyDIV = WorldCampfireScreenHireDialogModule.prototype.destroyDIV
WorldCampfireScreenHireDialogModule.prototype.destroyDIV = function()
{
	this.mDetailsPanel.mPerksModule.destroyDIV();
	this.mDetailsPanel.mPerksModule = null;
	this.mDetailsPanel.CharacterBackgroundPerksContainer.remove();
	this.mDetailsPanel.CharacterBackgroundPerksContainer = null;
	this.mDetailsPanel.ActiveModule = null;
	this.mDetailsPanel.ActiveModuleIdx = 0;

	Reforged.Hooks.WorldCampfireScreenHireDialogModule_destroyDIV.call(this);
}

Reforged.Hooks.WorldCampfireScreenHireDialogModule_updateDetailsPanel = WorldCampfireScreenHireDialogModule.prototype.updateDetailsPanel;
WorldCampfireScreenHireDialogModule.prototype.updateDetailsPanel = function(_element)
{
	Reforged.Hooks.WorldCampfireScreenHireDialogModule_updateDetailsPanel.call(this, _element);
	this.mDetailsPanel.mPerksModule.loadFromData(_element.data('entry').perkTree);
	this.mDetailsPanel.SwitchModuleContainer.bindTooltip({ contentType: 'msu-generic', modId: Reforged.ID, elementId: "HireScreen.DescriptionContainer+1"});
	this.toggleModule(1);
	this.mDetailsPanel.SwitchModuleContainer.show();
}

WorldCampfireScreenHireDialogModule.prototype.toggleModule = function(_idx)
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

WorldCampfireScreenHireDialogModule.prototype.unlockPerk = function(_brotherId, _perkId)
{
    var brotherId = _brotherId;
    if (brotherId === null)
    {
        var selectedBrother = this.mSelectedEntry;
        if (selectedBrother === null || !(CharacterScreenIdentifier.Entity.Id in selectedBrother))
        {
            console.error('ERROR: Failed to unlock perk. No entity selected.');
            return;
        }

        brotherId = selectedBrother[CharacterScreenIdentifier.Entity.Id];
    }

    var self = this;
    this.notifyBackendUnlockPerk(brotherId, _perkId, function (data)
    {
        if (data === undefined || data === null || typeof (data) !== 'object')
        {
            console.error('ERROR: Failed to unlock perk. Invalid data result.');
            return;
        }

        // check if we have an error
        if (ErrorCode.Key in data)
        {
            self.notifyEventListener(ErrorCode.Key, data[ErrorCode.Key]);
        }
        else
        {
            // find the brother and update him
            if (CharacterScreenIdentifier.Entity.Id in data)
            {
                self.loadFromData(data);
                self.selectListEntry(selectedBrother);
            }
            else
            {
                console.error('ERROR: Failed to unlock perk. Invalid data result.');
            }
        }
    });
};

WorldCampfireScreenHireDialogModule.prototype.notifyBackendUnlockPerk = function (_brotherId, _perkId, _callback)
{
    SQ.call(this.mSQHandle, 'onUnlockPerk', [_brotherId, _perkId], _callback);
};
