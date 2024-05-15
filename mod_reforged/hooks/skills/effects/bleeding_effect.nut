::Reforged.HooksMod.hook("scripts/skills/effects/bleeding_effect", function(q) {
	q.m.Stacks <- 1;
	q.m.StacksThisTurn <- 1;
	q.m.StacksForMoraleCheck <- 3;
	q.m.MaxMalusMult <- 0.5;
	q.m.MalusMultPerStack <- 0.05;

	q.create = @(__original) function()
	{
		__original();
		this.m.Description = "This character is bleeding profusely and will lose hitpoints each turn while acting slower and losing courage.";
		this.m.IsStacking = false;
	}

	q.getTooltip <- function()
	{
		local ret = this.skill.getTooltip();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/regular_damage.png",
			text = ::Reforged.Mod.Tooltips.parseString("Receive " + ::MSU.Text.colorRed(this.getDamage()) + " damage per [turn|Concept.Turn]")
		});
		ret.push({
			id = 11,
			type = "text",
			icon = "ui/icons/bravery.png",
			text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeMult(this.getMalusMult()) + " less [Resolve|Concept.Bravery]")
		});
		ret.push({
			id = 12,
			type = "text",
			icon = "ui/icons/initiative.png",
			text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeMult(this.getMalusMult()) + " less [Initiative|Concept.Initiative]")
		});
		ret.push({
			id = 13,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("If at least " + ::MSU.Text.colorRed(this.m.StacksForMoraleCheck) + " stacks are received in a single [turn|Concept.Turn], a negative [morale check|Concept.Morale] is immediately triggered")
		});
		return ret;
	}

	q.getName <- function()
	{
		return this.m.Stacks == 1 ? this.m.Name : this.m.Name + " (x" + this.m.Stacks + ")";
	}

	q.getDescription = @() function()
	{
		return this.m.Description;
	}

	q.getMalusMult <- function()
	{
		return 1.0 - ::Math.minf(this.m.MaxMalusMult, this.m.Stacks * this.m.MalusMultPerStack);
	}

	q.getDamage <- function()
	{
		local ret = this.getContainer().hasSkill("trait.bleeder") ? this.m.Stacks * 2 : 1;
		return this.getContainer().hasSkill("effects.hyena_potion") ? ::Math.floor(ret * 0.5) : ret;
	}

	// The vanilla file has an empty onUpdate function
	q.onUpdate = @() function( _properties )
	{
		local mult = this.getMalusMult();
		_properties.InitiativeMult *= mult;
		_properties.BraveryMult *= mult;
	}

	// Based on the vanilla function but use this.getDamage() to calculate hitInfo.DamageRegular and use this.m.Overlay for spawnIcon
	// and get rid of the part that decrements this.m.TurnsLeft and removes the effect
	// also apply damage in instances smaller than ::Const.Morale.OnHitMinDamage to prevent morale check from this damage
	q.applyDamage = @() function()
	{
		if (this.m.LastRoundApplied != ::Time.getRound())
		{
			this.m.LastRoundApplied = ::Time.getRound();
			local actor = this.getContainer().getActor();
			this.spawnIcon(this.m.Overlay, actor.getTile());

			// Split the damage instances if damage is greater than 10 as 10 is the maximum damage from single bleeding in vanilla.
			// Not splitting can potentialy cause unintended morale checks if damage is greater than ::Const.Morale.OnHitMinDamage.
			local damage = [this.getDamage()];
			local i = 0;
			while (i < damage.len() && damage[i] > 10)
			{
				damage.push(damage[i] - 10);
				damage[i] = 10;
				i++;
			}

			foreach (d in damage)
			{
				// Stop applying damage if this skill was removed e.g. by triggering Nine Lives.
				if (this.isGarbage() || !actor.isAlive() || actor.isDying())
					return;

				local hitInfo = clone ::Const.Tactical.HitInfo;
				hitInfo.DamageDirect = 1.0;
				hitInfo.BodyPart = ::Const.BodyPart.Body;
				hitInfo.BodyDamageMult = 1.0;
				hitInfo.FatalityChanceMult = 0.0;
				hitInfo.DamageRegular = d;

				actor.onDamageReceived(actor, this, hitInfo);
			}
		}
	}

	q.onRefresh <- function()
	{
		local actor = this.getContainer().getActor();
		if (actor.getCurrentProperties().IsResistantToAnyStatuses && ::Math.rand(1, 100) <= 50)
		{
			if (!actor.isHiddenToPlayer())
				::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(actor) + " had his bleeding wound quickly close thanks to his unnatural physiology");
			return;
		}

		this.m.Stacks++;
		this.spawnIcon(this.m.Overlay, actor.getTile());

		if (++this.m.StacksThisTurn == this.m.StacksForMoraleCheck)
			actor.checkMorale(-1, ::Const.Morale.OnHitBaseDifficulty * (1.0 - actor.getHitpoints() / actor.getHitpointsMax()));
	}

	q.onTurnStart <- function()
	{
		this.m.StacksThisTurn = 0;
	}
});
