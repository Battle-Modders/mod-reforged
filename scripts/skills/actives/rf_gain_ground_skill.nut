this.rf_gain_ground_skill <- ::inherit("scripts/skills/skill", {
	m = {
		ValidTiles = []

		__BaseActionPointCost = 0,
		__BaseFatigueCost = 0
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
		this.m.ActionPointCost = -2;
		this.m.FatigueCost = 0;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.MaxLevelDifference = 1;
		this.m.AIBehaviorID = ::Const.AI.Behavior.ID.RF_KataStep;
	}

	// Vanilla does not ensure a non-negative value return (should probably be fixed over at MSU)
	function getActionPointCost()
	{
		return ::Math.max(0, this.skill.getActionPointCost());
	}

	function getCostString()
	{
		if (this.getContainer().getActor().isPlacedOnMap())
			return this.skill.getCostString();

		local ret = "Costs " + (this.m.ActionPointCost == 0 ? "+0" : ::MSU.Text.colorizeValue(this.m.ActionPointCost, {AddSign = true, InvertColor = true})) + " [Action Points|Concept.ActionPoints] and builds ";
		ret += (this.m.FatigueCost == 0 ? "+0" : ::MSU.Text.colorizeValue(this.m.FatigueCost, {AddSign = true, InvertColor = true})) + " [Fatigue|Concept.Fatigue] compared to the movement costs of the starting tile";
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

	function onAdded()
	{
		this.m.__BaseActionPointCost = this.m.ActionPointCost;
		this.m.__BaseFatigueCost = this.m.FatigueCost;
	}

	function isUsable()
	{
		return this.m.ValidTiles.len() != 0 && this.skill.isUsable() && !this.getContainer().getActor().getCurrentProperties().IsRooted;
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		return this.isTileValid(_targetTile) && this.skill.onVerifyTarget(_originTile, _targetTile);
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
		this.setupCosts(this.getContainer().getActor().getTile());
	}

	function onResumeTurn()
	{
		this.setupCosts(this.getContainer().getActor().getTile());
	}

	function onTurnStart()
	{
		this.m.ValidTiles.clear();
		this.setupCosts(this.getContainer().getActor().getTile());
	}

	function onTurnEnd()
	{
		this.m.ValidTiles.clear();
		this.setupCosts(this.getContainer().getActor().getTile());
	}

	function onMovementFinished( _tile )
	{
		this.m.ValidTiles.clear();
		this.setupCosts(_tile);
	}

	function onCombatStarted()
	{
		this.setupCosts(this.getContainer().getActor().getTile());
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.ValidTiles.clear();
		this.setBaseValue("FatigueCost", this.m.__BaseFatigueCost);
		this.setBaseValue("ActionPointCost", this.m.__BaseActionPointCost);
	}

	function setupCosts( _tile )
	{
		local actor = this.getContainer().getActor();
		local myTile = actor.getTile();
		this.setBaseValue("FatigueCost", this.m.__BaseFatigueCost + actor.getFatigueCosts()[myTile.Type]);
		this.setBaseValue("ActionPointCost",this.m.__BaseActionPointCost + actor.getActionPointCosts()[myTile.Type]);
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
