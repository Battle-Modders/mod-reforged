::Reforged.HooksMod.hook("scripts/entity/tactical/enemies/serpent", function(q) {
	q.onInit = @() function()
	{
		this.actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.Serpent);
		b.Initiative += ::Math.rand(0, 50);
		// b.IsAffectedByNight = false;		// Now handled by racial effect
		// b.IsImmuneToDisarm = true;		// Now handled by racial effect

		// if (!::Tactical.State.isScenarioMode() && ::World.getTime().Days >= 20)
		// {
		// 	b.MeleeDefense += 5;

		// 	if (::World.getTime().Days >= 50)
		// 	{
				b.DamageDirectMult += 0.15;
		// 	}
		// }

		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = ::Const.DefaultMovementAPCost;
		this.m.FatigueCosts = ::Const.DefaultMovementFatigueCost;
		this.addSprite("socket").setBrush("bust_base_beasts");
		local body = this.addSprite("body");
		this.m.Variant = ::Math.rand(1, 2);
		body.setBrush("bust_snake_0" + this.m.Variant + "_head_0" + ::Math.rand(1, 2));

		if (this.m.Variant == 2 && ::Math.rand(0, 100) < 90)
		{
			body.varySaturation(0.1);
		}

		if (::Math.rand(0, 100) < 90)
		{
			body.varyColor(0.1, 0.1, 0.1);
		}

		if (::Math.rand(0, 100) < 90)
		{
			body.varyBrightness(0.1);
		}

		local injury = this.addSprite("injury");
		injury.Visible = false;
		injury.setBrush("bust_snake_injury");
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.65;
		this.setSpriteOffset("status_rooted", this.createVec(-10, 20));
		this.setSpriteOffset("status_stunned", this.createVec(-35, 20));
		this.setSpriteOffset("arrow", this.createVec(0, 20));
		this.m.Skills.add(::new("scripts/skills/racial/serpent_racial"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_pathfinder"));
		// this.m.Skills.add(::new("scripts/skills/perks/perk_backstabber")); Replaced with ForceEnabled version
		this.m.Skills.add(::new("scripts/skills/perks/perk_relentless"));
		this.m.Skills.add(::new("scripts/skills/actives/serpent_hook_skill"));
		this.m.Skills.add(::new("scripts/skills/actives/serpent_bite_skill"));
		::Tactical.getTemporaryRoster().add(this);

		// Reforged
		this.m.BaseProperties.Reach = ::Reforged.Reach.Default.BeastLarge;
		this.m.Skills.add(::new("scripts/skills/perks/perk_backstabber"));
		this.m.Skills.add(::Reforged.new("scripts/skills/perks/perk_rf_from_all_sides", function(o) {
			o.m.RequiredWeaponType = null;
		}));
	}

	// switcheroo function to replace loot drops with dummy object
	q.onDeath = @(__original) function( _killer, _skill, _tile, _fatalityType )
	{
		local itemsToChange = [
			"scripts/items/loot/rainbow_scale_item"
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

		if (_tile != null && (_killer == null || _killer.getFaction() == ::Const.Faction.Player || _killer.getFaction() == ::Const.Faction.PlayerAnimals) && ::Math.rand(1, 100) <= 15)
		{
			local loot = ::new("scripts/items/loot/rainbow_scale_item");
			loot.drop(_tile);
		}
	}
});
