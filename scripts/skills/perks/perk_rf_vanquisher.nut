this.perk_rf_vanquisher <- ::inherit("scripts/skills/skill", {
	m = {
		ValidTile = null,
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
		return !this.m.IsInEffect || this.m.ValidTile == null;
	}

	function getTooltip()
	{
		local ret = this.skill.getTooltip();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/action_points.png",
			text = ::Reforged.Mod.Tooltips.parseString("Skills cost " + ::MSU.Text.colorGreen("half") + " [Action Points|Concept.ActionPoints]")
		});
		ret.push({
			id = 11,
			type = "text",
			icon = "ui/icons/warning.png",
			text = ::Reforged.Mod.Tooltips.parseString("Will expire upon taking any action other than a skill usage")
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
		if (_deathTile != null && _killer.getID() == this.getContainer().getActor().getID() && ::Tactical.TurnSequenceBar.isActiveEntity(this.getContainer().getActor()))
			this.m.ValidTile = _deathTile;
	}

	function onMovementFinished( _tile )
	{
		this.m.IsInEffect = this.m.ValidTile != null && _tile.isSameTileAs(this.m.ValidTile);
	}

	function onAfterUpdate( _properties )
	{
		if (this.m.IsInEffect)
		{
			foreach (skill in this.getContainer().getAllSkillsOfType(::Const.SkillType.Active))
			{
				skill.m.ActionPointCost = ::Math.max(1, skill.m.ActionPointCost * 0.5);
			}
		}
	}

	function onAffordablePreview( _skill, _movementTile )
	{
		if (this.m.IsInEffect)
		{
			foreach (skill in this.getContainer().getAllSkillsOfType(::Const.SkillType.Active))
			{
				this.modifyPreviewField(skill, "ActionPointCost", 0, false);
			}
		}
		// Gain Ground can only be used on a valid tile
		else if ((_skill != null && _skill.getID() == "actives.rf_gain_ground") || (_movementTile != null && this.m.ValidTile != null && _movementTile.isSameTileAs(this.m.ValidTile)))
		{
			foreach (skill in this.getContainer().getAllSkillsOfType(::Const.SkillType.Active))
			{
				this.modifyPreviewField(skill, "ActionPointCost", -1 * ::Math.max(0, skill.m.ActionPointCost * 0.5), false);
			}
		}
	}

	function onAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		this.m.IsInEffect = false;
	}

	function onPayForItemAction( _skill, _items )
	{
		this.m.IsInEffect = false;
		this.m.ValidTile = null;
	}

	function onWaitTurn()
	{
		this.m.IsInEffect = false;
		this.m.ValidTile = null;
	}

	function onTurnStart()
	{
		this.m.IsInEffect = false;
		this.m.ValidTile = null;
	}

	function onTurnEnd()
	{
		this.m.IsInEffect = false;
		this.m.ValidTile = null;
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.IsInEffect = false;
		this.m.ValidTile = null;
	}
});
