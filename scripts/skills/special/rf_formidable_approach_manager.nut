this.rf_formidable_approach_manager <- ::inherit("scripts/skills/skill", {
	m = {
		Enemies = [],
		// Temporarily store enemy IDs here for which we "enable" formidable approach
		// with enemies around destination tile while previewing a movement. We store
		// the IDs so we can clean up when ending preview.
		__EnemiesDuringPreview = []
	},
	function create()
	{
		this.m.ID = "special.rf_formidable_approach_manager";
		this.m.Name = "";
		this.m.Description = "";
		this.m.Type = ::Const.SkillType.Special;
		this.m.IsHidden = true;
		this.m.IsSerialized = false;
	}

	// Enable formidable approach with enemies around destination tile while previewing a movement.
	// This works under the assumption that a "preview" type update is always followed by one
	// that isn't a preview one. During the preview update we "register" the enemies around
	// the destination tile, and then during the next update we clean it up.
	// This helps to account for formidable approach in the hit-chance preview during movement preview.
	function onUpdate( _properties )
	{
		local actor = this.getContainer().getActor();
		local myPerk = this.getContainer().getSkillByID("perk.rf_formidable_approach");

		if (actor.isPreviewing() && actor.getPreviewMovement() != null)
		{
			local destTile = ::Tactical.State.getLastTileHovered();
			if (destTile.IsEmpty)
			{
				// Iterate over the enemies next to the previewed destination tile
				foreach (enemy in ::Tactical.Entities.getAdjacentActors(destTile).filter(@(_, _a) !_a.isAlliedWith(actor)))
				{
					this.m.__EnemiesDuringPreview.push(enemy.getID());

					if (myPerk != null)
					{
						myPerk.m.Enemies.push(enemy.getID());
					}

					local enemyPerk = enemy.getSkills().getSkillByID("perk.rf_formidable_approach");
					if (enemyPerk != null)
					{
						enemyPerk.m.Enemies.push(actor.getID());
					}
				}
			}
		}
		else
		{
			foreach (id in this.m.__EnemiesDuringPreview)
			{
				if (myPerk != null)
				{
					::MSU.Array.removeByValue(myPerk.m.Enemies, id);
				}

				local entity = ::Tactical.getEntityByID(id);
				if (entity == null)
					continue;

				local enemyPerk = entity.getSkills().getSkillByID("perk.rf_formidable_approach");
				if (enemyPerk != null)
				{
					::MSU.Array.removeByValue(enemyPerk.m.Enemies, actor.getID());
				}
			}

			this.m.__EnemiesDuringPreview.clear();
		}
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

	function onMovementFinished()
	{
		local myPerk = this.getContainer().getSkillByID("perk.rf_formidable_approach");
		local myTile = this.getContainer().getActor().getTile();

		// Iterate over the enemies we were next to before we started our movement
		foreach (id in this.m.Enemies)
		{
			local enemy = ::Tactical.getEntityByID(id);
			if (enemy == null) continue;

			if (!enemy.isPlacedOnMap() || enemy.getTile().getDistanceTo(myTile) > 1)
			{
				// We have exited an enemy's Zone of Control
				local perk = enemy.getSkills().getSkillByID("perk.rf_formidable_approach");
				if (perk != null) perk.unregisterEnemy(this.getContainer().getActor());
				if (myPerk != null) myPerk.unregisterEnemy(enemy);
			}
		}

		// Iterate over the enemies next to our new tile
		foreach (tile in ::MSU.Tile.getNeighbors(myTile))
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
