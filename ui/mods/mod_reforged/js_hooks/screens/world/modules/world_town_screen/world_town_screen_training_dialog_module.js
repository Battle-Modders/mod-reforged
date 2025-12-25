Reforged.Hooks.WorldTownScreenTrainingDialogModule_createTrainingControlDIV= WorldTownScreenTrainingDialogModule.prototype.createTrainingControlDIV;
WorldTownScreenTrainingDialogModule.prototype.createTrainingControlDIV = function(_i, _parentDiv, _entityID, _data, _money)
{
	Reforged.Hooks.WorldTownScreenTrainingDialogModule_createTrainingControlDIV.call(this, _i, _parentDiv, _entityID, _data, _money);
	if (_data.id in [0, 1, 2])
		return;
	var tooltipID = "PerkGroup+" + _data.id;
	var tooltipData = { contentType: 'msu-generic', modId: DynamicPerks.ID, elementId: tooltipID };

	var icon = _parentDiv.find('img.is-icon').last();
	icon.bindTooltip(tooltipData);

	var name = _parentDiv.find('div.is-name').last();
	name.bindTooltip(tooltipData);
}
