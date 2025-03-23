::Reforged.HooksMod.hook("scripts/entity/tactical/enemies/necromancer", function(q) {
	q.onInit = @() function()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.Necromancer);
		b.TargetAttractionMult = 3.0;
		b.IsAffectedByNight = false;
		b.Vision = 8;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_undead");
		this.getSprite("head").Color = this.createColor("#ffffff");
		this.getSprite("head").Saturation = 1.0;
		this.getSprite("body").Saturation = 0.6;
		this.m.Skills.add(::new("scripts/skills/actives/raise_undead"));
		this.m.Skills.add(::new("scripts/skills/actives/possess_undead_skill"));

		// Reforged
		this.m.Skills.add(::Reforged.new("scripts/skills/perks/perk_inspiring_presence", function(o) {
			o.m.IsForceEnabled = true;
		}));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rf_soul_link"));
	}

	q.getLootForTile = @(__original) function( _killer, _loot )
	{
		local ret = __original(_killer, _loot);

		if (_killer == null || _killer.getFaction() == ::Const.Faction.Player || _killer.getFaction() == ::Const.Faction.PlayerAnimals)
		{
			if (::Math.rand(1, 100) <= 67)
			{
				ret.push(::new("scripts/items/loot/signet_ring_item"));
			}
		}

		return ret;
	}
});
