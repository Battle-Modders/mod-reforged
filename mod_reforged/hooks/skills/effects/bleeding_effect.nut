::Reforged.HooksMod.hook("scripts/skills/effects/bleeding_effect", function(q) {
	q.m.Attacker <- null;

	q.onAdded = @(__original) function()
	{
		__original();
		if (!this.isGarbage())
		{
			this.m.Attacker = this.getContainer().getActor().getLastAttacker();
		}
	}

	q.applyDamage = @() function()
	{
		if (this.m.LastRoundApplied != ::Time.getRound())
		{
			this.m.LastRoundApplied = ::Time.getRound();
			local actor = this.getContainer().getActor();
			this.spawnIcon("status_effect_01", actor.getTile());
			local hitInfo = clone ::Const.Tactical.HitInfo;
			hitInfo.DamageRegular = this.m.Damage * (actor.getSkills().hasSkill("effects.hyena_potion") ? 0.5 : 1.0);
			hitInfo.DamageDirect = 1.0;
			hitInfo.BodyPart = ::Const.BodyPart.Body;
			hitInfo.BodyDamageMult = 1.0;
			hitInfo.FatalityChanceMult = 0.0;
			actor.onDamageReceived(this.getAttacker(), this, hitInfo);

			if (--this.m.TurnsLeft <= 0)
			{
				this.removeSelf();
			}
		}
	}

	q.getAttacker <- function()
	{
		if (!::MSU.isNull(this.m.Attacker) && this.m.Attacker.isAlive() && this.m.Attacker.isPlacedOnMap())
		{
			return this.m.Attacker;
		}

		return this.getContainer().getActor();
	}
});
