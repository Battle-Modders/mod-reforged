::Reforged.HooksMod.hook("scripts/entity/tactical/enemies/unhold", function(q) {
	q.onInit = @() { function onInit()
	{
		this.actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.Unhold);
		// b.IsImmuneToDisarm = true;		// Now handled by racial effect
		// b.IsImmuneToRotation = true;		// Now handled by racial effect

		// if (!::Tactical.State.isScenarioMode() && ::World.getTime().Days >= 90)
		// {
		// 	b.DamageTotalMult += 0.1;
		// }

		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = ::Const.DefaultMovementAPCost;
		this.m.FatigueCosts = ::Const.DefaultMovementFatigueCost;
		this.m.Items.getAppearance().Body = "bust_unhold_body_02";
		this.addSprite("socket").setBrush("bust_base_beasts");
		local body = this.addSprite("body");
		body.setBrush("bust_unhold_body_02");
		body.varySaturation(0.1);
		body.varyColor(0.09, 0.09, 0.09);
		local injury_body = this.addSprite("injury");
		injury_body.Visible = false;
		injury_body.setBrush("bust_unhold_02_injured");
		this.addSprite("armor");
		local head = this.addSprite("head");
		// Reforged adds a chance to have smiling unhold face as head sprite
		if (::Math.rand(1, 100) <= 5)
		{
			head.setBrush("bust_rf_unhold_head_smiling");
		}
		else
		{
			// Original vanilla face
			head.setBrush("bust_unhold_head_02");
		}
		head.Saturation = body.Saturation;
		head.Color = body.Color;
		this.addSprite("helmet");
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.65;
		this.setSpriteOffset("status_rooted", this.createVec(-10, 16));
		this.setSpriteOffset("status_stunned", this.createVec(0, 10));
		this.setSpriteOffset("arrow", this.createVec(0, 10));
		this.m.Skills.add(::new("scripts/skills/perks/perk_crippling_strikes"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_pathfinder"));
		// this.m.Skills.add(::new("scripts/skills/perks/perk_steel_brow"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_battering_ram"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_stalwart"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_hold_out"));
		this.m.Skills.add(::new("scripts/skills/racial/unhold_racial"));
		this.m.Skills.add(::new("scripts/skills/actives/sweep_skill"));
		this.m.Skills.add(::new("scripts/skills/actives/sweep_zoc_skill"));
		this.m.Skills.add(::new("scripts/skills/actives/fling_back_skill"));
		this.m.Skills.add(::new("scripts/skills/actives/unstoppable_charge_skill"));

		// Reforged
		this.m.BaseProperties.Reach = ::Reforged.Reach.Default.BeastHuge;
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_rattle"));
		this.m.Skills.add(::Reforged.new("scripts/skills/perks/perk_rf_dismantle", function(o) {
			o.m.RequiredDamageType = null;
			o.m.RequiredWeaponType = null;
		}));
		this.m.Skills.add(::Reforged.new("scripts/skills/perks/perk_rf_formidable_approach"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_menacing"));
	}}.onInit;

	q.onDeath = @(__original) { function onDeath( _killer, _skill, _tile, _fatalityType )
	{
		// Set smiling head back to normal vanilla head so that _dead sprites are vanilla ones
		local headSprite = this.getSprite("head");
		if (headSprite.getBrush().Name == "bust_rf_unhold_head_smiling")
		{
			headSprite.setBrush("bust_unhold_head_02");
		}

		__original(_killer, _skill, _tile, _fatalityType);
	}}.onDeath;

	q.getLootForTile = @(__original) { function getLootForTile( _killer, _loot )
	{
		__original(_killer, _loot);

		// We implement our own drop rate for deformed valuables, so we delete any that was spawned by vanilla
		for (local i = _loot.len() - 1; i > 0; i--)
		{
			if (_loot[i].getID() == "misc.deformed_valuables")
			{
				_loot.remove(i);
			}
		}

		if (_killer == null || _killer.getFaction() == ::Const.Faction.Player || _killer.getFaction() == ::Const.Faction.PlayerAnimals)
		{
			if (::Math.rand(1, 100) <= 25)
			{
				_loot.push(::new("scripts/items/loot/deformed_valuables_item"));
			}
		}

		return _loot;
	}}.getLootForTile;
});
