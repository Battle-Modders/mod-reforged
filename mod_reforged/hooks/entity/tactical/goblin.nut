::Reforged.HooksMod.hook("scripts/entity/tactical/goblin", function(q) {
	q.onInit = @() function()
	{
	    this.actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.GoblinAmbusher);
		b.IsFleetfooted = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		this.m.Items.getAppearance().Body = "bust_goblin_01_body";
		this.addSprite("socket").setBrush("bust_base_goblins");
		local quiver = this.addSprite("quiver");
		quiver.Visible = false;
		local body = this.addSprite("body");
		body.setBrush("bust_goblin_01_body");
		body.varySaturation(0.1);
		body.varyColor(0.07, 0.07, 0.09);
		local injury_body = this.addSprite("injury_body");
		injury_body.Visible = false;
		injury_body.setBrush("bust_goblin_01_body_injured");
		this.addSprite("armor");
		local head = this.addSprite("head");
		head.Saturation = body.Saturation;
		head.Color = body.Color;
		local injury = this.addSprite("injury");
		injury.Visible = false;
		injury.setBrush("bust_goblin_01_head_injured");
		this.addSprite("helmet");
		this.addSprite("helmet_damage");
		local body_blood = this.addSprite("body_blood");
		body_blood.Visible = false;
		this.m.Skills.add(this.new("scripts/skills/effects/captain_effect"));
		this.m.Skills.add(this.new("scripts/skills/special/double_grip"));
		this.m.Skills.add(this.new("scripts/skills/actives/hand_to_hand"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_quick_hands"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_bullseye"));
		// this.m.Skills.add(this.new("scripts/skills/perks/perk_anticipation"));
		// this.m.Skills.add(this.new("scripts/skills/actives/footwork")); // Replaced with perk

		if (this.Const.DLC.Unhold)
		{
			this.m.Skills.add(this.new("scripts/skills/actives/wake_ally_skill"));
		}

		// Reforged
		b.RangedDefense += 10;
		this.m.BaseProperties.Reach = ::Reforged.Reach.Default.Goblin;

		this.m.Skills.add(::new("scripts/skills/perks/perk_footwork"));
	}

	q.onDeath = @(__original) function( _killer, _skill, _tile, _fatalityType )
	{
		if (_tile != null);
		{
			local loot = null;
			if (this.isKindOf(this, "goblin_leader") || this.isKindOf(this, "goblin_shaman") || this.m.IsMiniboss)
			{
				loot = this.new("scripts/items/loot/goblin_rank_insignia_item.nut");
				loot.drop(_tile);
			}
			else
			{
				loot = ::MSU.Class.WeightedContainer([
					[1.0, "scripts/items/loot/goblin_carved_ivory_iconographs_item.nut"],
					[0.5, "scripts/items/loot/goblin_minted_coins_item.nut"]
		    	]).rollChance(20);

		    	if (loot != null) ::new(loot).drop(_tile);
			}
			__original(_killer, _skill, _tile, _fatalityType);
		}
	}
});
