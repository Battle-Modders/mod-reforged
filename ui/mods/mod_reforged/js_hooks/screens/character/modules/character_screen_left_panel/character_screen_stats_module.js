// Adds an entityId entry into the tooltip query calls for attributes
Reforged.Hooks.CharacterScreenStatsModule_setProgressbarValues = CharacterScreenStatsModule.prototype.setProgressbarValues;
CharacterScreenStatsModule.prototype.setProgressbarValues = function (_data)
{
    Reforged.Hooks.CharacterScreenStatsModule_setProgressbarValues.call(this, _data);

    var selectedBrother = this.mDataSource.getSelectedBrother();
    if (selectedBrother === null) return;

    // We replace the static vanilla tooltipsEvents. The difference is that we also push the 'entityId: entityID' inside so that the tooltips on squirrel side can reference the respective entity
    this.removeEventHandler();
    var entityID = selectedBrother[CharacterScreenIdentifier.Entity.Id];
	$.each(this.mLeftStatsRows, function (_key, _value)
	{
		_value.Row.bindTooltip({ entityId: entityID, contentType: 'ui-element', elementId: _value.TooltipId });
		//_value.Talent.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.CharacterStats.Talent });
	});

	$.each(this.mMiddleStatsRows, function (_key, _value)
	{
		_value.Row.bindTooltip({ entityId: entityID, contentType: 'ui-element', elementId: _value.TooltipId });
		//_value.Talent.bindTooltip({ contentType: 'ui-element', elementId: TooltipIdentifier.CharacterStats.Talent });
	});
}
