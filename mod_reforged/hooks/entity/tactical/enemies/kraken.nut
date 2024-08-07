::Reforged.HooksMod.hook("scripts/entity/tactical/enemies/kraken", function(q) {
	q.onInit = @() function()
	{
		this.actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.Kraken);
		b.TargetAttractionMult = 3.0;
		b.IsAffectedByNight = false;
		b.IsImmuneToKnockBackAndGrab = true;
		b.IsImmuneToStun = true;
		b.IsImmuneToPoison = true;
		b.IsMovable = false;
		b.IsAffectedByInjuries = false;
		b.IsRooted = true;
		b.IsImmuneToDisarm = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = ::Const.DefaultMovementAPCost;
		this.m.FatigueCosts = ::Const.DefaultMovementFatigueCost;

		if (!::Tactical.State.isScenarioMode())
		{
			if (!::World.Flags.get("IsKrakenDefeated"))
			{
				this.setName("Beast of Beasts");
			}
			else
			{
				this.setName(::Const.Strings.KrakenNames[::Math.rand(0, ::Const.Strings.KrakenNames.len() - 1)]);
			}
		}

		this.addSprite("socket").setBrush("bust_base_beasts");
		local body = this.addSprite("body");
		body.setBrush("bust_kraken_body_01");

		if (::Math.rand(0, 100) < 90)
		{
			body.varySaturation(0.2);
		}

		if (::Math.rand(0, 100) < 90)
		{
			body.varyColor(0.08, 0.08, 0.08);
		}

		this.addDefaultStatusSprites();
		this.setSpriteOffset("arrow", this.createVec(20, 190));
		this.m.Skills.add(::new("scripts/skills/actives/kraken_devour_skill"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_hold_out"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_steel_brow"));
		local myTile = this.getTile();

		for( local i = 0; i < 8; i = ++i )
		{
			local mapSize = ::Tactical.getMapSize();

			for( local attempts = 0; attempts < 500; attempts = ++attempts )
			{
				local x = ::Math.rand(::Math.max(0, myTile.SquareCoords.X - 2), ::Math.min(mapSize.X - 1, myTile.SquareCoords.X + 8));
				local y = ::Math.rand(::Math.max(0, myTile.SquareCoords.Y - 8), ::Math.min(mapSize.Y - 1, myTile.SquareCoords.Y + 8));
				local tile = ::Tactical.getTileSquare(x, y);

				if (!tile.IsEmpty)
				{
				}
				else
				{
					local tentacle = ::Tactical.spawnEntity("scripts/entity/tactical/enemies/kraken_tentacle", tile.Coords);
					tentacle.setParent(this);
					tentacle.setFaction(this.getFaction());
					this.m.Tentacles.push(this.WeakTableRef(tentacle));
					break;
				}
			}
		}

		// Reforged
		this.m.BaseProperties.IsAffectedByReach = false;
	}
});
