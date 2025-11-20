this.rf_sapling_harvest_effect <- ::inherit("scripts/skills/skill", {
	m = {
		DamageThreshold = 0.1,
		SpawnedUnit = "scripts/entity/tactical/enemies/schrat_small"
	},
	function create()
	{
		this.m.ID = "effects.rf_sapling_harvest";
		this.m.Name = "Sapling Harvest";
		this.m.Icon = "skills/terrain_icon_06.png";
		this.m.SoundOnUse = [];
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Last;
	}

	function getDescription()
	{
		return ::Reforged.Mod.Tooltips.parseString("Whenever this character receives " + ::MSU.Text.colorPositive((this.m.DamageThreshold * 100.0) + "%") + " or more damage to [Hitpoints|Concept.Hitpoints] from a single hit, spawn a Sapling on an adjacent tile, if possible.");
	}

	function onDamageReceived( _attacker, _damageHitpoints, _damageArmor )
	{
		local actor = this.getContainer().getActor();
		if (_damageHitpoints < (this.m.DamageThreshold * actor.getHitpointsMax())) return;

		local candidates = [];
		local myTile = actor.getTile();

		for (local i = 0; i < 6; i++)
		{
			if (!myTile.hasNextTile(i)) continue;

			local nextTile = myTile.getNextTile(i);
			if (nextTile.IsEmpty && ::Math.abs(myTile.Level - nextTile.Level) <= 1)
			{
				candidates.push(nextTile);
			}
		}
		if (candidates.len() == 0) return;

		if (!this.getContainer().RF_validateSkillCounter(_attacker, true))
			return;

		local spawnTile = candidates[::Math.rand(0, candidates.len() - 1)];
		local sapling = ::Tactical.spawnEntity(this.m.SpawnedUnit, spawnTile.Coords);
		sapling.setFaction(actor.getFaction());
		sapling.riseFromGround();
	}
});
