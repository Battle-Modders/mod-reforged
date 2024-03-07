::Reforged.HooksMod.hook("scripts/skills/effects/bleeding_effect", function(q) {
	q.m.Stacks <- 1;
	q.m.StacksThisTurn <- 1;

	q.create = @(__original) function()
	{
		__original();
		this.m.Description = "This character is bleeding profusely and will lose hitpoints each turn while acting slower and losing courage."
		this.m.IsStacking = false;
	}

	q.getTooltip <- function()
	{
		local ret = this.skill.getTooltip();
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/regular_damage.png",
			text = ::Reforged.Mod.Tooltips.parseString("Receive " + ::MSU.Text.colorRed(this.m.Stacks) + " damage per [turn|Concept.Turn]")
		});
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/bravery.png",
			text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizePercentage(-this.getMalusMult() * 100, {AddSign = false}) + " reduced [Resolve|Concept.Bravery]")
		});
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/initiative.png",
			text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizePercentage(-this.getMalusMult() * 100, {AddSign = false}) + " reduced [Initiative|Concept.Initiative]")
		});
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("If at least " + ::MSU.Text.colorRed(3) + " stacks are received in a single [turn|Concept.Turn], a negative [morale check|Concept.Morale] is immediately triggered")
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
		return ::Math.minf(0.5, this.m.Stacks * 0.05);
	}

	// The vanilla file has an empty onUpdate function
	q.onUpdate = @() function( _properties )
	{
		local mult = 1.0 - this.getMalusMult();
		_properties.InitiativeMult *= mult;
		_properties.BraveryMult *= mult;
	}

	// Copy of vanilla but use this.m.Stacks instead of this.m.Damage to calculate hitInfo.DamageRegular
	// and get rid of the part that decrements this.m.TurnsLeft and removes the effect
	q.applyDamage = @() function()
	{
		if (this.m.LastRoundApplied != this.Time.getRound())
		{
			this.m.LastRoundApplied = this.Time.getRound();
			local actor = this.getContainer().getActor();
			this.spawnIcon("status_effect_01", actor.getTile());
			local hitInfo = clone this.Const.Tactical.HitInfo;
			hitInfo.DamageRegular = this.m.Stacks * (actor.getSkills().hasSkill("effects.hyena_potion") ? 0.5 : 1.0);
			hitInfo.DamageDirect = 1.0;
			hitInfo.BodyPart = this.Const.BodyPart.Body;
			hitInfo.BodyDamageMult = 1.0;
			hitInfo.FatalityChanceMult = 0.0;
			actor.onDamageReceived(actor, this, hitInfo);
		}
	}

	q.onRefresh <- function()
	{
		this.m.Stacks++;
		if (++this.m.StacksThisTurn == 3)
		{
			local actor = this.getContainer().getActor();
			actor.checkMorale(-1, ::Const.Morale.OnHitBaseDifficulty * (1.0 - actor.getHitpoints() / actor.getHitpointsMax()));
		}
	}

	q.onTurnStart <- function()
	{
		this.m.StacksThisTurn = 0;
	}
});
