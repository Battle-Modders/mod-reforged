// New function to change Icon of Flee-Button when enemies gave up
TacticalScreenTopbarOptionsModule.prototype.changeFleeButtonToAllowRetreat = function (_allowRetreat)
{
	if (_allowRetreat === true)
	{
		this.mFleeButton.changeButtonImage(Path.GFX + Reforged.BUTTON_ALLOW_RETREAT);
	}
	else if (_allowRetreat === false)
	{
		this.mFleeButton.changeButtonImage(Path.GFX + Asset.BUTTON_FLEE);
	}
};

