::Reforged.HooksMod.hook("scripts/entity/tactical/enemies/kraken", function(q) {
	q.onInit = @() function()
	{
	    this.actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.Kraken);
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
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;

		if (!this.Tactical.State.isScenarioMode())
		{
			if (!this.World.Flags.get("IsKrakenDefeated"))
			{
				this.setName("Beast of Beasts");
			}
			else
			{
				this.setName(this.Const.Strings.KrakenNames[this.Math.rand(0, this.Const.Strings.KrakenNames.len() - 1)]);
			}
		}

		this.addSprite("socket").setBrush("bust_base_beasts");
		local body = this.addSprite("body");
		body.setBrush("bust_kraken_body_01");

		if (this.Math.rand(0, 100) < 90)
		{
			body.varySaturation(0.2);
		}

		if (this.Math.rand(0, 100) < 90)
		{
			body.varyColor(0.08, 0.08, 0.08);
		}

		this.addDefaultStatusSprites();
		this.setSpriteOffset("arrow", this.createVec(20, 190));
		this.m.Skills.add(this.new("scripts/skills/actives/kraken_devour_skill"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_hold_out"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_steel_brow"));
		local myTile = this.getTile();

		for( local i = 0; i < 8; i = ++i )
		{
			local mapSize = this.Tactical.getMapSize();

			for( local attempts = 0; attempts < 500; attempts = ++attempts )
			{
				local x = this.Math.rand(this.Math.max(0, myTile.SquareCoords.X - 2), this.Math.min(mapSize.X - 1, myTile.SquareCoords.X + 8));
				local y = this.Math.rand(this.Math.max(0, myTile.SquareCoords.Y - 8), this.Math.min(mapSize.Y - 1, myTile.SquareCoords.Y + 8));
				local tile = this.Tactical.getTileSquare(x, y);

				if (!tile.IsEmpty)
				{
				}
				else
				{
					local tentacle = this.Tactical.spawnEntity("scripts/entity/tactical/enemies/kraken_tentacle", tile.Coords);
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
