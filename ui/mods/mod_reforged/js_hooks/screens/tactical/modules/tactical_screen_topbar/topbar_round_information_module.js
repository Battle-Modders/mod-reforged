Reforged.Hooks.TacticalScreenTopbarRoundInformationModule_update = TacticalScreenTopbarRoundInformationModule.prototype.update;
TacticalScreenTopbarRoundInformationModule.prototype.update = function (_data)
{
	// feat: Replace the exact enemiesCount with a range based on discovered enemies
	if (_data !== null && _data !== undefined && 'RF_enemiesCountMax' in _data)
	{
		_data[TacticalScreenIdentifier.Topbar.RoundInformation.EnemiesCount] = _data.RF_enemiesCountMin + " - " + _data.RF_enemiesCountMax;
	}

	Reforged.Hooks.TacticalScreenTopbarRoundInformationModule_update.call(this, _data);
}
