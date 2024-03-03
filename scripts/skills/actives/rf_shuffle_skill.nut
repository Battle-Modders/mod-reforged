this.rf_shuffle_skill <- ::inherit("scripts/skills/actives/rotation", {
	m = {
		UsesLeft = 1,

		// Config
		UsesPerTurn = 1,
	},
	function create()
	{
		this.rotation.create();
		this.m.ID = "actives.rf_shuffle";
		this.m.Name = "Shuffle";
		// this.m.Description = ::Reforged.Mod.Tooltips.parseString("Use the cover provided by a shield-bearing ally to move 1 tile ignoring [Zone of Control|Concept.ZoneOfControl] and without triggering free attacks.");
		this.m.Icon = "ui/perks/perk_25_active.png";
		this.m.IconDisabled = "ui/perks/perk_25_active_sw.png";
		this.m.Overlay = "perk_25_active";
		this.m.ActionPointCost = 0;
		this.m.FatigueCost = 5;
		// this.m.MaxLevelDifference = 1;
	}

	function onTurnStart()
	{
		this.m.UsesLeft = this.m.UsesPerTurn;
	}

	function onAfterUpdate( _properties )
	{
		local actor = this.getContainer().getActor();
		if (actor.isPlacedOnMap())
		{
			local numAdjacentEnemies = ::Tactical.Entities.getHostileActors(actor.getFaction(), actor.getTile(), 1, true).len();
			this.m.FatigueCostMult = 1.0;
			this.m.FatigueCostMult += (numAdjacentEnemies * 1.0);
		}
	}

	function isUsable()
	{
		if (this.m.UsesLeft <= 0) return false;
		// if (!this.getParent().hasPartner(true)) return false;	probably not needed anymore here

		return this.rotation.isUsable();
	}

	function isHidden()
	{
		if (!this.getParent().hasPartner(true)) return true;

		return this.rotation.isHidden();
	}

	function onUse( _user, _targetTile )
	{
		local ret = this.rotation.onUse(_user, _targetTile);
		if (ret)
		{
			this.m.UsesLeft -= 1;
		}
		return ret;
	}
});
