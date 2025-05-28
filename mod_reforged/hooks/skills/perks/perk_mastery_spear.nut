::Reforged.HooksMod.hook("scripts/skills/perks/perk_mastery_spear", function(q) {
	q.m.IsSpent <- true;
	q.m.TilesMoved <- 0;
	q.m.PrevTile <- null; // Used to account for movement due to teleportation
	q.m.FatigueCostMultMult <- 0.5;

	q.create = @(__original) { function create()
	{
		__original();
		this.m.Icon = ::Const.Perks.findById(this.getID()).Icon; // Vanilla uses the wrong icon i.e. `perk_10.png` which is the Anticipation icon.
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Description = ::Reforged.Mod.Tooltips.parseString("This character has mastered the art of fighting with the spear allowing him to perform an extra attack once per [turn.|Concept.Turn]");
	}}.create;

	q.isHidden = @() { function isHidden()
	{
		return this.m.IsSpent;
	}}.isHidden;

	q.getTooltip = @(__original) { function getTooltip()
	{
		local ret = __original();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("The next piercing spear attack costs " + ::MSU.Text.colorPositive("0") + " [Action Points|Concept.ActionPoints] and builds " + ::MSU.Text.colorizeMult(this.m.FatigueCostMultMult, {InvertColor = true}) + " less [Fatigue|Concept.Fatigue]")
		});

		local maxTilesAllowed = this.getMaxTilesAllowed();
		ret.push({
			id = 20,
			type = "text",
			icon = "ui/icons/warning.png",
			text = "Will expire upon switching your weapon or moving" + (maxTilesAllowed == 0 ? "" : "more than " + maxTilesAllowed + " tile(s)")
		});

		return ret;
	}}.getTooltip;

	q.onAfterUpdate = @(__original) { function onAfterUpdate( _properties )
	{
		__original(_properties);

		if (this.m.IsSpent)
			return;

		local actor = this.getContainer().getActor();
		if (actor.isPreviewing())
		{
			if (actor.getPreviewMovement() != null && actor.getPreviewMovement().Tiles + this.m.TilesMoved >= this.getMaxTilesAllowed())
				return;

			if (actor.getPreviewSkill() != null && this.isSkillValid(actor.getPreviewSkill()))
				return;
		}

		foreach (skill in this.getContainer().m.Skills)
		{
			if (this.isSkillValid(skill))
			{
				skill.m.ActionPointCost = 0;
				skill.m.FatigueCostMult *= this.m.FatigueCostMultMult;
			}
		}
	}}.onAfterUpdate;

	q.onAnySkillExecuted = @(__original) { function onAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		__original(_skill, _targetTile, _targetEntity, _forFree);

		if (this.isSkillValid(_skill) && ::Tactical.TurnSequenceBar.isActiveEntity(this.getContainer().getActor()))
			this.m.IsSpent = true;
	}}.onAnySkillExecuted;

	q.onPayForItemAction = @(__original) { function onPayForItemAction( _skill, _items )
	{
		__original(_skill, _items);

		foreach (item in _items)
		{
			if (item != null && item.getSlotType() == ::Const.ItemSlot.Mainhand)
			{
				this.m.IsSpent = true;
				return;
			}
		}
	}}.onPayForItemAction;

	q.onMovementStarted = @(__original) { function onMovementStarted( _tile, _numTiles )
	{
		// _numTiles == 0 means teleportation
		if (_numTiles == 0)
			this.m.PrevTile = _tile;
		else
			this.m.TilesMoved += _numTiles;

		__original(_tile, _numTiles);
	}}.onMovementStarted;

	q.onMovementFinished = @(__original) { function onMovementFinished()
	{
		__original();

		if (this.m.PrevTile != null)
		{
			this.m.TilesMoved += this.getContainer().getActor().getTile().getDistanceTo(this.m.PrevTile);
			this.m.PrevTile = null;
		}

		if (this.m.TilesMoved > this.getMaxTilesAllowed())
			this.m.IsSpent = true;
	}}.onMovementFinished;

	q.onTurnStart = @(__original) { function onTurnStart()
	{
		__original();

		this.m.TilesMoved = 0;

		local actor = this.getContainer().getActor();
		if (actor.isDisarmed())
			return;

		local weapon = actor.getMainhandItem();
		if (weapon != null && weapon.isWeaponType(::Const.Items.WeaponType.Spear))
			this.m.IsSpent = false;
	}}.onTurnStart;

	q.onCombatFinished = @(__original) { function onCombatFinished()
	{
		__original();
		this.m.IsSpent = true;
		this.m.TilesMoved = 0;
	}}.onCombatFinished;

	q.isSkillValid <- { function isSkillValid( _skill )
	{
		if (_skill.isRanged() || !_skill.isAttack() || !_skill.getDamageType().contains(::Const.Damage.DamageType.Piercing))
			return false;

		local weapon = _skill.getItem();
		return !::MSU.isNull(weapon) && weapon.isItemType(::Const.Items.ItemType.Weapon) && weapon.isWeaponType(::Const.Items.WeaponType.Spear);
	}}.isSkillValid;

	q.getMaxTilesAllowed <- { function getMaxTilesAllowed()
	{
		local weapon = this.getContainer().getActor().getMainhandItem();
		return weapon == null || weapon.isItemType(::Const.Items.ItemType.OneHanded) ? 1 : 0;
	}}.getMaxTilesAllowed;
});
