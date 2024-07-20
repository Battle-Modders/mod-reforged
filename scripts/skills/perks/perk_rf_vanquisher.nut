this.perk_rf_vanquisher <- ::inherit("scripts/skills/skill", {
	m = {
		ValidTiles = [],
		IsInEffect = false
	},
	function create()
	{
		this.m.ID = "perk.rf_vanquisher";
		this.m.Name = ::Const.Strings.PerkName.RF_Vanquisher;
		this.m.Description = "Having just killed an opponent, this character is eager to take on another one!";
		this.m.Icon = "ui/perks/rf_vanquisher.png";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function isHidden()
	{
		return !this.m.IsInEffect || this.m.ValidTiles.len() == 0;
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/action_points.png",
			text = ::Reforged.Mod.Tooltips.parseString("The next skill used costs " + ::MSU.Text.colorPositive("half") + " [Action Points|Concept.ActionPoints]")
		});
		ret.push({
			id = 11,
			type = "text",
			icon = "ui/icons/warning.png",
			text = "Will expire upon taking any action other than a skill usage"
		});
		return ret;
	}

	function onAdded()
	{
		this.getContainer().add(::new("scripts/skills/actives/rf_gain_ground_skill"));
	}

	function onRemoved()
	{
		this.getContainer().removeByID("actives.rf_gain_ground");
	}

	function onOtherActorDeath( _killer, _victim, _skill, _deathTile, _corpseTile, _fatalityType )
	{
		if (_deathTile != null && _killer != null && _killer.getID() == this.getContainer().getActor().getID() && ::Tactical.TurnSequenceBar.isActiveEntity(this.getContainer().getActor()))
			this.m.ValidTiles.push(_deathTile);
	}

	function onMovementFinished( _tile )
	{
		if (this.isTileValid(_tile))
		{
			this.m.IsInEffect = true;
			this.spawnIcon("perk_rf_vanquisher", _tile);
		}
	}

	function onAfterUpdate( _properties )
	{
		local actor = this.getContainer().getActor();
		local isValid = this.m.IsInEffect;
		if (actor.isPreviewing())
		{
			// Gain Ground can only be used on a valid tile
			isValid = (actor.getPreviewMovement() != null && this.isTileValid(actor.getPreviewMovement().End)) || (actor.getPreviewSkill() != null && actor.getPreviewSkill().getID() != "actives.rf_gain_ground");
		}

		if (isValid)
		{
			foreach (skill in this.getContainer().m.Skills)
			{
				if (!skill.isGarbage() && skill.m.ActionPointCost > 1)
					skill.m.ActionPointCost /= 2;
			}
		}
	}

	function onBeforeAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		if (_skill.isAttack())
			this.m.ValidTiles.clear();
	}

	function onAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		this.m.IsInEffect = false;
	}

	function onPayForItemAction( _skill, _items )
	{
		this.m.IsInEffect = false;
		this.m.ValidTiles.clear();
	}

	function onWaitTurn()
	{
		this.m.IsInEffect = false;
		this.m.ValidTiles.clear();
	}

	function onTurnStart()
	{
		this.m.IsInEffect = false;
		this.m.ValidTiles.clear();
	}

	function onTurnEnd()
	{
		this.m.IsInEffect = false;
		this.m.ValidTiles.clear();
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.IsInEffect = false;
		this.m.ValidTiles.clear();
	}

	function isTileValid( _tile )
	{
		if (_tile == null)
			return false;

		foreach (t in this.m.ValidTiles)
		{
			if (_tile.isSameTileAs(t))
				return true;
		}
		return false;
	}
});
