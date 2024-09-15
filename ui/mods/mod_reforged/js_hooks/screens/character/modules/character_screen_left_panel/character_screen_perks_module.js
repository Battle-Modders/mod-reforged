// This hook adds the ability to toggle to a display by perk groups in the perks screen
Reforged.Hooks.CharacterScreenPerksModule_createDIV = CharacterScreenPerksModule.prototype.createDIV;
CharacterScreenPerksModule.prototype.createDIV = function (_parentDiv)
{
	var self = this;
	Reforged.Hooks.CharacterScreenPerksModule_createDIV.call(this, _parentDiv);
	this.mContainer.SwitchModuleContainer = $("<div class='perks-screen-switch-module-container'/>")
		.hide()
		.appendTo(this.mContainer);
	this.mContainer.SwitchModuleContainer.bindTooltip({ contentType: 'msu-generic', modId: Reforged.ID, elementId: "HireScreen.DescriptionContainer+0"}); // re-use text from hire screen
	this.mContainer.SwitchModuleButton = this.mContainer.SwitchModuleContainer.createImageButton(Path.GFX + Asset.BUTTON_PLAY, function ()
	{
		self.toggleModule();
	}, '', 6);

	this.mContainer.CharacterBackgroundPerkGroupsContainer = $("<div class='perks-screen-perkgroups-container'/>")
		.append($("<div class='name title-font-normal font-bold font-color-brother-name'>Perk Groups</div>"))
		.hide()
		.appendTo(this.mContainer);

	this.mPerkGroupsModule = new DynamicPerks.GenericPerkGroupsModule(this.mContainer.CharacterBackgroundPerkGroupsContainer, 1);

	this.mModules = [
		this.mLeftColumn,
		this.mContainer.CharacterBackgroundPerkGroupsContainer,
	];
	var self = this;
	this.mActiveModule = this.mModules[0];
}


Reforged.Hooks.CharacterScreenPerksModule_show = CharacterScreenPerksModule.prototype.show;
CharacterScreenPerksModule.prototype.show = function ()
{
	Reforged.Hooks.CharacterScreenPerksModule_show.call(this);
	this.mContainer.SwitchModuleContainer.show();
}

Reforged.Hooks.CharacterScreenPerksModule_hide = CharacterScreenPerksModule.prototype.hide;
CharacterScreenPerksModule.prototype.hide = function ()
{
	Reforged.Hooks.CharacterScreenPerksModule_hide.call(this);
	this.mContainer.SwitchModuleContainer.hide();
}

CharacterScreenPerksModule.prototype.toggleModule = function(_idx)
{
	var idx = this.mActiveModule == this.mModules[0] ? 1 : 0;
	var newModule = this.mModules[idx];
	this.mContainer.SwitchModuleContainer.updateTooltip({ contentType: 'msu-generic', modId: Reforged.ID, elementId: "HireScreen.DescriptionContainer+" + idx});

	this.mActiveModule.hide();
	this.mActiveModule = newModule;
	this.mActiveModule.show();
}

Reforged.Hooks.CharacterScreenPerksModule_loadPerkTreesWithBrotherData = CharacterScreenPerksModule.prototype.loadPerkTreesWithBrotherData;
CharacterScreenPerksModule.prototype.loadPerkTreesWithBrotherData = function (_brother)
{
	Reforged.Hooks.CharacterScreenPerksModule_loadPerkTreesWithBrotherData.call(this, _brother);
	this.mPerkGroupsModule.loadFromData(_brother.perkGroupsOrdered);
};
