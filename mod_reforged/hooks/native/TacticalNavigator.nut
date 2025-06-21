// Reduce available fatigue by the fatigue that would be built due to evading attacks of opportunity
local buildVisualisation = ::TacticalNavigator.buildVisualisation;
::TacticalNavigator.buildVisualisation <- { function buildVisualisation( _entity, _settings, _actionPoints, _fatigue )
{
	if (!_entity.getCurrentProperties().IsImmuneToZoneOfControl && _entity.getTile().hasZoneOfControlOtherThan(_entity.getAlliedFactions()) && (_entity.getTile().Properties.Effect == null || _entity.getTile().Properties.Effect.Type != "smoke"))
	{
		_fatigue = ::Math.max(0, _fatigue - _entity.getTile().getZoneOfControlCountOtherThan(_entity.getAlliedFactions()) * ::Const.Combat.FatigueLossOnBeingMissed * _entity.getCurrentProperties().FatigueEffectMult * _entity.getCurrentProperties().FatigueLossOnAnyAttackMult);
	}
	return buildVisualisation(_entity, _settings, _actionPoints, _fatigue);
}}.buildVisualisation;

// Reduce available fatigue by the fatigue that would be built due to evading attacks of opportunity
local getCostForPath = ::TacticalNavigator.getCostForPath;
::TacticalNavigator.getCostForPath <- { function getCostForPath( _entity, _settings, _actionPoints, _fatigue )
{
	if (!_entity.getCurrentProperties().IsImmuneToZoneOfControl && _entity.getTile().hasZoneOfControlOtherThan(_entity.getAlliedFactions()) && (_entity.getTile().Properties.Effect == null || _entity.getTile().Properties.Effect.Type != "smoke"))
	{
		_fatigue = ::Math.max(0, _fatigue - _entity.getTile().getZoneOfControlCountOtherThan(_entity.getAlliedFactions()) * ::Const.Combat.FatigueLossOnBeingMissed * _entity.getCurrentProperties().FatigueEffectMult * _entity.getCurrentProperties().FatigueLossOnAnyAttackMult);
	}
	return getCostForPath(_entity, _settings, _actionPoints, _fatigue);
}}.getCostForPath;
