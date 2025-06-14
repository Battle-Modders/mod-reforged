::Reforged.HooksMod.hook("scripts/skills/actives/shieldwall", function(q) {
	q.getTooltip = @(__original) { function getTooltip()
	{
		local ret = __original();

		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("Removes the penalty to shield defenses from built [Fatigue|Concept.Fatigue]")
		});

		return ret;
	}}.getTooltip;

	q.onAfterUpdate = @() { function onAfterUpdate( _properties )
	{
		// Part of perk_rf_shield_sergeant functionality
		local actor = this.getContainer().getActor();
		if (!actor.isPlacedOnMap())
			return;

		local tile = actor.isPreviewing() && actor.getPreviewMovement() != null ? actor.getPreviewMovement().End : actor.getTile();

		foreach (ally in ::Tactical.Entities.getFactionActors(actor.getFaction(), tile, 2))
		{
			if (ally.getID() == actor.getID()) continue;

			if (ally.getSkills().hasSkill("perk.rf_shield_sergeant"))
			{
				this.m.ActionPointCost = ::Math.max(this.m.ActionPointCost * 0.5, 2);
				this.m.FatigueCostMult *= 0.5;
				return;
			}
		}
	}}.onAfterUpdate;

	q.onTurnStart = @() { function onTurnStart()
	{
		// Part of perk_rf_shield_sergeant functionality
		this.RF_checkForShieldSergeant();
	}}.onTurnStart;

	q.onTurnEnd = @() { function onTurnEnd()
	{
		// Part of perk_rf_shield_sergeant functionality
		this.RF_checkForShieldSergeant();
	}}.onTurnEnd;

	// Part of perk_rf_shield_sergeant functionality
	q.RF_checkForShieldSergeant <- { function RF_checkForShieldSergeant()
	{
		local actor = this.getContainer().getActor();
		if (actor.getCurrentProperties().IsStunned || actor.getMoraleState() == ::Const.MoraleState.Fleeing || this.getContainer().hasSkill("effects.shieldwall"))
		{
			return;
		}

		local hasPerk = this.getContainer().hasSkill("perk.rf_shield_sergeant");

		foreach (ally in ::Tactical.Entities.getFactionActors(actor.getFaction(), actor.getTile(), 1, true))
		{
			if (::Math.abs(ally.getTile().Level - actor.getTile().Level) <= 1 && ally.getSkills().hasSkill("actives.shieldwall") && (hasPerk || ally.getSkills().hasSkill("perk.rf_shield_sergeant")))
			{
				this.getContainer().add(::new("scripts/skills/effects/shieldwall_effect"));
				::Sound.play(this.m.SoundOnUse[::Math.rand(0, this.m.SoundOnUse.len() - 1)], ::Const.Sound.Volume.Skill * this.m.SoundVolume, actor.getPos());
				if (!actor.isHiddenToPlayer())
				{
					::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(actor) + " uses Shieldwall due to " + ::Const.UI.getColorizedEntityName(hasPerk ? actor : ally) + "\'s Shield Sergeant perk");
				}
				return;
			}
		}
	}}.RF_checkForShieldSergeant;
});
