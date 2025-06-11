WorldTownScreen.prototype.notifyBackendRetinueButtonPressed = function()
{
	if(this.mSQHandle !== null)
	{
		SQ.call(this.mSQHandle, 'onRetinueButtonPressed');
	}
}
