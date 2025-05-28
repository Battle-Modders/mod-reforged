::Reforged.HooksMod.hook("scripts/skills/effects/bleeding_effect", function(q) {
	q.m.Stacks <- 1;
	q.m.StacksThisTurn <- 1;
	q.m.StacksForMoraleCheck <- 3;
	q.m.MaxMalusMult <- 0.5;

	// Used to speed up the bleed icon spam from multiple bleeds in a single attack
	q.m.SkillCount <- 0;

	q.create = @(__original) { function create()
	{
		__original();
		this.m.Description = "This character is bleeding profusely and will lose hitpoints each turn while acting slower and losing courage.";
		this.m.IsStacking = false;
	}}.create;

	q.getTooltip = @() { function getTooltip()
	{
		local ret = this.skill.getTooltip();
		ret.push({
			id = 10,
			type = "text",
			icon = "ui/icons/regular_damage.png",
			text = ::Reforged.Mod.Tooltips.parseString("Receive " + ::MSU.Text.colorNegative(this.getDamage()) + " damage per [turn|Concept.Turn]")
		});

		if (this.getContainer().getActor().getID() == ::MSU.getDummyPlayer().getID())
		{
			ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = ::Reforged.Mod.Tooltips.parseString("[Initiative|Concept.Initiative] and [Resolve|Concept.Bravery] are reduced per stack, up to a maximum of " + ::MSU.Text.colorizeMult(this.m.MaxMalusMult) + ". The reduction per stack is more for characters with lower current [Hitpoints|Concept.Hitpoints]")
			});
		}
		else
		{
			local malusMult = ::Math.round(this.getMalusMult() * 100) / 100.0;
			ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeMult(malusMult) + " less [Resolve|Concept.Bravery]")
			});
			ret.push({
				id = 12,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = ::Reforged.Mod.Tooltips.parseString(::MSU.Text.colorizeMult(malusMult) + " less [Initiative|Concept.Initiative]")
			});
		}

		ret.push({
			id = 13,
			type = "text",
			icon = "ui/icons/special.png",
			text = ::Reforged.Mod.Tooltips.parseString("If at least " + ::MSU.Text.colorNegative(this.getStacksForMoraleCheck()) + " stacks are received in a single [turn,|Concept.Turn] a negative [morale check|Concept.Morale] is immediately triggered")
		});
		return ret;
	}}.getTooltip;

	q.getName = @() { function getName()
	{
		return this.m.Stacks == 1 ? this.m.Name : this.m.Name + " (x" + this.m.Stacks + ")";
	}}.getName;

	q.getDescription = @() { function getDescription()
	{
		return this.m.Description;
	}}.getDescription;

	q.getMalusMult <- { function getMalusMult()
	{
		local actor = this.getContainer().getActor();
		local debuff = ::Math.minf(this.m.MaxMalusMult, 2 * this.m.Stacks.tofloat() / actor.getHitpoints());
		debuff *= actor.getCurrentProperties().RF_BleedingEffectMult;
		return ::Math.maxf(0, 1.0 - debuff);
	}}.getMalusMult;

	q.getDamage = @() { function getDamage()
	{
		return ::Math.floor(this.m.Stacks * this.getContainer().getActor().getCurrentProperties().RF_BleedingEffectMult);
	}}.getDamage;

	q.getStacksForMoraleCheck <- { function getStacksForMoraleCheck()
	{
		return ::Math.max(1, this.m.StacksForMoraleCheck / this.getContainer().getActor().getCurrentProperties().RF_BleedingEffectMult);
	}}.getStacksForMoraleCheck;

	// The vanilla file has an empty onUpdate function
	q.onUpdate = @() { function onUpdate( _properties )
	{
		local mult = this.getMalusMult();
		_properties.InitiativeMult *= mult;
		_properties.BraveryMult *= mult;
	}}.onUpdate;

	// Based on the vanilla function but use this.getDamage() to calculate hitInfo.DamageRegular and use this.m.Overlay for spawnIcon
	// and get rid of the part that decrements this.m.TurnsLeft and removes the effect
	// also apply damage in instances smaller than ::Const.Morale.OnHitMinDamage to prevent morale check from this damage
	q.applyDamage = @() { function applyDamage()
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
	}}.applyDamage;

	q.onAdded = @(__original) { function onAdded()
	{
		__original();
		this.m.SkillCount = ::Const.SkillCounter;
	}}.onAdded;

	q.onRefresh = @() { function onRefresh()
	{
		local actor = this.getContainer().getActor();
		if (actor.getCurrentProperties().IsResistantToAnyStatuses && ::Math.rand(1, 100) <= 50)
		{
			if (!actor.isHiddenToPlayer())
				::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(actor) + " had his bleeding wound quickly close thanks to his unnatural physiology");
			return;
		}

		this.m.Stacks++;

		if (this.m.SkillCount != ::Const.SkillCounter)
		{
			this.spawnIcon(this.m.Overlay, actor.getTile());
		}
		// Speed up the icons from multiple bleed instances received in a single skill, after the first instance
		else
		{
			local original_SkillIconStayDuration = ::Const.Tactical.Settings.SkillIconStayDuration;
			local original_SkillIconOffsetY = ::Const.Tactical.Settings.SkillIconOffsetY;
			::Const.Tactical.Settings.SkillIconStayDuration *= 0.3;
			::Const.Tactical.Settings.SkillIconOffsetY *= 0.6;
			this.spawnIcon(this.m.Overlay, actor.getTile());
			::Const.Tactical.Settings.SkillIconStayDuration = original_SkillIconStayDuration;
			::Const.Tactical.Settings.SkillIconOffsetY = original_SkillIconOffsetY;
		}

		this.m.SkillCount = ::Const.SkillCounter;

		if (++this.m.StacksThisTurn == this.getStacksForMoraleCheck())
			actor.checkMorale(-1, ::Const.Morale.OnHitBaseDifficulty * (1.0 - actor.getHitpoints() / actor.getHitpointsMax()));
	}}.onRefresh;

	q.onTurnStart = @() { function onTurnStart()
	{
		this.m.StacksThisTurn = 0;
	}}.onTurnStart;
});
