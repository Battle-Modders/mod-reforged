// Reduce available fatigue by the fatigue that would be built due to evading attacks of opportunity
local buildVisualisation = ::TacticalNavigator.buildVisualisation;
::TacticalNavigator.buildVisualisation <- { function buildVisualisation( _entity, _settings, _actionPoints, _fatigue )
{
	_fatigue = ::Math.max(0, _fatigue - _entity.RF_getZOCEvasionFatigue());
	return buildVisualisation(_entity, _settings, _actionPoints, _fatigue);
}}.buildVisualisation;

// Reduce available fatigue by the fatigue that would be built due to evading attacks of opportunity
local getCostForPath = ::TacticalNavigator.getCostForPath;
::TacticalNavigator.getCostForPath <- { function getCostForPath( _entity, _settings, _actionPoints, _fatigue )
{
	_fatigue = ::Math.max(0, _fatigue - _entity.RF_getZOCEvasionFatigue());
	return getCostForPath(_entity, _settings, _actionPoints, _fatigue);
}}.getCostForPath;
