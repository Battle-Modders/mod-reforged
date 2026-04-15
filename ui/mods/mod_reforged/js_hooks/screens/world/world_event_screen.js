Reforged.Hooks.WorldEventScreen_updateHeader = WorldEventScreen.prototype.updateHeader;
WorldEventScreen.prototype.updateHeader = function (_data)
{
	Reforged.Hooks.WorldEventScreen_updateHeader.call(this, _data);

	// Bind tooltips of the characters to their images in the event screen.
	// Note: WorldEntity is a key in MSU Nested Tooltips so for that we want
	// to return msu's id instead of reforged id.

	if (_data.characterLeftTooltipID !== null)
	{
		this.mCharacterOverlayLeft.bindTooltip({ contentType: 'msu-generic', modId: _data.characterLeftTooltipID.indexOf("WorldEntity+") != -1 ? Reforged.MSUID : Reforged.ID, elementId: _data.characterLeftTooltipID });
	}

	if (_data.characterRightTooltipID !== null)
	{
		console.error(_data.characterLeftTooltipID.indexOf("WorldEntity+"));
		this.mCharacterOverlayRight.bindTooltip({ contentType: 'msu-generic', modId: _data.characterRightTooltipID.indexOf("WorldEntity+") != -1 ? Reforged.MSUID : Reforged.ID, elementId: _data.characterRightTooltipID });
	}
}
