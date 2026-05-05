Reforged.Hooks.WorldTownScreenTravelDialogModule_addListEntry = WorldTownScreenTravelDialogModule.prototype.addListEntry;
WorldTownScreenTravelDialogModule.prototype.addListEntry = function (_data)
{
	var result = Reforged.Hooks.WorldTownScreenTravelDialogModule_addListEntry.call(this, _data);

	// Add tooltip to settlement's image.
	var entry = this.mListScrollContainer.find('.list-entry').last();
	var image = entry.find('.column.is-left img:first');
	image.bindTooltip({ contentType: 'msu-generic', modId: Reforged.MSUID, elementId: 'WorldEntity+' + _data.ID });

	// Add tooltip to owner faction's banner.
	if (_data['FactionImagePath'] !== null && 'RF_OwnerID' in _data && _data.RF_OwnerID !== null)
	{
		image = entry.find('.column.is-right img:first');
		image.bindTooltip({ contentType: 'msu-generic', modId: Reforged.ID, elementId: 'Faction+' + _data.RF_OwnerID });
	}

	return result;
}

Reforged.Hooks.WorldTownScreenTravelDialogModule_updateDetailsPanel = WorldTownScreenTravelDialogModule.prototype.updateDetailsPanel;
WorldTownScreenTravelDialogModule.prototype.updateDetailsPanel = function (_element)
{
	Reforged.Hooks.WorldTownScreenTravelDialogModule_updateDetailsPanel.call(this, _element);

	if (_element !== null && _element.length > 0)
	{
		// Add tooltip to settlement's image.
		var data = _element.data('entry');
		this.mDetailsPanel.DestinationImage.bindTooltip({ contentType: 'msu-generic', modId: Reforged.MSUID, elementId: 'WorldEntity+' + data.ID });
	}
}
