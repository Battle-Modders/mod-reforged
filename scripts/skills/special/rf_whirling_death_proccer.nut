this.rf_whirling_death_proccer <- ::inherit("scripts/skills/skill", {
	m = {
		SkillCount = 0
	},
	function create()
	{
		this.m.ID = "special.rf_whirling_death_proccer";
		this.m.Name = "";
		this.m.Description = "";
		this.m.Icon = "ui/perks/rf_whirling_death.png";
		//this.m.IconMini = "perk_01_mini";
		this.m.Type = ::Const.SkillType.Special;
		this.m.IsActive = false;
		this.m.IsHidden = true;
		this.m.IsSerialized = false;
	}

	function onMovementFinished( _tile )
	{
		local roll = ::Math.rand(1, 100);
		local actor = this.getContainer().getActor();
		local attackSkills = [];
		for (local i = 0; i < 6; i++)
		{
			if (!_tile.hasNextTile(i))
				continue;

			local nextTile = _tile.getNextTile();
			if (!nextTile.IsOccupiedByActor)
				continue;

			local entity = nextTile.getEntity();
			if (entity.isAlliedWith(actor) || entity.getCurrentProperties().getReach() <= actor.getCurrentProperties().getReach())
				continue;

			local enemyPerk = entity.getSkills().getSkillByID("perk.rf_whirling_death");
			if (enemyPerk == null || !enemyPerk.isEnabled() || roll > enemyPerk.m.Chance)
				continue;

			local aoo = entity.getSkills().getAttackOfOpportunity();
			if (aoo != null)
				attackSkills.push(aoo);
		}

		if (attackSkills.len() == 0)
			return;

		::MSU.Array.rand(attackSkills).useForFree(_tile);
	}
});
