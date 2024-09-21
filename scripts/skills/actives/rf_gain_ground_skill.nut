this.rf_gain_ground_skill <- ::inherit("scripts/skills/skill", {
	m = {
		ValidTiles = []
		APCostModifier = -2,
		FatigueCostModifier = -2
	},
	function create()
	{
		this.m.ID = "actives.rf_gain_ground";
		this.m.Name = "Gain Ground";
		this.m.Description = ::Reforged.Mod.Tooltips.parseString("Keep going! Immediately after killing an adjacent target you may move into their tile ignoring [Zone of Control.|Concept.ZoneOfControl]");
		this.m.Icon = "skills/rf_gain_ground_skill.png";
		this.m.IconDisabled = "skills/rf_gain_ground_skill_sw.png";
		this.m.Overlay = "rf_gain_ground_skill";
		this.m.SoundOnUse = [
			"sounds/combat/footwork_01.wav"
		];
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.Last;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsTargetingActor = false;
		this.m.IsVisibleTileNeeded = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsDisengagement = true;
		this.m.ActionPointCost = 0;
		this.m.FatigueCost = 0;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.MaxLevelDifference = 1;
		this.m.AIBehaviorID = ::Const.AI.Behavior.ID.RF_KataStep;
	}

	function getCostString()
	{
		if (this.getContainer().getActor().isPlacedOnMap())
			return this.skill.getCostString();

		local ret = "Costs " + (this.m.APCostModifier == 0 ? "+0" : ::MSU.Text.colorizeValue(this.m.APCostModifier, {AddSign = true, InvertColor = true})) + " [Action Points|Concept.ActionPoints] and builds ";
		ret += (this.m.FatigueCostModifier == 0 ? "+0" : ::MSU.Text.colorizeValue(this.m.FatigueCostModifier, {AddSign = true, InvertColor = true})) + " [Fatigue|Concept.Fatigue] compared to the movement costs of the starting tile";
		return ::Reforged.Mod.Tooltips.parseString(ret);
	}

	function getTooltip()
	{
		local ret = this.skill.getDefaultUtilityTooltip();
		if (this.getContainer().getActor().getCurrentProperties().IsRooted)
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = ::MSU.Text.colorNegative("Cannot be used while rooted")
			});
		}

		if (this.m.ValidTiles.len() == 0)
		{
			ret.push({
				id = 20,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = ::MSU.Text.colorNegative("Can only be used immediately after killing an adjacent target")
			});
		}

		return ret;
	}

	function isUsable()
	{
		return this.m.ValidTiles.len() != 0 && this.skill.isUsable() && !this.getContainer().getActor().getCurrentProperties().IsRooted;
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		return this.isTileValid(_targetTile) && this.skill.onVerifyTarget(_originTile, _targetTile);
	}

	function onAfterUpdate( _properties )
	{
		this.m.FatigueCost = 0;
		this.m.ActionPointCost = 0;

		local actor = this.getContainer().getActor();
		if (actor.isPlacedOnMap())
		{
			local myTile = actor.getTile();
			this.m.FatigueCost = ::Math.max(0, (actor.getFatigueCosts()[myTile.Type] + _properties.MovementFatigueCostAdditional + this.m.FatigueCostModifier) * _properties.MovementFatigueCostMult);
			this.m.ActionPointCost = ::Math.max(0, (actor.getActionPointCosts()[myTile.Type] + _properties.MovementAPCostAdditional + this.m.APCostModifier) * _properties.MovementAPCostMult);
		}
	}

	function onUse( _user, _targetTile )
	{
		::Tactical.getNavigator().teleport(_user, _targetTile, null, null, false);
		this.m.ValidTiles.clear();
		return true;
	}

	function onOtherActorDeath( _killer, _victim, _skill, _deathTile, _corpseTile, _fatalityType )
	{
		if (_deathTile == null)
			return;

		local actor = this.getContainer().getActor();
		if (actor.isPlacedOnMap() && _killer != null && _killer.getID() == actor.getID() && ::Tactical.TurnSequenceBar.isActiveEntity(actor) && actor.getTile().getDistanceTo(_deathTile) == 1)
			this.m.ValidTiles.push(_deathTile);
	}

	function onBeforeAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		if (_skill != this && !_forFree)
			this.m.ValidTiles.clear();
	}

	function onPayForItemAction( _skill, _items )
	{
		this.m.ValidTiles.clear();
	}

	function onWaitTurn()
	{
		this.m.ValidTiles.clear();
	}

	function onTurnStart()
	{
		this.m.ValidTiles.clear();
	}

	function onTurnEnd()
	{
		this.m.ValidTiles.clear();
	}

	function onMovementFinished( _tile )
	{
		this.m.ValidTiles.clear();
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.ValidTiles.clear();
	}

	function isTileValid( _tile )
	{
		if (_tile == null || !_tile.IsEmpty)
			return false;

		foreach (t in this.m.ValidTiles)
		{
			if (_tile.isSameTileAs(t))
				return true;
		}
		return false;
	}
});
