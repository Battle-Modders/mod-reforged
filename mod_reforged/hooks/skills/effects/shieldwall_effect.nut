::Reforged.HooksMod.hook("scripts/skills/effects/shieldwall_effect", function(q) {
	q.getTooltip = @(__original) function()
	{
		local ret = __original();

		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("Immune against [Hook Shield|Skill+rf_hook_shield_skill]")
		});

		return ret;
	}

	// Part of perk_rf_shield_sergeant functionality
	q.onTurnStart = @(__original) function()
	{
		local hasPerk = this.getContainer().hasSkill("perk.rf_shield_sergeant");

		foreach (ally in ::Tactical.Entities.getFactionActors(actor.getFaction(), actor.getTile(), 1, true))
		{
			if (::Math.abs(ally.getTile().Level - actor.getTile().Level) <= 1 && ally.getSkills().hasSkill("actives.shieldwall") && (hasPerk || ally.getSkills().hasSkill("perk.rf_shield_sergeant")))
			{
				this.m.IsGarbage = false;
				if (!actor.isHiddenToPlayer())
				{
					::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(actor) + " retains Shieldwall due to " + ::Const.UI.getColorizedEntityName(hasPerk ? actor : ally) + "\'s Shield Sergeant perk");
				}
				return;
			}
		}
	}
});
