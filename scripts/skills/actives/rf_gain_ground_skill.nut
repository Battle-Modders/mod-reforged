this.rf_gain_ground_skill <- ::inherit("scripts/skills/skill", {
	m = {
		ValidTiles = []
	},
	function create()
	{
		this.m.ID = "actives.rf_gain_ground";
		this.m.Name = "Gain Ground";
		this.m.Description = ::Reforged.Mod.Tooltips.parseString("Keep going! After killing an enemy you may move into their tile ignoring [Zone of Control|Concept.ZoneOfControl]. Can only be used immediately after a successful kill.");
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
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsDisengagement = true;
		this.m.ActionPointCost = 0;
		this.m.FatigueCost = 0;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.MaxLevelDifference = 1;
		this.m.AIBehaviorID = ::Const.AI.Behavior.ID.RF_KataStep;
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();
		local actor = this.getContainer().getActor();

		if (!actor.isPlacedOnMap())
		{
			ret.push({
				id = 3,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::Reforged.Mod.Tooltips.parseString("Costs " + ::MSU.Text.colorGreen(2) + " fewer [Action Points|Concept.ActionPoints] and builds [Fatigue|Concept.Fatigue] equal to the movement cost of the starting tile")
			});
		}
		else
		{
			ret.push({
				id = 3,
				type = "text",
				text = this.getCostString()
			});
		}

		if (actor.getCurrentProperties().IsRooted)
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = ::MSU.Text.colorRed("Cannot be used while rooted")
			});
		}

		if (this.m.ValidTiles.len() == 0)
		{
			ret.push({
				id = 11,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = ::MSU.Text.colorRed("Can only be used immediately after killing a target")
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
			this.m.FatigueCost = ::Math.max(0, (actor.getFatigueCosts()[myTile.Type] + _properties.MovementFatigueCostAdditional) * _properties.MovementFatigueCostMult);
			this.m.ActionPointCost = ::Math.max(0, (actor.getActionPointCosts()[myTile.Type] + _properties.MovementAPCostAdditional - 2) * _properties.MovementAPCostMult);
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
		if (_deathTile != null && _killer.getID() == this.getContainer().getActor().getID() && ::Tactical.TurnSequenceBar.isActiveEntity(this.getContainer().getActor()))
			this.m.ValidTiles.push(_deathTile);
	}

	function onBeforeAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		if (_skill != this)
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
