Reforged.Hooks.WorldTownScreenTrainingDialogModule_createTrainingControlDIV= WorldTownScreenTrainingDialogModule.prototype.createTrainingControlDIV;
WorldTownScreenTrainingDialogModule.prototype.createTrainingControlDIV = function(_i, _parentDiv, _entityID, _data, _money)
{
	console.error("createTrainingControlDIV")
	Reforged.Hooks.WorldTownScreenTrainingDialogModule_createTrainingControlDIV.call(_i, _parentDiv, _entityID, _data, _money);
	if (_data.id in [0, 1, 2])
		return;
	var tooltipID = "PerkGroup+" + _data.id;
	var tooltipData = { contentType: 'msu-generic', modId: DynamicPerks.ID, elementId: tooltipID };

	var icon = _parentDiv.find('img.is-icon');
	console.error("icon len " + icon.length)
	icon.bindTooltip(tooltipData);

	var name = _parentDiv.find('div.is-name');
	console.error("name len " + name.length)
	name.bindTooltip(tooltipData);
}
