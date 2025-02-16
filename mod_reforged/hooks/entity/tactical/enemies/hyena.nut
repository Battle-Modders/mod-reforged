::Reforged.HooksMod.hook("scripts/entity/tactical/enemies/hyena", function(q) {
	q.onInit = @() function()
	{
		this.actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.Hyena);
		b.IsAffectedByNight = false;
		b.IsImmuneToDisarm = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = ::Const.DefaultMovementAPCost;
		this.m.FatigueCosts = ::Const.DefaultMovementFatigueCost;
		this.addSprite("socket").setBrush("bust_base_beasts");
		local body = this.addSprite("body");
		body.setBrush("bust_hyena_0" + ::Math.rand(1, 3));

		if (::Math.rand(0, 100) < 90)
		{
			body.varySaturation(0.2);
		}

		if (::Math.rand(0, 100) < 90)
		{
			body.varyColor(0.05, 0.05, 0.05);
		}

		local head = this.addSprite("head");
		head.setBrush("bust_hyena_0" + ::Math.rand(1, 3) + "_head");
		head.Color = body.Color;
		head.Saturation = body.Saturation;
		local injury = this.addSprite("injury");
		injury.Visible = false;
		injury.setBrush("bust_hyena_injured");
		local body_blood = this.addSprite("body_blood");
		body_blood.Visible = false;
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.54;
		this.setSpriteOffset("status_rooted", this.createVec(0, 0));
		this.m.Skills.add(::new("scripts/skills/actives/hyena_bite_skill"));
		// this.m.Skills.add(::new("scripts/skills/perks/perk_coup_de_grace"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_backstabber"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_pathfinder"));

		// Reforged
		this.m.BaseProperties.Reach = ::Reforged.Reach.Default.BeastMedium - 1;
		this.m.Skills.add(::new("scripts/skills/perks/perk_crippling_strikes"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_sundering_strikes"));
	}

	// switcheroo function to replace loot drops with dummy object
	q.onDeath = @(__original) function( _killer, _skill, _tile, _fatalityType )
	{
		local itemsToChange = [
			"scripts/items/loot/sabertooth_item"
		]
		local new = ::new;
		::new = function(_scriptName)
		{
			local item = new(_scriptName);
			if (itemsToChange.find(_scriptName) != null)
			{
				item.drop <- @(...)null;
			}
			return item;
		}
		__original(_killer, _skill, _tile, _fatalityType);
		::new = new;

		if (_tile != null && (_killer == null || _killer.getFaction() == ::Const.Faction.Player || _killer.getFaction() == ::Const.Faction.PlayerAnimals))
		{
			local chanceToRoll = ::MSU.isKindOf(this, "hyena_high") ? 30 : 20;

			if (_tile != null && ::Math.rand(1, 100) <= chanceToRoll)
			{
				local loot = ::new("scripts/items/loot/sabertooth_item");
				loot.drop(_tile);
			}
		}
	}
});
