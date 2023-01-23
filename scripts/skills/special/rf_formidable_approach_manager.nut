this.rf_formidable_approach_manager <- ::inherit("scripts/skills/skill", {
	m = {
		Enemies = []
	},
	function create()
	{
		this.m.ID = "special.rf_formidable_approach_manager";
		this.m.Name = "";
		this.m.Description = "";
		this.m.Type = ::Const.SkillType.Special;
		this.m.IsActive = false;
		this.m.IsHidden = true;
		this.m.IsSerialized = false;
	}

	function onMovementStarted( _tile, _numTiles )
	{
		this.m.Enemies.clear();

		foreach (tile in ::MSU.Tile.getNeighbors(_tile))
		{
			if (tile.IsOccupiedByActor && !tile.getEntity().isAlliedWith(this.getContainer().getActor()))
			{
				this.m.Enemies.push(tile.getEntity().getID());
			}
		}
	}

	function onMovementFinished( _tile )
	{
		local myPerk = this.getContainer().getSkillByID("perk.rf_formidable_approach");

		// Iterate over the enemies we were next to before we started our movement
		foreach (id in this.m.Enemies)
		{
			local enemy = ::Tactical.getEntityByID(id);
			if (enemy == null) continue;

			if (!enemy.isPlacedOnMap() || enemy.getTile().getDistanceTo(_tile) > 1)
			{
				// We have exited an enemy's Zone of Control
				local perk = enemy.getSkills().getSkillByID("perk.rf_formidable_approach");
				if (perk != null) perk.unregisterEnemy(this.getContainer().getActor());
				if (myPerk != null) myPerk.unregisterEnemy(enemy.getID());
			}
		}

		// Iterate over the enemies next to our new tile
		foreach (tile in ::MSU.Tile.getNeighbors(_tile))
		{
			// Ignore allies. Additionatlly, ignore enemies we were already next to when starting our movement
			if (!tile.IsOccupiedByActor || tile.getEntity().isAlliedWith(this.getContainer().getActor()) || this.m.Enemies.find(tile.getEntity().getID()) != null)
				continue;

			// We have ended our movement next to a new enemy
			local perk = tile.getEntity().getSkills().getSkillByID("perk.rf_formidable_approach");
			if (perk != null) perk.registerEnemy(this.getContainer().getActor());
			if (myPerk != null) myPerk.registerEnemy(tile.getEntity());
		}

		this.m.Enemies.clear();
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (!_skill.isRanged() && _targetEntity.isAlive())
		{
			local perk = _targetEntity.getSkills().getSkillByID("perk.rf_formidable_approach");
			if (perk != null)
			{
				perk.unregisterEnemy(this.getContainer().getActor());
			}
		}
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.Enemies.clear();
	}
});
