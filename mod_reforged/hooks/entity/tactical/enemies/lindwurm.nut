::Reforged.HooksMod.hook("scripts/entity/tactical/enemies/lindwurm", function(q) {
	q.onInit = @() function()
	{
		this.actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.Lindwurm);
		// b.IsAffectedByNight = false;				// Now handled by racial effect
		// b.IsImmuneToKnockBackAndGrab = true;		// Now handled by racial effect
		// b.IsImmuneToStun = true;					// Now handled by racial effect
		b.IsMovable = false;
		// b.IsImmuneToRoot = true;					// Now handled by racial effect
		// b.IsImmuneToDisarm = true;				// Now handled by racial effect

		// if (!::Tactical.State.isScenarioMode() && ::World.getTime().Days >= 170)
		// {
		// 	b.MeleeSkill += 10;
		// 	b.DamageTotalMult += 0.1;
		// }

		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = ::Const.DefaultMovementAPCost;
		this.m.FatigueCosts = ::Const.DefaultMovementFatigueCost;
		this.addSprite("socket").setBrush("bust_base_beasts");
		local body = this.addSprite("body");
		body.setBrush("bust_lindwurm_body_0" + ::Math.rand(1, 1));

		if (::Math.rand(0, 100) < 90)
		{
			body.varySaturation(0.2);
		}

		if (::Math.rand(0, 100) < 90)
		{
			body.varyColor(0.08, 0.08, 0.08);
		}

		local head = this.addSprite("head");
		head.setBrush("bust_lindwurm_head_0" + ::Math.rand(1, 1));
		head.Color = body.Color;
		head.Saturation = body.Saturation;
		local injury = this.addSprite("injury");
		injury.Visible = false;
		injury.setBrush("bust_lindwurm_body_01_injured");
		local body_blood = this.addSprite("body_blood");
		body_blood.Visible = false;
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.63;
		this.setSpriteOffset("status_rooted", this.createVec(0, 15));
		this.setSpriteOffset("status_stunned", this.createVec(-5, 30));
		this.setSpriteOffset("arrow", this.createVec(-5, 30));
		this.m.Skills.add(::new("scripts/skills/actives/gorge_skill"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_pathfinder"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_hold_out"));
		this.m.Skills.add(::new("scripts/skills/racial/lindwurm_racial"));
		// this.m.Skills.add(::new("scripts/skills/perks/perk_reach_advantage"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_fearsome"));
		// this.m.Skills.add(::new("scripts/skills/perks/perk_underdog"));

		if (this.m.Tail == null)
		{
			local myTile = this.getTile();
			local spawnTile;

			if (myTile.hasNextTile(::Const.Direction.NE) && myTile.getNextTile(::Const.Direction.NE).IsEmpty)
			{
				spawnTile = myTile.getNextTile(::Const.Direction.NE);
			}
			else if (myTile.hasNextTile(::Const.Direction.SE) && myTile.getNextTile(::Const.Direction.SE).IsEmpty)
			{
				spawnTile = myTile.getNextTile(::Const.Direction.SE);
			}
			else
			{
				for( local i = 0; i < 6; i = ++i )
				{
					if (!myTile.hasNextTile(i))
					{
					}
					else if (myTile.getNextTile(i).IsEmpty)
					{
						spawnTile = myTile.getNextTile(i);
						break;
					}
				}
			}

			if (spawnTile != null)
			{
				this.m.Tail = this.WeakTableRef(::Tactical.spawnEntity("scripts/entity/tactical/enemies/lindwurm_tail", spawnTile.Coords.X, spawnTile.Coords.Y, this.getID()));
				this.m.Tail.m.Body = this.WeakTableRef(this);
				this.m.Tail.getSprite("body").Color = body.Color;
				this.m.Tail.getSprite("body").Saturation = body.Saturation;
			}
		}

		// Reforged
		this.m.BaseProperties.Reach = ::Reforged.Reach.Default.BeastGargantuan;
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_formidable_approach"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_menacing"));
	}
});
