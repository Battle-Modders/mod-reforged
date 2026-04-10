WorldTownScreen.prototype.RF_notifyBackendContractRightClicked = function (_contractID)
{
	SQ.call(this.mSQHandle, 'RF_onContractRightClicked', _contractID);
};
