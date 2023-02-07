// New function to change Icon of Flee-Button when enemies gave up
TacticalScreenTopbarOptionsModule.prototype.changeFleeButtonToWin = function (_allowWin)
{
	if (_allowWin === true)
	{
		this.mFleeButton.changeButtonImage(Path.GFX + Reforged.Asset.BUTTON_RETREAT_WIN);
	}
	else if (_allowWin === false)
	{
		this.mFleeButton.changeButtonImage(Path.GFX + Asset.BUTTON_FLEE);
	}
};

