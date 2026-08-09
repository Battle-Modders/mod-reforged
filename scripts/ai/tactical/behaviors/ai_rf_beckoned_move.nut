this.ai_rf_beckoned_move <- this.inherit("scripts/ai/tactical/behavior", {
	m = {
	},
	function create()
	{
		this.m.ID = ::Const.AI.Behavior.ID.RF_BeckonedMove;
		this.m.Order = ::Const.AI.Behavior.Order.RF_BeckonedMove;
		this.m.IsThreaded = false;
		this.behavior.create();
	}
    
	function onEvaluate( _entity )
	{
		if (!_entity.isPlacedOnMap())
		{
			return ::Const.AI.Behavior.Score.Zero;
		}

		if (_entity.getCurrentProperties().IsStunned)
		{
			return ::Const.AI.Behavior.Score.Zero;
		}

		if (_entity.getActionPoints() < ::Const.Movement.AutoEndTurnBelowAP)
		{
			return ::Const.AI.Behavior.Score.Zero;
		}

        if (_entity.getActionPointCostsRaw() == ::Const.ImmobileMovementAPCost)
        {
            return ::Const.AI.Behavior.Score.Zero;
        }

		if (_entity.getCurrentProperties().IsRooted)
		{
			return ::Const.AI.Behavior.Score.Zero;
		}

        if (!_entity.getSkills().hasSkill("effects.rf_beckoned"))
        {
			return ::Const.AI.Behavior.Score.Zero;
        }

        local charmer = _entity.getSkills().getSkillByID("effects.rf_beckoned").getCharmer()

        if (charmer == null || !charmer.isPlacedOnMap())
        {
			return ::Const.AI.Behavior.Score.Zero;
        }

        local navigator = this.Tactical.getNavigator();
        local entityActionPointCosts = _entity.getActionPointCosts();
        local entityFatiguePointCosts = _entity.getFatigueCosts();
        local charmerTile = charmer.getTile();
        local acceptableDistanceFromDest = 1;
        local settings = navigator.createSettings();
        local Allies = clone _entity.getAlliedFactions();
        Allies.extend(charmer.getAlliedFactions());
        Allies.push(charmer.getFaction());
        settings.ActionPointCosts = entityActionPointCosts;
        settings.FatigueCosts = entityFatiguePointCosts;
        settings.FatigueCostFactor = 0.0;
        settings.ActionPointCostPerLevel = _entity.getLevelActionPointCost();
        settings.FatigueCostPerLevel = _entity.getLevelFatigueCost();
        settings.MaxLevelDifference = _entity.getMaxTraversibleLevels();
        settings.AllowZoneOfControlPassing = true;
        settings.ZoneOfControlCost = 0;
        settings.AlliedFactions = Allies;
        settings.Faction = _entity.getFaction();
        settings.HiddenCost = 0;
        settings.HeatCost = 0;

		if (navigator.findPath(_entity.getTile(), charmerTile, settings, 1))
		{
			return ::Const.AI.Behavior.Score.AlwaysUse;
		}
        else
        {
            return ::Const.AI.Behavior.Score.Zero;
        }
	}

	function onExecute( _entity )
	{        
        local charmer = _entity.getSkills().getSkillByID("effects.rf_beckoned").getCharmer()
        local navigator = this.Tactical.getNavigator();
        local entityActionPointCosts = _entity.getActionPointCosts();
        local entityFatiguePointCosts = _entity.getFatigueCosts();
        local charmerTile = charmer.getTile();
        local acceptableDistanceFromDest = 1;
        local settings = navigator.createSettings();
        local Allies = clone _entity.getAlliedFactions();
        Allies.extend(charmer.getAlliedFactions());
        Allies.push(charmer.getFaction());
        settings.ActionPointCosts = entityActionPointCosts;
        settings.FatigueCosts = entityFatiguePointCosts;
        settings.FatigueCostFactor = 0.0;
        settings.ActionPointCostPerLevel = _entity.getLevelActionPointCost();
        settings.FatigueCostPerLevel = _entity.getLevelFatigueCost();
        settings.MaxLevelDifference = _entity.getMaxTraversibleLevels();
        settings.AllowZoneOfControlPassing = true;
        settings.ZoneOfControlCost = 0;
        settings.AlliedFactions = Allies;
        settings.Faction = _entity.getFaction();
        settings.HiddenCost = 0;
        settings.HeatCost = 0;

        navigator.findPath(_entity.getTile(), charmerTile, settings, 1);
        
        local movement = navigator.getCostForPath(_entity, settings, _entity.getActionPoints(), _entity.getFatigueMax() - _entity.getFatigue());
        this.m.Agent.adjustCameraToDestination(movement.End);

		return true;
	}

});

