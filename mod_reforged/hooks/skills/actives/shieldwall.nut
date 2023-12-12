::Reforged.HooksMod.hook("scripts/skills/actives/shieldwall", function(q) {
	q.getTooltip = @(__original) function()
	{
		local tooltip = __original();
		tooltip.push(
			{
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Grants immunity to the next stun, but will be lost upon receiving the stun"
			}
		);

		tooltip.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("Grants immunity against [Hook Shield|Skill+rf_hook_shield_skill]")
		});

		return tooltip;
	}

	q.onAfterUpdate = @() function( _properties )
	{
		// Part of perk_rf_shield_sergeant functionality
		local actor = this.getContainer().getActor();
		if (actor.isPlacedOnMap())
		{
			foreach (ally in ::Tactical.Entities.getFactionActors(actor.getFaction(), actor.getTile(), 2))
			{
				if (ally.getID() == actor.getID()) continue;

				if (ally.getSkills().hasSkill("perk.rf_shield_sergeant"))
				{
					this.m.ActionPointCost = ::Math.max(this.m.ActionPointCost * 0.5, 2);
					this.m.FatigueCostMult *= 0.5;
					return;
				}
			}
		}
	}

	q.onTurnStart <- function()
	{
		// Part of perk_rf_shield_sergeant functionality
		local actor = this.getContainer().getActor();
		if (actor.getCurrentProperties().IsStunned || actor.getMoraleState() == ::Const.MoraleState.Fleeing || this.getContainer().hasSkill("effects.shieldwall"))
		{
			return;
		}

		foreach (ally in ::Tactical.Entities.getFactionActors(actor.getFaction(), actor.getTile(), 1))
		{
			if (ally.getID() == actor.getID()) continue;

			local hasPerk = this.getContainer().hasSkill("perk.rf_shield_sergeant");

			if (::Math.abs(ally.getTile().Level - actor.getTile().Level) <= 1 && ally.getSkills().hasSkill("actives.shieldwall") && (hasPerk || ally.getSkills().hasSkill("perk.rf_shield_sergeant")))
			{
				this.getContainer().add(::new("scripts/skills/effects/shieldwall_effect"));
				this.Sound.play(this.m.SoundOnUse[::Math.rand(0, this.m.SoundOnUse.len() - 1)], ::Const.Sound.Volume.Skill * this.m.SoundVolume, actor.getPos());
				if (!actor.isHiddenToPlayer())
				{
					::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(actor) + " uses Shieldwall due to " + ::Const.UI.getColorizedEntityName(hasPerk ? actor : ally) + "\'s Shield Sergeant perk");
				}
				return;
			}
		}
	}

	q.onTurnEnd <- function()
	{
		// Part of perk_rf_shield_sergeant functionality
		this.onTurnStart();
	}
});
