// Adds an entityId entry into the tooltip query calls for attributes
Reforged.Hooks.CharacterScreenStatsModule_setProgressbarValues = CharacterScreenStatsModule.prototype.setProgressbarValues;
CharacterScreenStatsModule.prototype.setProgressbarValues = function (_data)
{
	Reforged.Hooks.CharacterScreenStatsModule_setProgressbarValues.call(this, _data);
	this.setProgressbarValue(this.mLeftStatsRows.Morale.Progressbar, _data, ProgressbarValueIdentifier.rf_Reach, ProgressbarValueIdentifier.rf_ReachMax, ProgressbarValueIdentifier.rf_ReachLabel);

	var selectedBrother = this.mDataSource.getSelectedBrother();
	if (selectedBrother === null) return;

	// We replace the static vanilla tooltipsEvents. The difference is that we also push the 'entityId: entityID' inside so that the tooltips on squirrel side can reference the respective entity
	this.removeEventHandler();
	var entityID = selectedBrother[CharacterScreenIdentifier.Entity.Id];
	$.each(this.mLeftStatsRows, function (_key, _value)
	{
		if (_value.TooltipId == "character-stats.Morale")
		{
			_value.Row.bindTooltip({ entityId: entityID, contentType: 'msu-generic', elementId: "Concept.Reach", modId: Reforged.ID });
		}
		else
		{
			_value.Row.bindTooltip({ entityId: entityID, contentType: 'ui-element', elementId: _value.TooltipId });
		}
	});

	$.each(this.mMiddleStatsRows, function (_key, _value)
	{
		_value.Row.bindTooltip({ entityId: entityID, contentType: 'ui-element', elementId: _value.TooltipId });
	});
}

Reforged.Hooks.CharacterScreenStatsModule_createDIV = CharacterScreenStatsModule.prototype.createDIV;
CharacterScreenStatsModule.prototype.createDIV = function (_parentDiv)
{
	this.mLeftStatsRows["Morale"].IconPath  = Path.GFX + Asset.rf_Reach;
	this.mLeftStatsRows["Morale"].StyleName = ProgressbarStyleIdentifier.rf_Reach;
	Reforged.Hooks.CharacterScreenStatsModule_createDIV.call(this, _parentDiv);
}
