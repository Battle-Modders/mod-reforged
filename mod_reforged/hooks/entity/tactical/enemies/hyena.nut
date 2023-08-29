::mods_hookExactClass("entity/tactical/enemies/hyena", function(o) {
	o.onInit = function()
	{
	    this.actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.Hyena);
		b.IsAffectedByNight = false;
		b.IsImmuneToDisarm = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		this.addSprite("socket").setBrush("bust_base_beasts");
		local body = this.addSprite("body");
		body.setBrush("bust_hyena_0" + this.Math.rand(1, 3));

		if (this.Math.rand(0, 100) < 90)
		{
			body.varySaturation(0.2);
		}

		if (this.Math.rand(0, 100) < 90)
		{
			body.varyColor(0.05, 0.05, 0.05);
		}

		local head = this.addSprite("head");
		head.setBrush("bust_hyena_0" + this.Math.rand(1, 3) + "_head");
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
		this.m.Skills.add(this.new("scripts/skills/actives/hyena_bite_skill"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));

		// Reforged
		this.m.BaseProperties.Reach = ::Reforged.Reach.Default.BeastMedium - 1;
		this.m.Skills.add(::new("scripts/skills/perks/perk_sundering_strikes"));
		if (::Reforged.Config.IsLegendaryDifficulty)
    	{
    		this.m.BaseProperties.MeleeSkill += 10;
    		this.m.BaseProperties.MeleeDefense += 10;
    		this.m.BaseProperties.RangedDefense += 10;
    		this.m.Skills.add(::MSU.new("scripts/skills/perks/perk_rf_dismantle"));
    		this.m.Skills.add(::new("scripts/skills/perks/perk_fortified_mind"));
    		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_fresh_and_furious"));
    	}
	}

	local onDeath = o.onDeath; // switcheroo function to replace loot drops with dummy object
	o.onDeath = function( _killer, _skill, _tile, _fatalityType )
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
				item.drop <- @()null;
			}
			return item;
		}
		onDeath(_killer, _skill, _tile, _fatalityType);
		::new = new;

		local chanceToRoll = ::MSU.isKindOf(this, "hyena_high") ? 30 : 20;

		if (_tile != null && ::Math.rand(1, 100) <= chanceToRoll)
		{
			local loot = ::new("scripts/items/loot/sabertooth_item");
			loot.drop(_tile);
		}
	}
});
